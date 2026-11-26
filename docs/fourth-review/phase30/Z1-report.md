# Phase 30, agent Z1: D29 track in Chapters 5 and 7
*2026-11-26 08:45 PST*

Files edited: `analysis/report/03-research-compendium.qmd` (Ch 5)
and `analysis/report/05-containers.qmd` (Ch 7). No other book file
was touched. No commit, no render.

## Word counts (`wc -w`)

| File | Before | After |
|---|---|---|
| `03-research-compendium.qmd` | 13784 | 14428 |
| `05-containers.qmd` | 15359 | 15556 |

Nothing was cut that other text depends on. In Ch 5 no `##`
heading or anchor was renamed or removed. In Ch 7 the heading
'Profiles as base images' became 'Choosing a base image'. It had
no explicit id. This grep found no reference to its old text or to
its auto-id:

```
grep -rn -i -E 'profiles-as-base-images|profiles as base' \
  /Users/zenn/prj/tch/12-reproducibility/analysis \
  /Users/zenn/prj/tch/12-reproducibility/docs \
  --include='*.qmd' --include='*.md' --include='*.yml' --include='*.R'
```

Output: one hit, in an earlier draft of this report. No book file.

## Changes by finding

Neutral term for archetypes: 'project type', matching
`glossary.qmd:27` ('in general, a project type').

### R4-006 / D29, Chapter 5

- Objectives and outline (lines 58-97): neutral wording first
  ('five things a compendium must capture', 'project types',
  'grows without restructuring'); no `zzcollab` attribution in the
  objectives; outline names the Marwick scale and the box.
- Orientation (200-212), analyst judgment 1 (242), check 'three
  judgments, one tool-free' (269-286): neutral wording; the check no
  longer presumes `zzcollab`. 'That is,' removed (220).
- Vocabulary box (307-325): Five Pillars, Archetype, Progressive
  disclosure labeled '(zzcollab term)', neutral definition only;
  Archetype notes that the literature grades compendia by size.
- 'The Five Pillars' (635-648): opens with Marwick et al.'s three
  general principles, derives the five artifacts, then attributes
  the name once (`[@thomas2026zzcollab]`).
- Layout (722-788): tree is 'a compendium in the Marwick
  convention'; `zzcollab.yaml` and `.zzcollab-state` removed from
  the tree; `Makefile` kept, marked optional. New paragraph on
  Marwick et al.'s small, medium and large compendia (as the
  article's prose states them), contrasted with project type. New
  box: what `zzc init`, `zzc renv` and `zzc docker` write; the two
  framework files.
- README check (861): `make all` replaced by
  `Rscript analysis/scripts/run_all.R`.
