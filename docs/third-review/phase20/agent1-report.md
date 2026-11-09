# Agent 1 report: Chapters 1 to 3 (Phase 20)
*2026-11-08 10:49 PST*

Files: `analysis/report/00-intro.qmd` (Ch 1),
`01-reproducibility-crisis.qmd` (Ch 2),
`02-levels-of-reproducibility.qmd` (Ch 3). No other file was edited.
Line numbers are post-edit. Evidence labels: V ran it, I inspected,
EK expert knowledge not checked, U unverified.

## 1. Items

| Item | File:line (now) | Action | Evidence |
|---|---|---|---|
| Replicability defined as robustness | 00:66-68 | fixed: 'whether a scientific finding holds on new data' (Ch 3 wording) | I |
| `stringsAsFactors` 'every model' | 00:189-192 | fixed: factor-specific behavior (level ordering, functions requiring a factor), Ch 2 wording | V: `lm()` coefficients identical for character vs factor predictor (`all.equal` TRUE) |
| 'default random-number algorithm' | 00:184-185 | fixed: 'the default algorithm that `sample()` uses to turn a seed into draws' | I (`RNGkind()` reports Mersenne-Twister; only `sample.kind` changed, per readers [A-V]) |
| 'byte for byte' definition | 00:38-40 | fixed: 'within a stated tolerance' | I |
| Claerbout attribution | 00:117-119 | fixed: 'in Buckheit and Donoho's paraphrase of Claerbout' | I (matches epigraph and Ch 2) |
| Two 'verbatim' Peng quotations | 00:85-88 vs 02:7-9 | fixed: intro now quotes the epigraph wording exactly | U: the epigraph wording matches the Peng (2011) *Science* abstract as I recall it [EK]; not opened. Phase 25 |
| 'how often re-execution fails' (figure has two panels) | 00:175-177 | fixed: 'replication and re-execution' | I |
| Part III 'Validation' vs its contents | 00:307-309 | fixed: one clause, 'the practices that let a pinned analysis be re-run and checked' | I |
| 'It appears that' tic (intro) | 00:266 | fixed: removed; next sentence supplies the evidence | I |
| BLAS rung contradicts Ch 3 (PCA answer) | 01:650-659 | fixed to canonical rule: image determines which BLAS, ladder does not require it, thread count and CPU vary, no rung guarantees it | I |
| Sampler layer and rung (body) | 01:786-795 | fixed: default (R runtime, L2) vs override (session configuration, explicit `RNGkind()` in code) | I |
| Sampler: check answer at 'single word' | 01:815-826 | fixed: 'Which term'; answer states default vs override | I |
| Sampler: Ex 3 solution | 01:1163-1171 | fixed: lockfile no; container fixes the default; override fixed only by `RNGkind()` in code | I |
| Sampler / `stringsAsFactors`: Ex 8 solution | 01:1287-1299 | fixed: premise reworded; 'R-runtime *default* secured at L2; exposure closable earlier in code'; 'That is,' removed | I |
| Ex 8 premise ('no stack defined yet') | 01:1048-1053 | fixed: 'names the stack informally ... does not say which layer the flip occupies' | I |
| Simulation exposure | 01:621-624 | fixed: 'a simulation study that resamples, permutes, or randomizes through `sample()`' | V: `rnorm()` draws identical under Rounding and Rejection |
| Trisovic attribution | 01:575-579 | fixed: 'Much of this churn, along with missing files and hard-coded paths'; removed 'their dependencies had' | I; that the paper reports path and file errors is EK |
| Motto sentence garbled split (A2) | 01:484-489 | fixed: colon restored | I |
| 'Moreover,' misstated logic (01:94) | 01:181-185 | fixed: 'and since ...'; 'The prose names' | I |
| 01 Outline vs body order (Orientation listed first, body had stack section first) | 01:92, 179 | fixed: moved 'Where this sits on the stack' (with `fig-stack-crisis`, label unchanged) after Orientation, matching the Outline and the opening sentence; roadmap clause added | V: `run_chapter.R` clean; heading order checked by grep |
| 'To illustrate, consider' openers | 01:124 (now 94), 02:91 | fixed: 'Consider' | I |
| Ex 2 solution 'evidence the effect is not there' | 01:1128-1129 | fixed: 'direct evidence against the effect' | I |
| Mixed persons in 01 objectives and solutions | 01:18-21, 1062-1063, 1081-1098, 1129-1133, 1199 | fixed: 'you' throughout objectives and solutions | I |
| 'We note that' tics | 01:1095, 02:546 | fixed: removed | I |
| Ch 3 roadmap and Outline ordering (A1) | 02:79-87, 122-129 | fixed: 'The cohort, continued' moved last in both; roadmap also names 'Two numbering schemes' | V: heading order by grep matches Outline |
| `.Rprofile` seed in worked example | 02:899-910 | fixed: `RNGkind()` in `analysis.R`, seed at the consuming call, 'Neither goes in the project `.Rprofile`', pointer to @sec-testing | I (Ch 11 uses `withr::with_seed()`, grep) |
| 'The question is not statistical' | 02:100-109 and check 145-170 | fixed: computational in origin; its size is a statistical finding (flat or ill-conditioned likelihood, non-convergence), check with `lme4::allFit()`, report as optimizer-sensitive; answer adds 'reproducible is not trustworthy' | I; `allFit()` existence EK |
| BLAS example is an incidence rate | 02:393-415 (check) and 02:1254-1261 (Ex 3 solution) | fixed by **replacement**: a least-squares coefficient computed as `solve(crossprod(X), crossprod(X, y))`; answer says `crossprod()` goes to the BLAS and `solve()` to LAPACK | EK (not run on two BLAS builds) |
| `LC_NUMERIC` passage | 02:363-372, and vocabulary at 309-310 ('decimal marks' removed) | fixed: R keeps `LC_NUMERIC` at 'C' and warns if changed; decimal-comma file read as text unless `dec = ','` | V: `Sys.getlocale('LC_NUMERIC')` is 'C'; setting it warns; `read.csv` on '1,5' with `sep=';'` gives chr |
| `utils` in lockfile | 02:1037-1043 | already fixed (Phase 19): 'tibble and every other non-base package; base packages such as `stats` and `utils` have no record' | I: `grep -n utils` |
| Stale L0 placement (cohort section) | 02:1000-1024 | already fixed (Phase 19): computed inline, run prints L1 | V: inline `rung` => L1 |
| Stale L0 in honest-level callout | 02:695-703 | fixed: no rung typed; states the placement is computed when the chapter renders | I |
| 'below it' (Ex 8 solution) | 02:1419-1426 | fixed: 'not the analysis code further up'; plus one sentence reconciling with Ex 6 (override vs default) | I (`determinant_layers()` order read in `R/stack_diagram.R`) |
| Inverted ACM logic (Ex 5 solution) | 02:1333-1336 | fixed: 'so the current standard cannot explain the request' | I |
| Layer count (nine / nine or ten / four of the ten) | 02:279-281, 816-819, 1125 | fixed: book uses nine; Ex 1 says nine. **Not** changed to 'four of the nine' at 816: the framework's own review (`zzcollab/docs/zzcollab-system-review.md:143, 160`) says 'about four of ten' on its own finer split, so the sentence now says that accounting splits more finely into about ten | I: grep of zzcollab docs; `determinant_layers()` has 9 rows |
| 'toward L3' for CI | 02:574-578 | fixed: 'from L2 asserted to L2 confirmed; a baseline test is what would make it L3' | I |
| 'build and run identically' at L2 | 02:899-900 | fixed: 'build the same environment' | I |
| 'the one layer that remains outside the guarantee' | 02:921-926 | fixed: names the three unpinned layers | I |
| Container image glossary 'runs identically wherever' | 02:260-263 | fixed: 'the same environment wherever a container runtime for its platform runs' (Finding 30 consistency) | I |
| 'Two features ... the layers' | 02:350-352 | fixed: 'settings' | I |
| Ch 3 default-versus-override (Finding 41 remedy; Ex 6 vs Ex 8) | 02:374-389 | fixed: paragraph plus a four-row unlabeled table (RNG kind, `stringsAsFactors`, locale and time zone, BLAS) | I |
| Numerical libraries rung in Ch 3 body and Ex 1 solution | 02:332-337, 1192-1196 | fixed to canonical rule | I |
| 'Unfortunately,' | 01:979; 02:635, 813 | removed (all three) | grep counts below |
| 'That is,' misuse | 01:394 (colon), 01:975 (For example), 01:1294 (removed); 02:316 (colon), 02:1399 (Concretely) | fixed | grep counts below |
| 'It appears that' (Ch 3) | 02:830-832 | fixed: 'We know of no integrative framework that currently pins these layers' | I |
| Ex 2 solution garbled question sequence (02:1135-1146) | 02:1231-1235 | fixed: single question ending 'That is L3.' | I |
| Mixed persons in 02 objectives and solutions | 02:18-21, 1179-1181, 1188-1192, 1211-1216, 1295-1318, 1435-1436 | fixed: 'you' | I |

