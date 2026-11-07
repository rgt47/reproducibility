# Persona review: MS program director, biostatistics
*2026-11-07, third review*

Simulated persona: an academic biostatistician who directs an MS
program at a US school of public health and would decide whether to
adopt the book for a required one-quarter course. Judgments about
what such programs expect are informed opinion, not survey data.

## Five-line summary

1. Verdict: adopt with revisions. The ladder and the capture/validation split are worth teaching, but the statistical core of Ch 11 has three errors that would mislead MS students.
2. Critical: the book's Cox unit test (`08-testing-quality.qmd:1673-1675`) fails when run [V]. It encodes a wrong contract (events = non-missing outcomes) in the chapter whose subject is oracles.
3. Major: parallel-RNG advice is wrong on two counts [V]. A sampler change is presented as a result change, though it is a quarter of one Monte Carlo SE [V]. The worked example also seeds in `.Rprofile`, and an optimizer-dependent estimate is called 'not statistical'.
4. Major for adoption: the rendered instructor guide is public and has no week table. Several autograder keys are stale against the repository (`renv.lock` now exists). At 600 PDF pages the core path runs about 50 pages a week [V].
5. Factual-issues items in scope: 3, 4, 5, 9, 13, 14, 16, 23, 24, 26, 30 confirmed; 27 and 47 partly confirmed; 43 likely but unverified.

Report: this file.

## 1. Verdict

I would adopt with revisions. Our MS students need what Chapters 3
and 11 teach: the ladder, the reproducibility paradox, oracles, and
baseline tests. No competing text I know frames these for health
data as well [EK]. In its current state, though, I could not assign
Ch 11 without an erratum sheet. Its statistical content (the Cox
contract, Monte Carlo error, parallel streams) is exactly what my
faculty would check first, and part of it is wrong. Assessment at
scale is also not ready. Every answer is printed, and the 'instructor'
keys ship in the public appendix.

## 2. Findings

### Critical

**C1. The Cox unit test fails, and it states the wrong contract.**
`08-testing-quality.qmd:1663-1666, 1673-1675`. [V] Run against the
committed extract, `expect_equal(fit$nevent,
sum(!is.na(cohort$incident_dm)))` FAILS: `nevent` is 48 and the
right-hand side is 305 (mean relative difference 0.84). The prose
states the contract as 'event count equals the number of non-missing
outcomes'. That counts zeros as events. It also ignores rows dropped
for a missing `age_at_enroll` (one row) or a missing covariate. The
chapter argues at length that an oracle must come from outside the
code, then prints an oracle that is simply false. A student who
copies it into their package gets a red suite and, worse, the wrong
mental model of `coxph`. No test in `inst/tinytest/` exercises
`fit_cox()` [V: three files, none for Cox], though
`08-testing-quality.qmd:588-591` says 'the test suite above required
only a new test file for `fit_cox()`'. Fix: the contract is
`fit$nevent == sum(dat$incident_dm == 1)` and `fit$n == nrow(dat)`.
Here `dat` is the complete-case set, and the oracle is a hand count
on a five-row fixture. Commit the file as
`inst/tinytest/test-fit-cox.R` and run it.

### Major

**M1. Parallel RNG: wrong diagnosis, and an incomplete fix.**
`08-testing-quality.qmd:954-974`. [V] With the default
Mersenne-Twister, `set.seed(1); mclapply(...)` returned different
values on two runs. The first failure of naive `mclapply()` is
irreproducibility, not correlation. Shared streams appear only with
`mc.set.seed = FALSE`: I observed duplicated pairs. The text offers
L'Ecuyer-CMRG with `clusterSetRNGStream()` as 'the fix'. It also
implies the fix removes the dependence on the number of cores. It
does not. With `clusterSetRNGStream(cl, 1)`, 2 and 4 workers gave
different results [V], and so did `mclapply` under L'Ecuyer with 2 and
4 cores [V]. Streams are assigned per worker, so the result depends on
how tasks are chunked. Fix: say that per-worker streams give
independence but not invariance to worker count. Teach per-task
streams for that: `future.apply` with `future.seed = TRUE`, `doRNG`,
or `parallel::nextRNGStream()` precomputed for each replicate. Add a
two-line demonstration that 2 and 4 workers agree under per-task
seeding.

