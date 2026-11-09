# Phase 24, Agent 1 report
*2026-11-08*

Files: `analysis/report/01-reproducibility-crisis.qmd` (Ch 2),
`analysis/report/02-levels-of-reproducibility.qmd` (Ch 3),
`analysis/report/version-control.qmd` (Ch 4). Task A only. Not
committed.

## 1. Items

| Item | File and line | Action | Evidence |
|---|---|---|---|
| A, Ch 2 cumulative check ('did not replicate' vignette: `stringsAsFactors`, runtime layer, container vs `renv`) | 01:92-122 | added | V (run_chapter, greps), I (claims) |
| A, Ch 3 cumulative check (2018 bootstrap plus `levels()` returning `NULL`: two R-runtime defaults, L2 vs code-level closure) | 02:89-120 | added | V, I |
| A, Ch 4 cumulative check (Dockerfile with no lockfile claiming L2: rung earned, package churn, BLAS) | version-control:108-141 | added | V, I |

Each check sits immediately after the closing `:::` of the
'Before you start' card (in all three files the `include: false`
chunk precedes the card, so nothing intervened). Format is exactly
the brief's nested shape; no 'above' or 'below' in any check
(checked by script). Nothing was cut. No id, exercise, or existing
check was changed. No card edits (reading-time test passed unchanged).

Words added (question / answer / whole block including headings and
fences): Ch 2 75 / 137 / 231; Ch 3 77 / 135 / 231; Ch 4 87 / 131 /
236. Longest sentence per block: 33, 31, 32 words.

## 2. Claims checked against earlier chapters (current line numbers)

**Ch 2 check (draws on Ch 1 only, `00-intro.qmd`).**

- Reproducibility = same code and data re-run; replicability = new
  study with its own data, National Academies: 00:59-68.
- R 4.0.0 flipped `stringsAsFactors` from `TRUE` to `FALSE`,
  character columns where factors were: 00:187-190.
- `renv` pins package versions: 00:225. 'renv says nothing about the
  operating system': 00:245.
- Docker via Rocker images pins the OS and libraries: 00:226-228;
  'pinning the operating system and runtime with a container':
  00:301-302. Rung name 'L2 pinned environment': 00:281-282.
- CI re-runs on a clean machine to confirm the pinned layers
  suffice: 00:228-230.

**Ch 3 check (draws on Chs 1 and 2).**

- Same definitions: 00:59-68; 01:434-442.
- R 3.6.0 changed the default `sample()` algorithm; same seed,
  different draws; bootstraps affected: 01:573-589.
- Seed fixes the start, the kind is separate; default belongs to the
  R runtime, fixed at L2; override fixed only by an explicit
  `RNGkind()` call in the analysis code: 01:815-828 and
  `@tbl-rng-kind` (01:769-806).
- R 4.0.0 `stringsAsFactors` flip: 01:591-597; `load_cohort()` writes
  the argument explicitly: 01:889-900; R-runtime layer pinned only by
  fixing the R release, an L2 concern: 01:916-918.
- Computational rather than statistical: 01:565-640 (section).

**Ch 4 check (draws on Chs 2 and 3; Ch 1 not needed).**

- Rungs cumulative: 02:552. L1 requires a lockfile, L2 a container
  recipe as well: 02:1079-1083. The compendium's own rung logic
  returns L0 for a Dockerfile with no lockfile: 02:1023-1029. 'credits
  L2 to a `Dockerfile` in a project with no lockfile' as an error:
  02:1146, 02:1157.
- Package churn = code rot: 01:302-304, 01:603-612; package versions
  'churn fastest': 02:335-337. Lockfile restored inside the image
  reaches L2: 02:937-939.
- Low-order-digit difference is the numerical-library signature:
  02:316-325 (BLAS, thread count), 02:446-459 (existing check).
- No rung guarantees BLAS; the image determines which BLAS is
  installed but thread count and processor vary: 01:685-690,
  02:366-370.
- Fixing the thread count narrows it; a stated tolerance absorbs the
  remainder: 02:428 (table row). L3 baseline test within a stated
  tolerance: 02:526-533.

## 3. Claims resting on expert knowledge (EK, not checked in the book)

- Ch 2: that `renv` does not pin R itself. The book says only that
  `renv` pins package versions and says nothing about the OS
  (00:225, 00:245). The answer's wording ('`renv` pins package
  versions and this change is in R') stays within that, but the
  inference that a lockfile would not close it is EK.
- Ch 3: `levels()` on a character vector returns `NULL` (base R
  behavior, not stated in the book).
- Ch 4: the vignette specifies that the Dockerfile's build installs
  from the *current* CRAN release. This is deliberate: a versioned
  `rocker/r-ver` tag defaults to a dated snapshot repository, which
  would pin packages in practice and spoil the vignette (EK).

## 4. Counts ('That is,' plus 'Unfortunately,', combined grep -c)

Ch 2: 2 before, 2 after. Ch 3: 2, 2. Ch 4: 2, 2. The new text
contains neither phrase.

## 5. Verification

- `run_chapter.R` (locked library): 01, 02, and version-control each
  end `== summary: errors 0  warnings 0`. Inline values read
  correctly (Ch 3: `rung` L1, `next_artifact` a container recipe).
- `test-manuscript-invariants.R`: All ok, 352 results.
- `test-reading-times.R`: All ok, 12 results.
- Dash grep (em/en): empty for all three files.
- `@label.` continuation-line grep: empty for all three files.
- Book not rendered (per brief), so the nested callouts are
  structurally checked only, not seen rendered in HTML or PDF.

## 6. For the lead

- **Ch 3 prerequisite line now understates.** The card at
  02:38-40 says 'Chapter 1 (the introduction) ... no other chapter
  is assumed', but the new cumulative check (per the brief) draws on
  Chapter 2. I did not edit the card (only reading-time edits are
  allowed). Suggested replacement for 02:38-40:
  '**Prerequisites.** Chapter 1 (@sec-intro), for the first,
  informal pass at the determinant stack this chapter makes precise,
  and Chapter 2 (@sec-crisis), for the two silent defaults of R
  itself; no other chapter is assumed.'
- Ch 3's answer cites `@tbl-rng-kind` (a Chapter 2 table). This
  should resolve in a Quarto book, but confirm the cross-chapter
  reference survives the PDF answer-lifting filter.
- No shared-file, bib, or instructor-guide changes needed.

## 7. Not done or uncertain

- Ch 2 can draw on only one earlier chapter, so it does not meet the
  'two or more chapters' criterion and its vignette has one layer,
  not a set of confusable ones. Unavoidable given the book's order.
- Ch 4's check uses Chs 2 and 3 but not Ch 1.
- Word counts of the answers (131 to 137) sit near the top of the
  80 to 140 range.

## Message to the lead

Three cumulative checks added, one per chapter, right after each
'Before you start' card; all three chapters run with errors 0 and
warnings 0, and both test files pass. One decision: the Ch 3 card's
prerequisite line says no chapter beyond Ch 1 is assumed, which the
new check contradicts. Suggested text in Section 6.
