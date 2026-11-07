# Persona review: research software engineer (containers, HPC, CI)
*2026-11-07 11:32 PST*

Simulated persona: an RSE at an academic medical center who would field students' questions while they follow this book. Judgments about what the profession expects are informed opinion, not survey data.

## Summary

1. All three reader findings are confirmed with runs: the showcase digest is an OCI index with amd64 and arm64 images, `--cleanenv` leaves `$HOME` mounted, and the Ch 12 Exercise 4 job cannot act as a gate (its `check-renv` target auto-fixes and then passes).
2. New critical finding: the book says Apple Silicon needs `--platform linux/amd64`. The showcase Dockerfile in fact builds natively on arm64, and zzcollab, the book's own tool, builds arm64 on a Mac by default. Laptops and clusters therefore end up running different images from the 'same' digest.
3. New major findings: the CI workflow assumes a `.Rprofile` that activates renv, and the zzcollab `.Rprofile` does not do that on a CI host. The Slurm script strips `SLURM_*` variables and asks for four cores while forcing one thread. A clean CI runner cannot 'rebuild exactly what is stale'. `actions/checkout@v7.0.1` exists, so the 'v4 is current' claim and the Phase 16 'correction' are both wrong.
4. Three chapters (Ch 5, 7, 8) now contradict their own frozen output: the output shows `renv.lock` TRUE, and the prose says no lockfile exists.
5. Verdict: adopt with revisions. The pinning discipline is sound and was actually built and tested, but several commands fail or mislead on the platforms students really use: Apple Silicon, HPC, and zzcollab-scaffolded CI.

## What I ran or built

- **Showcase Dockerfile.** I built the Dockerfile at 05:753-781 natively on arm64 (Docker 29.9.3, no `--platform`), using a one-package lockfile (jsonlite 2.0.0, renv 1.2.3). It built with exit 0. `renv` and `jsonlite` compiled from source. Image `rse-showcase-arm64`; files in `work-persona-rse/showcase/`.
- **Registry inspection.** I ran `docker buildx imagetools inspect` on every digest in the chapters.
- **Platform pull test.** I ran `docker pull` of `rocker/tidyverse:4.4.0@sha256:3e72...` without `--platform`.
- **Apptainer probe.** Apptainer 1.5.5 ran inside privileged Docker, as root, probing `$HOME` and environment handling (`work-persona-rse/appt.sh`).
- **CRLF test.** A CRLF-terminated script ran inside rocker/r-ver.
- **Make tab test.** The 8-space recipe test ran under GNU Make 3.81 (macOS) and 4.3 (Ubuntu).
- **Ch 12 Exercise 7.** I ran it with the locked library.
- **GitLab YAML.** I parsed it with `yaml::read_yaml` (a structural check only).
- **Version lookups.** `gh api` queries on actions/checkout and r-lib/actions releases.
- **Not run.** No amd64 build, no CI service, no Slurm, no Podman, no Binder, and no `rix`/Nix.

## 1. Verdict

Adopt with revisions. The digest-plus-dated-snapshot-plus-`RENV_CONFIG_REPOS_OVERRIDE` recipe is correct and better tested than most course material I have supported. The verification script that refuses to pass without a baseline test is also good. What I would not hand to students unchanged:

- the architecture story, which is wrong for the image the book actually uses;
- the Apptainer and Slurm guidance, which leaks the home directory and drops scheduler variables;
- the Ch 12 workflows as they would behave in a zzcollab compendium.

## 2. Findings

### Critical

**C1. The architecture account is wrong for the book's own showcase image, and the book's tool contradicts it** (05:535-538, 568-575, 600-602; setup-appendix:18-24, 33-37, 152, 159-161).

[V] Digest `73adabf3...` is an OCI image index:

- amd64 manifest `8d7a9eb2...`
- arm64 manifest `38625d86...`
- two attestation manifests