**M2. A sampler change is not a change in the result.**
`08-testing-quality.qmd:787-860, 1737-1744`; `02-levels-of-reproducibility.qmd:336-341`.
[V] The chunk reports that the BMI bound moves by 0.0036 under
`Rejection` (reproduced exactly: 29.1400 to 29.1436). I reran the same
bootstrap at 40 seeds. The Monte Carlo SD of that bound at B = 2000
is 0.0154, so the 'failure' is about a quarter of one MCSE. The
chapter's later Monte Carlo section (898-952) separates the two
tolerances correctly. However, it never connects them back to the
table. The diagnosis list at 1737-1744 also has no entry for 'the RNG
changed; is the difference within Monte Carlo error?' A
biostatistician's answer to a failed bootstrap baseline after an R
upgrade is that the analysis reproduces, as a statistical result,
within MC error. Fix: (a) add one sentence after `tbl-baseline-rng`
comparing 0.0036 with the MCSE. (b) For stochastic outputs, record
the seed-exact value (tolerance 1e-8) and the MCSE in the baseline.
On a seed-exact failure, apply a second check, |diff| < 3 MCSE. (c)
The REFACTOR-PLAN canonical-analysis spec (lines 1846-1849) already
called for 'a stated Monte Carlo tolerance for the bootstrap'. It was
not implemented.

**M3. The book's own default number of replicates is too small for the precision it implies.**
`R/cohort.R` `bootstrap_ci(n = 1000)`; `08-testing-quality.qmd:919-952`.
[V] At B = 1000 the upper bound of the HbA1c OR interval has a
seed-to-seed SD of 0.215 on a value near 5.5 (30 seeds). Reported to
two decimals, the second digit is noise. The three-seed demonstration
(SD 0.319 vs 0.101) is offered as 'broadly consistent with
1/sqrt(n)'. Resampling triples from 30 seeds, the three-seed SD ratio
has a 5-95% range of 0.57 to 10.4, so the demonstration could have
shown the spread growing with B [V]. Also, `n` names the number of
replicates in a field where `n` means the sample size. Fix: rename the
argument `B`, use 20 or more seeds, report the MCSE of each bound, and
give the rule: choose B so the MCSE is below half a unit of the last
reported digit. Cite a standard simulation-reporting source on Monte
Carlo SEs. I did not check which is in the bibliography.

**M4. Seeding in `.Rprofile` contradicts Ch 11.**
`02-levels-of-reproducibility.qmd:855-859`. [I] The worked example
sets 'the RNG kind and a seed in the project `.Rprofile`'. A seed set
at session start makes every stochastic result depend on all earlier
RNG consumption. That includes interactive versus `Rscript` runs,
chunk caching, and packages that draw at load. Ch 11 (706-714)
correctly puts the seed in the function signature with
`withr::with_seed()`. Ch 3's own Exercise 6 solution (1308-1311) puts
`RNGkind()` in the analysis code. REFACTOR-PLAN line 1952 listed this
fix and it is still present. Fix: `.Rprofile` may set `RNGkind()`
defensively. The seed belongs at the call that consumes it.

**M5. 'The question is not statistical.'**
`02-levels-of-reproducibility.qmd:91-104, 146-155`. [I] A mixed-model
OR that moves from 1.24 to 1.19 when the optimizer changes signals a
flat or ill-conditioned likelihood, or a non-converged fit. That is a
statistical finding about the model. Pinning the package makes the
fragile answer reproducible. That is Ch 11's paradox, one chapter
early. REFACTOR-PLAN Finding 19 and line 1951 recorded this; the text
is unchanged. Fix: keep the story and add two sentences. The
discrepancy is computational in origin, but its size is a convergence
diagnostic. Check it with `lme4::allFit()`, and report the estimate
as optimizer-sensitive.

