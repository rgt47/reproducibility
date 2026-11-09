# Phase 20 brief: Tier 2 correctness and voice-pass repair
*2026-11-08*

You are one of six agents editing *Reproducible Research for the
Health Sciences* (Quarto book, repo
`/Users/zenn/prj/tch/12-reproducibility`, chapters in
`analysis/report/`, branch `phase-20-tier2`). Each agent owns a
disjoint set of chapter files, named in its prompt. Edit only those
files. Read this brief in full before starting.

## Sources

- `THIRD-REVIEW-PLAN.md`: Section 6, the Tier 2 row for your
  chapters; Findings 29, 33, 36, 41 in Section 5; house rules in
  Section 8; Section 12 for what Phase 19 already fixed.
- The reports in `docs/third-review/` named in your prompt. They give
  line-level defects and proposed fixes.
- **Line numbers in the plan and reports are pre-Phase-19 and are
  often off by tens of lines.** Locate every item by its quoted text,
  not by line number. If an item is already fixed (Phase 19 did many),
  record it as 'already fixed' with the grep that shows it.

## In scope (Phase 20)

1. Every Tier 2 item in your chapters' row of Section 6, except those
   listed under 'Out of scope' below.
2. The voice-pass defects of Finding 36 in your files: meaning or
   logic errors, garbled splits, mixed persons, and the tics.
3. Any remaining hand-typed statement about this repository's own
   state (Finding 29, house rule 1): replace it with an inline R
   expression over a chunk result. Phase 19 did most of these.
4. Ladder consistency (Finding 41) in your files, using the canonical
   rules below.
5. The Finding 33 items that fall in your files.

## Out of scope (do not do; later phases)

- Monte Carlo SEs, the two-tier baseline, `B = 1000`, and per-task
  parallel seeding (Finding 35, Phase 21). Leave that text alone.
- Glossary regulated-sense notes, the preface scope sentence (Phase 21).
- New content: git preflight, LLM agents paragraph, disclosure
  template, better prompts, LLM inside an analysis, any Section 7
  addition A1 to A9, trusted research environments (Phase 22).
- Reading times on chapter cards; cutting duplication (Phase 23;
  Decision D18 forbids cuts other than defects).
- Cheat-sheet index, preface week table, colophon, instructor guide,
  PDF answer placement, figure accessibility (Phase 24).
- `_quarto.yml`, `references.bib`, `instructor-guide.qmd`,
  `_llm-rule.qmd`, `_habits.qmd`, `R/`, `inst/`, `.github/`: shared
  files the lead edits. If your fix needs a change there, write it to
  your side file (below) and the lead will apply it.

## Canonical ladder rules (Finding 41)

Every chapter must agree with these. Align your text to them; do not
invent a third version.

- **Rungs:** L0 locatable, L1 pinned packages (a lockfile), L2 pinned
  environment (a container or Nix recipe also fixes the OS, the R
  runtime, and the system libraries), L3 verified (a baseline test
  passes within a stated tolerance after a clean rebuild). The rungs
  are cumulative: a Dockerfile without a lockfile is not L2.
- **Numerical libraries (BLAS, LAPACK):** no rung guarantees this
  layer. An image determines which BLAS is installed, but the ladder
  does not require it to be fixed, and thread count and CPU still
  vary.