## 2. Counts

| File | 'That is,' before | after | 'Unfortunately,' before | after |
|---|---|---|---|---|
| 00-intro | 2 | 2 | 0 | 0 |
| 01-reproducibility-crisis | 5 | 2 | 1 | 0 |
| 02-levels-of-reproducibility | 4 | 2 | 2 | 0 |

The remaining 'That is,' uses each introduce a restatement (00:63,
00:285; 01:373, 01:684; 02:594, 02:919).

Other checks [V]: no em or en dashes in the three files; the
`@label.` list-continuation lint pattern returns nothing. Overlong
prose lines introduced by the edits were rewrapped; the remaining
lines over 70 characters are pre-existing code or chunk options.

## 3. `run_chapter.R` summaries (final)

- 00-intro.qmd: `inline expressions: 0`, `errors 0  warnings 0`
  (baseline identical).
- 01-reproducibility-crisis.qmd: `inline expressions: 0`,
  `errors 0  warnings 0` (baseline identical), run after the section
  move.
- 02-levels-of-reproducibility.qmd: `inline expressions: 8`,
  `errors 0  warnings 0`; lockfile TRUE, dockerfile FALSE, rung L1,
  'pinned packages', next artifact 'a container recipe, a
  `Dockerfile`'. Each reads correctly in its sentence (baseline
  identical).