**M6. The canonical BLAS illustration is a computation that uses no BLAS.**
`02-levels-of-reproducibility.qmd:352-374, 1164-1171`. [I/EK] An
incidence rate is a ratio of two sums. R's `sum()` accumulates in long
double and never calls BLAS. A sixth-decimal difference with
'operating system identical' is more plausibly hardware: x86-64 has
80-bit long double and arm64 does not. Fix: use a regression
coefficient (`lm` and `qr` go through LAPACK and BLAS). Alternatively,
attribute the incidence-rate case to the hardware layer.

**M7. Grading at scale is not supported as published.**
`instructor-guide.qmd` (rendered, `_quarto.yml:67`); `preface.qmd:123-125`.
[I] The preface sends instructors to 'a week-by-week table' in the
instructor guide. The rendered guide has none. The table lives only in
the unrendered `INSTRUCTOR-GUIDE.md:23-34`. The rendered guide holds
the Exercise 7 keys, and chapters link to it for self-study readers
(`02-levels-of-reproducibility.qmd:1317-1322`). So the keys are public,
and every other solution is printed. Several keys are now wrong
against the repository [V]. `renv.lock` is tracked, so Ch 5
`sum(pillars)` is 2, not 1 (`instructor-guide.qmd:114-126`). Ch 8
expects `renv.lock = FALSE` (197). Ch 3 and the Ch 3 text
(`02-levels-of-reproducibility.qmd:922-924`) still say 'no
`renv.lock`'. An autograder built on these keys would fail correct
submissions. Fix: move the week table into the rendered guide, or
point the preface to the right file. Compute every key at render time
from inline R. Accept that public keys are self-check keys. Plan the
graded labs (`INSTRUCTOR-GUIDE.md:55-66`) as the real assessment, with
a lab repository that is held back.

**M8. The repository tracks the identifier-bearing extract it says it does not.**
`10-archiving-sharing.qmd:1235-1240`; `instructor-guide.qmd:340-347`.
[V] `inst/testdata/cohort_raw.csv` is tracked by git. It is
byte-identical to the gitignored `analysis/data/raw_data/cohort_raw.csv`,
which carries `mrn`, `patient_name` and `dob`. The text says 'the CSV
is generated from a committed script rather than tracked directly'.
The rubric says no check 'would need to change for real patient-level
data'. Both are false for this repository. The synthetic data are
harmless. The lesson is not: a second copy in a fixtures directory is
exactly the leak pattern Exercise 8 (1411-1422) teaches. Fix: say so,
and make it the example. Real data would need the fixture replaced by
a synthetic subset with the identifier columns dropped. Add a check
with `git ls-files | grep -i cohort_raw`.

### Minor