- Archetypes intro (1052-1088): neutral framing (what a compendium
  delivers, against Marwick's size scale); one attribution of
  'archetype'; the six-archetype paragraph (R5-01) moved into a box.
- Blog subsection: 'The framework's representative deployment'
  made neutral; 'That is,' removed.
- Progressive disclosure (1414-1421): 'grows without restructuring'
  first, then the attribution, noting the interface-design meaning;
  'the same `Makefile`' removed. Check answer cites the README, not
  `zzcollab.yaml`.
- Worked example (1472-1593): by-hand body (run; log below), `$`
  prompts dropped (R5-07); host gates; forward pointer to Ch 6 and
  Ch 7 for pinning (removes R5-02's 'docker two chapters early'
  from the body); README written by hand names the project type;
  render gate by `rmarkdown::render()` with the LaTeX requirement
  stated. One box holds every `zzc` and `make` line, the
  `check-renv` versus `check-renv-no-fix` note, and the archetype
  update via `zzc config set-local archetype manuscript`.
- Later uses of 'archetype' and 'Five Pillars' (tables, figure,
  exercises, cheat sheet) kept after attribution: Chapters 7 to 13
  cite 'the archetypes of @sec-compendium'.

### R4-006 / D29, R7-01, R7-02, R7-09, Chapter 7

- Objective 72, outline 99-102, orientation 209-212: 'profile'
  replaced by 'base image'. Vocabulary box (315): Profile labeled
  '(zzcollab term)'. Lines 530 and 1085 no longer mention profiles.
- 'Choosing a base image' (1348-1435): `rocker/r-ver`,
  `rocker/tidyverse`, `rocker/verse` (and `rocker/rstudio`) as the
  general choice; profile names in a box (1377-1386). Archetype
  bullets and the check (now 'choosing a base image') name Rocker
  images.
- Worked example (1502-1602): body is the showcase recipe plus the
  two commands of `@sec-docker-run`, cross-referenced, not
  repeated; the switch to `rocker/verse` pins by
  `docker buildx imagetools inspect` (pointer to Exercise 1) and
  rebuilds with the same command. Box (1549-1602) holds
  `zzc minimal`, `make docker-build`, `make r`,
  `zzc docker --profile publishing`, and the disclosed departures:
  native arm64 except for verse, missing `OPENBLAS_NUM_THREADS`, a
  tag-only `FROM` when the pull fails (new; see below), and
  `PLATFORM` honored by the run but not the build.
- Checks 'what changed' and 'complete the Dockerfile' no longer
  depend on the box ('generated Dockerfile is, in essence'
  removed, per R7-02).
- Exercise 3 and solution: 'base image'; data analysis now
  `rocker/r-ver` as in the worked example, or `rocker/tidyverse`,
  with the trade-off (R7-09).

## Tool commands corrected against source (lead should note)

1. **`zzc publishing` does not switch an existing project.** The
   Phase 26 text said it regenerates against `rocker/verse`.
   `_quickstart_existing_project()` (`zzcollab.sh:2233-2242`)
   refuses with 'To switch it to ...: zzcollab docker --profile'.
   The box now uses `zzc docker --profile publishing`, which sets
   `profile-name` and regenerates the Dockerfile
   (`zzcollab.sh:452-455`). `help.sh:31-33` still says the profile
   commands 'switch profile (existing project)'; that help text is
   stale (tool issue).
2. **`zzc tidyverse` after `zzc init` (Ch 5, Phase 26 sequence) is
   not what help implies.** On an initialized workspace it runs
   `_quickstart_existing_project()`: with no profile configured it
   generates only a Dockerfile (2244-2250); with a different
   profile configured it stops (2237-2242). The box now uses
   `zzc init --archetype analysis`, `zzc renv`,
   `zzc docker --profile tidyverse`, all listed in
   `help.sh:24-37` and `show_help_docker`.
3. **Tag-only `FROM` on pull failure.**
   `resolve_image_digest()` (`modules/docker.sh:1071-1092`)
   returns an empty digest with a warning when `docker pull`
   fails, and `generate_dockerfile_inline()` (1138-1143) then
   writes `FROM base:version` with no digest. Disclosed in the Ch 7
   box as noted here, not as a recorded tool issue.

## What I ran (real output)

Host R 4.6.2, `usethis` 3.2.1, `devtools` 2.5.2, `tinytest` 1.4.3,
`rmarkdown` 2.31, TinyTeX `pdflatex`. Script:
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/ch5/step2.sh`
(`set -x`). `report.Rmd` was a one-chunk synthetic file
(`summary(cars$speed)`, `output: pdf_document`). The full
`devtools::check()` and `R CMD check` logs are `check2.log` and
`check3.log` in the same directory; only their last lines are
printed below, by the script's own `tail -3`. Verbatim log
(`step2.log`):

```
+ cd /private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/ch5
+ rm -rf diabetescohort diabetes-cohort diabetescohort_0.0.0.9000.tar.gz diabetescohort.Rcheck
+ date '+%Y-%m-%d %H:%M %Z'
2026-11-26 08:28 PST
+ Rscript -e 'usethis::create_package('\''diabetes-cohort'\'', open = FALSE)'
Error in `check_package_name()`:
✖ "diabetes-cohort" is not a valid package name. To be allowed on CRAN,
  it should:
