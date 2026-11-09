# Agent 5 report: Chapters 11 (08) and 12 (09)
*2026-11-08*

Files edited: `analysis/report/08-testing-quality.qmd` and
`analysis/report/09-continuous-integration.qmd`. No other file
was edited. I ran no git state-changing commands.

Evidence labels: V ran it; I inspected; EK expert knowledge, not
checked.

## 1. Items

### Chapter 11 (08-testing-quality.qmd)

| Item | Location (current) | Action | Evidence |
|---|---|---|---|
| T1-7 Cox oracle | 'Unit tests of `fit_cox()`', about 1700-1735 | already fixed (complete-case contract, file `test-fit-cox.R`); left alone | I |
| T1-9 CFR 'discern', IQ/OQ/PQ attribution | 'Validation in the regulated sense', about 1300-1325 | already fixed; left alone | I (grep 'discern') |
| Validation Hub sentence | about 1368-1375 | already fixed ('reasonable case', left to each organization); left alone | I |
| Opening paragraph mixes 'the reader', 'one's', 'we' (Finding 36) | 25-34 | fixed: 'you will be able ... in your own analyses, the chapter develops'; 'plus a baseline test' corrected to 'among them the baseline test' (the baseline test is a form of the fourth kind) | I |
| Duplicate roadmap with wrong closing section (08:169-174) | after 'defined by a test' | fixed: paragraph deleted | I |
| Outline omissions (follows from the roadmap deletion) | Outline callout, 69-83 | fixed: Outline now names the analysis plan as oracle, Monte Carlo versus sampler, regulated validation, and the cohort section | I |
| m9 `calculate_mean` 'of the orientation' (orientation never names it) | 'Unit tests of functions' | fixed: 'The mean function of the orientation, here called `calculate_mean`' | I |
| `expect_inherits` contradiction (listing headed `inst/tinytest/test-cohort.R` shows `is.numeric(coef(fit))`; the real file uses `expect_inherits(fit, 'lm')`) | integration listing, about 566 | partly fixed: listing relabeled 'illustrative and abridged, after inst/tinytest/test-cohort.R'. The real test file still contradicts the prose; see 'For the lead' | I |
| Data-validation listing headed as the real file | about 660 | fixed: relabeled 'abridged from inst/tinytest/test-cohort.R' (its four assertions are in that file, with `info=`) | I |
| 197 eyes typed | data-validation section | fixed: inline `r sum(survival::diabetic$trt == 0)` (renders 197) | V |
| m1 abridged baseline listing (3 of 5 assertions) | about 751-780 | fixed: listing now shows all five assertions (adds `n_events`, `upper`); header says it is abridged only in omitting the fallback paths; 'five passes' now matches | I (compared with `inst/tinytest/test-baseline-cohort.R`) |
| 'We read the bottom row first' (08:1001) | fig-test-coverage lead-in | fixed: 'Start with the bottom row.' | I |
| m2 answer (a) says the integration test 'would see the changed row count' | check 'which test catches it?' | fixed: names data-validation test or an integration test that asserts the cleaned row count; says the integration test shown checks only summary shape; notes the baseline test also catches it via `n_rows`. Figure and caption ('most likely to catch') left unchanged | I |
| Rule of thumb vs L3 (08:1266-1269, M7) | check 'capture or validation?' | fixed: appended the baseline-test exception (drops L3 to L2) | I |
| Regulated vocabulary 'narrower' vs Ch 3 'larger' | 'Validation in the regulated sense', first paragraph | fixed: 'narrower' changed to 'broader' (Ch 3 line 614 says 'larger'; agrees) | I (grep in 02) |
| 'Watch for' mixes 'the analyst's / the study' with 'you' (08:1597, 1600) | LLM section, second prompt | fixed: '*your* domain', 'in your population' | I |
| 338 vs 306 rows (m3) | cohort canonical analysis | fixed: sentence moved after the chunk; now 'fit a different model to the `r nrow(raw)`-row raw extract' (renders 338). `fit_cox(raw)` itself uses 306 rows; the sentence no longer claims a fitted row count | V (ran `fit_cox(raw)`: n = 306; `nrow(raw)` = 338) |
| 'That is,' introducing a list (integration test, cohort section) | about 1740 | fixed: colon | I |
| Unlabeled cohort-section listings (integration, data validation, baseline; not in `inst/tinytest/`) | cohort section | fixed: one sentence labels the three listings 'illustrative and abridged, and the book's suite does not run them as written' | V (grep found none of their `info=` strings in `inst/tinytest/`); I ran their assertions on the cohort ad hoc and all passed |
| `md5sum` while Ch 12 standardizes on SHA-256 (Pharma minor) | after the baseline listing | fixed: `shasum -a 256 cohort_raw.csv` | I |
| Ex 3 solution column names, nonexistent `derived_data/cohort.rds`, 5 percent, 'Other' (m8) | Solutions, Exercise 3 | fixed: rewritten on the cohort's names (`mrn`, `age_at_enroll`, `sex`, `incident_dm`), `load_cohort`/`clean_cohort`, levels F and M, 15 percent; framed as 'written for the running cohort ... your own dataset will have its own names and bounds' | V (all four assertions pass on the cleaned cohort) |
| Solutions intro and Ex 1 solution in third person (D17) | Solutions | fixed: 'You perform these exercises on your own functions'; 'If you cannot state where an expected value came from, you have usually written a change-detector' | I |
| m12 Peng paraphrase ('confirming a result') and 'the reader is referred' | Further reading, last paragraph | fixed: 'why reproducibility is a minimum scientific standard when full independent replication is not possible'; third-person referrals replaced | EK for the Peng paraphrase |
| Parallel-RNG conditional made flat (08:958-962) | 'Monte Carlo error and parallel streams' | deferred to Phase 21 (paragraph is in the out-of-scope parallel-RNG text) | I |
| MCSE, `B = 1000`, two-tier baseline | same section | deferred (Phase 21, out of scope) | n/a |
| Sandve non sequitur (08:1173-1176) | 'Code quality as a validation feature' | declined: not in the Tier 2 row; not a defect of meaning | I |
| Ex 5 solution: two tolerances conflated (persona-ms) | Solutions, Exercise 5 | deferred: overlaps the Phase 21 tolerance and MCSE work | I |
| Reading time 45 min (reader estimates about 65) | Before you start | deferred (Phase 23) | n/a |