## 4. For the lead

- No shared-file change is required by these edits.
- Instructor-guide keys: none made stale. The Ch 2 and Ch 3
  Exercise 7 answers are unchanged; `instructor-guide.qmd:73`
  already gives the corrected `utils` wording.
- No bib entry needed. `lme4::allFit()` is named in prose with no
  citation; add `lme4` (Bates et al. 2015, *JSS*) to
  `references.bib` only if the house style wants a citation for
  named functions.
- New table at 02:383-389 has no label or caption (deliberately, so
  no cross-reference target is added). If the lead prefers it
  numbered, a `tbl-` label needs a caption via a chunk or `: caption
  {#tbl-...}` syntax; check the PDF rendering of its long final
  column.
- Rendered check needed (not done, per brief): the moved 'Where this
  sits on the stack' section in Ch 2 and the new pipe table in Ch 3.

## 5. Not done, or uncertain

- **Peng quotation [U], for Phase 25.** Both sites now read
  'Reproducibility has the potential to serve as a minimum standard
  for judging scientific claims when full independent replication of
  a study is not possible' (00:85-88 quotes it inside a sentence with
  a lowercase 'reproducibility'). I did not open Peng (2011). The
  paraphrases at 01:495-497 and 02 Further reading ('impractical')
  are unquoted and were left.
- **BLAS example [EK].** That `crossprod()` dispatches to BLAS and
  `solve()` to LAPACK, and that two BLAS builds or thread counts can
  differ in the sixth decimal, was not run on two BLAS builds.
- **Trisovic error categories [EK].** That the paper reports missing
  files and hard-coded paths alongside library errors was not checked
  against the paper.
- **`lme4::allFit()` [EK]**: not run here.
- Duplication of the NAS definitions and stack paragraph across
  Chs 1 to 3 (reader A) left in place (Decision D18, Phase 23).
- 01:1110-1134 still says 'A reader with the authors' own data' in
  the Ex 2 template and 'What a reader needs' in Ex 5; these mirror
  the exercise text's own third-person 'a reader' and were kept.
- Exposition sentences that address 'the reader' (for example
  00:313-316, 02:1018) are exposition, not objectives or solutions,
  and were left under D17.
- Reader A's 02:1105-1106 'pinned by the container image if it fixes
  the BLAS' is the Ex 1 solution, fixed above.
- No HTML or PDF render was run (brief forbids it).