[V] The showcase Dockerfile builds natively on arm64 without `--platform`. So 'needed `--platform linux/amd64` to build at all' (05:536-538) is false, and so is 'as this book's own Dockerfile requires' (setup:160). In that arm64 build the packages compiled from source. Item 7's diagnosis is right: the text describes a tidyverse-based Dockerfile that no longer exists.

[I] zzcollab pins the index digest deliberately ('platform-agnostic', `modules/docker.sh:1081-1086`). On arm64 hosts it builds `linux/arm64` for every base except verse (`docker.sh:1376-1390`), and the Makefile defaults `PLATFORM` to `linux/arm64` (`templates/Makefile:52`).

The consequences:

- A Mac student and an Intel labmate who 'build the identical, byte-for-byte filesystem' (05:600-602) actually build different images from different base manifests, one with PPM binaries and one with source compiles.
- Moving from `zzc minimal` to `zzc publishing`, the 'single changed line' of 05:1268, silently switches a Mac build from native arm64 to emulated amd64.
- An image built natively on a Mac and pushed to a registry will not run on an x86 cluster.

Fix:

- State that a digest may name an index, and that `--platform` selects which child manifest a build receives.
- To pin one filesystem, pin the platform manifest digest, or pin the index digest and always pass `--platform linux/amd64`.
- Correct 05:535-538 and the appendix to say that `rocker/r-ver` is multi-arch and needs no flag, while tidyverse and verse at 4.4.0 do.
- Teach `docker buildx build --platform linux/amd64 --push` (or building in CI) for any image bound for HPC.
- Reconcile the advice with zzcollab's arm64 default, or change the default.

### Major

**M1. Apptainer `--cleanenv` does not isolate `$HOME`** (06:851-853, 965-969, 995, 1360).

[V] Under plain `exec` and under `--cleanenv`, `$HOME` was mounted with `.Rprofile` and `R/` visible. `--cleanenv` cleared `R_LIBS_USER` and `SLURM_ARRAY_TASK_ID`. `--containall` hid `$HOME` but moved the working directory to `$HOME`, so `source("analysis/simulate.R")` would break. `--cleanenv --no-home` hid `$HOME` and kept the working directory.

[V] Inside rocker, `.libPaths()` appends `~/R/<platform>-library/4.4`. Rscript also reads `~/.Rprofile`. A cluster home directory can therefore still inject packages and options.

Fix: use `apptainer exec --cleanenv --no-home --bind "$PWD" img.sif Rscript --vanilla analysis/simulate.R` (or `--containall --bind "$PWD" --pwd "$PWD"`), and correct the Pitfall, the CYU answer, and the cheat sheet.

**M2. The Slurm example breaks the usual HPC pattern** (06:936-947). Three problems:

- [V] `--cleanenv` strips `SLURM_*`, so job arrays (the 'thousands of replicates' case) lose `SLURM_ARRAY_TASK_ID`.
- [EK] `parallelly::availableCores()` falls back to every core on the node.
- [I] The script requests `--cpus-per-task=4`, while the Ch 7 image forces `OMP_NUM_THREADS=1`/`OPENBLAS_NUM_THREADS=1`.

Fix:

- Pass `--env SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID,SLURM_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK`.
- Add `#SBATCH --array`.
- Say whether R-level parallelism is intended.
- Add the commonly needed `module load apptainer`, plus `APPTAINER_CACHEDIR`/`APPTAINER_TMPDIR` on scratch, since home quotas kill multi-GB builds.
- Add `apptainer registry login` for a private `ghcr.io/lab/...` image.

**M3. The Ch 12 Exercise 4 solution is not a gate** (09:2030-2041). [I against `zzcollab/templates/Makefile`]

- `make check-renv` runs `check_packages(auto_fix = TRUE, strict = TRUE)` (Makefile:134-135). In `compare.R:395-406`, a failure that the auto-fix repairs returns success. On an ephemeral runner, the gate rewrites `renv.lock` and goes green.
- `make docker-render-book` expands to `docker run ... $(PACKAGE_NAME)` (Makefile:81-86, 418-419). It runs inside `rocker/verse`, which has no Docker CLI and no project image.
- There is no `renv::restore()`.
- `make check` needs the image's `R_RUN` prefix and the restored dependencies.