• Contain only ASCII letters, numbers, and '.'.
• Have at least two characters.
• Start with a letter.
• Not end with '.'.
Backtrace:
    ▆
 1. └─usethis::create_package("diabetes-cohort", open = FALSE)
 2.   └─usethis:::check_package_name(name)
 3.     └─usethis:::ui_abort(...)
 4.       └─cli::cli_abort(...)
 5.         └─rlang::abort(...)
Execution halted
+ Rscript -e 'usethis::create_package('\''diabetescohort'\'', open = FALSE)'
✔ Creating 'diabetescohort/'.
✔ Setting active project to
  "/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/ch5/diabetescohort".
✔ Creating 'R/'.
✔ Writing 'DESCRIPTION'.
Package: diabetescohort
Title: What the Package Does (One Line, Title Case)
Version: 0.0.0.9000
Authors@R (parsed):
    * First Last <first.last@example.com> [aut, cre]
Description: What the package does (one paragraph).
License: `use_mit_license()`, `use_gpl3_license()` or friends to pick a
    license
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 8.0.0
✔ Writing 'NAMESPACE'.
✔ Setting active project to "<no active project>".
+ cd diabetescohort
+ mkdir -p analysis/data/raw_data analysis/data/derived_data analysis/scripts
+ Rscript -e 'usethis::use_build_ignore('\''analysis'\'')'
✔ Setting active project to
  "/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/ch5/diabetescohort".
✔ Adding "^analysis$" to '.Rbuildignore'.
+ Rscript -e 'usethis::use_gpl_license(version = 3)'
✔ Setting active project to
  "/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/ch5/diabetescohort".
✔ Adding "GPL (>= 3)" to 'License'.
✔ Writing 'LICENSE.md'.
✔ Adding "^LICENSE\\.md$" to '.Rbuildignore'.
+ Rscript -e 'tinytest::setup_tinytest('\''.'\'')'
Creating ./tests
Creating ./tests/tinytest.R
Creating ./inst
Creating ./inst/tinytest
Creating ./inst/tinytest/test_diabetescohort.R
Adding 'Suggests: tinytest' to DESCRIPTION
+ Rscript -e 'pkgload::load_all(); tinytest::run_test_dir('\''inst/tinytest'\'')'
ℹ Loading diabetescohort

test_diabetescohort.R.........    1 tests OK 22ms
All ok, 1 results (23ms)
+ Rscript -e 'devtools::check()'
+ echo 'devtools::check exit=0'
devtools::check exit=0
+ tail -3 ../check2.log
Duration: 4.6s

0 errors ✔ | 0 warnings ✔ | 0 notes ✔
+ cd ..
+ R CMD build diabetescohort
* checking for file ‘diabetescohort/DESCRIPTION’ ... OK
* preparing ‘diabetescohort’:
* checking DESCRIPTION meta-information ... OK
* checking for LF line-endings in source and make files and shell scripts
* checking for empty or unneeded directories
Removed empty directory ‘diabetescohort/R’
Removed empty directory ‘diabetescohort/man’
* building ‘diabetescohort_0.0.0.9000.tar.gz’

+ R CMD check diabetescohort_0.0.0.9000.tar.gz
+ echo 'R CMD check exit=0'
R CMD check exit=0
+ tail -3 check3.log

Status: OK

+ mkdir -p diabetescohort/analysis/report
+ cp report.Rmd diabetescohort/analysis/report/report.Rmd
+ cd diabetescohort
+ Rscript -e 'rmarkdown::render('\''analysis/report/report.Rmd'\'')'
+ tail -2

Output created: report.pdf
+ ls analysis/report
report.pdf
report.Rmd
```

Separately run on the same skeleton (output verbatim):

```
$ Rscript -e "devtools::test()"
ℹ No testing infrastructure found.
! Setup testing with `usethis::use_testthat()`.
$ zzc init --archetype analysis < /dev/null    (in an empty scratch dir)
═══════════════════════════════════════════════════════════
  Initializing: zzcinit
═══════════════════════════════════════════════════════════

❌ Required identity fields missing in user config
❌ Run: zzcollab config init --interactive
```

In the book, `devtools::check()` is shown as `#> Status: OK` (a
line of its real output, `check2.log:78`) rather than the `✔`
summary line, to keep that glyph out of the PDF code font.
`devtools::check()` ran before `analysis/report/` existed and was
not re-run after (the directory is build-ignored).

