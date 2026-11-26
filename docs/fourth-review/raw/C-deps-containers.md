# Reviewer C: Dependencies and Containers (Chapters 6 and 7)
*2026-11-25 17:55 PST*

## Summary

The two chapters are technically careful in the places the third review
worked on (index versus manifest digests, `RENV_CONFIG_REPOS_OVERRIDE`,
OpenBLAS threads, `LC_NUMERIC`), and much of that care is backed by builds
the author actually ran. Judged against the new stated reader, a true
novice outside biostatistics, they fall short in four ways. First, Chapter
7 never shows how to run a container: there is no `docker run`, no bind
mount, and no way to get code or data into the image without `zzc`. A
reader without the author's tool can build an image and then do nothing
with it. Second, the worked example rests on `zzcollab`, whose current
generated Dockerfile and Makefile contradict the chapter's own rules
(native arm64 on a Mac, one thread variable rather than two, explicit
snapshots). The chapter never names the tool or discloses that it is the
author's. Third, failure paths and decision guidance are thin or deferred:
when not to use Docker, HPC without Docker, disk use, system libraries
(the GDAL story that motivates Chapter 7 is never resolved), and the
future of amd64 emulation on Apple Silicon. Fourth, the chapters total
about 25,000 words (`wc -w`), and the same three-layer argument is
restated many times. Chapter 6's motivating `dplyr` example does not
match the `dplyr` NEWS, and one answer contains a logic error about the
chapter's central invariant.

## Strengths

- The digest discussion distinguishes an index from a platform manifest
  correctly. I checked that the printed `tidyverse:4.4.0` digest (05:1822)
  matches Docker Hub.
- The showcase Dockerfile was built and its failure modes were tested
  (the `renv` version check, the repository override in both directions).
  Very few textbooks do this.
- The verification callout warns against comparing image digests across
  rebuilds. That advice is correct and rarely given.
- The decimal-mark table and the time-zone check question are concrete,
  memorable failures.
- `tbl-cohort-deps` computes the repository state rather than typing it
  (Finding 29 is fixed here).

## Findings

### Chapter 7 never teaches how to run a container or get work into it
- Location: 05-containers.qmd:415-427
- Quote: 'anything one wants to keep, such as edited source or output, must live outside the container, on a host directory made visible inside it.'
- Severity: blocking
- Viewpoint: student
- Evidence: inspected (`grep -n 'docker run'` finds no hit in 05; the first `docker run` in the book is 06-backends-runtimes.qmd:316, as a Podman analogue; no `-v` or bind mount in 05 except the LLM caution at 1597)
- Prior: new
- Problem: The chapter teaches the difference between an image and a container, but it never shows the command that starts one, mounts the project, or runs a script. The showcase Dockerfile copies only `renv.lock` (05:724). The only route to running anything is `make r` in the `zzc` worked example (05:1336). A reader who does not use `zzcollab` can build the image and then cannot use it.
- Why it matters: A novice learns to write an L2 recipe but cannot run the analysis inside it. The chapter therefore fails Section 2's test that a reader without the tool can follow every chapter.
- Fix: After the showcase build, add a short subsection, 'Running the analysis inside the image', with three commands and their expected output: `docker build --platform linux/amd64 -t cohort-env .`; `docker run --rm --platform linux/amd64 -v "$PWD":/project -w /project cohort-env Rscript analysis/scripts/01-clean.R`; and `docker run --rm -it ... cohort-env R` for an interactive session. Explain that the `-v` mount is the 'host directory made visible inside it', that outputs written there persist, and that on Windows the project must sit in the WSL2 filesystem (setup appendix). Add one check question on what is lost when `-v` is omitted.