Fix: use `check-renv-no-fix`, a restore step, and host-side `quarto render` or `rmarkdown::render`. Alternatively, use a shell-executor runner that first runs `docker build`. Then show the job failing.

**M4. The workflow relies on an `.Rprofile` that zzcollab compendia do not ship** (09:513-516, 610-613, 842-847).

[V] With `CI=true` and no `ZZCOLLAB_CONTAINER`, this repository's `.Rprofile` prints 'renv skipped' and leaves `.libPaths()` at the system library (`.Rprofile:35, 43, 58-64`).

[EK] `setup-renv` relies on the project autoloader, so later steps will not see the restored library. That is exactly the cross-boundary bug the chapter describes at 591-608.

Fix: say that the workflow assumes a stock renv `.Rprofile`, or have each step `source('renv/activate.R')` (or set `ZZCOLLAB_CONTAINER=true`). Run the workflow once on a zzc scaffold.

**M5. A pipeline on a clean runner rebuilds everything** (pipelines:961-963, 1206-1208; 09:1546-1547).

[EK] `_targets/` is not in the checkout, so 'a clean machine rebuilds exactly what the change made stale' cannot happen without persisting the store: `actions/cache`, `tar_github_actions()`'s `targets-runs` branch, or a cloud store.

The cross-reference '@sec-pipelines discusses when it does not' points to nothing [I: pipelines.qmd read in full].

Fix: say 'rebuilds everything, which is the clean-rebuild test'. Selective rebuild in CI requires a restored store.

**M6. The action versions are stale, and the Phase 16 correction was wrong** (09:477-479, 503, 724, 960).

[V] actions/checkout `v7.0.1` was published 2026-07-20 (`gh api`), so REFACTOR-PLAN:2771 ('v7 does not exist') is incorrect. 'Current when this chapter was revised' is false for v4.

[V] The illustrative SHA does resolve to v4.2.2, whose `action.yml` declares `node20`. v7.0.1 declares `node24`.

[EK] GitHub is retiring Node 20 actions.

Fix: pin `actions/checkout@<v7.0.1 sha> # v7.0.1`, update the illustrative SHA, and add Dependabot or Renovate to keep SHA pins current. Without that, SHA pinning freezes in known CVEs.

**M7. Unpinned third-party code runs in CI** (09:524, 817; Makefile:132). `remotes::install_github('rgt47/zzrenvcheck')` installs the HEAD of a personal repository inside the gate job, with `GITHUB_PAT` in the environment. This is the same tag-versus-digest hazard the secrets section warns about [I].

Fix: use `install_github('rgt47/zzrenvcheck@<sha>')`.

**M8. Stale cohort artifact checks in three chapters** (03:1211-1213, 1221-1226, Ex 8 at 1656-1664; 05:1323-1331; 06:760, 775-779). [V] The frozen outputs now show `renv.lock` TRUE (03 and 05 `_freeze/.../html.json`, and the 06 freeze), while the prose says it is absent and places the compendium at L0. This confirms item 1 and extends it to Ch 7 and Ch 8.

Fix: rewrite for L1 (`renv.lock` present, no Dockerfile).

