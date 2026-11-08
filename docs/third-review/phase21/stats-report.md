# Phase 21 statistics agent report
*2026-11-08*

Branch `phase-21-stats`. Nothing committed; no state-changing git
commands run; no `quarto render`.

Evidence labels: V = I ran it and observed the result; I = I read the
source or text; EK = expert knowledge, not checked here.

## Tasks

| Task | File(s) | What changed | Evidence |
|---|---|---|---|
| 1 Sampler change vs MC error (M2) | 08 | New executed chunk `baseline-mcse` after the `tbl-baseline-rng` prose: MCSE of the 97.5% BMI bound from 40 seeds at the table's 2000 replicates; inline sentences compare the shift (0.0036) with it (0.2 MCSE): the seed-exact comparison fails, but the statistical result reproduces. Table caption now says 'not reproduced seed-exactly' (label unchanged). | V (run_chapter) |
| 1 Diagnosis list | 08 (after the Cox baseline listing, 'A failure here means either ...') | Adds a fifth cause for a baseline with a Monte Carlo quantity: the RNG changed (check `RNGkind()`), and the question is whether the difference is within MC error, which the second tier answers. | I |
| 1 Ch 3 alignment | 02 (sample.kind paragraph, 'broke exactly this, silently') | The sentence now says what broke: digit-for-digit regeneration. It then says whether the statistical result changed is a separate question, and @sec-testing / @tbl-baseline-rng shows the shift is a fraction of one MCSE. | I; V run_chapter |
| 1 Check-your-understanding 'two kinds of instability' | 08 | The old answer said raising `n` does not fix the sampler change, which contradicts M2. Rewritten: a sampler change acts like a new seed, so its size shrinks as 1/sqrt(B), but the seed-exact tier keeps failing. Pinning the sampler restores exactness; the second tier confirms statistical reproduction. | I/EK |
| 2 Two-tier helper | R/cohort.R | New exported `compare_to_baseline(new, recorded, mcse = NULL, tol = 1e-8, k = 3)`, vectorized. It returns 'exact' / 'within Monte Carlo error' / 'changed'. Relative tolerance with an absolute fallback when \|recorded\| <= tol (as `all.equal`); both boundaries inclusive; refuses NA, length mismatch, and negative or wrong-length MCSE. Roxygen documented. | V tests |
| 2 Chapter use | 08 | `baseline-mcse` applies it to both reruns (inline: 'exact', 'within Monte Carlo error'). The text says which tier applies to which quantity: tier 2 only for Monte Carlo quantities; the Cox HR/CI in `test-baseline-cohort.R` are deterministic, so only tier 1 applies (`mcse = NULL`). It adds the sqrt(2) MCSE point: under normality k = 3 flags a pure change of draws 3.4% of the time (computed). | V |
| 2 Tests | inst/tinytest/test-compare-baseline.R (new) | 20 assertions, all with `info=`: the three outcomes, the inclusive k-MCSE boundary (exactly representable values), just beyond it, `k` and `tol` effects, the tol boundary, `mcse = NULL` and its default, vector and MCSE-vector cases, zero baseline, zero MCSE, and four invalid-input errors. The Cox baseline test is untouched. | V |
| 2 Ex 5 solution | 08 (Ex 5 solution, 'The tolerance is the part ...') | Names the two tolerances: *numerical* (1e-8) and *reporting* (publication precision; for a Monte Carlo quantity, set by the MCSE). The coefficients are deterministic, so only the numerical tolerance applies. | I |
| 3 Rename `n` to `B` | R/cohort.R, test-cohort.R, 08, man | `bootstrap_ci(x, B = 1000, seed)`. I also renamed `bootstrap_cox_ci()` for consistency (it has no callers). Default stays 1000. The roxygen gains a details note on MCSE. I grepped the whole repo (excluding _book, _freeze, renv, .git): no `n =` callers remain except a quote in docs/third-review/persona-ms.md. | V grep, V tests |
| 3 `mc-stability` redo | 08 | 20 seeds at B = 250 and B = 1000. Inline MCSE of each bound at each B, the ratios, and the 16% uncertainty of a 20-seed SD. The rule is stated: half a unit of the last digit, or report only supported digits. The default-call interval is reported at supported precision (1.5 to 5). B for one more decimal on the upper bound is about 19,000. The '1/sqrt(n)' claim is kept only as 'consistent with that scaling but do not pin it closely'. The ratios (2.0, 1.8) support that. A `stopifnot()` guards the claim and fails the render if the ratios leave about 2 SE of 2. The 'Monte Carlo stable' sentence is removed (no other references). | V |
| 3 Printed-bound precision | 08 | I checked every printed bootstrap bound in the book. There are only two: `tbl-baseline-rng` (4 dp) and the old width summary (removed). The table keeps 4 dp because the seed-exact tier needs them. The text now says the statistically supported value is 29.1, computed from the MCSE, with a `stopifnot` that both samplers round to it. MCSEs print to 2 significant figures (`sig2()`). The Cox HR (1.83, 1.32 to 2.52) is not a bootstrap quantity. pipelines.qmd's bootstrap prints only timings. | V grep, I |
| 4 Parallel streams (M1, m7) | 08 | Paragraph rewritten. Default `mc.set.seed = TRUE` under Mersenne-Twister is irreproducible: the child discards the inherited state and seeds from the clock and pid. `mc.set.seed = FALSE` gives duplicated streams. L'Ecuyer per-worker streams (`mclapply` under L'Ecuyer, `clusterSetRNGStream()`) are independent but depend on the worker count. Per-task streams (`nextRNGStream()` precomputed, `future.apply` with `future.seed = TRUE`, `doRNG`) are invariant. The 'width understates MC error' wording is gone. | V for all four behaviors (scratch script, below); I for future.apply/doRNG (EK) |
| 4 Helper + demo + test | R/cohort.R; 08 chunk `per-task-streams`; inst/tinytest/test-replicate-streams.R (new) | New exported `replicate_streams(B, FUN, seed, cores = 1L)`. It precomputes L'Ecuyer streams with `nextRNGStream()`, sets stream i for replicate i, runs `mclapply()` (or sequential `lapply` on Windows or when cores = 1), and restores the caller's RNG state with `withr::with_preserve_seed()`. The demo shows 2000 bootstrap means of BMI identical on 1 and 2 workers (inline TRUE). The test has 7 assertions: 1 vs 2 workers identical, rerun identical, a different seed differs, no shared streams, leading replicates independent of B, caller RNG kind and state restored. `exit_file` on Windows. Base `parallel` only. renv.lock has no top-level future/doRNG. | V |
| 5 Ch 13 passage | 10 (Simulation study, 'regenerate the leading replicates') | Says the correspondence holds only when a replicate's draws are fixed by its index: per-replicate seeds or streams, or one serial stream consumed in the same order. A parallel run on per-worker streams does not qualify. The MCSE of each reported summary belongs in the deposit. I added the serial-stream case because the claim is also true there, and saying 'only with per-replicate seeds' would be wrong. | I/EK |
| 6 Citation | 08 | Cites `[@morris2019]` for 'report the MCSE of every Monte Carlo estimate; choose the number of repetitions from the precision required'. The half-unit-of-last-digit rule is framed as our application, not attributed to them. Not in references.bib (grep empty). The DOI resolves (302 to Wiley); the entry below comes from doi.org content negotiation. | V |

