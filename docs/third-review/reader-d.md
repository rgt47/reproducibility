# Reader D: Chapters 11 (08-testing-quality) and 12 (09-continuous-integration)
*2026-11-07*

## Summary

1. The Cox unit test in Ch 11 (08:1673-1675) fails when run on the real cohort: `fit$nevent` is 48, and there are 305 non-missing outcomes [V]. Ch 12 Exercise 7, run exactly as written, returns `length(missing) = 2` (`survival`, `withr`) and then three names, not 0 and one [V]. The instructor key (instructor-guide:303-313) gives 0 and `"sandwich"`, so it is wrong too.
2. Ch 12 contradicts itself on hashing. The `tbl-integrity` digest (09:1139) hashes an in-memory R object by serialization. The Exercise 3 solution (09:1994-1997) defends that digest as hashing 'raw data bytes on disk', and REFACTOR-PLAN:2224 records it as 'already correct'. It is not correct: identical values with a different class give a different digest [V].
3. Ch 12 Exercise 4's solution (09:2030-2041) will not work as a CI gate. `make check-renv` calls `check_packages(auto_fix = TRUE)` and edits the lockfile on the runner. `make docker-render-book` needs Docker inside a `rocker/verse` job [I].
4. Known items, all confirmed: #2, #3, #23, #24, #25, #43 (the white paper treats only base and recommended packages as low risk), #45 (partly), #46. A new one: the 21 CFR 11.10(a) quotation says 'discriminate', but the regulation says 'discern', and it does not mention IQ/OQ [I, opened the source].
5. The voice pass mostly kept meaning. Its main damage: two openings that switch between 'the reader' and 'we' (08:27-34, 09:27-36), ten 'That is,' in Ch 12 (none before the pass), a garbled `git bisect` sentence (09:1500), and a duplicate roadmap in Ch 11 that gives the wrong closing section (08:169-174). The stated reading times are low: about 65 and 80 minutes, against the stated 45 and 50.

---

## Findings ranked by severity

### Major

