# Phase 31, Agent E: Pipelines (Ch 9) and Testing (Ch 10)
*2026-11-26 09:10 PST*

Files changed: `analysis/report/pipelines.qmd`,
`analysis/report/08-testing-quality.qmd`. New directory:
`analysis/exercises/pipeline-start/` (README.md, .gitignore,
`clean_data.R`, `fit_model.R`, `make_figures.R`, `report.Rmd`,
`data/raw_data.csv`). No shared file was edited. Word counts
(`wc -w`): pipelines 13,873 to 14,082; testing 16,316 to 17,486.
Line numbers below are in the edited files.

Evidence labels: V = I ran it or opened the source today;
I = I read the book or tool source. Scratch material is under
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/E/`
(logs named below); scratch library `E/lib` holds targets 1.12.1,
tarchetypes 0.14.2, validate 1.1.7, visNetwork.

## Findings

| ID | Status | Change | Evidence |
|---|---|---|---|
| R10-03 | Partly done | Starter project created (below). Pipelines Exercise 1 stem offers 'your own analysis or the starter' and says Exercises 2 to 5 continue on it; the Solutions sentence now covers the starter. Testing Exercises 1, 3, 5 offer the starter; the testing Solutions sentence, false for Exercises 4 and 6 to 9, now names Exercises 1 to 3 and 5. **Not done:** grading the pipeline exercises (faded Makefile, then Makefile, then `targets`) and replacing testing Exercise 4; both are exercise redesigns, beyond 'small, local edits', and would need instructor-guide changes | V: see 'Starter project' |
| R10-07 | Done | `pipelines.qmd:1184-1188`, check answer (choosing among five tools): the current route is `crew` with `crew.cluster`; the older `clustermq` backend 'survives in the `targets` manual's appendix 'High-performance computing (the old way)'' | V, opened today: https://books.ropensci.org/targets/ (TOC: ch 13 'Distributed computing'; Appendix A 'High-performance computing (the old way)'); https://books.ropensci.org/targets/crew.html (crew for HPC and cloud, `crew_controller_sge()` from crew.cluster; no mention of clustermq); https://books.ropensci.org/targets/hpc.html (`tar_make_clustermq()`, `tar_make_future()`). The manual does not call clustermq deprecated, so the book does not either |
| R10-10 | Done | `pipelines.qmd:500-516` (chunk) and `:536-538` (prose). `tbl-pipeline-steps` chunk: the fit uses `cluster = id`; the bootstrap resamples patients (`split()` by `id`, then `sample()` of the groups); a code comment and one prose sentence explain the pairing. Executed code changed, so the chunk was rerun | V: `cluster = id` and `+ cluster(id)` give identical coefficients and robust SE 0.148 for laser (survival 3.8.12; 197 patients, each with exactly two eyes). Scratch render: bootstrap 281 ms, 97 percent of the total; the 'ordering' claim still holds |
| R4-013 (Ch 9, 10) | Done for pre-commit; `make` deferred to the setup checklist | Ch 9 (`pipelines.qmd:792-805`): 'Before you run this' box opening the optional Make section: `make --version`, expected first line `GNU Make`, pointer to the setup page's machine checklist (file link to `#sec-setup-checklist`), and a note that the `targets` sections need no `make`. Ch 10 (`08-testing-quality.qmd:1678-1695`; Exercise 6 stem near `:2370`): 'Before you run this' box after the `.pre-commit-config.yaml` listing: framework via `pip install pre-commit`, `brew install pre-commit` (macOS), or `precommit::install_precommit()` (needs miniconda); `pre-commit --version`; R package from CRAN; `precommit::use_precommit()` once per clone. The box states that these steps were not run for the book. Exercise 6 stem now includes both installs and `use_precommit()` | V: `make --version` here prints 'GNU Make 3.81'. Opened today: https://pre-commit.com/ (`pip install pre-commit`, `pre-commit --version`); https://lorenzwalthert.github.io/precommit/articles/precommit.html (pip3 `--user`, brew, conda route, `use_precommit()` 'once in every git repo'); https://cran.r-project.org/package=precommit (0.4.3, 2024-07-22, available). **Untested:** every pre-commit step (framework not installed here). Not stated in the book, because not confirmed today: the Apple Command Line Tools page rendered empty, and the Rtools45 page does not say it ships `make`; the box therefore defers to the setup checklist, which already names both routes |
| R11-03 | Done | `08-testing-quality.qmd:45-57` (prerequisites), `:1140-1144` (heading and skip sentence), Outline line about the optional section, and the 'optional next section' phrase near `:985`. Prerequisite rewritten: the two-tier baseline check and the optional section assume the standard error of a simulated quantity and introduce MCSE and random-number streams. Section retitled 'Monte Carlo error and parallel streams (optional)' with a skip sentence that excepts its closing `fig-test-coverage` comparison, which is core but sits at the end of that section (moving it would be a restructure). 'the rule the next section gives' now says 'the optional next section'. Outline names the optional section | I |
| R11-04 | Done | `08-testing-quality.qmd:585-604` (table and covr) and `:798-834` (validate). After the tinytest transcript: `tbl-tinytest-testthat` (five rows: file location, one test, class check, `R CMD check` runner, development runner) and a paragraph on `covr::package_coverage()`. In the data-validation section: a three-rule `validate::validator()` example with real output on the raw extract and the cleaned cohort, and when a validator earns its place | V: `testthat` 3.3.2 (host, and CRAN https://cran.r-project.org/package=testthat, 2026-01-11); every function named in the table exists in tinytest 1.4.3 and testthat 3.3.2 (`exists()` check). validate 1.1.7 run in the scratch library (log `validate_demo.log`; CRAN https://cran.r-project.org/package=validate, 2025-12-10, maintainer Mark van der Loo, so 'maintained by the author of `tinytest`'). covr: https://covr.r-lib.org/ ('compatible with any testing package', via `tools::testInstalledPackage()`); run on a scratch package with a tinytest suite: 66.67 percent, the untested branch named (log `covr.log`) |
| R11-05 | Partly done | `08-testing-quality.qmd:54-58`: 'The chapter up to the reproducibility tests uses the intervening chapters only in its opening check and in passing comparisons, so a reader can take that part straight after @sec-compendium.' (I read lines 100 to 800 and grepped their `@sec-` links: the warm-up check cites Ch 6, 7, 9; the stack section mentions lockfiles and images and points to Ch 11 in passing.) Ch 9 already points to @sec-testing in its worked example. **For the lead:** a matching forward pointer belongs in `03-research-compendium.qmd` (not my file), near the `inst/tinytest/` layout | I |
| R11-07 | Done | `08-testing-quality.qmd:1537-1544`. One passage after `styler`: Air, a Posit formatter written in Rust, works in Positron, RStudio, and VS Code, takes the tidyverse style guide as its main source with stated departures, and offers an `air-format` pre-commit hook; choose one formatter | V, opened today: https://posit-dev.github.io/air/ (Rust; editors), https://posit-dev.github.io/air/formatter.html ('main source ... the Tidyverse style guide, but we occasionally deviate'), https://posit-dev.github.io/air/integration-pre-commit.html (`posit-dev/air-pre-commit`, `id: air-format`, rev 0.8.2 example). Not stated: speed, 'default in Positron', Air 0.10.0 (not confirmed today) |
| R11-08 | Already done | Line 2668 onward reads 'cover the adjacent ground of provenance'; the body passage at 'Code quality as a validation feature' says 'provenance' too. No edit | I: `git log -S 'adjacent ground of'` shows `ebc8c5b` (Phase 26) |
| R11-09 | Proposed (shared file) | See 'Proposed changes to shared files' | V: https://cran.r-project.org/package=tinytest (1.4.3, published 2026-03-24, Mark van der Loo); host has 1.4.3 |
| R11-10 | Done | `08-testing-quality.qmd:1195-1201` (chunk) and the reporting-rule sentence below it. `mc-stability` chunk gains `dp()` ('1 decimal place', '0 decimal places') and `ci_text`; the sentence now reads 'the rule allows 1 decimal place for the lower bound and 0 decimal places for the upper. The default call's interval should therefore be reported as 1.5 to 5, each bound rounded to the digits its own MCSE supports.' | V: scratch render, text above copied from the HTML. Frozen output: the old `_freeze/08-testing-quality` had 'the upper bound 0, ... reported as 1.5 to 5.' |
| R11-11 | Done, with a caveat | `08-testing-quality.qmd:1167-1171`. Bootstrap section: '`bootstrap_ci()` resamples the logistic model of `fit_model()`, the compendium's first and simpler analysis. The analysis the book treats as canonical, and checks against a recorded baseline, is the Cox model of @sec-cohort-continued-testing.' The review's word 'secondary' was not used: `R/cohort.R:115-123` names the logistic driver `run_primary_analysis()`, so calling it secondary would contradict the code. **For the lead:** rename or redocument `run_primary_analysis()` (used in `test-cohort.R:142-144`) | I: `R/cohort.R:58-131` |
| R11-12 | Done in the book; test file proposed | `08-testing-quality.qmd:777-779` (listing), `:791-796` (paragraph), `:2517-2537` (Exercise 3 solution). Data-validation listing gains `expect_true(mean(is.na(cohort$age_at_enroll)) < 0.05)` with a comment, and a paragraph on why a range check under `na.rm = TRUE` needs a missingness partner. Exercise 3 solution gains the same expectation with an `info` message; its intro sentence says so. Exercise 7's 'four constraints' unchanged | V (log via `r1112_validate.R`): with every age blanked, the range check returns TRUE and the bound FALSE; on the real cleaned cohort 1 of 337 ages is missing (0.003), so the bound passes. The listing says 'abridged from `inst/tinytest/test-cohort.R`', which lacks the line: see proposals |
| R11-13 | Done | `08-testing-quality.qmd:545-583`. After 'tinytest: bare expectations': a real transcript (`cat` of `R/mean.R` with a planted `na.rm` bug and of a three-expectation test file with `info` messages; `run_test_file()` with one failure, `diff` and `info` lines) and a paragraph on reading it. The long `call` line is cut where marked; the redrawn progress line is shown once | V: run in `E/tt` with the host's tinytest 1.4.3, exactly the printed command (logs `tinytest_transcript.log`, `tt3.log`); exit status 0 despite the failure, consistent with the chapter's later `all_pass()` point |

## Starter project (R10-03)

`analysis/exercises/pipeline-start/`: the worked example's shape on
`survival::diabetic`. `data/raw_data.csv` (394 rows, written by
`write.csv(survival::diabetic, ...)`); `clean_data.R` (arm labels)
to `cleaned.rds`; `fit_model.R` (Cox, `cluster = id`) to
`model.rds`; `make_figures.R` (survival curves as a `ggplot`
object, not a PNG) to `figures.rds`; `report.Rmd` (hazard ratio
0.46, 95% CI 0.34 to 0.61, robust SE). Stems: `pipelines.qmd:1667-1673`, `:1771-1776`; `08-testing-quality.qmd:2340-2346`, `:2357-2360`, Exercise 5 stem, `:2435-2439`. Packages used: survival,
ggplot2, rmarkdown, knitr, all in `renv.lock`. No `Makefile` and no
`_targets.R` ship: writing them is the exercise. README gives the
copy step, requirements, the hand-run commands, and which exercise
uses what.

Run in scratch copies (logs `starter_test1.log`, `starter_test2.log`):

- Hand run of the four steps: each exits 0; `report.html` holds the
  sentence and one embedded figure.
- Exercise 2 (four-rule Makefile, chapter's rules with
  `data/raw_data.csv`, and `cleaned.rds` added to the figures rule):
  first `make` builds all four; after editing `fit_model.R` it reruns
  fit, figures, report and skips cleaning; with nothing changed,
  'report.html is up to date'; after `touch data/raw_data.csv`,
  everything rebuilds.
- Exercise 3 (functions in `R/`, worked example's `_targets.R` with
  `packages = 'survival'`, report fetching with `tar_read()`,
  `R_LIBS` set to the scratch library): first `tar_make()` 6
  completed; a second skipped all 6; editing `make_figures()`:
  `tar_outdated()` named `report` and `figures`, and `tar_make()`
  rebuilt exactly those two.
- Exercise 4: editing `fit_model()` outdated model, figures,
  report; after adding an undeclared `read.csv('cutoff.csv')` and
  rebuilding, changing the CSV left `tar_outdated()` empty, as the
  chapter says.

A finding from the first draft: `make_figures()` first wrote a PNG
as a side effect and returned a list. Editing it then rebuilt
`figures` but skipped `report`, because the returned value was
unchanged, while the PNG on disk had changed: a stale report the
pipeline called current. Returning the `ggplot` object fixed it.
The chapter's worked example returns objects, so it is not
affected, but the trap may deserve a sentence in a later phase.

Not run: the README's `cp -R ... ~/pipeline-start` (run with a
scratch destination instead); the starter on Windows.

