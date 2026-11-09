# Phase 25, Agent 3: literate programming, pipelines, testing, CI
*2026-11-08 17:40 PST*

Subject: Quarto and knitr, PDF determinism, Make, `targets`, other
pipeline tools, `tinytest`, `R CMD check` and `rcmdcheck`, `lintr`,
`styler`, pre-commit, GitHub Actions, GitLab CI, Dependabot and
Renovate, parallel RNG, MCSE, `zzc verify` and `make docker-test`,
and `zzrenvcheck::check_packages()`. No repository file was edited.

Environment for runs: host R 4.6.0 (aarch64-apple-darwin23), GNU
Make 3.81, Quarto 1.10.18, pandoc 3.13, TeX Live 2026 (TinyTeX),
git 2.56.0, rcmdcheck 1.4.0, tinytest 1.4.3, knitr 1.51, lintr
3.3.0.1. Installed into a scratch library only (not the locked one):
targets 1.12.0, tarchetypes 0.14.1, future.apply 1.21.0 (future
1.82.0), doRNG 1.8.6.3, and zzrenvcheck at commit `6f53235`
(0.10.0, built from `git archive` of the local checkout). Scripts
and logs are in
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p25/a3/`.
All dates accessed: 2026-11-08. zzcollab read at its working tree
HEAD `f86f9d4`.

Status key: V = verified by a run here; I = verified by reading the
primary source here (source code, tagged file, or documentation
page); C = corrected; H = hedged.

## 1. Claims table

| id | file:line | claim | status | source | evidence |
|---|---|---|---|---|---|
| A3-01 | 09:436-440 | Undeclared `pkg::` in `R/` is a WARNING; `error_on = 'error'` lets it through | V | scratch pkg, `rcmdcheck(error_on=)` | WARNING "'::' or ':::' import not declared from: 'sandwich'"; `error_on='error'` returned normally, `'warning'` raised `rcmdcheck_warning` |
| A3-02 | 09:2391-2393 | `R CMD check --as-cran` exits nonzero on ERROR, not on WARNING | V | `R CMD check` on scratch pkgs | exit 0 with 2 and 3 WARNINGs (with and without `--as-cran`); exit 1 with an ERROR |
| A3-03 | 09:595-597 | `error-on: '"warning"'` is the action's default | V | r-lib/actions `v2` (commit f9a764f, 2026-09-21) `check-r-package/action.yaml` | `default: '"warning"'` |
| A3-04 | 09:659-661 | `rcmdcheck()` passes `.libPaths()` to the check by default | V | `formals(rcmdcheck)` | `libpath = .libPaths()`; `error_on` defaults to `"never"` via `RCMDCHECK_ERROR_ON` |
| A3-05 | 09:555-558, 656-674 | `setup-renv` restores into the project library; later steps depend on the `.Rprofile` autoloader; the zzcollab `.Rprofile` skips renv on CI | V (simulated) | `setup-renv/action.yaml` at v2; local simulation of its `renv::activate()` step then a fresh `Rscript` with `CI=true` | Action runs `renv::activate()` then `renv::restore()`, caches `renv/library`. Stock project: `.Rprofile` gains `source("renv/activate.R")`, later step sees project library. zzcollab `.Rprofile`: activate adds no line, later step prints 'renv skipped' and sees system library. Not run on a GitHub runner |
| A3-06 | 09:501-506, 1703-1706 | `error_on_fail` default `!interactive()`; with `FALSE` the step prints and passes | V | zzrenvcheck `6f53235` `R/compare.R:107`; scratch compendium run | `TRUE` exit 1, `FALSE` exit 0, default under `Rscript` exit 1; `sandwich` listed |
| A3-07 | 09:2385-2390 | `check-renv` auto-fixes and reports success; `check-renv-no-fix` modifies nothing, nonzero on failure | I | zzcollab `templates/Makefile:134-138`; `compare.R:395-406` | auto-fix re-check returns invisibly on pass; no-fix passes `error_on_fail = TRUE` |
| A3-08 | 09:2391 | `make check` runs `R CMD check --as-cran` | I | `templates/Makefile:300-301` | as stated |
| A3-09 | 09:781, 1683 | `actions/checkout@3d3c42e...` is v7.0.1 | V | `gh api repos/actions/checkout/git/ref/tags/v7.0.1` | object sha `3d3c42e5aac5ba805825da76410c181273ba90b1`, type commit |
| A3-10 | 09:741-744 | 'automatic redaction is not guaranteed' and the auditing advice, cited to `@githubsecrets` | C | both pages fetched with curl and grepped | Both quoted phrases occur on the hardening page and not on the secrets page (0 matches). The first quotation (09:737) already cites `githubhardening`; the second's citation is wrong |
| A3-11 | 09:754-756 | Hardening guidance calls read-only contents 'good security practice' | V | hardening page | 'It's good security practice to set the default permission for the `GITHUB_TOKEN` to read access only for repository contents' |
| A3-12 | 09:751-754 | Default token 'scoped broadly unless told otherwise' | H | workflow-syntax page, `permissions` | Default comes from an enterprise, organization, or repository setting, which may be restricted; the book states one case as the rule |
| A3-13 | 09:775-778 | Tag 'can be moved or deleted'; SHA forgery needs a SHA-1 collision | V | hardening page | 'a tag can be moved or deleted if a bad actor gains access to the repository storing the action'; 'generate a SHA-1 collision for a valid Git object payload' |
| A3-14 | 09:786-791, 2546 | Dependabot or Renovate update SHA pins and the version comment by PR | V (docs) | Dependabot supported-ecosystems page; Renovate github-actions manager page; repo `.github/dependabot.yml` | Dependabot updates `@<commit>` and a same-line version comment; Renovate updates the SHA from the version comment and disables bare-SHA pins without one |
| A3-15 | 09:1154-1157 | Logs and artifacts deleted after 90 days by default; changeable within limits | V | `githubretention` page | '90 days'; public 1 to 90, private 1 to 400 days |
| A3-16 | 09:926-928 | GitLab fails the job at the first nonzero script line | V | docs.gitlab.com/ci/yaml/script/ | 'the job fails and further commands do not execute' |
| A3-17 | 09:933-935 | Docker-in-Docker requires a privileged runner | V | docs.gitlab.com/ci/docker/using_docker_build/ | 'Use this approach when your runner supports `privileged` mode' |
| A3-18 | 09:1052-1055 | `run_test_dir()` exits 0 with a failing expectation | V | scratch suite | exit 0 with 1 failure; `all_pass()` FALSE |
| A3-19 | 09:1062-1071, 1087-1090 | `ci/run-tests.R` exits 1 on failure, missing baseline, or a baseline that exits early | V | same script in scratch | exit 1 in each case; an `exit_file()` baseline contributes no row to `as.data.frame(res)$file` |
| A3-20 | 09:1100-1107; 08:1000-1004; 02:545-550 | `zzc verify --full` stamps L3 only if a `test-baseline*.R` 'exists and ran' | H | `modules/verify.sh:272-292`; tinytest log of an early-exit baseline | Code greps the test log for the file name. tinytest prints `test-baseline-x.R ... 0 tests [Exited at #2: absent]`, so a baseline whose guard exits early would count as 'ran'. Inferred from source plus the log; `zzc verify --full` not run (Docker build) |
| A3-21 | 09:1096-1098 | Coherence tier checks lockfile R against the Dockerfile | H | `verify.sh:204-217`; `docker.sh:1188-1197` | Compares with the state record and with an `ARG R_VERSION=` line; current generated Dockerfiles have no such line, so the Dockerfile comparison is in practice the state record's |
| A3-22 | 09:1107-1110 | 'Any later change to the environment drops the stamp' | C | `verify.sh:18-20, 308-310`; `status.sh:64-84` | Stamp is removed only when zzcollab rewrites `.zzcollab-state` (Dockerfile generation) or a later `--full` run fails to reach L3. An `renv::snapshot()` or a code edit leaves it |
| A3-23 | 09:1099-1100 | Coherence tier checks raw-data checksums | I | `verify.sh:220-229` | only when `data-manifest.sha256` exists; true as stated |
| A3-24 | 03:2385 (Makefile) `make docker-test` | nonzero on failure | I | `Makefile:309-312, 372-373` | `if (!all(as.logical(r))) quit(status = 1)`. Note: zero results gives `all(logical(0))` TRUE, so an empty suite passes |
| A3-25 | 09:1769-1773 | `renv::status()` compares library with lockfile | V | scratch project, renv 1.2.3 (locked lib) | 'out of sync [lockfile != library]: withr [0.0.1 != 3.0.3]' |
| A3-26 | 09:1678-1680 | Without `pull_request` a change is tested only on `main`; without `push`, direct commits untested | I | workflow-syntax page (branch filters) | follows from `push: branches: [main]` as written |
| A3-27 | 07:788-796; colophon:13-19 | `freeze: auto` re-executes only on source change; data change ignored; single-document render always executes | V | scratch Quarto project, 1.10.18 | data 1 to 2: project render still showed 1; `quarto render a.qmd` showed 2; source edit re-executed |
| A3-28 | 07:797-811 | knitr cache stores objects and seed; data change does not invalidate; `cache.extra` with mtime does | V | scratch `knitr::knit()` | plain cached chunk kept 1 after CSV became 2; `cache.extra = file.mtime()` chunk showed 2; draw after cached `set.seed()` chunk identical across runs |
| A3-29 | 07:980-989 | PDFs of identical source differ between renders | V | pdfLaTeX, XeLaTeX, LuaLaTeX twice each | all six hashes differ without `SOURCE_DATE_EPOCH` |
| A3-30 | 07:982-983 | Document identifier 'often randomly generated' | C | same runs | With the date fixed, two builds in one directory were identical for all three engines, so the ID is derived from inputs (time, name, path), not random; Ex 5 (07:1667) already says 'derived from the time' |
| A3-31 | 07:991-999, 1697-1699; 09:1134-1137 | Byte-identical PDFs need `SOURCE_DATE_EPOCH` plus stripping IDs and canonicalizing font-subset names | H | same runs | `SOURCE_DATE_EPOCH=1700000000` alone gave identical bytes for all three engines in one directory; LuaLaTeX differed only in `/ID` across two directories. Font-subset tags did not vary. Full Quarto PDF not tested |
| A3-32 | 07:1021-1026 | zzcollab render hook stamps 'render time and the git version' in a footer | C | `templates/tools/stamp.tex` | Footer prints render time and source path; the git version is defined but 'left off the default footer'; it names the staged copy in `share/` and its manifest row |
| A3-33 | pipelines:616-629 | 8 spaces gives the TAB hint; 4 spaces the bare message; a spaced recipe with a colon raises no error | V | GNU Make 3.81 | `Makefile:3: *** missing separator (did you mean TAB instead of 8 spaces?).  Stop.`; `missing separator.  Stop.`; 'Nothing to be done for `report.html'', exit 0 |
| A3-34 | pipelines:671-692, 1758-1766, 2015 | Make is timestamp-based; `touch` rebuilds; content edit with old mtime missed | V | GNU Make 3.81 | touch rebuilt b and c; edited `a` with `touch -r` left `c` 'up to date' and stale |
| A3-35 | pipelines:810-833, 2015-2017 | `format = 'file'` hashes contents; touch alone does not invalidate; mtime-restored edit missed by default, caught with `trust_timestamps = FALSE` | V | targets 1.12.0 scratch pipeline | as stated; default `trust_timestamps = NULL` (file-system decision) |
| A3-36 | pipelines:836-845, 894-906 | Function-body edit invalidates that target and downstream only; undeclared file read is invisible | V | same | editing `make_figs()` listed `figs report`; editing undeclared `side.txt` listed nothing |
| A3-37 | pipelines:783-789, 812-813, 2021 | `tar_render()` tracks source and `tar_read()`/`tar_load()` deps; `tar_quarto()` for Quarto | V / I | run; `?tar_render`, `?tar_quarto` | prose edit listed `report`; help states both behaviors |
| A3-38 | pipelines:846-855 | Package versions not tracked; `packages` only loads | I | `?tar_target` (`packages`) | 'packages to load right before the target runs'; version non-tracking not tested |
| A3-39 | pipelines:867-882 | `tar_make()` runs in a fresh R session; 1.12 summarizes skipped targets as a count | V | `formals(tar_make)`; run | `callr_function = callr::r`; '2 completed, 4 skipped' |
| A3-40 | pipelines:1007-1012; 09:1795-1798 | Clean runner without `_targets/` rebuilds every target | V | fresh scratch project | `tar_outdated()` listed all six targets |
| A3-41 | pipelines:1139-1142 | workflowr rebuilds changed documents and inserts the commit | I | workflowr `wflow_build` reference | 'build any files that have been modified more recently than their corresponding HTML files' (default); 'the commit version ID inserted into the HTML' |
| A3-42 | pipelines:1169-1172 | Make and `targets` lack native scheduler support | C | rOpenSci targets manual, HPC chapter | `targets` dispatches to cluster schedulers through `clustermq` or `future.batchtools`; the claim holds for Make only |
| A3-43 | 08:527-530, 814-815 | tinytest runs each file with the test directory as working directory | V | scratch suite | `getwd()` printed `.../inst/tinytest` |
| A3-44 | 08:521-523, 2486-2488 | Named expectations, `exit_file()`, `test_package()` exist | V | `getNamespaceExports('tinytest')` | all present; `test_package(at_home = FALSE, testdir = 'tinytest')` |
| A3-45 | 08:867-868 | R warns when the pre-3.6.0 sampler is selected | V | `RNGkind(sample.kind = 'Rounding')` | "non-uniform 'Rounding' sampler used" |
| A3-46 | 08:926-927, 1072-1074 | SD from 40 seeds uncertain about 11 percent; from 20 about 16 | V | arithmetic | `1/sqrt(2*39)` = 0.113; `1/sqrt(2*19)` = 0.162 (normal approximation) |
| A3-47 | 08:1105-1112 | MT plus `mc.set.seed = TRUE`: child discards state, reseeds from clock and pid; two runs differ | V | `parallel:::mc.set.stream` source; run | source removes `.Random.seed` in the child under MT; two seeded runs not identical. Note: `?mcparallel` prose says TRUE differs 'only if' L'Ecuyer is selected, which the code contradicts; the book follows the code |
| A3-48 | 08:1112-1115 | `mc.set.seed = FALSE` duplicates streams | V | run | values `0.2655 0.2655 0.3721 0.3721` |
| A3-49 | 08:1115-1124 | L'Ecuyer `mclapply` and `clusterSetRNGStream()` reproducible but depend on worker count | V | run | identical at 2 workers; differ between 2 and 3 for both |
| A3-50 | 08:1126-1130 | `future.apply` (`future.seed = TRUE`) and `doRNG` give worker-invariant per-task streams | V | run | identical across sequential, 2, 3 workers for both; plain `%dopar%` irreproducible |
| A3-51 | 08:1135-1136 | Forking unavailable on Windows; both runs sequential | I | `R/cohort.R:328`; `?mclapply` | `cores > 1 && OS.type != 'windows'`; help: 'not available on Windows unless mc.cores = 1' |
| A3-52 | 08:1367-1373 | lintr flags `=` assignment, long line, unused variable, undefined function | V | lintr 3.3.0.1 on a scratch file | four lints, one per example |
| A3-53 | 08:1408-1418 | precommit `v0.4.3` and the four hook ids exist; lintr hook blocks | V | `gh api` tag; `.pre-commit-hooks.yaml` and `lintr.R` at v0.4.3 | tag exists (2024-07-23); ids present; hook `stop()`s unless `--warn_only` |
| A3-54 | 08:1400-1404 | Hook means unlinted code 'cannot enter the history in the first place' | H | git 2.56.0 run | `git commit --no-verify` succeeded past a refusing hook; a clone has no `pre-commit` hook |
| A3-55 | 08:1424-1429 | CI 'runs the same checks again on the server' | C | grep of 09 for `lint`/`style` | No workflow in Ch 12 runs `lintr` or `styler` |
| A3-56 | 08:1386-1394, 2489 | `make lint`/`make style` run in the container | I | `Makefile:153-157` | `$(DOCKER_RUN)`; help notes 'needs code-quality enabled' |
| A3-57 | 03:409-418, 2028 | Built check never sees `analysis/`; directory check does not parse it | V | scratch compendium, `analysis/bad.R` with a syntax error and `library(sandwich)` | build then check: `Status: OK`; directory check: only the NOTE 'Checking should be performed on sources prepared by R CMD build' |
| A3-58 | conventions:33-37 | Reading-time rule enforced by a test | V | `test-reading-times.R`, locked library | 12 of 12 pass |
| A3-59 | Ch 9 vignette (Phase 24 agent 3) | `Rscript` reads the project `.Rprofile`, else `~/.Rprofile`, neither with `--vanilla` | V | scratch HOME and directories | as stated |

## 2. Replacement blocks

### A3-10 09-continuous-integration.qmd
The first quotation (09:737) already cites `githubhardening`; only
the second needs the change.

OLD:
```
not guaranteed', and the documentation recommends auditing
a workflow's output to confirm a secret is never
explicitly printed [@githubsecrets]. The condensed
```
NEW:
```
not guaranteed', and the documentation recommends auditing
how a workflow handles secrets to confirm one is never
explicitly printed [@githubhardening]. The condensed
```
After this change `@githubsecrets` is cited nowhere (09:744 is its
only use), so the entry becomes unused.

### A3-12 09-continuous-integration.qmd
OLD:
```
The second rule is least privilege. The default token GitHub
Actions issues a job is scoped broadly unless told otherwise,
and a workflow with no `permissions` block runs with more
access than most jobs need. GitHub's hardening guidance calls
```
NEW:
```
The second rule is least privilege. The default permissions of
the token GitHub Actions issues a job come from a repository,
organization, or enterprise setting, which may be permissive.
A workflow with no `permissions` block inherits that setting
and can run with more access than most jobs need. GitHub's
hardening guidance calls
```

### A3-20, A3-21, A3-22 09-continuous-integration.qmd
OLD:
```
default *coherence* tier requires no rebuild. It checks
that the captured artifacts agree with each other and
that the R version named in the lockfile matches the one
in the Dockerfile. It also checks that the backend is
```
NEW:
```
default *coherence* tier requires no rebuild. It checks
that the captured artifacts agree with each other and
that the R version named in the lockfile matches the one
recorded when the Dockerfile was generated. It also checks
that the backend is
```
OLD:
```
things hold: the image rebuilt, the tests passed, and at
least one `inst/tinytest/test-baseline*.R`
file exists and ran. Without a baseline test it reports
the project as rebuilt and tested, at L2, with no baseline
comparison, and does not stamp L3. Any later change to the
environment drops the stamp. A compendium that has
drifted therefore reverts to unverified automatically and
carries no stale claim. In regulated work, the stamp is not
```
NEW:
```
things hold: the image rebuilt, the tests passed, and at
least one `inst/tinytest/test-baseline*.R` file exists and
is named in the test log. The log names a file even when its
guard exits early with no tests, so `ci/run-tests.R`, which
counts results, is the stricter check. Without a baseline
test it reports the project as rebuilt and tested, at L2,
with no baseline comparison, and does not stamp L3. The stamp
is removed when zzcollab regenerates the Dockerfile or when a
later `--full` run falls short of L3. A change made outside
zzcollab, such as `renv::snapshot()` or an edited script,
leaves it in place, so a stamp older than the last such change
is stale. In regulated work, the stamp is not
```

### A3-20 08-testing-quality.qmd
OLD:
```
`zzc verify --full` applies exactly this rule. It stamps
L3 only when the image rebuilds, the test suite passes,
and at least one `inst/tinytest/test-baseline*.R` file
exists and ran. Otherwise it reports the project as
rebuilt and tested, at L2, with no baseline comparison.
```
NEW:
```
`zzc verify --full` applies this rule. It stamps L3 only
when the image rebuilds, the test suite passes, and at
least one `inst/tinytest/test-baseline*.R` file exists
and is named in the test log. Otherwise it reports the
project as rebuilt and tested, at L2, with no baseline
comparison. A baseline whose guard exits early is still
named in the log, so the guard must not fire in the image.
```

### A3-20 02-levels-of-reproducibility.qmd
OLD:
```
`zzc verify --full` applies exactly this definition. It
records L3 only when the image rebuilds, the test suite
passes, and at least one baseline test (a file named
`inst/tinytest/test-baseline*.R`) exists and ran.
```
NEW:
```
`zzc verify --full` applies this definition. It records L3
only when the image rebuilds, the test suite passes, and at
least one baseline test (a file named
`inst/tinytest/test-baseline*.R`) exists and appears in the
test log.
```
(The Ch 3 cheat-sheet row at 02:1521 'a `test-baseline*.R`
file ran' can stay if the tool is fixed; otherwise 'appears in
the test log'.)

### A3-30, A3-31 07-literate-programming.qmd
OLD:
```
modification timestamp in its metadata. It also carries
an internal document identifier, often randomly
generated. Moreover, when it subsets the fonts it uses,
it assigns those subsets internal names that can vary
between builds. Two renders of byte-for-byte identical
```
NEW:
```
modification timestamp in its metadata. It also carries
an internal document identifier, which engines derive from
the time, the file name, and in some cases the build path.
Some engines also give the font subsets they embed names
that can vary between builds. Two renders of byte-for-byte identical
```
OLD:
```
value instead of the wall-clock time. Setting it
removes the timestamp difference, and a determined
practitioner can normalize further, stripping identifiers
and canonicalizing font-subset names, until two renders
do hash alike. This is worthwhile work in some settings,
```
NEW:
```
value instead of the wall-clock time. In a test with TeX
Live 2026, setting it alone made two pdfLaTeX, XeLaTeX, or
LuaLaTeX builds of a short document in one directory
identical. Builds in different directories could still
differ in their identifier, and a full report adds figures,
paths, and tool versions, each another source of difference.
Normalizing them all is worthwhile work in some settings,
```

### A3-31 07-literate-programming.qmd (Exercise 5 solution)
OLD:
```
Byte-identical PDFs are attainable, by setting
`SOURCE_DATE_EPOCH` and freezing font subsetting, but this
is a fragile route to a result the baseline comparison
```
NEW:
```
Byte-identical PDFs are attainable, by setting
`SOURCE_DATE_EPOCH` and holding the build path and every
tool version fixed, but this
is a fragile route to a result the baseline comparison
```

### A3-31 09-continuous-integration.qmd
OLD:
```
a document's embedded timestamps, by setting a fixed
`SOURCE_DATE_EPOCH`, and to freeze its fonts. With enough
```
NEW:
```
a document's embedded timestamps, by setting a fixed
`SOURCE_DATE_EPOCH`, and to fix its build path. With enough
```

### A3-32 07-literate-programming.qmd
OLD:
```
the opposite direction. Its render hook deliberately
stamps each rendered PDF with the render time and the git
version of the source, in a footer. It does so precisely
so that a reader can tell two renders apart and trace
each to its source commit. The rendered document is thus
```
NEW:
```
the opposite direction. Its render hook deliberately
stamps each rendered PDF with the render time and the
source path, in a footer, and stages a dated copy whose
name and manifest row record the git version of the
source. A reader can therefore tell two renders apart and
trace each to its source commit. The rendered document is thus
```

### A3-42 pipelines.qmd
OLD:
```
this setting, many languages, many steps, and execution
spread across a cluster or the cloud, with native support
for job schedulers that Make and `targets` lack. `targets`
would be the wrong reach because it is R-native. Its
```
NEW:
```
this setting, many languages, many steps, and execution
spread across a cluster or the cloud, with native support
for job schedulers. Make has none, and `targets` reaches a
scheduler only through backends such as `clustermq`.
`targets` would be the wrong reach because it is R-native. Its
```

### A3-54 08-testing-quality.qmd
OLD:
```
fails. Configuring the linter and styler as a
pre-commit hook means that unstyled or unlinted code
cannot enter the history in the first place. That is
a far stronger guarantee than a convention that
relies on the analyst's memory. The configuration
```
NEW:
```
fails. Configuring the linter and styler as a
pre-commit hook means that unstyled or unlinted code
cannot be committed from a clone where the hook is
installed, unless the analyst bypasses it with
`git commit --no-verify`. That is a stronger guarantee
than a convention that relies on memory, but a clone does
not carry the hook with it. The configuration
```

### A3-55 08-testing-quality.qmd
OLD:
```
The analyst is then prompted to fix it. Continuous
integration, in @sec-verification, runs the same
checks again on the server, so that a collaborator
who has not installed the hook is caught
nonetheless. The hook is the fast local gate; CI is
the authoritative remote one.
```
NEW:
```
The analyst is then prompted to fix it. The hook is
the fast local gate. A collaborator who has not
installed it is caught only if continuous integration
(@sec-verification) runs the same checks on the
server. The workflows in that chapter do not, so a
project that relies on the hook should add a step
running `lintr::lint_dir()` there.
```

## 3. For the lead

- No new BibTeX entry. A3-10 reuses `githubhardening`; after it,
  `githubsecrets` is uncited (keep or remove).
- Tool issues, not book text (for the author):
  1. `zzc verify --full` counts a baseline as 'ran' when its file
     name appears in the test log (`verify.sh:283`). tinytest
     prints the name for a file that exited early with 0 tests.
     A stricter check would count results per file, as
     `ci/run-tests.R` does.
  2. `make docker-test` and `make test` pass an empty suite:
     `all(as.logical(r))` is TRUE for zero results.
  3. The coherence tier's Dockerfile R-version check reads `ARG
     R_VERSION=`, which current generated Dockerfiles do not
     write; it could parse the `FROM` tag or the
     `zzcollab.r.version` label instead.
  4. `ensure-zzrenvcheck` installs zzrenvcheck from HEAD,
     unpinned (`Makefile:132`), as Phase 20 noted.
- `?mcparallel` prose says `mc.set.seed = TRUE` changes behavior
  'only if' L'Ecuyer is selected; the code removes `.Random.seed`
  in the child under Mersenne-Twister. The book follows the code
  (V). Worth knowing if a reader quotes the help page.

## 4. Not verified, and why

- No CI service ran. A3-05 simulates `setup-renv` locally (macOS,
  host R, renv 1.2.3), not on `ubuntu-24.04`.
- `zzc verify --full` and `make docker-test` were not run (Docker
  build). A3-20 to A3-24 rest on the source plus a tinytest log.
- The plain `tar_target(report, ..., format = 'file')` pattern
  (pipelines:790-797) was not rerun; it is the earlier agents' V.
  My tarchetypes is 0.14.1, the text says 0.14.0.
- Package-version non-tracking in `targets` (A3-38) rests on the
  help text, not a two-version experiment.
- PDF determinism (A3-29 to A3-31) was tested on a one-line LaTeX
  document, not a Quarto PDF render of the book or a report.
- Make was tested on GNU Make 3.81 only (RSE reported 4.3 earlier).
- The quoted 'documented case' of cross-boundary state
  (09:640-653) is internal history; not checked.
- Snakemake and Nextflow descriptions (pipelines:1112-1123) rest on
  the cited papers, which I did not open.
- persona-ms item 43 (Nicholls et al. risk tiers, 08 regulated
  passage) is outside this subject and was left for the regulated
  agent.

## Message to the lead

Report at this path. 59 claims checked: 48 verified by run or
source, 6 corrected, 5 hedged. Corrections that matter most: the
redaction quotation at 09:741-744 is on the hardening page, so its
citation should be `githubhardening` (A3-10); the zzcollab render
footer does not print the git version (A3-32); 'any later change
drops the stamp' is false, since only zzcollab regeneration or a
failed `--full` run removes it (A3-22); `targets` does reach
schedulers through `clustermq` (A3-42); no Ch 12 workflow runs
lintr, so the Ch 11 sentence that CI repeats the hook's checks is
false (A3-55). One tool defect for the author: `zzc verify --full`
would count an early-exiting baseline as run (A3-20). The R CMD
check exit status, `setup-renv`, parallel streams, `freeze`,
cache, Make, and the targets claims all hold as written.