**M1. Cox event-count assertion is wrong and fails on the real cohort.** 08:1663-1666, 1673-1675. [V]
The contract given is 'event count equals the number of non-missing outcomes'. Run on the cleaned cohort, `fit$nevent` = 48 and `sum(!is.na(cohort$incident_dm))` = 305. tinytest reports `FAILED[data] ... Mean relative difference: 0.842623`. The assertion counts zeros as events. `fit_cox()` also drops rows with missing age or sex (R/cohort.R:152-154), so even the corrected count is only equal here by accident. No file in `inst/tinytest/` runs this assertion (confirms known item #3).
*Fix:* state the contract as 'the event count equals the number of events among complete cases':
```r
cc <- with(cohort, !is.na(incident_dm) & !is.na(age_at_enroll) & !is.na(sex))
expect_equal(fit$nevent, sum(cohort$incident_dm[cc]))
expect_equal(fit$n, sum(cc))
```
Add it to `inst/tinytest/test-cohort.R`, so that the book's habit of running every chunk it shows also covers this one.

**M2. Ch 12 Exercise 7 and its key are wrong.** 09:1836-1848; instructor-guide:303-313. [V]
Run exactly as written from the repository root:
- `length(missing)` = 2, with `missing` = `c("survival", "withr")`.
- After `library(sandwich)` is appended to a copy, `missing` = `c("sandwich", "survival", "withr")`.

The exercise's pinned set `c('tibble','ggplot2','stats','utils')` leaves out the `withr` and `survival` that the chapter's own chunk includes (09:1619). The key's `#> 0` is typed, not computed. A self-study reader is sent to the demonstration section (09:2173-2176), which prints '(none)' against the six-package list. That reader therefore 'confirms' the wrong key, while their own run correctly disagrees. A second problem: part 2 says to re-run 'the same two lines against the copy', but the first line hard-codes `'R/cohort.R'`. *Fix:* put `'withr', 'survival'` in the exercise's vector, or better, use `names(renv::lockfile_read('renv.lock')$Packages)`. Change the path to a variable, and regenerate the key from an executed chunk (confirms item #2).

**M3. The `tbl-integrity` digest is the fragile object hash the chapter warns against.** 09:1118-1123, 1132-1143, 1994-1997; REFACTOR-PLAN:2224. [V]/[I]
`digest(cohort, algo = 'sha256')` serializes a tibble in memory. It does not hash file bytes. The Exercise 3 solution says 'the digest in @tbl-integrity is defensible because it targets the raw data bytes on disk', and the prior review recorded it as 'already correct (file-byte hashing)'. Both claims are false. I ran the same values as a tibble and as a `data.frame`: the digests were `3d29e020...` and `046d1085...`. The digest moves when class attributes change and the values do not, which is exactly the false-positive mechanism 09:1976-1990 describes. The prose also mixes up objects: the section is about a raw-file manifest (09:1110-1113), yet the demo calls its object a 'derived dataset' (09:1119).
*Fix:* write the frame to a temporary CSV and hash the file with `digest(file = path, algo = 'sha256')` or `tools::md5sum()`. Better still, hash the real `cohort_raw.csv` and show a `data-manifest.sha256` line. Then the solution's sentence becomes true.

**M4. Exercise 4's solution would fail or go silently green in CI.** 09:2030-2041, 2072-2080. [I, zzcollab templates/Makefile:134-138, 418-419, 81]
- `check-renv` runs `zzrenvcheck::check_packages(auto_fix = TRUE, strict = TRUE)` and is documented 'run before commit'. In CI it repairs `renv.lock` on the runner, so the gate cannot go red for an omission it can fix. The non-modifying target is `check-renv-no-fix`.
- `docker-render-book` expands to `$(CONTAINER_RUNTIME) run ...`. A job whose `image:` is `rocker/verse:4.4.0` has no Docker daemon, which the chapter itself notes at 09:857-860.
- The translation also drops the `renv::restore()` that the body's GitLab file performs (09:814), so `make check` runs against an unrestored library.

*Fix:* use `check-renv-no-fix`, add the restore step, and render without Docker inside the image job (or move rendering to the shell-executor `verify` job). Add one sentence explaining why the auto-fix target must not be a gate.

**M5. 'The honest level' callout overclaims and contradicts the next section.** 09:1064-1074. [I] (confirms item #25)
The callout says 'this chapter's own gates reach L3'. The gates do not reach L3; the verify job does (09:928-950). Moreover, the chapter says that 'the image build and the job as a whole were not run for this chapter' (09:1017). The callout then says that 'CI establishes nothing at all about the data's own integrity'. Yet verification 'reads the manifest' (09:1112), and `zzc verify` checks raw-data checksums (09:1025-1026). The callout is also a single sentence of about 60 words, against the voice spec's limit of about 35.
*Fix:* 'This chapter's verify job, if run against its baseline test, would reach L3; the chapter itself ran the gate logic but not the job. A stamp older than the last change to the lockfile, Dockerfile, or code is stale. The gates alone say nothing about whether the raw data changed; the checksum manifest of the next section does.'

**M6. The capture test matrix rates 'Docker without renv' as L2.** 09:1229. [I] (confirms item #46)
Ch 3 says the rungs are cumulative: 'An L2 analysis is also locatable and package-pinned' (02:467-468), and 'a genuinely pinned-environment analysis carries both' (02:479-480). An image that 'installs from `DESCRIPTION`' pins no package versions. *Fix:* rate the row L0 with the note 'environment fixed, packages unpinned'. Alternatively, explain explicitly that the framework's L2 label departs from Ch 3's definition, but that undercuts the ladder.

**M7. The rule of thumb in a check-your-understanding answer contradicts L3.** 08:1266-1269 versus 08:880, 1956-1963. [I] (confirms item #24)
'Removing a validation feature leaves the level unchanged.' The chapter also says 'A baseline test is what L3 requires', and Exercise 4's solution drops L3 to L2 when the baseline test is removed. *Fix:* append 'with one exception: the baseline test is the evidence L3 requires, so removing it drops L3 to L2.'

**M8. The regulated-validation section misquotes the CFR and misattributes IQ/OQ.** 08:1285-1299, 1362-1367. [I; opened law.cornell.edu/cfr/text/21/11.10]
The regulation reads '...and the ability to *discern* invalid or altered records'. The book has 'discriminate'. Section 11.10 does not mention installation or operational qualification, yet the answer at 08:1362-1367 says that '21 CFR 11.10(a) asks for ... installation and operational qualification records'. IQ/OQ come from FDA guidance and GAMP practice [EK]. *Fix:* correct the quotation, and attribute IQ/OQ to 'industry practice under this requirement'.

**M9. The R Validation Hub summary overstates 'trusted' status.** 08:1334-1337. [I; opened pharmar.org/white-paper] (confirms item #43)
The white paper calls only 'base and recommended (core) packages' minimal risk. For the tidyverse it says only that there is 'a reasonable case' to treat the team as a trusted resource, and leaves that decision to each organization. It also requires qualification tests for statistical-modeling functions 'regardless of the risk assessment'. The phrase 'earns trusted status with no further work' is therefore wrong. *Fix:* 'lower risk, such as base R and the recommended packages, needs little further remediation; whether to extend that to other widely used packages is left to each organization.'

### Minor

**m1. The listed baseline test omits two of its five assertions without saying so.** 08:751-769 versus 08:870. [V] (confirms item #23)
`run_test_dir` reports 5 passes for `test-baseline-cohort.R`. The listing shows 3 (no `n_events`, no `upper`) and a simpler guard than the real file. *Fix:* label the listing 'abridged', or show all five.

**m2. The coverage figure says no reproducibility test catches dropped rows, but the book's baseline test does.** 08:1033-1037, 1071-1074. [I]
`test-baseline-cohort.R` asserts `n_rows` against the baseline. A matrix offered as 'close to diagonal, which is the point' should mark that cell, or the caption should say 'most likely to catch'. The integration test shown checks `nrow(summary_tbl)`, not cohort rows (08:576), so the answer's 'which would see the changed row count' does not fit the test as written either.

**m3. The uncleaned-model sentence has a typed number that misdescribes the fit.** 08:1639-1641. [V]
'Fit a different model on 338 rows': 338 is the raw row count, but `fit_cox(raw)` uses 306 rows. *Fix:* compute it inline, or say 'on the 338-row raw extract'.

**m4. The cohort gate demonstration claims to read 'what this compendium currently declares as pinned'** (09:1611-1614), but `locked` is a typed vector (09:1619). [V]
The conclusion holds: all five used packages are in the real `renv.lock`. The demonstration nonetheless teaches the very anti-pattern the gate exists to prevent. *Fix:* `locked <- names(renv::lockfile_read('../../renv.lock')$Packages)`. Also, 09:440 says the gate 'scans the source, `analysis/` included', while the code at 09:450 scans only `analysis/`.

**m5. 'Must be called with `error_on_fail = TRUE`'** (09:463-466, cheat sheet 09:2212) overstates. [I, zzrenvcheck R/compare.R:107]
The default is `!interactive()`, so a call from `Rscript` already errors. The package recommends passing it explicitly 'so the gate does not depend on how R was started'. Say that instead.

**m6. 'As the first section established'** (09:1279) points to 'What the checks are: the three gates', which is not the first section. [I] (item #45, confirmed)
The 'five moves' count (09:1565) is defensible if `sessionInfo` and the lockfile diff count separately ('first four moves', 09:1574), so I could not confirm that half of item #45. The Outline (09:75-86) does omit 'Secrets, tokens, and pinned actions' and 'Debugging a failed reproduction'; that half is confirmed.

**m7. The parallel-RNG paragraph** (08:958-963, 969-971) says `mclapply` with no setup 'can leave workers sharing' state, and that the result 'understates the Monte Carlo error'. [EK]
With the default `mc.set.seed = TRUE`, the children are reseeded, so the main failure is irreproducibility rather than shared streams. 'A width that understates the true Monte Carlo error' also mixes the interval width with its MC error. Rephrase.

**m8. Ch 11 Exercise 3's solution** uses different column names (`id`, `age`, `outcome`), a `derived_data/cohort.rds` that does not exist (the directory is empty), a missingness bound of 5 percent, and an `'Other'` level. It claims to be 'in the form the chapter uses' (08:1895-1916) while the body uses `mrn`, `age_at_enroll`, 15 percent. [I] Either use the cohort's names or drop the claim.

**m9. 'The `calculate_mean` function of the orientation'** (08:534): the orientation never names it (08:108-122). [I]

**m10. The book's own `test-cohort.R` labels a same-session check 'reproducibility'** (inst/tinytest/test-cohort.R, final block). The chapter's Pitfall (08:716-727) says such a check is not a reproducibility test. [I] Rename the block 'determinism (same session)'.

**m11. The GitLab image comment says** 'the tag must name the R version recorded in renv.lock' (09:811-812) beside `rocker/verse:4.4.0`, while this repository's lockfile records R 4.6.1. [I] Use a placeholder, or the real version.

**m12. Peng 2011 paraphrase** (08:2148-2152): Peng's minimum standard is reproducibility, not 'confirming a result'. [EK] (item #44, likely confirmed)

---

## Part A. Meaning preservation of the voice pass (ee7a639 to d786c6b)

Counts (before, then after):

| Marker | Ch 11 | Ch 12 |
|---|---|---|
| 'That is,' | 0 then 3 (86, 377, 1680) | 0 then 10 (29, 94, 181, 412, 689, 730, 938, 1192, 1258, 1512) |
| 'We note that' | 0 then 1 (945) | 0 then 1 (336) |
| 'Unfortunately,' | 0 then 0 | 0 then 1 (391) |
| Rhetorical questions added | 3 (138, 914, 1323) | 3 (473, 619, 1038) |
| 'therefore' | 1 then 4 | 6 then 19 |
| 'However,' | 0 then 1 | 0 then 7 |

In Ch 12, 'That is,' is spread across the whole chapter. In most places it replaced a colon or 'because', which turns a causal or explanatory link into a restatement. Four of the six rhetorical questions open with 'But ...', and those openers are becoming a tic.

Changes to correct:

- **08:27-34.** Before: 'you will be able ... to tell the difference in your own analysis.' After: 'the reader will be able ... To tell the difference in an analysis of one's own, we develop...'. Three voices in two sentences. *Fix:* 'By the end of this chapter we will be able to say ... To make that distinction in our own analyses, we develop ...'.
- **09:27-36.** 'the reader will be able ... That is, we shall be able to say ... We shall also be able ... Finally, we shall learn'. This mixes 'the reader' and 'we', 'That is' introduces a list rather than a restatement, and the passage has three 'we shall' clauses. *Fix:* 'By the end of this chapter we will be able to look at a green build and say which of three gates ran, what each would have caught, and what a missing baseline test still lets through; and we will know how to turn each gate red on purpose, because ...'.
- **08:169-174.** An added roadmap ('The plan of the chapter is as follows ... Lastly, we close with the way the emphasis shifts across archetypes') duplicates the Outline in the callout above it. It is also wrong about the ending: after archetypes come the worked example, LLM, cohort, exercises, and the plan, regulated, and Monte Carlo sections, none of which it mentions. *Fix:* delete the paragraph; the Outline does the job.
- **09:1500-1501.** Before: 'Told that the fourth commit was bad and the first was good, `git bisect run Rscript check.R` tested...'. After: 'We told `git bisect run Rscript check.R` that the fourth commit was bad'. That misstates how bisect works: the good and bad commits go to `git bisect start`, not to `run`. *Fix:* 'We marked the fourth commit bad and the first good, then ran `git bisect run Rscript check.R`. It tested ...'.
- **09:1357-1359 and 1370-1371.** Before: 'a machine that is not yours ... a person who is not you'. After: 'not the author's ... not the author'. The check-your-understanding question still quotes 'a machine, or a person, that is not yours'. The book's best memorable device (section title, Habit 6) was weakened in the one sentence it anchors. *Fix:* restore 'yours/you' in that sentence, or reword the question.
- **09:1512.** Before: '... changed under it, because `git bisect` can only blame a commit if ...'. After: 'That is, `git bisect` can ...'. The causal link is lost. *Fix:* restore 'because'.
- **09:94, 412, 689, 730, 938, 1192.** 'That is,' wrongly introduces a reason (94: restore 'because'), an elaboration (412: restore the colon), a code example (689: 'It passes `GITHUB_PAT: ...`'), or a list (730, 938). *Fix:* restore the colons or 'because'. Keep 'That is' only where it restates (181, 1258 are fine).
- **09:336.** 'We note that continuous integration captures no new layer' is the third statement of the point (after 91 and 143). *Fix:* cut the sentence and open with 'It does not pin a package version ...'.
- **09:391.** 'Unfortunately, its scope is narrower than it looks' adds editorializing. *Fix:* 'Its scope is narrower than it looks.'
- **08:1001.** 'Read the bottom row first' became 'We read the bottom row first'. That turns an instruction to the reader into a claim about what 'we' do. Minor; restore the imperative or write 'Start with the bottom row'.
- **08:958-962.** 'can leave workers sharing ... state, so that resamples ... are correlated' became '... state. Resamples ... are then correlated'. A conditional ('can') is now a flat assertion. *Fix:* 'Resamples ... can then be correlated'.
- **08:1597, 1600.** 'your domain / your population' became 'the analyst's / the study', inside a 'Watch for' that still addresses 'you' two lines later (1605-1606). This mixes persons within one block. *Fix:* restore 'your'.

I found no change that dropped a number, name, or citation. The Validation Hub steps (08:1327-1337) were split into ordinal sentences without loss of meaning.

---

## Part B. Reader review

### Chapter 11, Testing and Code Quality (08-testing-quality.qmd)

- **Reading time.** About 12,700 words. Roughly 10,700 prose words take about 54 minutes, and about 360 code lines add about 10 minutes, for about 65 minutes. The callout says 45 (08:39). [I, estimate]
- **Opening.** Strong. The sum-instead-of-mean function and the paradox (08:108-136) motivate the chapter well for health-science students. The epigraph fits.
- **Closing.** The cheat sheet and further reading consolidate the chapter. There is no closing paragraph pointing to Ch 12 beyond 08:2141-2147. That is adequate.
- **Hardest passages.** (1) 08:1285-1299, regulatory prose aimed at a pharma audience. (2) 08:943-952, 'Monte Carlo stable at a given comparison tolerance ... a separate check'. (3) 08:579-591, the `glm`/`coxph` migration argument. It says the `fit_cox()` 'migration' required only a new test file. But `fit_model()` was never migrated; a second function was added, so the example does not show what it claims. Suggested rewrite of (3): 'Testing `inherits(fit, 'lm')` ties the test to the model class. Testing that `coef(fit)` is numeric ties it to what `summarise_fit()` needs, and stays true if the model is later changed to one that does not inherit from `lm`, such as a `coxph` fit.'
- **Pedagogy.** There are 12 check-your-understanding boxes, all answerable from the text. Exercises 1, 2, 5, 6, and 8 agree with the body. Exercise 3's solution does not match the cohort (m8). Exercise 4's solution is correct, but it contradicts the rule of thumb at 08:1266-1269 (M7). The cohort unit test is wrong (M1).
- **Callouts.** There are 34 note callouts, most of them collapsible checks; that is heavy but conventional for this book. 'The honest level' (08:326-338) is used well. The Pitfall (08:716-727) is the best callout in the chapter.
- **Content.**
  - The analysis-plan-as-oracle section (08:360-425) is a real contribution for this audience.
  - Monte Carlo and the regulated sections are useful but drift toward the encyclopedic.
  - The Sandve sentence about provenance (08:1173-1176) is a non sequitur inside a paragraph on legibility.
  - `lintr`/`styler` duplicate nothing elsewhere.
- **Running example.** Numbers I reproduced [V]:
  - 338 raw rows, 337 cleaned, 1 duplicate.
  - Max raw age 400.
  - Outcome missingness 9.5 percent.
  - HR 1.83 (1.32-2.52), with 48 events.
  - 197 eyes per arm, laser event rate 0.274.
  - Bootstrap width SDs 0.319 and 0.101.
  - RNG-sampler shift 0.0036 BMI units.
  - Baseline file equal at 1e-8.

  All prose numbers are inline-computed except '338 rows' (m3) and '197 eyes' (08:621). The latter is correct, but it is typed.
- **Memorability.** These devices work: 'trusted rather than checked' (08:157); 'the function agreeing with itself' (08:625); the empty re-execution row in fig-test-coverage. It would help to state the paradox in one boxed line at its first appearance and repeat it in the cheat sheet.

### Chapter 12, Continuous Integration and Verification (09-continuous-integration.qmd)

- **Reading time.** About 15,400 words. Roughly 14,000 prose words take about 70 minutes, and about 230 code lines add about 8 minutes, for about 80 minutes. The callout says 50 (09:41). This is the longest chapter I have read in the book; it should be split, or the time stated honestly. [I, estimate]
- **Opening.** Good. The 'untested claims' sentence and the finished-registry-study scenario (09:113-133) are well aimed. The objectives paragraph is damaged (Part A).
- **Closing.** Further reading is adequate. There is no forward pointer to archiving (Ch 13).
- **Hardest passages.** (1) 09:591-617, cross-boundary state, which is dense and abstract for students with no CI experience. (2) 09:1064-1074, the callout (M5). (3) 09:998-1006, the `.Rprofile`/autoloader assumption. Suggested rewrite of (3): 'Two assumptions are built in. The image must contain `tinytest` and `pkgload`. And because `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE` stops the mounted project from activating its own library, the image must already have the pinned packages on R's default path, for example in the site library.'
- **Pedagogy.**
  - The deliberate-breakage table (09:566-570) is excellent and matches habit 4.
  - Exercises 1, 2, 5, 6, and 8 agree with the body.
  - Exercises 3, 4, and 7 have defective solutions (M3, M4, M2).
  - In Exercise 2's solution, the manifest-gate defect 'a package used in the code and absent from `DESCRIPTION`' (09:1926-1927) is the same defect assigned to `R CMD check` two paragraphs earlier, and it contradicts the compendium invariant at 09:436-439.
- **Callouts.** There are 38 note callouts and 14 checks. Two checks per section in places dilute them, and 'what the demonstration does and does not show' (09:1664-1687) is the most valuable of them. The single important callout is the flawed one (M5).
- **Content.**
  - Secrets and SHA pinning (09:666-742) is well done and self-critical. The checkout SHA comment agrees with my recollection of v4.2.2 [EK].
  - 'Continuous integration captures no new layer' is stated four times (91, 143, 336, 1355).
  - The debugging section (09:1464-1603) overlaps Ch 6 and Ch 10. It is useful, but it lengthens a chapter that is already too long.
  - 'In one documented case' (09:595) cites nothing.
  - The cheat sheet's 'Habit 6' is the only place habit 6 is named in this chapter.
- **Running example.** The cohort gate chunk reproduces [V]: the used packages are `stats, survival, tibble, utils, withr`, and all are in the real lockfile. The prose list (09:1636-1637) is typed but correct. The `tbl-integrity` digests differ from the first character (`ca5e...` versus `a979...`) [V]. The Exercise 3 solution's TRUE/FALSE reproduces [V].
- **Memorability.** The strongest device in either chapter is 'The machine that is not yours' paired with 'a person who is not you'. Restore it (Part A). 'A step allowed to fail ... is a report, not a gate' (09:559-560) also works.

---

## Three concrete fixes, ranked

1. **Make every graded answer come from executed code.** That means three changes:
   - Fix the Cox assertion (08:1673-1675) and add it to `inst/tinytest/test-cohort.R`.
   - Correct Ch 12 Exercise 7's package vector and path (09:1839-1846).
   - Regenerate instructor-guide:303-313 from a run.

   Each defect here is a typed expected value that the book's own oracle rule forbids.
2. **Reconcile the hashing story in Ch 12.** Hash a file in `tbl-integrity` (09:1139-1143), correct 09:1994-1997, and correct the record in REFACTOR-PLAN:2224. Fix the Exercise 4 solution's targets (09:2036-2040).
3. **Correct the level claims.** Rewrite 'The honest level' (09:1064-1074), the Docker-only matrix row (09:1229), and the rule of thumb at 08:1266-1269, so that the L2/L3 boundary agrees with Ch 3 (02:440-480). Fix the CFR quotation (08:1287-1289).

## Evidence notes and scope

My scripts and outputs are in work-reader-d/ (ch11.R, ch11.out, ch12.R, ch12.out). All R was run with the locked library from the repository root, without Docker. I did not render either chapter, build any image, or run any CI workflow. The YAML files were read, not executed. Reading-time estimates are word-count approximations. The SHA for `actions/checkout` v4.2.2, the `mclapply` reseeding behavior, and the Peng paraphrase rest on expert knowledge [EK] that I did not check.