- `00-intro.qmd:84-86` quotes Peng as 'when full independent replication is impractical'. The Ch 3 epigraph (`02-levels-of-reproducibility.qmd:7-9`) quotes the same sentence as '...of a study is not possible'. These are two different 'verbatim' quotations. [I] The epigraph matches the abstract as I recall it [EK]. Fix the intro.
- `00-intro.qmd:179-182`: R 3.6.0 changed the `sample.kind` default, not 'the default random-number algorithm'. `RNGkind()` still reports Mersenne-Twister [V].
- `00-intro.qmd:183-187`: `lm()` gives identical coefficients for character and factor predictors [V]. The `stringsAsFactors` flip did not alter 'every model that treated those columns as categorical'. It altered factor-level handling and code that tested `is.factor`.
- `02-levels-of-reproducibility.qmd:342-345`: R holds `LC_NUMERIC` at 'C' [V], so base parsing of a decimal mark does not depend on it. Ch 6 was corrected (REFACTOR-PLAN 2218); this passage was not.
- `02-levels-of-reproducibility.qmd:76, 266, 771, 1039` and `10-archiving-sharing.qmd:946`: 'nine', 'nine or ten', 'four of the ten'. `determinant_layers()` has nine [V].
- `02-levels-of-reproducibility.qmd:872-874`: 'the one layer that remains outside the guarantee'. The chapter's own figure leaves three layers unpinned.
- `08-testing-quality.qmd:566-591` shows `expect_true(is.numeric(coef(fit)))` and argues against `expect_inherits(fit, 'lm')`. The real `inst/tinytest/test-cohort.R` uses `expect_inherits(fit, 'lm')` [I].
- `08-testing-quality.qmd:1639-1641`: 'a different model on 338 rows'. The uncleaned Cox fit uses 306 rows [V].
- `08-testing-quality.qmd:2005-2010`: '1e-8 ... catches any change large enough to alter a reported figure' and 'chosen against the precision at which results are reported' describe two different tolerances. Name them: numerical (1e-8) and reporting or Monte Carlo.
- `10-archiving-sharing.qmd:639-641`: CITATION.cff now reads `affiliation: University of California, San Diego` [V]. Only the empty `orcid` remains.
- `10-archiving-sharing.qmd:1868-1869`: 'Running `zzc verify` once ... lifts ... to L3' omits the baseline-test condition that Ch 3 (457-461) makes necessary.
- `10-archiving-sharing.qmd:840-842`: the NIH DMS Plan goes in the 'Other Plan(s)' attachment. Only DMS costs go in the budget justification [EK, not opened].
- `10-archiving-sharing.qmd:1689-1696`: 'the reduced pipeline ... must regenerate the leading replicates' holds only with per-replicate seeds or streams (see M1). Say so, and deposit the MCSE with the results.

### Verified sound (stated so the lead does not re-check)

- The 1e-8 relative tolerance on the Cox HR and CI is defensible [V]. Tightening `coxph` to `eps = 1e-14` changed the HR by 2e-12 relative, and tightening `glm` to 1e-14 changed coefficients by 4e-13. Iteration-count changes will not trip the baseline.
- `test-baseline-cohort.R` runs five assertions and all pass [V]. The committed baseline matches a fresh run exactly [V]. PH holds for the canonical model (global `cox.zph` p = 0.59) [V].
- The HbA1c OR chunk values in the text (0.319, 0.101) reproduce exactly [V].

## 3. Gaps (with scope judgment)

- **Simulation-based tests of statistical code.** In scope. The four kinds of test omit the one our students most need: checking a method's operating characteristics by simulation. Examples are coverage of a CI and the bias of an estimator, with a tolerance set from Monte Carlo error. One section in Ch 11 would fit.
- **Model diagnostics as tests.** In scope, briefly. Convergence warnings, `cox.zph`, and separation in logistic fits can be asserted in `tinytest`. These are 'data-validation for models'. Keep it to one paragraph so the book does not become a statistics text (preface 103-107).
- **Per-task parallel seeding** (M1). In scope.
- **Missing data in the canonical analysis.** 9.5% of outcomes are missing and are dropped silently by complete-case analysis. A sentence naming the assumption suffices. Missing-data methods are out of scope.
- **SAP/pre-registration as oracle** (`08-testing-quality.qmd:360-425`) is a good addition. It would be stronger with a 5-line executable example asserting the model formula.

## 4. Cuts for a ten-week quarter

[V] The PDF is 600 pages. The core path is about 127,000 words of
chapter source (code included), about 12,700 words a week. Ch 12 alone
is 15,400 words. Reading times are understated: Ch 11 says 45 minutes
for 12,700 words, which would be under 300 words a minute on technical
text with code.

Candidates to cut or move to appendices:

- Ch 3 'Two numbering schemes' (658-718). It is a framework-documentation issue, not a concept.
- Ch 11 'Validation in the regulated sense' (1273-1371). Keep a paragraph and a pointer; MS students going to industry learn this on the job.
- Ch 11 linting/pre-commit section and Exercise 6. Lab material, not reading.
- Ch 13 forge and registry vendor discussion (439-479), the Whole Tale and Turing Way paragraph, and Exercises 3, 5 and 6. `rang` was archived on CRAN [U, as reported].
- The 'Collaborating with an LLM' sections. Collapse them into one shared page; the restricted-data rule is restated in every chapter.
- Week 1 currently assigns preface, intro and crisis (about 11,000 words) plus setup. Move the setup appendix to a pre-course week.