### The worked example's tool contradicts the chapter's platform and thread rules
- Location: 05-containers.qmd:1343-1348; 05:1363-1370; 05:932-935
- Quote: 'The generated Dockerfile is, in essence, the one shown earlier. It carries a digest-pinned `FROM rocker/r-ver`, the locale and time-zone and thread variables'
- Severity: blocking
- Viewpoint: referee
- Evidence: inspected (zzcollab `templates/Makefile:47-52`, `PLATFORM ?= $(if $(filter arm64,$(_HOST_ARCH)),linux/arm64,linux/amd64)`; `modules/docker.sh:1413-1427`, which builds `--platform linux/arm64` on an arm64 host for every base except verse; `modules/docker.sh:1223-1227`, which sets `OMP_NUM_THREADS=1` and no `OPENBLAS_NUM_THREADS`)
- Prior: 'fix for Finding 30 incomplete' (D15 recorded the arm64 default as a tool issue, but the chapter still tells the reader that the tool implements the book's rule)
- Problem: The chapter says 'this book passes `--platform linux/amd64` to every build, whatever the base' (05:932-935). It requires both thread variables (05:1123-1127, Ex 5 answer). It presents the `zzc` Dockerfile as 'in essence' the showcase. A Mac reader who follows `zzc minimal` and `make docker-build` gets a native arm64 image with only `OMP_NUM_THREADS` set, which is the image the chapter warns against. Moving to `zzc publishing` silently switches that reader to emulated amd64 (persona-rse.md:54 raised this; 05:1363-1370 still calls it 'a single changed line').
- Why it matters: The worked example is the only part of the chapter a novice will actually run. It gives a result that differs from the one the chapter promises, with no disclosure.
- Fix: Either (a) make the worked example match the book: pass `PLATFORM=linux/amd64` explicitly in the shell block (`make docker-build PLATFORM=linux/amd64`) and add `OPENBLAS_NUM_THREADS=1` to the tool, or (b) replace 'in essence, the one shown earlier' with an explicit list of the differences ('on an Apple Silicon Mac the tool builds arm64 natively by default; pass `PLATFORM=linux/amd64` to match CI'). Option (a) is preferable; it is a tool change plus one flag in the text.

### No guidance on when not to use Docker, or on what to do where Docker is unavailable
- Location: 05-containers.qmd:37-50; 05:443-459; 05:847-860
- Quote: 'no Docker or systems-administration background is assumed, since the chapter builds the idea from first principles.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected (the prerequisites do not name the setup appendix; the first link to it is at 05:859, inside the Pilot 4 callout; `@sec-backends` appears only at 05:456 and 05:2111)
- Prior: new
- Problem: The chapter assumes that every reader will install Docker Desktop. It does not say that university HPC systems almost never allow Docker, that some institutions do not license Docker Desktop, or that some analyses do not need L2 at all (a pure-R analysis with no compiled dependencies and a short life). The alternatives (Podman, Apptainer, `rix`/Nix, a CI-only build) are deferred to Chapter 8, which the reader reaches only after installing Docker.
- Why it matters: A skeptical mentor's first question is 'does my student need this?'. A student on a locked-down laptop or a cluster stops at the first `docker build` and does not know that a path exists for them.
- Fix: Add a callout after the Orientation, 'Do you need a container, and can you run one?', with three rows. (1) A short-lived analysis with no compiled or system dependencies: a lockfile plus a recorded R version may be enough; state the L1 claim honestly. (2) Docker is not permitted (HPC, unlicensed institution): read @sec-backends first; Apptainer and Podman consume the same image. (3) Docker is available: install it using the [setup appendix](setup-appendix.qmd) before continuing. Name the setup appendix in the prerequisites.

### The image explanation omits the kernel, and its metaphor reverses recipe and image
- Location: 05-containers.qmd:400-413; 05:272-276
- Quote: 'It is, quite literally, a snapshot of a fully installed computer: it holds an operating system'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: An image holds an operating system's user space but no kernel. Containers share the host's Linux kernel, so on macOS and Windows Docker Desktop runs a hidden Linux virtual machine. The text instead calls the image 'quite literally' a snapshot of a computer. It also says image and container differ 'as a recipe from a meal' (05:402-403), and then calls the Dockerfile 'a recipe' (05:431), so 'recipe' names two different things.
- Why it matters: A student needs the VM fact to understand why Docker Desktop must be running, why it has its own disk and memory limits (setup-appendix.qmd:163), and why the CPU can still change floating-point results inside an 'identical' container (05:1130).
- Fix: Replace the sentence with: 'an image holds everything above the operating-system kernel: the Linux user space, system libraries, R, and packages. A container borrows the kernel of the machine it runs on; on a Mac or Windows laptop, Docker Desktop supplies a small Linux virtual machine for this.' Use a single analogy: Dockerfile is the recipe, image is the frozen meal, container is the meal being eaten. Add a three-box diagram (Dockerfile to image to container, with `docker build` and `docker run` on the arrows). That would also be the chapter's first diagram of its core mental model.

### The GDAL failure that motivates the chapter is never fixed, and system libraries installed with apt are not pinned
- Location: 05-containers.qmd:162-170; 05:796-808; 05:2052-2061
- Quote: 'That is a failure the lockfile could not prevent and the container does.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (`grep -n 'apt-get'` finds no hit in 04 or 05; renv `sysreqs()` added in renv 1.1.2, verified at https://cran.r-project.org/web/packages/renv/news/news.html)
- Prior: new
- Problem: The chapter opens with a package that needs GDAL. No Dockerfile in the chapter installs a system library, so the reader never learns the `apt-get install libgdal-dev` step. The text also says the `FROM` line 'fixes the operating system, the system libraries' (05:796-798), which is true only for what the base image already carries. Anything installed with `apt-get` later resolves against the live Ubuntu archive on build day and is not pinned by the digest or the PPM snapshot. Neither `renv::sysreqs()` nor `pak::pkg_sysreqs()`, which list the system packages a lockfile needs, is mentioned.
- Why it matters: Spatial, imaging, and XML packages are common in health and environmental research. A student who copies the showcase recipe will hit exactly the failure that opened the chapter.
- Fix: Add a `RUN apt-get update && apt-get install -y --no-install-recommends libgdal-dev libgeos-dev libproj-dev && rm -rf /var/lib/apt/lists/*` line to a variant of the showcase. Add a short paragraph: apt packages are fixed only when the image is built; to keep them, keep the built image (by digest in a registry, @sec-archiving), not just the recipe. Show `renv::sysreqs()` (or `pak::pkg_sysreqs()`) as the way to find the needed libraries.

### Emulation is presented as a cost only in time; Rosetta and its phase-out are not mentioned
- Location: 05-containers.qmd:937-952; 05:992-1004
- Quote: 'This is a real cost, worth planning a build around, but it is a cost in time, not in correctness.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (zzcollab `templates/Makefile:47-50` and `modules/docker.sh:1416` state that QEMU emulation 'breaks' or 'kills Haskell binaries such as pandoc'); verified (Apple: 'macOS 27: Final release to support Rosetta', https://developer.apple.com/news/?id=w5ngl9k2); unverified (whether Docker Desktop's amd64 emulation will lose Rosetta after macOS 27)
- Prior: new (does not reopen D15; it concerns the wording of a consequence, not the decision)
- Problem: The author's own tool records that emulated amd64 builds can crash (pandoc). The chapter says only that emulation is slow. It does not mention Docker Desktop's optional Rosetta-based emulation (off by default, per phase25/agent2-report.md A2-18). Apple has announced that macOS 27 is the last release to fully support Rosetta. The book's strategy (always amd64, on Macs, via emulation) is therefore exposed to a platform change during the book's life.
- Why it matters: A Mac student whose emulated build crashes will read the chapter's 'not wrong' as a sign that they made a mistake, when emulation is a known failure path.
- Fix: Replace the sentence with: 'Emulation is slower and occasionally fails outright (some compiled tools, pandoc among them, can crash under QEMU); when an emulated build crashes, try enabling Docker Desktop's Rosetta option, or build on CI (@sec-ci) and pull the result.' Add one sentence that emulation support on Apple Silicon depends on Apple's and Docker's roadmaps and should be rechecked. Add 'crashes under emulation' as a row in the setup appendix's symptom table.