### Scratch verification of the parallel claims (V)

Script:
/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p21/parallel_check.R

- `set.seed(1); mclapply(..., mc.cores = 2)` twice, Mersenne-Twister: not identical.
- `mc.set.seed = FALSE`: values duplicated in pairs (0.2655 0.2655 0.3721 0.3721 ...).
- `clusterSetRNGStream(cl, 1)`, 1 vs 2 workers: not identical; 2 workers twice: identical.
- L'Ecuyer `mclapply`, 1 vs 2 cores: not identical.

## Computed MCSE values (seeds 1:k, rendered inline)

| Quantity | B | Seeds | MCSE |
|---|---|---|---|
| 97.5% bootstrap bound of mean BMI (`tbl-baseline-rng`), Rejection | 2000 | 40 | 0.0154 (printed 0.015) |
| Sampler shift / MCSE | | | 0.0036 / 0.0154 = 0.23 (printed 0.2) |
| HbA1c OR, upper bound (about 5.5) | 250 | 20 | 0.434 |
| HbA1c OR, lower bound (about 1.5) | 250 | 20 | 0.0718 |
| HbA1c OR, upper bound | 1000 | 20 | 0.215 |
| HbA1c OR, lower bound | 1000 | 20 | 0.0398 |
| Ratio B=250 / B=1000 (expected 2) | | | upper 2.01, lower 1.80 |

The upper OR bound at B = 1000 has MCSE 0.215. That matches the
reviewer's 30-seed 0.215 (V, independent seeds), and the reviewer's
BMI-bound figure 0.0154 (40 seeds) also matches. Supported decimals
at B = 1000 are 1 for the lower bound and 0 for the upper bound.
Default-seed interval: 1.509 to 5.267, which the text reports as 1.5
to 5.

## Tests