### Chapter 12 (09-continuous-integration.qmd)

| Item | Location (current) | Action | Evidence |
|---|---|---|---|
| Opening mixes 'the reader', 'we shall' x3, 'That is,' before a list (09:27-36) | 25-34 | fixed: 'you will be able to ... say exactly what it has shown: which ...'; one sentence with a colon list; 'You will also know how to turn each gate red' | I |
| Outline omissions ('Secrets, tokens, and pinned actions', 'Debugging a failed reproduction') | Outline callout | fixed: both added in order | I |
| 'That is,' introducing a reason (09:94) | 'Where this sits on the stack' | fixed: 'because' | I |
| 'We note that continuous integration captures no new layer' (third statement) | 'The machine that is not yours' | fixed: cut; paragraph opens 'Continuous integration does not pin ...' | I |
| 'Unfortunately, its scope is narrower than it looks' | `R CMD check` paragraph | fixed: 'Its scope is narrower than it looks.' | I |
| 'That is,' before an elaboration (09:412) | render gate | fixed: colon | I |
| m4 'scans the source, `analysis/` included' vs code scanning only `analysis/` | dependency-manifest gate | fixed: general sentence plus 'The minimal version below scans only `analysis/`' | I |
| m5 '`error_on_fail = TRUE`' must be passed | after the gate script; cheat sheet | fixed: default is `!interactive()`; pass it explicitly so the gate does not depend on how R was started | I (`zzrenvcheck/R/compare.R:53-56, 107`) |
| D21 checkout pin | secrets section | fixed: `uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1`; added sentences on the trailing comment and that Dependabot or Renovate can open pull requests that update pinned SHAs | V (`gh api repos/actions/checkout/git/ref/tags/v7.0.1`: commit 3d3c42e5...) |
| `@v4` tag examples | prose 'major versions current', both workflow blocks, `@v4` in the tag-hazard sentence | fixed: all now `@v7`; 'when this chapter was revised in November 2026'. `r-lib/actions/*@v2` kept: v2 is still the current major | V (`gh api` r-lib/actions tags: latest v2.14.0) |
| 'We should note here' plus 'That is,' list (09:727-735) | admission paragraph | fixed: rewritten in short sentences; now also admits the CRAN gate tools are unpinned and says only `zzrenvcheck` is pinned | I |
| Unpinned `zzrenvcheck` (RSE M7, Pharma M10) | GitHub workflow, GitLab file, Ex 4 solution | fixed: pinned by commit `6f53235668cb4048c1ae793d64b10d6505bf69a2` via `ref =`. No tag fits: the only tags are v0.3.0 to v0.3.2, and v0.3.2 predates `error_on_fail` (not found in its `R/compare.R`), so the chapter's own call would fail against it. That commit is `origin/main` on GitHub and has `Version: 0.10.0` in `DESCRIPTION` | V (`gh api repos/rgt47/zzrenvcheck/tags`, `.../commits/main`; `git grep` at v0.3.2) |
| `.Rprofile` assumption on CI (RSE M4) | YAML comment; new paragraph in 'Where CI bugs hide'; GitLab paragraph | fixed: comment now says 'A stock renv .Rprofile'; new paragraph says the zzcollab `.Rprofile` activates renv only when `ZZCOLLAB_CONTAINER=true` and gives two remedies (set it, or `source('renv/activate.R')`); GitLab paragraph says the assumption applies to both. The workflow was not run on a zzc scaffold | I (repository `.Rprofile` read); EK for setup-renv's reliance on the autoloader |
| 'That is,' before a code example (09:689) | secrets section | fixed: 'Its line `GITHUB_PAT: ...` passes ...' | I |
| GitLab image vs lockfile R (m11) | GitLab file; Ex 4 solution | fixed: `rocker/verse:4.6.1` in both; added sentence with inline `r renv::lockfile_read('../../renv.lock')$R$Version` (renders 4.6.1) | V (inline ran; Docker Hub tag `rocker/verse:4.6.1` returned HTTP 200) |
| 'a cost the reader should weigh' | presence-driven paragraph | fixed: 'a cost to weigh' | I |
| 'That is,' before a list (09:938) | 'Verification and level L3' | fixed: colon | I |
| Image assumptions sentence (reader-d hardest passage 3), 'the reader's own image' | after `ci/run-tests.R` | fixed: reader-d's rewrite, 'against the image in use' | I |
| Honest-level callout (M5, 09:1064-1074) | callout | fixed: the gates do not reach L3, only the verify job can; the chapter ran the gate logic and script, not the image build or job; stale stamp; the gates say nothing about raw data, the manifest does; added 'an L3 stamp is also not a validation record' (Pharma M4) | I |
| `tbl-integrity` hash (M3): the object hash the chapter warns against | 'Data integrity: the checksum manifest' | fixed: chunk writes CSV files and hashes them with `digest(file = path, algo = 'sha256')`. Three rows: baseline file; same values written from a `data.frame` (digest matches); one cell altered (differs). 'matches' is computed. Prose now says 'data file', explains why the file rather than the object is hashed, with inline `digest(cohort) == digest(as.data.frame(cohort))` (renders FALSE). New chunk `ci-manifest-line` prints a real `shasum`-format line for `cohort_raw.csv`. The `cohort` tibble is kept, so Exercise 3 still works | V (ran the chunk logic: file digests of tibble and data.frame CSVs equal; object digests differ; altered file differs) |
| Ex 3 solution 'targets the raw data bytes on disk' | Solutions, Exercise 3 | fixed: now true; reworded to 'hash the bytes of a data file on disk, not a serialized R object' | I |
| Ex 3 solution typed `# TRUE`/`# FALSE` and 'verified above ... on R 4.6.1' | Solutions, Exercise 3 | fixed: block is now an executed chunk (`ci-ex3-digest`); sentence uses inline `getRversion()`, `same_refit`, `same_altered` | V (TRUE, FALSE; R 4.6.0 on the verification host) |
| 'That is,' in the 'what to hash' answer (09:1192) | check 'what to hash' | fixed: colon | I |
| Docker-only L2 row (M6, 09:1229) | capture test matrix | fixed: row rated L0, 'environment is fixed but the packages are unpinned'; new sentence explains the cumulative rule. This departs from the framework's own label, if it labels the row L2 (not checked) | I |
| 'As the first section established' (m6) | archetype section | fixed: 'as the section on the three gates established' | I |
| 'machine that is not yours' device weakened (09:1357-1359) | 'Independent external verification' | fixed: 'a machine that is not yours ... a person who is not you'; the check question quoting it now matches | I |
| `git bisect` sentence misdescribes invocation (09:1500) | debugging section | fixed: 'We marked the fourth commit bad and the first good with `git bisect start`, then ran `git bisect run Rscript check.R`' | I |
| 'That is,' replacing 'because' (09:1512) | debugging section | fixed: 'because' | I |
| `renv::diagnostics()` described as comparing library to lockfile (RSE minor) | debugging section and its check answer | fixed: `renv::status()` in both places (name correction) | EK |
| '@sec-pipelines discusses when it does not' points to nothing; clean runner has no `_targets/` (RSE M5) | `targets` paragraph | fixed: dangling cross-reference removed; states that on a fresh runner `_targets/` is absent unless committed or restored, and the pipeline rebuilds every target | I (grep of `pipelines.qmd` found no such discussion); EK for runner behavior |
| m4 typed `locked` vector in the cohort gate demo | `ci-cohort-gate` | fixed: `locked <- names(renv::lockfile_read('../../renv.lock')$Packages)`; stop message no longer says 'analysis/' | V |
| Typed package list after the demo (09:1636-1637) | after `ci-cohort-gate` | fixed: hidden chunk `ci-cohort-gate-words`; sentence is now inline (verdict, used packages, reason) | V (renders 'passes', the five packages, 'each is either pinned in `renv.lock` or part of base R') |
| Ex 7 and key | Exercise 7 | Phase 19 fixed the lockfile read and the script variable. Remaining: the exercise typed 'one package name'; fixed to 'the package names'. Key chunk `ci-ex7-key` unchanged and computed | V (run: `length(missing)` 0, then `"sandwich"`) |
| Ex 2 solution: manifest gate defect duplicates `R CMD check`'s and contradicts the compendium invariant | Solutions, Exercise 2 | fixed: 'a package used in a script under `analysis/` and missing from `renv.lock`, which `R CMD check` never sees, or, for the package archetype, ...' | I |
| Ex 4 gate (M4; RSE M3) | Solutions, Exercise 4 | fixed: YAML now restores, installs gate tools (zzrenvcheck pinned), runs `rcmdcheck(error_on = "warning")`, `make check-renv-no-fix`, and renders in the image without Docker. Prose explains why `check-renv` (auto-fix) is not a gate, why `make check` lets a WARNING through, and why `docker-render*` cannot run in a `rocker/verse` job | I (zzcollab `templates/Makefile` lines 81-86, 134-138, 300-301, 402-418); EK that `R CMD check` exits 0 on a WARNING |
| Cheat sheet: `error_on_fail` 'required'; `digest(x, ...)` | cheat sheet | fixed; added a row for the SHA-pinned checkout | I |
| Ladder: check answer says a committed Dockerfile alone is L2 | check 'what CI does not know' | fixed: a Dockerfile reaches L2 only beside a lockfile; otherwise L0 (Finding 41) | I |
| 'we shall abbreviate' | Orientation | fixed: 'abbreviated CI' | I |
| 'In one documented case' cites nothing (09:595) | cross-boundary section | declined: not in the Tier 2 row; adding a citation is new content | I |
| Reading time 50 min (reader estimates about 80) | Before you start | deferred (Phase 23) | n/a |
| GitLab duplication, capture-matrix length | various | declined (D18: no cuts) | n/a |