### The showcase is anchored on R 4.4.0, and the amd64-only claim no longer holds for current tidyverse images
- Location: 05-containers.qmd:908-922; 05:2076; 05:700-703; setup-appendix.qmd:22-28
- Quote: 'But `rocker/tidyverse:4.4.0` and `rocker/verse:4.4.0`, the bases of the tidyverse and publishing profiles, publish `linux/amd64` only (verified)'
- Severity: major
- Viewpoint: referee
- Evidence: verified (Docker Hub API, `curl -s https://hub.docker.com/v2/repositories/rocker/tidyverse/tags/4.6.1`: amd64 and arm64, last updated 2026-10-29; `.../tidyverse/tags/4.6.2`: amd64 and arm64, 2026-11-16; `.../verse/tags/4.6.2`: amd64 only; `.../r-ver/tags/4.6.2` exists, 2026-11-25)
- Prior: new
- Problem: The statement is correct for 4.4.0 but is written as a fact about 'the bases of the tidyverse and publishing profiles'. The cheat sheet (05:2076) and setup appendix repeat it. For the compendium's own R (4.6.1, from its lockfile), `rocker/tidyverse` is multi-architecture, so a Mac build without the flag silently succeeds natively, which is the riskier case. The showcase also uses R 4.4.0 on `jammy` (a 2024 release) with a lockfile whose recorded R 'was set to 4.4.0 to match the image' (05:692-693). Chapter 6's lockfile records R 4.6.1. A novice sees two inconsistent R versions and a hand-edited lockfile.
- Why it matters: The book's Apple Silicon advice is now wrong for the images a reader would choose in late 2026, and the showcase looks dated to a referee.
- Fix: Rebuild the showcase on `rocker/r-ver:4.6.x` (`noble`), using Chapter 6's lockfile unedited. Reword 05:913-915 to 'at 4.4.0 ... (verified 2026-10-11); later tidyverse tags are multi-architecture, so check with `docker buildx imagetools inspect` rather than assume'. Fix the cheat-sheet row the same way.

