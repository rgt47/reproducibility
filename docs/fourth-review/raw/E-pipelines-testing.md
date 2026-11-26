# Reviewer E: Pipelines (Ch 10) and Testing (Ch 11)
*2026-11-25 17:53 PST*

## Summary

Both chapters are now technically careful where earlier reviews pressed (Cox
oracle, two-tier MCSE baseline, per-task streams, `tar_render()`,
`trust_timestamps`). What remains is persuasion, novice reach, and currency.
The testing chapter answers 'this is software engineering' by definition and a
toy bug, with no real case, and it cites Wilson 2017, which explicitly leaves
unit testing out for solo exploratory work. The core path is inconsistent:
only Make is core, yet core material depends on `targets`. Neither chapter
says how to obtain `make` or the `pre-commit` framework. Most exercises
presume an analysis of the student's own. Currency gaps: no `validate` or
`pointblank`, no coverage or snapshots, no `testthat` bridge, no Air, and a
CI lint step that cannot fail.

## Strengths

- The 'reproducible and wrong' framing (08:164-198) is the right answer, in
  principle, to 'why is testing in a reproducibility book'. The capture
  versus validation vocabulary makes the argument portable.
- The oracle principle, the pre-specified analysis plan as an oracle
  (08:393-458), and the LLM 'do not edit the test' prompt (08:1895-1901)
  will be useful to a scientist, not only to an engineer.
- The baseline test is demonstrated failing for the reason it exists
  (`tbl-baseline-rng`), and the MCSE second tier is stated with its
  false-alarm rate computed inline.
- Pipelines: the stale-figure orientation (pipelines:194-233) is concrete and
  is recognizably a scientist's problem. The `tar_render()` and
  `trust_timestamps` passages report scratch-run evidence rather than
  assertion.
- `sec-llm-in-pipeline` (responses cached as data, re-query treated as a new
  rater) is current and practically useful.
- AI-written tests (5.4): 08:1823-1911 is adequate and current, and needs no
  separate finding. It names the specific failure (an oracle derived by
  running the function), the agent that edits tests to reach green, and
  protected paths, and it gives a better prompt that forbids editing the
  test. The only gap is a concrete check, for example 'diff every expected
  value in an agent's commit against the plan'. That check is already
  implied by review question 5.

## Findings