Marwick et al. (2018): verified from the article PDF in the
author's Zotero library via `pdftotext`. Sections 5.1 'Small
Compendia', 5.2 'Medium Compendia', 5.3 'Large Compendia'; the
'three generic principles' sentence is in 5.1. Figures did not
extract, so the chapter states only what the prose says.
`marwick2018` already exists in `references.bib`; no new entry.

## Not run, and why

- Every `zzc` and `make` command in the boxes: inspected, not run
  (identity config missing; I did not create one). Sources:
  `modules/help.sh:24-37`; `zzcollab.sh:280, 325-360, 452-455,
  1602-1605, 2211-2256, 2270-2380, 3305-3330`;
  `templates/Makefile:47-52, 134-137, 340-342, 369, 372, 402`;
  `modules/docker.sh:1071-1092, 1138-1143, 1218-1224, 1308-1325,
  1413-1427`; `modules/config.sh:571-574`;
  `templates/bundles.yaml:84-108`.
- Ch 7 body: no new command printed; it cross-references the
  verified commands of `@sec-docker-run`. The `rocker/verse`
  rebuild was not run.
- The interface-design meaning of 'progressive disclosure' is from
  general knowledge, uncited (inferred).

## Grep: no `zzc` or `make <target>` outside a box

Box-aware awk (scratchpad `outside_box.awk`), run as
`awk -f outside_box.awk 03-research-compendium.qmd 05-containers.qmd`:

```
/^:::+ *\{/ { depth++ }
/^## With zzcollab/ { inbox = depth }
/^:::+ *$/ { if (inbox && depth == inbox) inbox = 0; depth--; next }
{
  hit = ($0 ~ /zzc |zzc$|`zzc|zzcollab|make [a-z]|`make|\.zzcollab-state|Makefile/)
  if (hit) printf "%s %s:%d: %s\n", (inbox ? "IN " : "OUT"), FILENAME, FNR, $0
}
```

Outside-box hits, all prose, none a command:

- Ch 5: 94, 273, 307, 311, 323, 643-644, 1065-1066, 1419
  (outline, '(zzcollab term)' labels, attributions); 175, 464, 724,
  1047, 1474, 1691, 1926 (the verb 'make'); 751, 761, 771 (the file
  `Makefile`, generic); 829 ('the `make` target or `Rscript`
  command', a generic README rule).
- Ch 7: 102, 315 (outline, label); 206, 1222 (the verb 'make').

Boxes: Ch 5 lines 778-789, 1075-1088, 1555-1593; Ch 7 lines
1376-1386, 1548-1602. Every `zzc ...` and `make <target>` line is
inside one.

## Proposed changes to shared files (lead)

- `glossary.qmd`: mark 'The Five Pillars' and 'Progressive
  disclosure' '(zzcollab term)' as 'Archetype' (27) and 'Profile'
  (505) already are, if not done this phase.
- `07-literate-programming.qmd:1014-1058, 1318, 1494, 1571, 1740`,
  `setup-appendix.qmd:47`, `02-levels-of-reproducibility.qmd:875`
  use 'publishing profile' or 'profiles' as general vocabulary;
  suggest 'the `rocker/verse` base', with any `zzc` command boxed.
  If any says `zzc publishing` switches a project, use
  `zzc docker --profile publishing` (finding 1 above).
- Ch 5 cheat-sheet rows ('The Five Pillars', 'Five archetypes',
  'Progressive disclosure') left as is, because
  `cheat-sheet-index.qmd` aggregates them.

## Not addressed (outside D29)

R5-03 to R5-06, R5-08 to R5-10, R7-03 to R7-08, R7-10 to R7-14:
not changed, except R5-07 (prompts) in the rewritten blocks and
R7-09 in the Exercise 3 solution.

## Test result

`tinytest` suite (brief rule 9) after the final edit: 455 results,
0 failures (`test-manuscript-invariants.R` 381/381,
`test-reading-times.R` 12/12). No reading-time card change needed.