## 5. Strengths to keep

- The paradox framing and the baseline-test definition of L3. They are clean, testable, and honest (`02-levels-of-reproducibility.qmd:441-465`).
- `bootstrap_ci()` takes its seed as an argument and uses `withr::with_seed()`. This is the right pattern, and it is verified non-destructive.
- The executed same-session versus cross-session demonstration (`tbl-baseline-rng`). It is genuinely instructive once M2 is added.
- The oracle discipline in `tbl-paradox`, and the 'two oracles' (function and SAP) argument.
- The restricted-data section of Ch 13 (662-825) is accurate and actionable for a health-sciences audience.

## 6. factual-issues.md items in my chapters

| # | Status | Evidence |
|---|---|---|
| 1 | Confirmed in my Ch 3 too | `renv.lock` tracked [V]; `02-levels-of-reproducibility.qmd:923-924`, `instructor-guide.qmd:65-69, 114-126, 197` still say absent |
| 3 | Confirmed, upgraded to critical | Test fails: 48 vs 305 [V] (C1) |
| 4 | Confirmed | `02-levels-of-reproducibility.qmd:1329-1330`; stack order from `determinant_layers()` puts analysis code above the runtime [V] |
| 5 | Confirmed | `02-levels-of-reproducibility.qmd:1242-1244`: if the conventions agree, the request *is* a misreading of the current standard; should read 'is not explained by' [I] |
| 9 | Confirmed | `renv.lock` has no `"Package": "utils"` record (count 0) [V]; `02-levels-of-reproducibility.qmd:953`, `instructor-guide.qmd:68` |
| 13 | Confirmed | `lm` coefficients identical [V] |
| 14 | Confirmed | `RNGkind()` default kind is Mersenne-Twister [V] |
| 16 | Confirmed | nine layers [V] |
| 23 | Confirmed | real file: five assertions, five passes [V]; listing at `08-testing-quality.qmd:751-769` shows three without saying it is abridged |
| 24 | Confirmed | `08-testing-quality.qmd:1267-1269` and `02-levels-of-reproducibility.qmd:396-398` versus `08-testing-quality.qmd:1961-1963`; state the baseline exception in the rule |
| 26 | Confirmed | `10-archiving-sharing.qmd:1554` `make render`; Makefile has `docker-render*` only [I]; ch12:2080 says no plain target |
| 27 | Partly | `10-archiving-sharing.qmd:1609` 'recorded output hashes'. A matching hash is valid evidence; the problem is that it is outside the ladder's tolerance definition and is fragile. Reword to 'a baseline test' |
| 30 | Confirmed | `instructor-guide.qmd:261` 'both targets' for three; 285-287 values not computed by the code shown [I] |
| 40 | Confirmed | `02-levels-of-reproducibility.qmd:530-532` 'toward L3' for CI without a baseline |
| 43 | Could not tell | did not open Nicholls et al.; my recollection [EK] is that base and recommended packages get the low-risk default, so 'long-established tidyverse' (`08-testing-quality.qmd:1335-1337`) is likely overstated |
| 44 | Confirmed (minor) | `08-testing-quality.qmd:2148-2152` paraphrases Peng's minimum as 'confirming a result'; the book's own epigraph says reproducibility |
| 47 | Partly | `10-archiving-sharing.qmd:436` 'regression to L0' should be L1 if the lockfile survives [I]; the cross-reference at about 1201 has moved and I could not identify it |

Not verified: Saju et al. (2025) figures; the date `rang` was
archived; the SWHID ISO status; TRIPOD+AI item numbers 18e and 18f
(consistent with my recollection [EK]); Docker Hub free-tier terms.
I did not build Docker, render the book, or read chapters outside my
assignment beyond targeted greps.

Scratch scripts: /private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/review3/work-persona-ms/check1.R through check4.R