## 2. Counts

| File | 'That is,' before | after | 'Unfortunately,' before | after |
|---|---|---|---|---|
| 08-testing-quality.qmd | 3 | 2 | 0 | 0 |
| 09-continuous-integration.qmd | 10 | 2 | 1 | 0 |

The two remaining in Ch 12 (lines about 183 and 1334) are the
restatements reader-d judged fine. The two in Ch 11 (about 90 and
374) restate.

## 3. run_chapter.R summaries

- `08-testing-quality.qmd`: inline expressions 18; `== summary:
  errors 0  warnings 0` (baseline before edits: 16 inline, errors 0
  warnings 0).
- `09-continuous-integration.qmd`: inline expressions 8; `==
  summary: errors 0  warnings 0` (baseline: 0 inline, errors 0
  warnings 0).

Other checks on both files: no em or en dashes; the example-list
lint is empty. Prose lines over 78 characters: none outside chunk
options and table rows.

## 4. For the lead

1. **`inst/tinytest/test-cohort.R`, integration block.** The
   chapter argues against `expect_inherits(fit, 'lm')`, but the
   book's own file uses it. Replace
   ```r
   expect_inherits(fit, 'lm',
                   info = 'a glm inherits from lm')
   ```
   with
   ```r
   expect_true(is.numeric(coef(fit)),
               info = 'coef() returns numeric coefficients')
   ```
   Then the listing can drop 'illustrative' and say 'abridged'.