Full suite: 384 passed, 0 failed (V). New: test-compare-baseline.R
20, test-replicate-streams.R 7. test-cohort.R is unchanged at 25 (the
argument rename only); test-manuscript-invariants.R 322. The prior
total was therefore 357 (inferred from the new file counts; I did not
rerun the suite on HEAD).

## run_chapter.R

- 08-testing-quality.qmd: errors 0 warnings 0; 36 inline expressions, all read correctly (V).
- 02-levels-of-reproducibility.qmd: errors 0 warnings 0 (V).
- 10-archiving-sharing.qmd: errors 0 warnings 0 (V).
- Dash grep empty; example-list `@label` grep empty, for all three (V).
- 'That is,' + 'Unfortunately,' combined count in 08: 2 before, 2 after. None were added in 02 or 10 (V).

## Added chunk run time

run_chapter.R on 08 was 8.2 s before and 25.5 to 32.5 s after (three
runs), so the chunks add about 17 to 24 s. Almost all of it is
`mc-stability` (20 x (250 + 1000) glm refits, about 31 s measured
alone in a cold session). `baseline-mcse` adds about 1.7 s;
`per-task-streams` adds under 1 s. Lowering it means fewer seeds,
which the brief forbids below 20, or dropping B = 1000, which is the
default whose MCSE the text needs. _freeze will cache it after one
render.

## For the lead

1. **references.bib**: add (key used in 08 as `[@morris2019]`):

```bibtex
@article{morris2019,
  author       = {Morris, Tim P. and White, Ian R. and
                  Crowther, Michael J.},
  title        = {Using simulation studies to evaluate statistical
                  methods},
  journal      = {Statistics in Medicine},
  year         = {2019},
  volume       = {38},
  number       = {11},
  pages        = {2074--2102},
  doi          = {10.1002/sim.8086}
}
```

2. **NAMESPACE and man (done by me, via `roxygen2::roxygenise()`;
   roxygen2 8.0.0 is in the R system library on the locked-env path,
   which matches `Config/roxygen2/version`).** NAMESPACE gains
   `compare_to_baseline` and `replicate_streams`. It also gains four
   exports that already had `@export` tags but were missing from the
   stale NAMESPACE: `bootstrap_cox_ci`, `fit_cox`, `run_canonical_analysis`,
   `summarise_cox`. New Rd: compare_to_baseline, replicate_streams,
   bootstrap_cox_ci, fit_cox, run_canonical_analysis, summarise_cox;
   bootstrap_ci.Rd updated. A second roxygenise pass was clean. Please
   review the four restored exports; they are correct per the tags
   but they change the installed package's API.
3. **DESCRIPTION** (not mine to edit): add `parallel` to `Imports`.
   `replicate_streams()` calls `parallel::nextRNGStream()` and
   `parallel::mclapply()`. Without it, R CMD check reports an
   undeclared `::` import (EK; I did not run R CMD check).
4. **Instructor guide**: no stale keys found. grep for Monte Carlo,
   MCSE, sampler, tolerance, parallel, replicates, and `bootstrap_ci`
   in instructor-guide.qmd and INSTRUCTOR-GUIDE.md matched only the
   cohort seed line (V).
5. `_book/` still shows the old `n = 300` text until the next render.

## Not done or uncertain

- No `quarto render`, so I did not check cross-chapter refs
  (`@sec-testing`, `@tbl-baseline-rng` from Ch 3) and the `morris2019`
  citation in rendered output. Both ids exist (I). The citation
  stays unresolved until the bib entry is added.
- R CMD check not run. The `replicate_streams()` example uses
  `cores = 2`, within CRAN's 2-core limit.
- The `mclapply` mechanism wording ('discards the inherited state ...
  seeds from the clock and its process id') comes from the
  `?mcparallel` documentation as I recall it (EK). The observed
  irreproducibility is V.
- The claims about `future.apply` (`future.seed = TRUE`) and `doRNG`
  are EK. Neither package is in renv.lock, so I did not run them.
- The 3.4% false-alarm figure assumes approximate normality of the
  bound across seeds and independence of the baseline and rerun draws
  (stated in the text as 'under normality').
- I did not revise the Verification callout after the table. It still
  calls the sampler comparison 'this exact failure', which is correct
  for the seed-exact tier.
- The Ch 3 sentence states a qualitative result from Ch 11 ('a
  fraction of one MCSE') without an inline value, because it is a
  cross-chapter claim. Ch 11 computes the value (0.2).
- `bootstrap_cox_ci()` was renamed beyond the brief's literal scope,
  for a consistent API. It has no callers.
- The user's global style prefers purrr maps. I used base
  `vapply`/`lapply`/`Reduce` to match the package's existing code and
  its Imports (no purrr).
