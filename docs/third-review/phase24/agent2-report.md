# Phase 24, Agent 2 report (Chapters 5, 6, 7)
*2026-11-08 PST*

Files edited: `analysis/report/03-research-compendium.qmd` (Ch 5),
`analysis/report/04-dependencies.qmd` (Ch 6),
`analysis/report/05-containers.qmd` (Ch 7). Nothing committed. No
text was cut; no id, exercise number, or existing check title was
changed.

## 1. Items

| Item | File:line (now) | Action | Evidence |
|---|---|---|---|
| Task A, Ch 5 cumulative check (Chs 2, 3, 4: 2018 tag, bootstrap interval moves under a newer R) | 03:94-126 | added | I (claims grepped, below); V (run_chapter) |
| Task A, Ch 6 cumulative check (Chs 3, 4, 5: stale derived file after the outlier threshold was tightened) | 04:82-117 | added | I; V |
| Task A, Ch 7 cumulative check (Chs 2, 3, 6: one lockfile, two laptops, three layers) | 05:96-130 | added | I; V |
| Task B, Ch 7 faded Dockerfile | 05:1403-1480 | added at end of `## Worked example`, after the existing 'what changed and what did not' check | I |
| F45 fig-gates: contrast | 03:1231 | measured | V (WCAG relative luminance, script below) |
| F45 fig-gates: legend did not show the shapes | 03:1268-1296 | fixed | V (rendered on png, pdf, cairo_pdf) |
| F45 fig-gates: fig-alt | 03:1233 | corrected | V (`ggplot_build` counts) |
| F45 fig-gates: code comment cited WCAG 1.4.11 for the color-only rule | 03:1266 | corrected to 1.4.1 | I |
| 'not emphasised' internal level | 03 chunk | left as is | V: not displayed; labels are 'Universal', 'Selective', 'Does not apply' |

### fig-gates detail

Contrast (WCAG 2 relative luminance, computed in R,
`scratchpad/p24/agent2/contrast.R`) [V]:

| Pair | Ratio |
|---|---|
| Universal `#1a5c8c` vs Selective `#1e7a50` | 1.34 |
| Universal vs Does not apply `#7a8a9c` | 2.01 |
| Selective vs Does not apply | 1.50 |
| White marker vs Universal | 7.11 |
| White marker vs Selective | 5.31 |
| White vs Does not apply | 3.53 |

All three fill pairs are below 3:1. This is acceptable only because a
non-color cue now carries each distinction: universal cells carry a
white filled circle (shape 16), selective cells a white filled
triangle (shape 17), and 'does not apply' cells carry no symbol. The
white markers clear 3:1 against both fills (WCAG 1.4.11).

Defect found and fixed: the shapes were drawn with
`show.legend = FALSE`, so the legend keyed the statuses by fill
alone. A reader who cannot separate blue from green saw circles and
triangles in the grid but no key saying which is which, so the shape
cue did not actually resolve WCAG 1.4.1. The shape scale now shares
the fill scale's labels (`status_labels`), maps 'not emphasised' to
`NA`, uses `drop = FALSE`, and the two scales merge into one legend
whose keys show circle on blue, triangle on green, plain gray
(`guides(fill = guide_legend(override.aes = list(size = 2.5)))` keeps
the key symbols inside their swatches). Rendered on `png()`, `pdf()`,
and `cairo_pdf()` with a warning handler: no warnings, and the
symbols draw in all three [V, images inspected at
`scratchpad/p24/agent2/gates-after.png`, `pdfdev-1.png`,
`cairodev-1.png`]. I did not check which device the book's PDF build
uses; both PDF devices work.

fig-alt check: `ggplot_build()` gives 10 circles on `#1a5c8c` and 3
triangles on `#1e7a50`, and 7 gray tiles [V]. Rows and columns, and
which cells are active, already matched the code. Corrected: 'medium
gray' to 'medium blue-gray' (`#7a8a9c`), 'inactive/active' to the
legend's own terms, the counts (ten circles, three triangles) added,
and a sentence on the legend added (it was not described).

## 2. Claims checked, per cumulative check

**Ch 5 (03:94-126).**

- R 3.6.0 (2019) changed the default sampler behind `sample()`; same
  seed, different draws: `01-reproducibility-crisis.qmd:541-552`.
- Tag and history make the code locatable, L0 and no more:
  `version-control.qmd:1503-1509`, `:1452-1461` (tags), `:2216`.
- Default RNG kind is set by the R release, part of the runtime, fixed
  at L2; override fixed only by an explicit `RNGkind()` call:
  `02-levels-of-reproducibility.qmd:380-385`, table row `:392`.
- Rungs are cumulative; L2 needs the lockfile:
  `02-levels-of-reproducibility.qmd:519-531`.
- Package churn as the other candidate: `01-reproducibility-crisis.qmd:571-580`.

**Ch 6 (04:82-117).**

- `derived_data/` is a promise of regenerability from raw inputs and
  code: `03-research-compendium.qmd:243-248` (formerly 211-216).
- `git log` lists commits touching a path; `git show` displays one
  commit's diff; `git show <hash>:path` recovers an old copy:
  `version-control.qmd:590-631`, `:1029-1031`. The outlier-threshold
  commit is Ch 4's own example (`:609`).
- Tag secures L0: `version-control.qmd:1503-1509`;
  `02-levels-of-reproducibility.qmd:475,480`.

