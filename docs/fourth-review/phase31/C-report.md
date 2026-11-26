# Phase 31, Agent C Report: Chapters 6 and 7
*2026-11-26 09:13 PST*

Files edited: `analysis/report/04-dependencies.qmd` (Ch 6) and
`analysis/report/05-containers.qmd` (Ch 7). No other book file
was touched. No commit. Scratch material is under
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/c/`.

## Word counts (`wc -w`)

| File | Before | After | Change |
|---|---|---|---|
| 04-dependencies.qmd | 11,431 | 11,792 | +361 |
| 05-containers.qmd | 15,556 | 16,778 | +1,222 |

Both chapters grew. The additions required by R6-05, R7-04
(about 50 lines of figure code), R7-05, R7-06, R7-07 and R7-10 to
R7-11 come to roughly 2,300 words; the repetition cuts come to
roughly 750. The R4-011 target of about 2,500 words cut from
Ch 6 and 7 is therefore **not met**; see the R4-011 row.

## Findings

| ID | Status | What changed, and evidence |
|---|---|---|
| R6-05 | Done | 'The limits of renv' now names `rig` (README syntax; **not run**, `rig` is not installed here), `renv::sysreqs()` with real output for `sf` on Ubuntu 22.04, `pak` through `options(renv.config.pak.enabled = TRUE)` (V: a restore in a scratch project installed through pak 0.11.2), and the lockfile's `Bioconductor` block (V: `renv::settings$bioconductor.version('3.23')` then a snapshot wrote `"Bioconductor": {"Version": "3.23"}`). The PPM text now states which Linux distributions get arm64 binaries (jammy x86_64 only; noble x86_64 and arm64; manylinux glibc 2.28+), and Ch 7 uses this to explain why the native arm64 showcase build compiled from source. Cheat-sheet row for `sysreqs()` added. |
| R6-06 | Done | Judgment 2 now states the two tests (does the version affect the result; does the code reference it) and a three-row table (`dplyr`, `tinytest`, `languageserver`). 'Develop below', the whitepaper (both mentions), 'two-test procedure', 'your stated convention', and the Dockerfile clause in the LLM verification are gone; the LLM verification now points back to the two tests. The cheat-sheet 'oracle' row is replaced by a placement rule of thumb. 'Habit 3' is kept: the chapter's included LLM callout introduces habit 3, and Conventions says rules cite habits by number. |
| R6-07 | Done | The PPM paragraph gives the `options(HTTPUserAgent = ...)` line from Posit's documentation, reformatted to 78 columns, and says Rocker images already set it. V: the line evaluates under R 4.6.2; `getOption('HTTPUserAgent')` in the `rocker/r-ver:4.4.0` showcase image returned `R/4.4.0 R (4.4.0 x86_64-pc-linux-gnu x86_64 linux-gnu)`. |
| R6-08 | Done | V: under renv 1.3.1 a snapshot wrote no `Hash` for a CRAN record (`jsonlite`) or a GitHub record (`rladies/praise`). The Exercise 1 solution now says exactly that and adds 'we did not test every kind of source'. |
| R6-09 | Done | After the dated 1.2.3 excerpt: 'Later versions may add fields. A snapshot taken with renv 1.3.1 on 2026-11-26 wrote records of the same form, and the four features held.' I did not claim 'stable across 1.1.0 to 1.3.1', since I tested only 1.3.1 (the excerpt itself is 1.2.3). |
| R6-10 | Done | Exercise 5 names `rang::resolve()` and says no container is needed. The 'Lighter approaches' paragraph states the archival (2026-08-22) and the install route `remotes::install_version('rang', '0.3.0')`. V: that call installed rang 0.3.0 into a scratch library under R 4.6.2, and `rang::resolve('dplyr', snapshot_date = '2023-01-15')` returned dplyr 1.0.10 with 15 dependencies; the solution quotes this (it matches the chapter's opening story). |
| R7-03 | Done (partly new) | Phase 29's section already covered licensing, clusters, and alternatives, and the prerequisites already name the setup page. Added only the missing part: a paragraph on when L2 is not needed (short-lived, pure-R, no system libraries, not rerun elsewhere), with `rig` as the intermediate step. Outline updated. No three-row callout was added, to avoid a second structure beside the existing section. |
| R7-04 | Done | The 'quite literally a snapshot of a fully installed computer' sentence is replaced: an image holds everything but the kernel; a paragraph explains Docker Desktop's Linux VM, why it must be running, its own resource limits, and why the CPU still matters. One analogy (Dockerfile recipe, image frozen dish, container a thawed portion); 'class from an object' removed. Vocabulary: Image entry corrected, Kernel entry added. New computed figure `fig-docker-objects` (ggplot, with `fig-cap` and `fig-alt`), checked visually in the scratch render. Evidence for the VM: Docker Desktop settings page ('Docker Desktop Linux VM', memory and disk limits). |
| R7-05 | Done | New `###` 'System libraries the base does not carry'. V (Docker 29.9.2, Apple Silicon, `--platform linux/amd64`): installing `sf` 1.1-1 binaries from the showcase snapshot into the showcase image succeeded, and `library(sf)` then failed on `libudunits2.so.0`; the variant with one `apt-get install libgdal-dev libgeos-dev libproj-dev libudunits2-dev` line built in 114 s, the apt step installed 138 packages (590 MB) and upgraded 13 base packages (`libxml2`, `libssl3` among them), and `library(sf)` printed 'Linking to GEOS 3.10.2, GDAL 3.4.1, PROJ 8.2.1'. A paragraph states that apt packages resolve against the live archive and are fixed only in the built image; the upgrade of base packages is used as the evidence. `renv::sysreqs()` is shown in Ch 6 and pointed to here. Only the added `RUN` instruction is printed, not a second full Dockerfile, so the instructor guide's showcase parser still finds the original first. FROM-line paragraph now says 'the system libraries the base carries'. |
| R7-06 | Done | 'A cost in time, not in correctness' is now conditional on the build completing. Added: emulation can fail (Docker's multi-platform page offers a manual QEMU install 'if emulation fails', cited `docker2024multiplatform`); the Rosetta setting by its exact name from Docker's settings page, 'Use Rosetta for x86_64/amd64 emulation on Apple Silicon', off by default, available with the Apple Virtualization framework; the CI route; Apple's notice that macOS 27 is the final release to support Rosetta for Intel-only apps, with Docker's behavior after that stated as unknown. **Not done:** the symptom-table row, which lives in the setup page (lead's file; proposed below). The zzcollab comment that QEMU crashes pandoc was not verified and is not used. |
| R7-07 | Done | `tbl-rocker-sizes`: compressed sizes of `r-ver`, `rstudio`, `tidyverse`, `verse` 4.6.2 for amd64 and arm64, from the Docker Hub API today; the showcase image's real size on disk (853 MB, from a 331 MB download) for the compressed-versus-unpacked point. New `###` 'Housekeeping: disk space' with the real `docker system df` output and the result of a real `docker image prune -f` (reclaimed 997.1 MB) and `docker builder prune -f` (674.6 kB), and a warning about `prune -a`. |
| R7-08 | Done | 'Cannot arise ... only one machine' replaced by 'most causes ... are thereby removed; the processor and run-time thread overrides remain'. The matching check answer was reworded the same way. |
| R7-10 | Done | R-package bullet: `rocker/r-ver` lacks `pandoc`, `qpdf`, and LaTeX. V: `command -v` in `rocker/r-ver:4.4.0` (amd64) and `4.6.0` (arm64) found none of the three (make and gcc present). The uses (pandoc for R Markdown vignettes, qpdf under `--as-cran`, LaTeX for the manual unless `--no-manual`) are inspected from R's check behavior, not run. |
| R7-11 | Done, neutral | Manuscript bullet, analyst judgment 1, and Exercise 3 solution now say 'a PDF engine'; `rocker/verse` carries LaTeX; TinyTeX and 'the Typst engine that Quarto bundles' are named as lighter alternatives with a pointer to @sec-literate. V: Quarto 1.11.9 here reports `typst 0.15.1`. At the time of my edit Ch 8 mentioned only `tinytex::tlmgr_install()`; the wording makes no claim about what Ch 8 says, so it stays consistent whatever agent D adds. The lead should check the pair after D's edits. |
| R7-12 | Done | Caption and alt text say 'illustrative'; the text adds that Rocker rebuilds a versioned tag while its R release is current. V (Docker Hub API today): `r-ver:4.6.1` last updated 2026-10-29, the date of R 4.6.2 (from `R.version.string`); `r-ver:4.4.0` last updated 2024-06-14. |
| R7-13 | Done | 'Chapter 6,' removed when Exercise 8 was rewritten. |
| R7-14 | Done | V: a variant built without `WORKDIR` restored `jsonlite` and left `renv.lock` in `/`, with no `/renv` directory; the old `renv::init()` rationale did not apply. The bullet and the cheat-sheet row now say `WORKDIR` keeps the project out of `/` and is where `docker run` mounts it, a matter of order rather than correctness. |
| R4-011 (4) | Partly done | Cut: the Ch 6 Hash Pitfall callout; the second 'limits of renv' paragraph; the closing restatement in 'Lighter approaches'; the whitepaper paragraph in Further reading. Ch 7: the Orientation's second paragraph (15 lines to 5); the opening and closing restatements in 'What the lockfile leaves standing'; the 'three layers, one tool' check (the Orientation's check covers the same ground); the 'divide the labor' paragraph halved; the 'runs the same everywhere' closing sentence; the LLM verification's repeat of the digest advice (now points to the Verification box); 'What has she gained' shortened. Exercise 8 rewritten as a spaced question on Ch 6's `renv::status()` gate, which Ch 7 does not restate, with a new solution. Grep found no other reference to the removed check or the Pitfall. Net growth remains (table above). |

## Commands run, with results

All scratch work used `RENV_PATHS_ROOT` and libraries under the
scratch directory; nothing was installed into the host library.

- `renv-test.R`: scratch project, renv 1.3.1, snapshot of
  `jsonlite` (CRAN) and `rladies/praise` (GitHub); neither record
  has `Hash` or `Requirements`.
- `renv-test2.R`: `renv::sysreqs('sf', distro = 'ubuntu:22.04',
  check = FALSE)` (the nine `sudo apt install` lines printed in
  Ch 6); the Bioconductor block. The same call without
  `check = FALSE` also worked.
- `renv-pak.R`: library deleted, `renv::restore()` with pak
  enabled; jsonlite and praise reinstalled through pak 0.11.2.
- `rang-test.R` and a second run with
  `remotes::install_version('rang', '0.3.0')` in a fresh scratch
  library: both installed rang 0.3.0; `resolve()` worked.
- Docker: `gdal/scripts/make-lock.R` in `cohort-env` (failure of
  `library(sf)`, lockfile of 12 packages); `gdal/proj/Dockerfile`
  built (log `gdal/build.log`); `noworkdir/Dockerfile` built; tool
  checks for pandoc, qpdf, pdflatex; `HTTPUserAgent` in the image.
  The two scratch images were removed afterwards.
- `docker system df`, `docker image prune -f`, `docker builder
  prune -f`. **Note for the author:** `docker image prune -f`
  removed one dangling (untagged) `clickhouse/clickhouse-server`
  image on this machine, 997.1 MB; no tagged image was touched.
- `hubsizes.sh`: Docker Hub tag API for four Rocker repositories
  at 4.4.0, 4.6.1, 4.6.2.

## Sources opened today (2026-11-26)

- renv NEWS and CRAN page (1.3.1, published 2026-10-06):
  https://cran.r-project.org/web/packages/renv/news/news.html,
  https://cran.r-project.org/package=renv
- pak on CRAN (0.11.2, 2026-11-07):
  https://cran.r-project.org/package=pak
- rig README and latest release (v0.11.1, 2026-10-26):
  `gh api repos/r-lib/rig/readme`, `.../releases/latest`
- renv Bioconductor article:
  https://rstudio.github.io/renv/articles/bioconductor.html
- Posit Package Manager, serving binaries (distribution and
  architecture table, user-agent line, URL forms):
  https://docs.posit.co/rspm/admin/serving-binaries.html
- Posit Public Package Manager product page ('ARM64 and portable
  manylinux'):
  https://posit.co/products/enterprise/public-package-manager/
- rang CRAN page (archived 2026-08-22) and archive listing:
  https://cran.r-project.org/package=rang,
  https://cran.r-project.org/src/contrib/Archive/rang/
- Docker Desktop settings (Rosetta option name and default; VM
  limits): https://docs.docker.com/desktop/settings-and-maintenance/settings/
- Docker multi-platform builds ('Install QEMU manually if
  emulation fails'): https://docs.docker.com/build/building/multi-platform/
- Apple, Rosetta notice: https://developer.apple.com/news/?id=w5ngl9k2
- Docker Hub tags API, e.g.
  https://hub.docker.com/v2/repositories/rocker/verse/tags/4.6.2

## Untested or hedged

- `rig add 4.6.1` and `rig default 4.6.1`: not run (rig not
  installed); syntax from the README, labeled in the text.
- `renv::init(bioconductor = TRUE)`: from the renv article, not
  run; the lockfile block was produced with the settings call.
- Docker's Rosetta option was not toggled; its behavior after
  macOS 27 is stated as unknown.
- `docker image prune -a` and the confirmation prompt without
  `-f`: from `--help`, not run.
- The uses of pandoc and qpdf in `R CMD check`: inspected, not run.
- That Ubuntu's archive eventually drops a pinned apt version is
  not asserted; the text says only that a pinned line builds
  'while the archive still serves that version'.

## Proposed changes to shared files

- `references.bib`: entries for the Posit serving-binaries page,
  the rig README, the Docker Desktop settings page, and Apple's
  Rosetta notice. The new text names these sources in prose
  without citation keys, since I may not edit the bibliography.
- `setup-appendix.qmd`: a symptom-table row, 'An emulated
  (`--platform linux/amd64`) build crashes on Apple Silicon':
  retry with the Rosetta setting named above, or build on CI and
  pull (R7-06).
- `glossary.qmd`: an entry for 'kernel', matching Ch 7's new
  vocabulary item.
- Lead check after agent D: Ch 7's manuscript bullet names TinyTeX
  and Quarto's Typst neutrally and points to @sec-literate.

## Verification

- tinytest: 456/456 after the edits (456/456 before). The
  reading-time test passes with the cards unchanged (Ch 6 45, Ch 7
  65 minutes).
- Scratch render (`c/render.sh`: both `.qmd` files,
  `references.bib`, `_llm-rule.qmd`, symlinks to `R/`,
  `DESCRIPTION`, `renv.lock`, `analysis/scripts`, `analysis/data`;
  `quarto render --to html` with
  `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`): exit 0 for both. The
  only warnings are unresolved `@sec-` cross-references to other
  chapters (23 in Ch 6, 32 in Ch 7), as expected; no R error, no
  `citation-missing`. `fig-docker-objects` and `tbl-rocker-sizes`
  are present in the HTML.
- `` `r `` grep: every hit in both files is a pre-existing inline
  expression meant to run (Ch 6 lockdiff and cohort scan, Ch 7
  cohort check); none was added.
- Voice: new sentences checked at 35 words or fewer; no em or en
  dashes; no 'you' in new exposition (two found and fixed); new
  code lines at most 78 characters.