## Proposed changes to shared files

1. `references.bib` (R11-09):

   ```bibtex
   @manual{vanderloo2020,
     title = {tinytest: Lightweight and Feature Complete Unit Testing Framework},
     author = {van der Loo, Mark},
     year = {2026},
     note = {R package version 1.4.3},
     url = {https://CRAN.R-project.org/package=tinytest}
   }
   ```

   The key can stay as `vanderloo2020` (cited at Ch 10 twice) or be
   renamed with both citations.
2. `conventions.qmd` core-path table, Testing row: 'Core; the section
   on Monte Carlo error and parallel streams is optional' (R11-03).
3. `inst/tinytest/test-cohort.R` after the age-range expectation
   (R11-12), so the chapter's 'abridged from' stays true:
   `expect_true(mean(is.na(cohort$age_at_enroll)) < 0.05, info = 'the age check is not passing on missing ages')`.
4. `03-research-compendium.qmd`: a forward pointer to Ch 10's first
   sections (R11-05).
5. Instructor guide: optional notes for the starter (expected hazard
   ratio 0.46; the Exercise 3 and 4 results above).
6. `R/cohort.R`: `run_primary_analysis()` names the logistic model
   'primary' while Ch 10 calls the Cox model canonical (R11-11).
7. Drift guards: the paragraph after the data-validation listing types 'one implausible age', and the `validate` output (338/337 rows, 1 and 18 fails, 1 NA) is pasted, not computed. Both follow from the seeded cohort generator; a manuscript test asserting `sum(is.na(clean_cohort(raw)$age_at_enroll)) == 1` and `sum(raw$sex == 'Female') == 18` (the latter already in `test-cohort.R`) would catch drift.