**Ch 7 (05:96-130).**

- A lockfile does not pin the system libraries packages link
  against; a restore may fail to compile: `04-dependencies.qmd:996-1003`
  (formerly 961-967).
- That layer is closed at L2 by a pinned environment:
  `02-levels-of-reproducibility.qmd:477,1481`.
- No rung guarantees BLAS and LAPACK; thread count narrows it; a
  tolerance absorbs the rest: `02-levels-of-reproducibility.qmd:395`,
  `01-reproducibility-crisis.qmd:654-658`.
- `Rounding` is the pre-3.6.0 sampler: `01-reproducibility-crisis.qmd:726`.
- An `.Rprofile` override is session configuration, fixed only by an
  explicit `RNGkind()` in the analysis: `02-levels-of-reproducibility.qmd:383-385`.

**Ch 7 faded Dockerfile answer.**

- Tag is mutable; digest names an index; one filesystem only with
  `--platform linux/amd64`: `05-containers.qmd` 'Making the image
  itself reproducible' (`FROM rocker/tidyverse@sha256` passage,
  originally :535-559).
- `jammy` must match the base; `noble` would bring other system
  libraries: original :700-708.
- `rocker/r-ver` links OpenBLAS, hence both thread variables: original
  :1076-1088.
- Container without lockfile does not reach L1, so not L2: original
  :766-772 and :1689-1693.
- `library = .libPaths()[1]`: original :735-738.

Claims resting on expert knowledge: none beyond the chapters' own
text. One inference: in the Ch 7 faded block, placeholder (3) is a
comment line inside an `ENV` continuation. Docker strips comment
lines inside continuations, so the faded block is still a well-formed
Dockerfile shape [EK, not tested; the block is display-only].

## 3. Faded example design (Task B)

The worked example itself prints no Dockerfile; it says the
generated one is 'in essence, the one shown earlier'. So the
reprinted artifact is the tested recipe of the section 'Making the
image itself reproducible' (original 05:665-695), verbatim except for
the four placeholders:

1. the digest-pinned `FROM` line;
2. the dated `ARG PPM_SNAPSHOT=.../jammy/2026-06-27` line;
3. the two thread-count lines `OMP_NUM_THREADS=1` and
   `OPENBLAS_NUM_THREADS=1` (one placeholder for two source lines);
4. the `renv::restore(library = .libPaths()[1], prompt = FALSE)` line.

Locale and time zone (`LANG`, `LC_ALL`, `TZ`) and the
`RENV_CONFIG_REPOS_OVERRIDE` line were left visible.

Known weakness, for the lead's decision: the verbatim `LABEL` block
still prints the full digest and the snapshot date, so a reader can
copy the hex string and date into (1) and (2). The exercise still
tests the line's form (tag plus `@sha256:`, the `__linux__/jammy/`
URL) and its placement, but it is easier than intended. Masking the
label values would break 'verbatim'; I did not do it.

## 4. Counts

| File | 'That is,' + 'Unfortunately,' before | after |
|---|---|---|
| 03 | 3 | 3 |
| 04 | 3 | 3 |
| 05 | 1 | 1 |

(Combined counts by `grep -c -E 'That is,|Unfortunately,'`; I added
neither phrase.)

Words added (added diff lines, `wc -w`, which includes code, the
long fig-alt line, and the lead's earlier three-line edit in each
file): Ch 5 about 522 (about 210 of which are the two checks), Ch 6
about 241, Ch 7 about 608 (about 225 for the cumulative check and
about 380, code included, for the faded example).

## 5. Verification

- `run_chapter.R`: 03 `errors 0 warnings 0`; 04 `errors 0 warnings 0`;
  05 `errors 0 warnings 0` (baseline was the same for all three).
- `test-manuscript-invariants.R`: All ok, 364 results.
- `test-reading-times.R`: All ok, 12 results; no card minutes changed.
- Dash grep: empty in all three. `@label.` grep: empty in all three.
- I also rewrapped my own text so that no line begins with `(@`,
  `(a)`, or `(1)` (a Pandoc example-list or fancy-list risk). Note:
  `03-research-compendium.qmd` already has three pre-existing lines
  beginning `(@sec-...)` (around 1340, 1343, 1671); not mine, left.
- Book not rendered, per the brief.

## 6. For the lead

- No shared-file changes needed.
- The faded example's answer contains a fenced code block inside the
  `## Answer` callout; the PDF answer-lifting filter must carry code
  blocks along with prose.
- Other agents were editing concurrently; the two test files passed
  at the time I ran them, against the tree as it then stood
  (`R/stack_diagram.R` changed on disk during my run; I did not touch
  it).

## 7. Not done

- Did not render the book, so the merged legend has not been seen in
  the Quarto HTML or LaTeX output, only on the three R devices.
- Did not run an `axe` check (lead's task).
- The 'not emphasised' factor level is British spelling but never
  displayed; left unchanged as instructed.

## Message to the lead

Three cumulative checks (Ch 5, 6, 7) and the Ch 7 faded Dockerfile
are in; all three chapters run with errors 0 warnings 0, invariants
364/364, reading times 12/12. fig-gates: the fills are 1.34, 2.01,
and 1.50 to 1 against each other, so shape carries the distinction;
I found the shapes were hidden from the legend and merged them into
it, and corrected the alt text. One decision: the faded Dockerfile's
verbatim `LABEL` block gives away the digest and snapshot date.