### The triad gate depends on an undisclosed author tool when renv itself provides the core check
- Location: 04-dependencies.qmd:691-713; 04:775-819; 04:580-581
- Quote: 'A scanner that read only the code would certify the project as consistent.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (renv `status()` reports packages 'used and not recorded', https://rstudio.github.io/renv/reference/status.html; `renv::dependencies()` parses '.R, .Rmd, .qmd, DESCRIPTION', https://rstudio.github.io/renv/reference/dependencies.html); inspected (`grep -c 'framework this book uses|the framework'` gives 6 in 04 and 2 in 05; neither chapter contains 'zzcollab'; the preface, preface.qmd:59-71, does not say the tool is the author's)
- Prior: new
- Problem: The chapter's enforceable check is `zzrenvcheck`, a non-CRAN package installed from the author's GitHub. The weaker compendium invariant it enforces, Code ⊆ renv.lock, is exactly what `renv::status()` reports. The section on scanning documents sets up a 'code-only' scanner as a straw man. `renv::dependencies()`, and therefore `renv::snapshot()`, already reads `.Rmd` and `.qmd`, as the chapter's own `tbl-cohort-deps` shows. The tool appears only as 'the framework this book uses', and its authorship is not disclosed here.
- Why it matters: A reader without the tool is not taught the built-in check. A referee will read the omission as promotion of the author's software.
- Fix: Teach `renv::status()` first, as the tool-neutral check (show its 'used but not recorded' output, and a CI line such as `Rscript -e 'stopifnot(renv::status()$synchronized)'`, after verifying its behavior). Present `zzrenvcheck` second, for what it adds: the `DESCRIPTION` middle term, auto-repair, and the Dockerfile pass. Name it once with a disclosure ('`zzcollab` and `zzrenvcheck`, written by this book's author'). Delete the straw-man sentence or rewrite it as 'renv's scan already reads documents; zzrenvcheck additionally ...'.

### The auto-snapshot hook contradicts the first analyst judgment, and the tool's snapshot type contradicts the chapter's description
- Location: 04-dependencies.qmd:518-526; 04:222-228; 04:497-503
- Quote: 'The project's generated `.Rprofile` installs an exit hook that snapshots the library when an interactive session ends'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (zzcollab `templates/.Rprofile:222-230` runs `renv::snapshot(prompt = FALSE)` in `.Last` with no `interactive()` test, and only when `renv/activate.R` exists; `.Rprofile:136-140` initializes new projects with `snapshot.type = "explicit"`); inferred (consequence for script-only packages)
- Prior: new
- Problem: Judgment 1 says choosing when to snapshot belongs to the analyst, and that a snapshot taken mid-exploration pins a half-installed state. The tool then snapshots automatically at every session exit. Separately, the chapter describes snapshot as a scan of the code (the implicit type). New `zzcollab` projects use the explicit type, which records only `DESCRIPTION` dependencies. In compendium mode, where script-only packages are supposed to sit in the lockfile but not in `DESCRIPTION` (04:617-623), an explicit snapshot would plausibly drop them, and `check-renv` would then add them back. The book's own repository uses `implicit` (`renv/settings.json`), so the book and the tool it recommends differ.
- Why it matters: The chapter teaches a judgment and then hands it to a hook. A novice cannot tell which behavior governs their lockfile.
- Fix: Either remove the paragraph, or say plainly: 'the framework snapshots on exit by default (disable with `ZZCOLLAB_AUTO_SNAPSHOT=false`); this trades judgment 1 for never forgetting, so review the lockfile diff before each commit.' Reconcile the snapshot type in the tool (record it as a tool issue) or describe explicit snapshots in the text.

### Logic error in the triad answers: undeclared does not imply unpinned
- Location: 04-dependencies.qmd:894-899; 04:1516-1523
- Quote: 'This in turn leaves it unpinned in the lockfile. The transitive composition $\mathrm{Code} \subseteq \mathrm{renv.lock}$ therefore fails as a consequence'
- Severity: major
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: Breaking Code ⊆ DESCRIPTION does not break Code ⊆ renv.lock. A package missing from `DESCRIPTION` can still be in the lockfile, either as a transitive dependency or through an implicit snapshot. `survival`, used in `R/model.R`, is very likely already pinned. The answers derive a false consequence from the subset relation that the chapter is teaching.
- Why it matters: This is the chapter's one formal argument. A careful student, or a mentor checking it, will notice the error.
- Fix: Replace with: 'Only the first inclusion is known to fail. Whether the package is also unpinned depends on whether the lockfile already records it, for instance as a transitive dependency; check with `renv::status()`.'

### Chapter 6's motivating `dplyr` example does not match the `dplyr` NEWS
- Location: 04-dependencies.qmd:150-155; 04:206-209
- Quote: '`dplyr` had moved from version 1.1.0 to 1.2.1, a grouping default had been refined, and one intermediate summary was computed over a slightly different partition.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (`curl -s https://cran.r-project.org/web/packages/dplyr/news/news.html`; the 1.2.0 and 1.2.1 sections contain no change to a grouping default, only a clearer `.groups` message and the soft-deprecated `dplyr.legacy_locale`; the 1.1.0 'Breaking changes' read: '`arrange()` and `group_by()` now use the C locale, not the system locale, when ordering or grouping character vectors')
- Prior: new
- Problem: The scenario reads as fact ('a familiar situation'), but no 1.1.0 to 1.2.1 grouping-default change exists. A real, documented change that fits the chapter does exist: `dplyr` 1.1.0 changed the ordering of `group_by()` from the system locale to the C locale. It changes row order, not group partitions, so 'different partition' and 'different coefficient' would also need rewording. The arithmetic in the check answer (04:206-209) repeats the invented mechanism.
- Why it matters: A book whose fourth goal is accuracy should not open a chapter with an invented package change presented as real, especially when a real one is available.
- Fix: Rebase the vignette on `dplyr` 1.0.10 to 1.1.0 and the C-locale ordering change, with a `group_by() |> summarise() |> slice(1)` consequence and a citation to the NEWS entry. Otherwise label it explicitly: 'a hypothetical change, of a kind that does occur'.

### Missing current tooling: rig, pak, system requirements, Bioconductor, PPM's arm64 and manylinux binaries
- Location: 04-dependencies.qmd:986-1013; 04:914-959; 04:1040-1093
- Quote: 'It does not pin the R interpreter itself, so a lockfile produced under R 4.6.0 may restore under R 4.2.1 with different results.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (renv 1.3.1 published 2026-10-06, https://cran.r-project.org/package=renv; `sysreqs()` in renv 1.1.2 and pak integration since 0.15.0, renv NEWS; Posit page: 'Linux support spans 10 distributions with ARM64 and portable manylinux', https://posit.co/products/enterprise/public-package-manager); inspected (no 'rig', 'Bioconductor' workflow, or 'pak' install appears in 04, except a regex example at 804)
- Prior: new
- Problem: The chapter says the lockfile cannot install R, but it does not name `rig`, the standard way to install and switch R versions on a host without a container. It does not mention `pak`, now the common installer, which `renv` can use and which `zzcollab` itself uses (docker.sh:1182). System-requirement lookup (`renv::sysreqs()`) is absent. Bioconductor gets one word, although `renv` records the Bioconductor release and that matters to genomics readers. The PPM text treats Linux binaries as codename- and amd64-specific. Posit now serves arm64 Linux and portable manylinux binaries, which bears on 05:928-930 ('the packages compiled from source' on arm64).
- Why it matters: A referee will treat the omission of `rig` and `pak` in a late-2026 R reproducibility text as a currency gap. `rig` is also the only intermediate step between L1 and Docker for students who cannot use containers.
- Fix: Add about 300 words to 'The limits of renv': `rig add 4.6.1` and `rig default 4.6.1` to match the lockfile's R on the host (a partial step that is still not L2); `renv::sysreqs()` to list missing system libraries before a restore fails; one sentence on `options(renv.config.pak.enabled = TRUE)`; and one sentence on Bioconductor records. Recheck the PPM arm64 and manylinux URLs and update 04:946-951 and 05:928-930.

### Disk use and resource failures are not addressed
- Location: 05-containers.qmd:505-520; 05:1170-1190
- Quote: '`rocker/verse` adds a LaTeX toolchain for rendering manuscripts to PDF.'
- Severity: major
- Viewpoint: student
- Evidence: verified (Docker Hub API compressed sizes: `rocker/verse:4.6.2` amd64 1.96 GB, `rocker/tidyverse:4.6.2` 1.1 GB, `rocker/r-ver:4.6.2` 0.42 GB; uncompressed sizes on disk are larger); inspected (no 'disk', 'prune', or size figure in 05)
- Prior: new
- Problem: The profile discussion argues from 'image size' without giving any size. It never warns that images, build cache, and emulated duplicates accumulate to tens of gigabytes. It never shows `docker system df` or `docker image prune`. Docker Desktop's disk ceiling appears only in a setup-appendix table row.
- Why it matters: A student laptop with a 256 GB drive fills up within a few weeks of rebuilding, and the resulting failures ('no space left on device', stalled builds) are not obviously linked to Docker.
- Fix: Add the three compressed sizes as a small table in the profiles section, computed or dated. Add a 'Housekeeping' paragraph with `docker system df`, `docker image prune`, and `docker builder prune`, and one sentence noting that the pinned image you want to keep should be tagged or pushed before pruning.

### Undefined forward references in Chapter 6: the uncited 'whitepaper', the 'two-test procedure', Dockerfiles, the oracle rule, and 'Habit 3'
- Location: 04-dependencies.qmd:236-237; 04:1321-1327; 04:1704-1705; 04:1729-1734
- Quote: 'a distinction we develop below and that the accompanying whitepaper treats at length.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (no citation key on either 'whitepaper' mention; 'two-test procedure' first appears at 04:1322 with no earlier definition; the LLM verification asks the reader to confirm that `languageserver` is 'in the Dockerfile' a chapter before Dockerfiles are taught)
- Prior: new
- Problem: The chapter promises to 'develop below' the distinction between a result dependency and development tooling, but it never does. It then relies on a 'two-test procedure' and 'your stated convention' for test packages that the reader has not met, and points to an unpublished, uncited whitepaper. The cheat sheet adds an 'oracle' rule of thumb and 'Habit 3' with no context in this chapter.
- Why it matters: A novice is asked to apply a rule nobody has given them.
- Fix: Add one short subsection with the two tests stated in full (does the package's version affect the result? does the code reference it?) and a three-row example (`dplyr`, `tinytest`, `languageserver`). Cite the whitepaper with a URL or remove it. Move the Dockerfile clause to Chapter 7. Drop the oracle row from this cheat sheet or rephrase it for this chapter.

### Length and repetition across the two chapters
- Location: 04-dependencies.qmd:441-470; 04:986-1013; 05-containers.qmd:154-224, 334-396, 2039-2062
- Quote: 'Nothing has been lost, because the old `Hash` never checked file integrity in the first place.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`wc -w`: 11,183 and 14,007 words including code; 12 and 13 'Check your understanding' blocks)
- Prior: 'reopens D18' (new argument: the target reader has changed from 'MS and PhD students in the health sciences who know R and basic git' to true novices, for whom repetition of an already-understood point costs attention needed for the mechanics this chapter omits, such as `docker run`)
- Problem: Chapter 7 states 'a lockfile pins packages but not the OS, system libraries, or R' in the orientation, the following check, 'What the lockfile leaves standing' and its check, Exercise 8, and its solution. Chapter 6's 'The limits of renv' already makes the same argument with the same GDAL and `libxml2` examples. The Hash Pitfall repeats the paragraph before it (reader-b.md:149 flagged this; it is still present).
- Why it matters: About 2,500 words could be cut, which would pay for the `docker run`, system-library, and 'when not to use Docker' material above without lengthening the book.
- Fix: Cut the Hash Pitfall callout (04:456-470). Shorten 'The limits of renv' to one paragraph plus a forward pointer. Merge 05's Orientation second paragraph with 'What the lockfile leaves standing' and delete one of the two checks. Rewrite Exercise 8 of 05 as a spaced question about Chapter 6 content not already restated in Chapter 7. Move the `rang`, `groundhog`, and `capsule` section to a two-sentence pointer plus further reading.

### 'Works on my machine cannot arise' overclaims
- Location: 05-containers.qmd:1280-1286
- Quote: ''Works on my machine' therefore cannot arise: there is, in the relevant sense, only one machine.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: The same chapter says that no rung fixes the numerical-library layer and that a different CPU can still move the last digits (05:1128-1132).
- Why it matters: A referee will quote the contradiction.
- Fix: 'Most of the causes of "works on my machine" are removed; the CPU and any run-time overrides of the thread variables remain.'

### Exercise 3 solution still conflicts with the worked example on data analysis
- Location: 05-containers.qmd:1858-1860; 05:1323-1328
- Quote: '**Data analysis:** tidyverse, because the analysis draws most of its stack from the base rather than the lockfile'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: 'fix for reader-b.md:183 incomplete'
- Problem: The worked example and 'The cohort, continued' choose minimal for data analysis, and the solution's own trade-off paragraph prefers minimal for 'honesty'. Recommending tidyverse also implies that the analysis depends on base-image packages outside the lockfile.
- Why it matters: Self-study readers check their answer against the solution.
- Fix: 'Minimal, or tidyverse if build time matters more than a complete lockfile; see the worked example.'

### R-package archetype on `rocker/r-ver` lacks some check tools
- Location: 05-containers.qmd:1217-1220
- Quote: 'R and the check tools suffice, so the minimal base is the honest choice'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (expert knowledge: `R CMD check --as-cran` uses pandoc for vignettes, qpdf, and LaTeX for the PDF manual unless `--no-manual` is passed)
- Prior: new
- Problem: `rocker/r-ver` is R on Ubuntu and 'little else'. A full check of a package with vignettes will fail or warn without pandoc, qpdf, or LaTeX.
- Why it matters: A student following the advice may meet a failed `R CMD check` that the chapter says should pass.
- Fix: Add 'plus pandoc and qpdf if the package has vignettes, and `--no-manual` or a LaTeX toolchain for the PDF manual'.

### The HTTP user-agent sentence is too vague to act on
- Location: 04-dependencies.qmd:946-952
- Quote: 'and R may need to send its version in the HTTP user agent.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (zzcollab sets it explicitly, `modules/docker.sh:1238`)
- Prior: new
- Problem: The text names a requirement and gives no command or condition.
- Why it matters: A Linux user who gets source builds from a binary URL has nothing to try.
- Fix: Give the `options(HTTPUserAgent = ...)` line the tool uses, or say 'Rocker images and recent R set this for you; if a binary URL still delivers source, see the Package Manager setup page'.

### Docker Desktop licensing is mentioned without explanation
- Location: 05-containers.qmd:850-852
- Quote: 'agency-issued laptops may not permit WSL or an unlicensed Docker Desktop'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (the licensing explanation is in 06-backends-runtimes.qmd:329-337)
- Prior: new
- Problem: 'Unlicensed' implies a license requirement that Chapter 7 never explains.
- Why it matters: Readers at large universities may be in breach without knowing it.
- Fix: Add a clause: 'Docker Desktop requires a paid subscription in larger organizations (@sec-backends); Podman is a license-free alternative.'

### LaTeX-heavy base for manuscripts without mentioning lighter routes
- Location: 05-containers.qmd:1213-1216
- Quote: 'A **manuscript** archetype needs the publishing base, because rendering to PDF requires the LaTeX toolchain'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (expert knowledge: Quarto renders PDF through Typst without LaTeX, and TinyTeX is far smaller than `rocker/verse`)
- Prior: new
- Problem: 'Needs' is too strong in 2026, and `rocker/verse` is amd64-only, so the publishing profile also forces emulation on a Mac.
- Why it matters: It is the largest image and the only profile that cannot run natively on a Mac.
- Fix: 'needs a PDF engine: `rocker/verse` (LaTeX), or a minimal base with TinyTeX, or Quarto's Typst output.'

### Hash statement may overstate what current renv writes
- Location: 04-dependencies.qmd:1466-1469
- Quote: '`renv` before 1.1.0 wrote one, but it was a fingerprint of `DESCRIPTION` fields used to key the package cache, never a hash of the installed files. Current `renv` does not write it.'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (renv NEWS, 1.2.3: 'The Hash field is not computed for enriched records', which suggests that non-enriched records may still carry one; I did not test this)
- Prior: new
- Problem: The claim may be true only for enriched (repository-installed) records.
- Why it matters: The chapter treats the field's absence as diagnostic of the renv version (Exercise 2 solution, 04:1488-1491).
- Fix: Test a GitHub-sourced record under renv 1.3.1 and hedge to 'repository records written by current renv carry no `Hash`'.

### Version and date currency in Chapter 6
- Location: 04-dependencies.qmd:361-363; 04:1432-1434
- Quote: 'The excerpt below comes from a lockfile that `renv` 1.2.3 wrote on 2026-10-11, under R 4.6.1'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (renv 1.3.1 published 2026-10-06, https://cran.r-project.org/package=renv; `rocker/r-ver:4.6.2` on Docker Hub, 2026-11-25)
- Prior: new
- Problem: renv 1.3.1 had been on CRAN for five days when the 1.2.3 excerpt was written, and R 4.6.2 now exists. The dated framing is honest, but Exercise 1 asks readers to compare with this version.
- Why it matters: Readers will see a different version immediately.
- Fix: Keep the dated excerpt, and add 'later versions may add fields; the four features below are stable across 1.1.0 to 1.3.1'.

### The tag-rebuild figure narrates rebuilds of a tag that has not moved since 2024
- Location: 05-containers.qmd:611-667; 05:570-577
- Quote: 'a maintainer rebuild in April and another in September silently change the ground the analysis stands on'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (Docker Hub API: `rocker/r-ver:4.4.0` last updated 2024-06-14 with digest `sha256:73adab...`, the one printed at 05:703; `r-ver:4.6.1` last updated 2026-10-29)
- Prior: new
- Problem: Rocker rebuilds versioned tags while they are current and stops afterwards. The figure labels an illustrative timeline with a real tag that did not move.
- Why it matters: A referee checking the figure will find the example does not occur for that tag.
- Fix: Label the timeline 'illustrative', or use a current tag (4.6.1, which was repushed after this chapter's build date) and say that Rocker rebuilds a versioned tag while it is the current release.

### Exercise 5 in Chapter 6 does not say how to use `rang` without Docker
- Location: 04-dependencies.qmd:1384-1388
- Quote: 'use `rang` to reconstruct the package environment as it stood on a chosen past date.'
- Severity: minor
- Viewpoint: student
- Evidence: unverified (expert knowledge: `rang::resolve(pkgs, snapshot_date)` returns the version graph; `dockerize()` needs Docker)
- Prior: new
- Problem: `rang`'s main output is a container recipe, which the reader has not met yet.
- Why it matters: A novice may stall on Docker one chapter early.
- Fix: Name `rang::resolve()` and say that no container is needed for the comparison.

### Hard-coded chapter number in Exercise 8
- Location: 05-containers.qmd:1738-1739
- Quote: 'This exercise returns to the lockfile of Chapter 6, 'Pinning Packages with renv' (@sec-dependencies).'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: The cross-reference already supplies the number; the typed number will go stale if the order changes.
- Why it matters: It is a maintenance risk of the kind Finding 29 targeted.
- Fix: Delete 'Chapter 6,'.

### The `WORKDIR` rationale cites `renv::init()`, which the recipe does not call
- Location: 05-containers.qmd:744-750
- Quote: 'That directory contains the home directory, and `renv::init()` refuses to initialize a project in that position.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: The showcase calls `renv::restore()`, not `init()`, so the stated reason does not apply to this recipe.
- Why it matters: It confuses the reader about which call the guard protects.
- Fix: 'keeps `renv`'s project files out of `/`, and avoids `renv` treating the whole filesystem as the project.'

## Scope disclosure

- Read in full: `04-dependencies.qmd` (1,739 lines), `05-containers.qmd` (2,116 lines), `THIRD-REVIEW-PLAN.md` (991 lines), `fourth-review-prompt.md`, and `BRIEF.md`.
- Inspected in part: `setup-appendix.qmd` (lines 1-60 plus a grep), `06-backends-runtimes.qmd` (grep only), `preface.qmd:55-80`, and `docs/third-review/reader-b.md` (grep for Chapters 6 and 7, about 100 lines). I grepped `persona-rse.md` and `phase25/agent2-report.md` for specific topics. I did not grep `REFACTOR-PLAN.md` systematically, so a duplicate of an earlier review-two item is possible.
- Tool sources inspected: zzcollab `modules/docker.sh:1060-1440`, `templates/Makefile` (grep plus lines 44-56 and 164-200), `templates/.Rprofile:1-30` and `100-250`, `templates/bundles.yaml` (profile names match the book), and `zzrenvcheck/R/config.R` and `compare.R` (grep; claims at 04:763-806 are consistent, and DESCRIPTION gives 0.10.0). I did not confirm that commit `6f53235` is 0.10.0.
- Executed: no R, Docker, renv, or Quarto. Only `curl` against the Docker Hub API and CRAN, plus grep and `wc`.
- Verified externally: renv NEWS and CRAN page, renv `status()` and `dependencies()` reference pages, `dplyr` NEWS (by curl and grep), Docker Hub tag metadata, Apple's Rosetta notice, and Posit's Public Package Manager page.
- Not verified: Docker Desktop's current default for amd64 emulation and its post-macOS-27 behavior; the claim that QEMU crashes pandoc (taken from the tool's comments); the `Hash` behavior of current renv; R CMD check requirements on `r-ver`; and the `rang` API. A web-search snippet about Docker 'known issues' crashes could not be confirmed by direct fetch and is not relied on.
