# Phase 24, Agent 3 report (Chapters 8, 9, 10)
*2026-11-08*

Files: `analysis/report/06-backends-runtimes.qmd` (Ch 8),
`analysis/report/07-literate-programming.qmd` (Ch 9),
`analysis/report/pipelines.qmd` (Ch 10). Nothing committed.

## 1. Items

| Item | File and current line | Action | Evidence |
|---|---|---|---|
| Task A, Ch 8 cumulative check | 06:93-125 | added | I (claims grepped), V (run_chapter) |
| Task A, Ch 9 cumulative check | 07:87-119 | added | I, V |
| Task A, Ch 10 cumulative check | pipelines:107-135 | added | I, V |
| Task B, faded `_targets.R` | pipelines:1285-1344, after 'the two-target split' check, end of '## Worked example' | added | I (code diffed by eye against pipelines:757-776), V (run_chapter) |
| Finding 45(c), fig-simpson alt text | 07:487 (`#| fig-alt`) | fixed | V (re-ran generator, numbers below) |
| fig-simpson caption | 07:486 | checked, unchanged (correct) | V |

All new checks follow the brief's shape exactly (outer check, nested
`## Answer`, nothing after the answer but the closing fences). No
existing id, label, exercise, or check was changed. No new ids.

## 2. Cumulative checks and where each claim was checked

**Ch 8 (06:93-125), vignette: a rebuilt image changes a
coefficient; `FROM rocker/r-ver:4.4.0` tag, live
`install.packages()`, no lockfile.** Cites @sec-levels,
@sec-dependencies, @sec-containers.

- live repository resolves 'the current version' per build:
  05-containers.qmd:636-639, 826-845
- lockfile records package versions, L1: 04-dependencies.qmd:140,
  1666
- tag is mutable; maintainer can rebuild 4.4.0 to patch a system
  library, even the R patch level: 05-containers.qmd:1658-1665
- rungs cumulative: 02-levels-of-reproducibility.qmd:519;
  container without lockfile is not L2: 05-containers.qmd:766-772
- remedy (digest, dated snapshot, lockfile restored inside):
  05-containers.qmd:770-772, 643-648
- no rung guarantees BLAS; tolerance absorbs the rest:
  02-levels:331-336, 395

**Ch 9 (07:87-119), vignette: same image as a SIF under Apptainer
with `--cleanenv`; colleague's `~/.Rprofile` sets
`RNGkind(sample.kind = 'Rounding')`.** Cites @sec-levels,
@sec-containers, @sec-backends.

- release sets default kind, fixed at L2; override is session
  configuration fixed only by explicit `RNGkind()`:
  02-levels:380-386, 392
- image fixes R runtime: 05-containers.qmd:110, 760-762
- Apptainer binds `$HOME` by default; `--cleanenv` drops only
  variables; R still reads `~/.Rprofile`; remedy `--no-home`,
  `--vanilla`: 06-backends-runtimes.qmd:976-990 (Pitfall; line
  numbers after my insertion), cheat sheet row near 06:1561
- Expert knowledge (EK, not grepped in the book): R reads
  `~/.Rprofile` only when the working directory has no
  `.Rprofile` (hence 'the project has none' in the vignette);
  `Rscript` does read the user profile unless `--vanilla`;
  `sample.kind` changes the draws of `sample()`, which a bootstrap
  uses.

**Ch 10 (pipelines:107-135), vignette: collaborator updates
`survival` in `renv.lock`; you restore and render the whole
project under `freeze: auto`; page unchanged under a fresh build
date.** Cites @sec-dependencies, @sec-literate, @sec-freeze. It
tests Ch 9's freeze, not Ch 10's pipeline material.

- `renv::restore()` reinstalls exactly the recorded versions:
  04-dependencies.qmd:1661
- `freeze: auto` compares only with the document's own source; an
  updated package leaves frozen results; fresh build date:
  07-literate-programming.qmd:783-814 (section @sec-freeze)
- single-document render always executes: same section, 'Freeze
  applies only to a render of the whole project; rendering a single
  document always executes its code'
- deposited analysis: pinned environment with freeze off, or after
  deleting `_freeze/` and cache directories: 07:874-879

Ladder wording used: 'no rung guarantees the BLAS'; 'an override
is session configuration, fixed only by an explicit `RNGkind()`
call in the analysis code'; 'a Dockerfile without a lockfile is
not L1, hence not L2, and the project stays at L0'.

## 3. Task B: faded `_targets.R` (pipelines:1285-1344)