2. **`inst/tinytest/test-cohort.R`, final block (reader-d m10).**
   Rename the heading `# --- reproducibility: the same seed gives
   the same answer ---` to `# --- determinism (same session): the
   same seed gives the same answer ---`. The chapter's Pitfall says
   a same-session check is not a reproducibility test.
3. **zzrenvcheck tag.** The repository has no tag at version
   0.10.0. A tag `v0.10.0` on `6f53235668cb4048c1ae793d64b10d6505bf69a2`
   would let the chapter pin `@v0.10.0`. I did not create one. The
   chapter's SHA pin is correct whether or not you add the tag.
4. **zzcollab tool issue (not edited).** `templates/Makefile:132`
   (`ensure-zzrenvcheck`) installs `rgt47/zzrenvcheck` unpinned at
   HEAD. Same hazard as RSE M7.
5. **`.github/`**: the chapter now shows
   `actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1`.
   Your `.github/` change should use the same line so book and repo
   agree. A `.github/dependabot.yml` with
   `package-ecosystem: github-actions` would make the new sentence
   true of the book's own repository; that is your call.
6. **Instructor guide, Ch 12 key (`sec-ig-ch09`).** Not stale: the
   values (0, then `"sandwich"`) match the executed chunk. One small
   point: the key names the second vector `missing2`, but the
   exercise re-runs the `missing` line. Suggest `missing` =
   `"sandwich"`.