Related point [V]: the lockfile records R 4.6.1, but 05:1333-1341 tells the reader to use `rocker/r-ver:4.4.0`/`jammy`. The match should be `r-ver:4.6.1`/`noble` (zzcollab's own map, `docker.sh:1106-1113`).

**M9. The Binder claims are overstated** (06:581-595, 636-638, 864-869). [EK] repo2docker builds its own image from the repository's configuration. It does not run 'the same pinned image the compendium ships' unless a `Dockerfile` is `FROM` that digest, and that image must also serve Jupyter (for example a `rocker/binder` base). mybinder.org capacity is limited and sessions are ephemeral.

Fix: qualify the claims, and name `rocker/binder` and `runtime.txt` (`r-YYYY-MM-DD`).

**M10. The digest definition is wrong for an index** (05:255-256, 644-646, 1818). 'The same digest always denotes byte-identical bytes' holds for the index document, not for the filesystem a host receives [V, C1]. This line seeds C1.

Fix: one sentence that distinguishes the index digest from the manifest digest.

### Minor

- **The book's own devcontainer fails on Apple Silicon** (06:775-779; `.devcontainer/devcontainer.json`). [V by analogy] `rocker/verse:4.4.0` is amd64-only, and an amd64-only index pull on arm64 fails with 'no matching manifest'. [EK] The `${env:HOME}` bind mount also fails where `HOME` is unset (Windows) or the directory is missing. Fix: add `"runArgs": ["--platform=linux/amd64"]` and make the cache mount optional.
- **CRLF symptom** (setup:95-96). [V] The kernel reports `exec /w/crlf.sh: no such file or directory`, and bash reports `/bin/bash^M: bad interpreter`. It is not `exec format error`, and 'no such file' sends students looking for a missing file (item 32 confirmed). Fix: quote both messages, and recommend a committed `.gitattributes` (`* text=auto eol=lf`) as the repository-level fix.
- **Missing-separator wording** (pipelines:579, 584-585). [V] GNU Make 3.81 and 4.3 both print `missing separator (did you mean TAB instead of 8 spaces?)` for the exact demonstration the Pitfall prescribes, so 'gives a line number but not the real cause' is false for that case.
- **Podman short names and SELinux** (06:279-283, 829-831). [EK] On RHEL or Fedora, Podman's enforced short-name resolution fails non-interactively on `FROM rocker/...`. SELinux hosts need `-v "$PWD":/project:Z`, and rootless Podman storage on NFS home directories fails. Fix: write `docker.io/rocker/...` (the showcase LABEL already does) and mention `:Z`.
- **Daemon vocabulary** (06:208-211). 'Docker relies on [a daemon]... which is why [Podman/Apptainer] run without administrative rights' ignores rootless Docker. Unprivileged Apptainer also depends on user namespaces or a setuid install [EK].
- **SIF determinism** (06:1347). The Ex 8 solution still says 'the conversion itself was deterministic' after REFACTOR-PLAN:2787 removed that claim from the body (item 52 confirmed). [EK] SIF builds embed creation metadata.
- **Digest lookup** (05:1827). `docker inspect ... RepoDigests` reports the cached local copy, not 'the digest a tag currently resolves to'. Fix: use `docker buildx imagetools inspect <tag>`, which queries the registry.
- **Bind-mount ownership** (05:752-782). The showcase runs as root, so on native Linux and WSL, outputs written to a bind mount are root-owned [EK]. Fix: show `--user "$(id -u):$(id -g)"`.
- **Bootstrap claim** (05:1344-1346). 'The cohort's own model fit uses a bootstrap' is right that `bootstrap_ci()` and `bootstrap_cox_ci()` exist [I `R/cohort.R:98,190`], but they are separate functions, not part of the fit.
- **`renv::diagnostics()`** (09:1522-1526). Described as 'reporting mismatched packages directly'; `renv::status()` is the function that compares the library with the lockfile [EK].
- **GitLab image tag** (09:812). The `rocker/verse:4.4.0` tag-pinned image contradicts the book's own lockfile (R 4.6.1), and amd64-only images fail on arm64 runners.
- **Docker socket** (09:832-839). Docker on a shell-executor runner is root on that host. For PHI-adjacent institutional runners this deserves a sentence [EK].

## 3. Gaps (scope per the preface)

- **Multi-arch build and push.** `buildx` with `--platform`, recording the manifest digest, registry authentication and retention (GHCR). In scope (Ch 7/13); without it C1 recurs.
- **CI caching.** renv cache, Docker layer cache, `_targets` store. In scope, in brief.
- **HPC operational basics.** `module`, cache directories, job arrays, environment passthrough, core binding (see M2). In scope for the optional Ch 8 section.
- **Keeping pins current.** Dependabot or Renovate for actions and base digests, and the CVE trade-off that 05:1549-1552 notes once. In scope.
- **Self-hosted or institutional runners and PHI.** Network placement, runner isolation, Docker-socket risk. In scope, given the audience.
- **Windows without WSL.** `make` comes from Rtools. A short note in the setup appendix.

## 4. Cuts for one quarter

- 09:1205-1266, the capture test matrix. It is framework-internal QA and not something students do.
- The 09:770-875 GitLab full-gates YAML, which duplicates the GitHub one. Keep one dialect in full, plus the Makefile shim idea, and fix Exercise 4.
- 06:499-506, the Guix paragraph, and 06:572-642, the Binder material (shrink it).
- 05:1162-1214, the team-model sketch, which Ch 13 develops anyway.

## 5. Strengths to keep

- The showcase recipe really was built, with a failing variant (05:740-831). The `RENV_CONFIG_REPOS_OVERRIDE` finding (05:812-821) is correct and rarely taught.
- Distro-codename matching (05:787-795).
- 'Never compare image digests' (05:870-876).
- `error-on: '"warning"'`, the warning against `continue-on-error`, and the explanation of the `R CMD check` scope (03:368-386; 09:391-403, 550-560).
- `ci/run-tests.R`, which refuses to pass without a baseline test (09:986-996).
- The secrets and permissions section (09:666-742).
- The `trust_timestamps` and `tar_render()` source-tracking demonstrations (pipelines:735-790).

## 6. factual-issues.md items in my chapters

| # | Status | Evidence |
|---|---|---|
| 1 | Confirmed, wider | The 03 freeze shows `packages_renv_lock` TRUE, and the 05 and 06 freezes also show TRUE against prose that says absent [V] (M8) |
| 2 | Confirmed | Ex 7 gives `missing` of length 2 (`survival`, `withr`), and three names after `sandwich` [V] |
| 6 | Confirmed | pipelines:1276 has no file target; the answer at 1299-1301 assumes one [I] |
| 7 | Confirmed | 05:535-538 [I], and the build refutes the flag claim [V] (C1) |
| 17 | Confirmed | From `analysis/report/`, `../data/` and `../../analysis/data/` resolve to the same file; 03:697-701 misattributes the difference [I] |
| 18 | Confirmed | 03:1037 and 1040 [I] |
| 20 | Confirmed | 05:1712 [I] |
| 21 | Confirmed | No Ch 7 verse digest exists; Ch 7 has only r-ver (755) and tidyverse (1580) [I] |
| 22 | Confirmed | 06:688 'rigour' [I] |
| 25 | Confirmed | 09:1067-1073 versus `zzc verify` checksums at 1025-1026 [I] |
| 31 | Refuted for this image | `docker pull` of tidyverse:4.4.0 without `--platform` failed with 'no matching manifest for linux/arm64/v8' [V]. A single-manifest (non-index) image would differ [EK] |
| 32 | Confirmed | See the CRLF bullet [V] |
| 33 | Half | 154 does name one place twice. 'Three machines' (line 6) matches the three machine sections [I] |
| 38 | Confirmed | setup:9-12 and 105-106 are uncited [I] |
| 45 | Confirmed | 09:1279; 'five moves' at 1565 against four described [I] |
| 46 | Confirmed | 09:1229 [I] |
| 49 | Confirmed (Ex 8 part) | pipelines:1717-1720 credits the worked example with a baseline test it lacks [I]. Caption versus prose at 462 and 544-545 confirmed [I] |
| 51 | Confirmed | 05:1224 versus 1615; 1096-1097 versus 1268. On a Mac the 'single line' also changes architecture [I] |
| 52 | Confirmed | 06:1347 [I] |