Display-only ```` ```{.r} ```` block, verbatim from pipelines:757-776
(the `_targets.R` the worked example says it uses) except four
placeholders:

1. `format = 'file'` on `raw_file`
2. `tar_target(raw_data, read_raw(raw_file)),` (declared dependency)
3. `tar_target(figures, make_figures(model, cleaned)),` (cross-edge)
4. `tar_render(report, 'report.Rmd')` (source tracked)

I did not fade `tar_option_set(packages = ...)`: the chapter says
it only attaches packages and tracks no versions, so it carries
less of the chapter's argument than `tar_render()`. Each answer
line names the plausible wrong line (data-frame target with
`format = 'file'`; literal path inside `read_raw()`; figures without
`cleaned`; `tar_target(... render_report ..., format = 'file')`),
each supported by pipelines text at 1270-1282, 892-906, 1224-1227,
791-800. About 195 words of prose plus a 71-word code block.

Note: the answer's four items begin with `(1)` to `(4)`, which
Pandoc's `fancy_lists` reads as an ordered list with parenthesized
markers. That is intended; it renders as a numbered list. If the
lead's `pdf-answers.lua` filter is sensitive to lists inside
answers, it should be checked.

## 4. Finding 45: fig-simpson numbers (V, re-ran the chunk's
generator, seed 2024, locked library)

| Species | n | mean length | mean depth | length range | within slope |
|---|---|---|---|---|---|
| A | 60 | 38.73 | 18.47 | 31.80 to 43.34 | +0.181 |
| B | 60 | 49.20 | 18.61 | 42.51 to 54.27 | +0.129 |
| C | 60 | 47.22 | 15.05 | 41.41 to 52.57 | +0.145 |

Pooled: intercept 20.105, slope -0.0606, r = -0.172. Fitted pooled
depth falls from 18.18 to 16.82 mm across the full length range
(31.8 to 54.3 mm), against a depth range of 13.2 to 20.0 mm, so
'nearly flat with a slight downward tilt' is accurate. Regression
of the three species means gives a between-species slope of -0.11
(computed from the rounded means).

Colors from `ggplot_build()` (default hue scale; no project option
overrides it, grep of `R/` and `.Rprofile`): A `#F8766D` (red), B
`#00BA38` (green), C `#619CFF` (blue); within-species lines solid
(linetype 1) in the species color; pooled line black, dashed.

The old clause 'the species clusters sit at descending heights as
bill length increases' was false: A (short) and B (longest) are at
the same height, and C, between them in length and close to B, is
about 3.5 mm lower. New alt text, one paragraph:

> A scatter plot of bill depth against bill length for three
> synthetic species: Species A in red, Species B in green, and
> Species C in blue. Within every species the points trend upward
> and carry a solid fitted line, in the species color, of positive
> slope. Species A sits at the shortest bill lengths and Species B
> at the longest, both at about the same depth. Species C overlaps
> Species B in bill length, centered slightly shorter, and sits well
> below both. A single black dashed line fitted to all the points
> pooled together is nearly flat with a slight downward tilt, the
> opposite sign from all three within-species lines. It tilts down
> because the shallow Species C cluster lies among the long bills,
> while the short-billed Species A cluster is deep.

Caption checked against the numbers: 'Within each synthetic species
bill depth rises with bill length (solid lines); across the pooled
sample the fitted line falls (dashed)' is correct (all three slopes
positive, pooled negative, styles match). Left unchanged.

The prose under the figure (07:533-542) says 'across species longer
bills are associated on average with shallower ones'. That holds
only weakly (between-species slope -0.11; B, the longest, is also
the deepest). It is not false, so I left it (D18).

## 5. Counts

'That is,' and 'Unfortunately,' combined (grep -c over both
patterns), before = after, since no added text uses either: 06: 0;
07: 1; pipelines: 1.

Dash grep (em/en): empty for all three files. `@label.` grep: empty
for all three files.

## 6. Verification

- `run_chapter.R` 06-backends-runtimes.qmd: `errors 0  warnings 0`
  (baseline also 0/0).
- `run_chapter.R` 07-literate-programming.qmd: `errors 1  warnings
  0`, identical to the baseline before my edits. The one error is
  ``r knitr::inline_expr(...)`` => 'inline_expr() must be called
  in a knitting process', a harness artifact of evaluating that
  inline call outside knitr; it is pre-existing, not mine.
- `run_chapter.R` pipelines.qmd: `errors 0  warnings 0` (baseline
  0/0).
- `test-manuscript-invariants.R`: All ok, 360 results.
- `test-reading-times.R`: All ok, 12 results; no card minutes
  changed.
- Book not rendered (per brief). I have not seen the new checks or
  the faded block rendered in HTML or PDF.

## 7. Words added per file (wc -w over the new blocks, including
markup)

- 06-backends-runtimes.qmd: 222 (question 76, answer 128)
- 07-literate-programming.qmd: 208 (question 78, answer 112), plus
  the fig-alt rewrite (old 77 words, new 118)
- pipelines.qmd: cumulative check 185 (question 68, answer 99);
  faded check 273 including a 71-word code block

## 8. For the lead

- No shared-file change needed.
- Instructor guide: no exercise was renumbered or changed, so no key
  is stale.
- The faded check's answer is an ordered list (`(1)` to `(4)`);
  confirm the PDF answers filter carries it intact.

## 9. Not done

- No render, so neither the HTML collapse nor the PDF answer
  placement of the four new checks was observed.
- The Ch 9 vignette's claims about R startup files (project versus
  home `.Rprofile`, `Rscript` reading the user profile) rest on
  expert knowledge, not on book text or a run.
- The Ch 8 answer's 'R patch level could move' rests on the
  containers chapter's own statement (05:1663-1665), not a test.

## Message to the lead

Report at
/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p24/agent3-report.md.
Three cumulative checks and one faded `_targets.R` added; the
fig-simpson alt text was rewritten from re-computed numbers, and the
caption is unchanged because it is correct. run_chapter: 06 and pipelines 0/0;
07 has the same one pre-existing harness error as at baseline.
Invariants 360 ok, reading times 12 ok. Decision needed: none.
Check that `pdf-answers.lua` handles an ordered list inside an
answer.