- **R's random-number sampler:** the R release sets the *default*
  kind, so the default is part of the R runtime and is fixed at L2.
  Code or `.Rprofile` can *override* it; an override is session
  configuration and is fixed only by an explicit `RNGkind()` call in
  the analysis code. A seed belongs in the analysis code, not in
  `.Rprofile` (Chapter 11's rule).
- **`stringsAsFactors`:** the default is an R-runtime default,
  secured at L2; the exposure can be closed earlier in code.
- **Capture versus verification:** L0 to L2 are reached by capture;
  L3 is reached only by verification.
- **The book's own compendium** is narrated at L1 (Decision D13),
  with its state computed live.

## Voice rules

The prose is in the author's academic voice. Keep it; fix only
defects. Do not restore second person wholesale (Section 10).

- **Person (Decision D17):** 'you' in learning objectives, exercises,
  and their solutions; 'we' in exposition. One person per passage.
  Replace 'the reader will be able to', 'we will be able to', and
  'one' in objectives with 'you'. A solution addresses the reader as
  its exercise does.
- **'That is,'** only to introduce a restatement, at most about three
  per chapter. Where it introduces an example use 'For example,';
  a list, a colon; a reason, 'because' or 'since'; an imperative,
  'Concretely,'. Count before and after: `grep -c 'That is,' file`.
- **'Unfortunately,'** remove it where it was added before a
  limitation stated neutrally; keep at most one per chapter, and only
  where the limitation is a genuine setback. Count before and after.
- Also reduce, where they read as a template: 'therefore' clusters,
  repeated 'We begin', repeated 'Consider ...' openers, 'In
  conclusion,' under an 'In conclusion' heading, 'It appears that' on
  a claim the next sentence supports.
- Sentences at most 35 words, about 25 on average. US English. No em
  or en dashes. Single quotes in prose. No contractions. No new
  'Unfortunately,' or 'That is,'.
- Wrap prose at about 66 characters to match the files; code lines at
  most 78.

## House rules (Section 8)

- No typed statement about the repository; compute it.
- No typed expected value in an exercise or solution; compute it from
  an executed chunk or state it without a number.
- Every printed test is run, or labeled 'illustrative and abridged'.
- No line inside a list item may begin with `@label.` or `@label)`
  (Pandoc reads it as an example list). Rewrap so a cross-reference
  never starts a continuation line.
- Keep every section id (`{#sec-...}`), figure label, table label,
  and cross-reference target unchanged. Do not renumber exercises.
- Do not change numbers, citations, or names except to correct them,
  and record each such correction.

## How to verify (required)

Do **not** run `quarto render` (six agents share one project and
output directory; the lead renders). Instead, for every chapter you
change, run:

```
env R_LIBS_USER=/nonexistent R_LIBS_SITE=/nonexistent \
  R_LIBS=/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/locklib \
  RENV_CONFIG_AUTOLOADER_ENABLED=FALSE \
  Rscript /private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p20/run_chapter.R <file>.qmd
```

(as one command on one line). It runs every executed chunk in order
and evaluates every inline expression. It must end with `errors 0
warnings 0`, and each inline value must read correctly in its
sentence. Run it on the unchanged file first to know the baseline.
Also run, as separate commands:

- `git -C /Users/zenn/prj/tch/12-reproducibility diff --stat`
- `grep -n -E '—|–' <file>` (must be empty)
- `grep -c 'That is,' <file>` and `grep -c 'Unfortunately,' <file>`
- `grep -n -E '^\s+@[A-Za-z][A-Za-z0-9_:-]*[.)](\s|$)' <file>`
  (must be empty)

Bash rules for this machine: one command per Bash call; no `for`,
`while`, `if` at the top level; no `$(...)`; no `&&` chaining; no
`sed -i`. Use the Edit tool for edits. Do not run git commands that
change state (no commit, checkout, stash, reset, add).

## Side file and report

Write your report to
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p20/agent<N>-report.md`
with:

1. A table, one row per item: item, file and current line, action
   (fixed, already fixed, deferred, declined), and evidence label
   (V ran it, I inspected, EK expert knowledge not checked).
2. Counts of 'That is,' and 'Unfortunately,' before and after, per
   file.
3. The final `run_chapter.R` summary line for each changed file.
4. 'For the lead': any change needed in a shared file (exact text),
   any instructor-guide key that your edits make stale (exercise
   number and the corrected key, computed), and any bib entry needed.
5. 'Not done': anything skipped or uncertain, with the reason. Do not
   claim a fix you did not check.

Your final message to the lead should be short: the report path, the
counts, and anything that needs a decision.