## Checks

- Docker: no Docker command was run in this session, so the lead's
  new rule required no action.
- Pre-render steps: `tools/us-spelling check` on both chapters and
  the starter README exits 0. `tools/make-contents.py` was not run
  (it writes `contents.qmd`); it lists chapters only, and no chapter
  title changed.
- Book-wide grep (quoted globs, `analysis/` and
  `INSTRUCTOR-GUIDE.md`): no link to the retitled MCSE section's
  anchor, no other `clustermq`, and no instructor-guide copy of the
  changed stems or solutions.
- Sentence length: added prose scanned; two sentences over 35 words
  split.

- Inline R: every `` `r `` hit in both files begins with an R
  identifier meant to run (pipelines 8, testing 32); the two new ones
  are `dp()` and `ci_text`.
- Voice scan of the added lines: no em or en dashes, contractions,
  'That is,' or 'Unfortunately'; code lines at most 78 characters
  (table rows are longer, as elsewhere in the book).
- Test suite (`run_test_dir`, host library), after the final edits:
  456/456. (An earlier run showed one failure in
  `translating-tools.qmd`, another agent's file, since fixed.)
- Scratch render (`E/render.sh`: repo depth mirrored with
  `DESCRIPTION`, `R/`, `inst/`, `renv.lock`, the cohort CSV, both
  `.qmd`, `references.bib`, `apa.csl`, `_llm-rule.qmd`, and a minimal
  `_quarto.yml`; host library only): both chapters exit 0; the only
  warnings are unresolved cross-references to other chapters. The
  new `tbl-tinytest-testthat`, `@sec-cohort-continued-testing`, and
  `@fig-test-coverage` references resolve.
- Freeze: `_quarto.yml` sets `freeze: auto`, so the lead's render
  re-executes both chapters (sources changed). `tbl-pipeline-steps`
  and `mc-stability` change output; `_freeze/pipelines` and
  `_freeze/08-testing-quality` are stale until then.