### Wilson 2017 cited for testing that it explicitly declines to recommend
- Location: 08-testing-quality.qmd:1307
- Quote: 'Wilson and colleagues, in their best-practices and good-enough-practices guidance, make behavioral testing a recurring recommendation [@wilson2014; @wilson2017].'
- Severity: major
- Viewpoint: referee
- Evidence: verified (https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510, 'What we left out': 'we have left unit testing off this list'; https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745, recommendations 5a to 5d, no behavior versus implementation distinction)
- Prior: new
- Problem: Neither paper draws the behavior versus implementation distinction explicitly; Wilson 2014 supports it only loosely ('Tests check to see whether the code matches the researcher's expectations of its behavior'). Wilson 2017 states that unit tests 'usually aren't compelling for solo exploratory work' and omits unit testing, coverage, and CI. Further reading (08:2520-2526) nonetheless presents it as a standard reference for testing.
- Why it matters: A skeptical mentor who reads the citation finds that the cited source agrees with the mentor.
- Fix: Cite Wilson 2014 (5a to 5c: assertions, an off-the-shelf testing library, turning bugs into tests) for testing. Then name Wilson 2017's position and answer it directly: 'Wilson et al. (2017) leave unit testing out for solo exploratory work. This chapter therefore leads with the two kinds of test that pay off even there: data validation and a baseline test.'

### The mentor objection is answered by definition and a toy bug, with no real case
- Location: 08-testing-quality.qmd:148
- Quote: 'Consider a registry study in which an analyst has written a small function to compute a mean biomarker value for each treatment arm.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected (grep for Reinhart, Herndon, Baggerly, Potti, Chang, Ziemann, and Neupane across analysis/report returns nothing)
- Prior: new
- Problem: The only motivating example is a synthetic sum-for-mean bug that no experienced researcher believes they would make. The objections 'my results have always been fine' and 'this is software engineering' get a vocabulary argument (validation register), not evidence. The chapter also gives no estimate of the cost of a minimal test file.
- Why it matters: Chapter 11 is where a mentor decides whether testing is worth the student's time, and the chapter currently offers no evidence that it is.
- Fix: Open with one or two documented cases of a code or data error that changed a published result, ideally from outside biomedicine. Candidates, all unverified and needing primary-source checks: Herndon, Ash, and Pollin (2014, *Cambridge J Econ*) on the Reinhart-Rogoff spreadsheet; the 2006 retractions after a column flip in in-house software (Chang lab, *Science*); Ziemann et al. (2016, *Genome Biology*) on gene names converted to dates (a data-validation case); Bhandari Neupane et al. (2019, *Org Lett*) on file-ordering-dependent results across operating systems. Add one sentence on cost: the four data-validation assertions at 08:701-715 are about 15 lines.

### Core path says Make is core and `targets` optional, but core material depends on `targets`
- Location: pipelines.qmd:49
- Quote: 'In the one-quarter core path (see the [Conventions](conventions.qmd) page), only the Make section below is core.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (conventions.qmd:199; pipelines objectives 72-76, worked example 1184-1259, faded example 1286-1345, Exercises 3, 4, 7, 9; 08-testing-quality.qmd:114-118 answers a core-chapter check with 'a `format = 'file'` target')
- Prior: 'fix for D3 incomplete' (REFACTOR-PLAN 10.11 and Phase 12 made only the chapter card say so)
- Problem: A student on the core path skips the `targets` section. They then meet an objective, a worked example, a completion exercise, four of nine exercises, and Chapter 11's warm-up answer that require it. The 'marked optional' sections are also not marked anywhere in the chapter body; 'optional' occurs only at line 53.
- Why it matters: The core-path promise (D3) is not kept for this chapter, and a self-study reader cannot tell what to skip.
- Fix: Mark the optional headings inline. Rewrite Ch 11's answer (08:114-118) to name 'a pipeline (Make or `targets`)'. Give Exercises 3, 4, 7, and 9 an 'optional' label, or add Make-only variants. See the next finding for the alternative of flipping core and optional.

### No install or failure path for `make` or for the `pre-commit` framework
- Location: 08-testing-quality.qmd:2098
- Quote: 'Install the `precommit` package, add the `.pre-commit-config.yaml` of this chapter to a project, and attempt to commit deliberately misformatted R code.'
- Severity: major
- Viewpoint: student
- Evidence: verified (https://lorenzwalthert.github.io/precommit/articles/precommit.html: framework via `pip3 install pre-commit --user`, `brew install pre-commit`, or `precommit::install_precommit()`; hooks via `precommit::use_precommit()`, once per repo) and inspected (a book-wide grep of analysis/report/*.qmd for Rtools and xcode-select finds nothing; there are no make install instructions in either chapter, setup-appendix.qmd, or shell-primer.qmd)
- Prior: new
- Problem: The R `precommit` package does nothing until the Python `pre-commit` tool is installed and `precommit::use_precommit()` is run; the chapter mentions neither. Chapter 10's core section and Exercise 2 assume a working `make` and `touch`. Neither chapter nor the setup appendix says how to obtain them on Windows (for example through Rtools or Git Bash) or that macOS needs the Command Line Tools. Both of these ways of obtaining them are unverified.
- Why it matters: The novice's first attempt fails at the install step, before any concept is reached.
- Fix: Add a 'Before you run this' box to each chapter: platform-specific steps for obtaining `make` and `touch`, linked from the setup appendix; the `pre-commit` install (`pip3 install pre-commit --user`, `brew install pre-commit`, or `precommit::install_precommit()`), then `precommit::use_precommit()` in each clone; and one symptom row for each in the setup appendix's troubleshooting table.

### Advice to run `lintr::lint_dir()` in CI does not make CI fail; three passages disagree
- Location: 08-testing-quality.qmd:1432
- Quote: 'The workflows in that chapter do not, so a project that relies on the hook should add a step running `lintr::lint_dir()` there.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (https://lintr.r-lib.org/articles/continuous-integration.html: builds error 'instead of just a warning' only with `LINTR_ERROR_ON_LINT=true`); inspected (repo `Makefile`:108-109 `lint` target is `print(lintr::lint_dir('R'))`, which also cannot fail)
- Prior: 'fix for Phase 25 (agent3-report.md:349) incomplete': the sentence was added there
- Problem: A bare `lint_dir()` step reports lints and exits 0, so this 'gate' cannot fail, which breaks the book's own Habit 4. The chapter also contradicts itself. 08:1794-1797 says 'Continuous integration re-runs both' the linter and styler, and the Exercise 6 solution (08:2379-2384) describes CI reporting a lint failure, while 08:1432 says the workflows do not lint.
- Why it matters: A student who follows the advice gets a check that always passes and believes it is a check.
- Fix: Replace with: 'add a step that sets `LINTR_ERROR_ON_LINT: true` and runs `lintr::lint_dir()`, or use r-lib/actions' `lint` workflow, which sets it.' Make 08:1794-1797 and the Exercise 6 solution conditional on that step existing. Record the zzcollab `make lint` target as a tool issue.

### `targets` presented as unable to miss a dependency
- Location: pipelines.qmd:1858
- Quote: 'Because the dependency is discovered from the code, the analyst cannot declare it incompletely.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (contradicts pipelines.qmd:303-309 and the Verification box 894-906)
- Prior: new (Phase 20 fixed the exercise stem, reader-c.md:113; this is the solution's conclusion)
- Problem: The chapter itself shows that `targets` misses an undeclared `read.csv()` and global state. Functions from installed packages and files read inside functions are also not tracked. This exercise's own setup (a helper sourced by a script) is exactly the case where the claim depends on `tar_source()` having loaded that helper.
- Why it matters: The exercise ends on the false sense of safety that the chapter's 'honest declarations' judgment exists to prevent.
- Fix: 'Because function dependencies are discovered from the code, an edited helper loaded by `tar_source()` cannot be forgotten; a file read inside a function, or a function from an installed package, still can.'

### Exercises presume an analysis of the student's own; difficulty is not graded
- Location: pipelines.qmd:1717
- Quote: 'Every exercise in this chapter is performed on an analysis of the reader's own, so the outputs vary'
- Severity: major
- Viewpoint: student
- Evidence: inspected (pipelines Exercises 1 to 5; 08 Exercises 1 to 4, where 4 classifies the tests of 1 and 3; 08 Exercise 5 says 'a small analysis' without supplying one)
- Prior: new
- Problem: Five of nine pipeline exercises (Exercise 6 is conceptual) and four of nine testing exercises depend on 'a multi-step analysis of your own' or 'a function you have written'. A first-year student often has no multi-script analysis, and no starter project is offered. The quoted statement is also false for Exercises 6 to 9. Exercise 2 (write a Makefile) is a large step after Exercise 1 (draw on paper). Testing Exercise 4 is trivial: every answer is 'validation'.
- Why it matters: Without a starter, the exercises cannot be done and the stated outcomes cannot be practiced.
- Fix: Ship the worked example's four-script analysis (pipelines:1184-1196: clean, fit, figures, report) as a starter directory, for example `analysis/exercises/pipeline-start/`, built on the cohort or on `survival::diabetic`. Grade the exercises: complete a faded Makefile, then write one, then `targets`. Allow 'your own analysis or the starter' in each stem. Correct the Solutions sentence. Replace testing Exercise 4 with a mixed classification that includes a baseline test and `.pre-commit-config.yaml`.

### 'No new statistics are introduced' is not true for a non-biostatistician
- Location: 08-testing-quality.qmd:45
- Quote: 'Statistically, no more than comfort reading a coefficient table from a fitted model and a percentile bootstrap interval; no new statistics are introduced.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (08:905-1155: MCSE, $\sqrt{2}$ MCSE, false-alarm rate under normality, digits supported, $1/\sqrt{B}$ scaling, L'Ecuyer-CMRG and per-task streams; 1950-1984 complete-case Cox counts)
- Prior: new
- Problem: The MCSE and parallel-stream sections (about 250 source lines) introduce Monte Carlo error theory and RNG stream design. A psychology or ecology student will find that difficult.
- Why it matters: The prerequisite box misleads exactly the out-of-field reader the book wants to reach.
- Fix: Mark 'Monte Carlo error and parallel streams' optional for readers who do not resample or simulate. This is not a cut, so it does not reopen D18. State the prerequisite honestly: 'the MCSE section assumes the idea of a standard error of a simulated quantity'.

### Testing chapter is not bridged to `testthat`, coverage, snapshots, or data-validation packages
- Location: 08-testing-quality.qmd:504
- Quote: 'A reader who has met `testthat` will notice the difference at once.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (grep for pointblank, assertr, validate, covr, and snapshot in 08 finds none; docs/third-review/coverage-syllabi.md:87 'most courses use testthat'; coverage-texts.md:52 flagged covr and snapshots); unverified (current `testthat` and `validate` versions, `validate`'s authorship, and the use of testthat in *R Packages* 2e are from memory)
- Prior: new. The coverage sweep noted the gap and no decision rejected it. REFACTOR-PLAN:2047-2049 rules out infrastructure topics such as SBOMs and SLSA, which does not cover these. Estimated cost: about one page, which bears on D18.
- Problem: The student will meet `testthat` 3e in *R Packages* (2e), `usethis`, and almost every package they read, and the chapter gives one sentence of contrast. Data validation, which the chapter itself calls the kind that 'most directly repay[s] a health scientist' (08:718-719), is hand-rolled with `expect_true()`. The chapter never mentions `validate` (by the author of `tinytest`), `pointblank`, or `assertr`. Coverage (`covr`) is absent.
- Why it matters: Without a bridge, the student cannot transfer the skills to the ecosystem they will actually work in.
- Fix: Add a five-row table: `tinytest` call, `testthat` 3e equivalent, and the runner for each. Add one paragraph and a three-rule example of `validate::validator()` (or `pointblank`) for the cohort, noting that rules become a reusable, reportable object. Add one sentence on `covr::package_coverage()` and its limits. Keep `tinytest` as the book's tool.

### Testing sits after three environment chapters
- Location: 08-testing-quality.qmd:1
- Quote: '# Testing and Code Quality {#sec-testing}'
- Severity: major
- Viewpoint: mentor
- Evidence: inferred (from `_quarto.yml` order: Part II renv, Docker, backends precede Part III literate, pipelines, testing)
- Prior: new (no recorded decision on chapter order)
- Problem: Unit and data-validation tests need no shell, Docker, or CI. Among the practices the book teaches, they are the cheapest and the most visibly scientific. A student or mentor who stops after Part II has learned to pin a wrong answer exactly, which is the paradox of 08:164. Pipelines precede testing although the pipeline worked example cites testability (pipelines:1208-1211).
- Why it matters: The order delays the practice most likely to persuade a skeptical mentor, and it maximizes the chance that a time-limited student never reaches it.
- Fix: Either move the first half of Chapter 11 (paradox, oracle, unit and data-validation tests) to immediately after the compendium chapter and leave the baseline, MCSE, and regulated sections in Part III, or at minimum swap Chapters 10 and 11 and add a forward pointer to the data-validation section from Chapter 5. Measure the cross-reference cost before deciding.

### Make as the core pipeline tool for R users
- Location: conventions.qmd:199
- Quote: 'Core for the Make section; `targets`, Snakemake, Nextflow, and workflowr are optional'
- Severity: minor
- Viewpoint: student
- Evidence: inferred (the case for Make's difficulty on Windows rests on the absence of any install path in the book, verified by grep for Rtools, xcode-select, and windows; the platform claims themselves are unverified)
- Prior: 'Reopens D3'
- Problem: D3 (REFACTOR-PLAN 10.11) placed a 'Make excerpt' in week 7 for load reasons and gave no tool-fit argument. The new argument has three parts. Most of the chapter's material is written in `targets`. `targets` runs wherever R runs, with no external binary. Make needs a separate install on Windows and has a tab-versus-space failure mode that the chapter itself needs a Pitfall box for.
- Why it matters: The core-path reader learns the less transferable tool for an R analysis and meets the harder install.
- Fix: Make `targets` (through the worked example) the core section, and make Make an optional comparative section. Keep the week-7 load by trimming the Make section, which is about 140 lines, to its timestamp-rule core.

### Honest-level callout claims the chapter's own practice runs `tar_make()` and `make`
- Location: pipelines.qmd:1042
- Quote: 'This chapter's own practice runs `tar_make()` and `make` to completion on demand.'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (`find /Users/zenn/prj/tch/12-reproducibility -name '_targets.R' -not -path '*/renv/*'` returns nothing); inspected (pipelines.qmd:1396-1400 says no model or report is wired 'through `targets` or a Makefile')
- Prior: new (same class as Finding 29; house rule 1)
- Problem: The callout is at best ambiguous. If 'own practice' means the scratch runs reported at pipelines:794-799 and 828-833, it should say so. If it means the compendium, it is false: the repository has no `_targets.R`, and its `Makefile` is zzcollab's tool Makefile, not an analysis pipeline, as the 'cohort, continued' section itself says.
- Why it matters: The book's credibility rests on not misdescribing its own compendium.
- Fix: 'This chapter's pipelines are illustrative; the compendium has none (see the cohort section). Even a pipeline that ran green would demonstrate re-execution, not a level.' Alternatively, add the three-target `_targets.R` and run it in CI.

### zzcollab commands in the main text without raw equivalents
- Location: 08-testing-quality.qmd:1388
- Quote: 'In the framework, both run inside the project container through Makefile targets, so that no host R installation is required'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (08:1393-1396, 999-1006, cheat sheet 2496-2497; repo `Makefile`:105-109 says 'needs code-quality enabled')
- Prior: 'fix for D2 incomplete'
- Problem: `make style`, `make lint`, and `zzc verify --full` appear in the main text and the cheat sheet, not in a boxed 'with zzcollab' track. The plain `styler::style_dir()` and `lintr::lint_dir()` calls are never shown.
- Why it matters: D2 promised that the course is teachable without zzcollab, and a reader without it cannot run these lines.
- Fix: Show the plain R calls first and box the zzcollab Make targets and the `zzc verify` rule, as D2 specifies.

### Air formatter absent
- Location: 08-testing-quality.qmd:1380
- Quote: '**Styling** is automatic reformatting: `styler` rewrites the source into a consistent layout'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (https://opensource.posit.co/blog/2026-06-26_air-0-10-0/: Air 0.10.0 adds 'pre-commit and prek support via posit-dev/air-pre-commit'; Positron ships Air as its default R formatter per https://positron.posit.co/guide-r-air.html, from the search result only)
- Prior: new
- Problem: Since 2025, Posit's Air has been the fast formatter used in Positron and now has a pre-commit hook. The chapter names only `styler`.
- Why it matters: The chapter will read as dated to a 2026 student whose editor already formats with Air.
- Fix: One sentence and an alternative hook: 'Air (Posit), a much faster formatter that follows the same tidyverse style, is the default in Positron and offers an `air-format` pre-commit hook; either tool serves.'

### Retinopathy timing model ignores the paired-eye design
- Location: pipelines.qmd:501
- Quote: 'fit <- survival::coxph(survival::Surv(time, status) ~ arm + age,'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (`survival::diabetic` has two eyes per patient, 394 records, as 08:665 states; no `cluster(id)` anywhere in analysis/report by grep)
- Prior: new
- Problem: The Cox fit treats 394 eyes as independent, and the bootstrap at 504-511 resamples eyes rather than patients. For a timing demonstration this is harmless, but the code is printed in a health-sciences book.
- Why it matters: A biostatistics referee will notice, and a student may copy it.
- Fix: Use `+ cluster(id)` and resample `id`s, or add a one-line comment that the model is for timing only and ignores the pairing.

### Exercise 2 solution points to the wrong exercise
- Location: pipelines.qmd:1778
- Quote: 'The first behavior is the one this exercise demonstrates; the second is the subject of exercise 4.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (Exercise 4 concerns an undeclared prerequisite, not a change that leaves timestamps unchanged)
- Prior: new
- Problem: 'The second' is a change that leaves timestamps unchanged; Exercise 4 is about an undeclared helper file.
- Why it matters: A student who checks Exercise 4 for the timestamp case will not find it.
- Fix: 'the second, together with the related failure of an undeclared input, is the subject of exercise 4', or point to the `trust_timestamps` passage (pipelines:815-833).

### `clustermq` named as the route to schedulers; `crew` appears to be the current one
- Location: pipelines.qmd:1172
- Quote: '`targets` reaches a scheduler only through backends such as `clustermq`.'
- Severity: minor
- Viewpoint: referee
- Evidence: inferred (https://books.ropensci.org/targets/crew.html presents `crew` for parallel and HPC runs, and the manual's table of contents titles an appendix 'High-performance computing (the old way)'; the page does not call `clustermq` deprecated)
- Prior: new (Phase 25 A3-42 checked the claim's truth, not its currency)
- Problem: The named backend appears to be the older route.
- Why it matters: A student who searches for `clustermq` is likely to find the older documentation rather than the current one.
- Fix: 'through `crew` and its cluster plugins (`crew.cluster`), or the older `clustermq` backend.'

### Sandve described as covering testing and code quality
- Location: 08-testing-quality.qmd:2526
- Quote: 'Sandve and colleagues' ten simple rules [@sandve2013] cover the same ground in a compact, rule-by-rule form'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285: no rule concerns testing or code style)
- Prior: 'fix for Phase 25 L13 incomplete' (agent4-report.md:53 hedged 'situate readable code', but 'cover the same ground' survives)
- Problem: 'The same ground' refers to testing and code quality, which the ten rules do not address.
- Why it matters: The description misattributes content to the source.
- Fix: 'Sandve and colleagues' ten simple rules cover the adjacent ground of provenance: version control, recorded seeds, and intermediate results.'

### `tinytest` reference pinned to 2020
- Location: references.bib:88 (cited at 08-testing-quality.qmd:297, 2514)
- Quote: 'note = {R package version 1.2.4}'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (https://cran.r-project.org/package=tinytest: version 1.4.3, published 2026-03-24; Imports parallel, utils)
- Prior: new
- Problem: The citation names a version six years old.
- Why it matters: It signals staleness in a chapter that teaches pinning.
- Fix: Update the entry to 1.4.3 (2026), or cite without a version and with an access date.

### Rendered reporting-rule sentence reads 'the upper bound 0 ... 1.5 to 5.'
- Location: 08-testing-quality.qmd:1086
- Quote: 'At the default `B = 1000` the rule allows the lower bound `r d_lower` decimal place and the upper bound `r d_upper`'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (`_freeze/08-testing-quality/execute-results/html.json` renders 'the upper bound 0, ... reported as 1.5 to 5.')
- Prior: new (the default `B = 1000` was set deliberately in Phase 21, M3; this finding concerns only the rendered sentence)
- Problem: The rendered sentence reads 'the upper bound 0' and ends '1.5 to 5.', which reads as a truncated number.
- Why it matters: The sentence carries the chapter's reporting rule, and as rendered a student may misread it.
- Fix: Use an inline helper that writes '0 decimal places', and print the interval as '1.5 to 5 (upper bound to the nearest unit)'.

### Two different cohort analyses without signposting
- Location: 08-testing-quality.qmd:1030
- Quote: 'on the HbA1c odds ratio, at `B = 250` and at the package default `B = 1000`'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (logistic `fit_model()` and HbA1c OR at 604, 1030; 'canonical' Cox BMI HR at 1920-1945; 08:622-625 says `fit_cox()` was added beside `fit_model()`)
- Prior: new (the coexistence is deliberate since T1-7; the gap is the signposting)
- Problem: The cohort is analyzed by a logistic model in one place and by a 'canonical' Cox model in another. 08:622-625 notes that both functions exist, but not which analysis is primary or why the bootstrap section uses the other.
- Why it matters: A novice cannot tell which analysis is the study.
- Fix: One sentence at 1030: '`bootstrap_ci()` resamples the secondary logistic analysis; the primary analysis is the Cox model of the cohort section.'

### Data-validation assertion passes when every age is missing
- Location: 08-testing-quality.qmd:707
- Quote: 'expect_true(all(cohort$age_at_enroll >= 18 & cohort$age_at_enroll <= 105, na.rm = TRUE))'
- Severity: minor
- Viewpoint: referee
- Evidence: inferred (`all(logical(0))` is `TRUE` in R; not run)
- Prior: new
- Problem: With `na.rm = TRUE`, an export that blanks every age passes. No companion missingness bound is given for age, although cleaning deliberately creates NAs.
- Why it matters: This is the false-comfort failure the chapter warns about.
- Fix: Add `expect_true(mean(is.na(cohort$age_at_enroll)) < 0.05, info = ...)` and a sentence on why a range check needs a missingness partner.

### No test-run output is ever shown
- Location: 08-testing-quality.qmd:517
- Quote: 'Each line is a complete test.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (no `#>` transcript or tinytest summary in the chapter)
- Prior: new (parallels Finding 39's call for `#>` transcripts)
- Problem: A novice never sees what passing or failing looks like in `tinytest`, or how `info=` appears in a failure.
- Why it matters: The student cannot recognize a pass or a failure, or read one, when running the suite.
- Fix: An abridged transcript of `run_test_file()` with one deliberate failure, showing the `info` message.

### Pipeline Exercise 7 omits that the CSV must be generated and the package loaded
- Location: pipelines.qmd:1686
- Quote: 'Run `cohort <- clean_cohort(load_cohort('analysis/data/raw_data/cohort_raw.csv'))` and report `nrow(cohort)`.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (the CSV is gitignored per THIRD-REVIEW-PLAN Finding 29; 08:973-977 gives the steps, pipelines does not)
- Prior: new
- Problem: On a fresh clone the file does not exist and `load_cohort` is not defined.
- Why it matters: The exercise fails on its first line for a student working from a fresh clone.
- Fix: Prefix the exercise with 'From the project root, run `Rscript analysis/scripts/simulate_cohort.R` and `pkgload::load_all()`'.

### Length: optional marks rather than cuts
- Location: pipelines.qmd:1100; 08-testing-quality.qmd:1468
- Quote: '## Validation in the regulated sense'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (`wc -w`: pipelines.qmd 13,737 and 08-testing-quality.qmd 15,482 raw words including code; 13 checks each)
- Prior: new (respects D18 and D20: no cut proposed)
- Problem: The core reader of Chapter 11 must pass through the regulated validation, code review, MCSE, and parallel-stream sections. The core reader of Chapter 10 must pass through Snakemake, Nextflow, `workflowr`, and the LLM-in-pipeline sections. None of these sections is marked.
- Why it matters: The one-quarter reading load stays high, and the student cannot tell what may be skipped.
- Fix: Mark these sections 'optional' in their headings and list them in the Conventions table. This amends the D3 table; it is not a cut.

### 'A pipeline captures no determinant' restated about ten times
- Location: pipelines.qmd:959
- Quote: 'a pipeline captures no new determinant and adds no rung to the ladder.'
- Severity: minor
- Viewpoint: mentor
- Evidence: inspected (grep for 'captures no', 'pins no', and 'adds no rung' gives lines 165, 180, 959-960, 986, 1427, 1873, and 2023; the same claim is also made at 141-147, 311-323, 1042-1047, and in the checks at 171-189, 1014-1036, and 1432-1455)
- Prior: new (Finding 38 class; D18 permits removing defective duplication only, so this is offered as a tightening)
- Problem: The chapter's one negative claim is made in the stack section, the analyst's-contribution list, the 'does and does not add' section, the honest-level box, the cohort section, three checks, two exercises, and the cheat sheet.
- Why it matters: A skeptical reader experiences the repetition as defensiveness, and it lengthens a chapter that is already about 55 minutes.
- Fix: State it once in full (959-968), keep the figure and the cheat-sheet row, and replace the other prose restatements with a back-reference or delete them. The checks can stay because they test retrieval.

## Scope disclosure

- Read in full: `pipelines.qmd` (2,051 lines); `08-testing-quality.qmd`
  (2,542 lines); `THIRD-REVIEW-PLAN.md` (991 lines); the BRIEF and the
  review prompt; `inst/tinytest/test-cohort.R`.
- Grepped only: `REFACTOR-PLAN.md` (D1 to D12, core path, testthat),
  `docs/third-review/*.md` for chapter names, testthat, clustermq,
  precommit, and lint_dir; `conventions.qmd`:178-205; `_quarto.yml`
  chapter list; the repository `Makefile` targets; `references.bib`
  entries; `_freeze/*/html.json` for the rendered inline values.
- Code: no R code, render, or install was run. Rendered values come from
  the existing `_freeze` files. `targets`, `make`, `pre-commit`, `lintr`,
  and `tinytest` behaviors were not executed by me. The scratch-run claims
  in pipelines:794-799 and 828-833 rest on earlier phases.
- Verified on the web (2026-11-25): Wilson 2014 and 2017 contents; Sandve
  2013 rule titles; tinytest 1.4.3; targets 1.12.1 (2026-11-19); lintr
  3.4.0 and `LINTR_ERROR_ON_LINT`; precommit v0.4.3 still latest; Air 0.10.0
  pre-commit support; the `crew` chapter of the targets manual.
- Web content came through a summarizing fetch tool, so quotations from
  the Wilson, Sandve, lintr, precommit, and Air pages are as the tool
  reported them, not from a raw read.
- Not checked: glossary consistency for the two chapters' terms (Section 5.6).
- Not verified: the paired-eye structure of `survival::diabetic` beyond the
  book's own '394 records' (from memory); the four proposed motivating cases (an Organic Letters
  search failed); `make` availability on Windows and macOS; current
  `testthat` and `validate` versions; whether Positron ships Air by
  default (search snippet only).