7. **Instructor guide, Ch 11.** No key is made stale by these
   edits. The Ex 3 solution is not in the guide.
8. **No bib entry needed.**

## 5. Not done, or uncertain

- The GitHub and GitLab workflows, the Ex 4 GitLab file, and the
  pinned `zzrenvcheck` install were not run on a CI service. I did
  not confirm that `remotes::install_github(..., ref = <sha>)`
  installs that commit, though this is documented `remotes`
  behavior (EK).
- The claim that `R CMD check` exits 0 on a WARNING is EK. So is the
  claim that `setup-renv` depends on the project autoloader.
- `rocker/verse:4.6.1` exists (Docker Hub returned 200). I did not
  check whether it ships `renv` and `rcmdcheck`'s dependencies; the
  body's GitLab file already assumed this.
- Rating the Docker-only matrix row L0 follows the canonical ladder.
  If zzcollab's own capture test matrix labels that row L2, the
  book and the framework now disagree (not checked in zzcollab).
- `renv::status()` replacing `renv::diagnostics()` is a correction
  from EK; I did not run either function on a drifted library.
- The Peng paraphrase is EK; I did not open @peng2011.
- Deferred to Phase 21: the parallel-RNG paragraph, including its
  voice defect ('are then correlated' should be 'can then be
  correlated'), MCSE, `B = 1000`, the two-tier baseline, and the Ex
  5 tolerance wording.
- Deferred to Phase 23: reading times (about 65 and 80 minutes per
  reader-d, against the stated 45 and 50).
- The listing at the start of the Ch 11 integration-test section
  still differs from the real file (see item 1 for the lead).
- `ci-manifest-line` prints the digest of whatever
  `cohort_raw.csv` exists at render time. The extract is ignored by
  git and regenerated, so the printed digest describes the render
  host's copy. The prose says no more than that.
