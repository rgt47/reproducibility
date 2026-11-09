# Phase 24 brief: spaced checks, faded examples, figure fixes, guide
*2026-11-08 16:02 PST*

You are one of five agents working on *Reproducible Research for the
Health Sciences* (repo `/Users/zenn/prj/tch/12-reproducibility`,
chapters in `analysis/report/`, branch `phase-24-apparatus`). Each
agent owns only the files named in its prompt; edit nothing else.

**First read** the Phase 20 brief,
`/Users/zenn/prj/tch/12-reproducibility/docs/third-review/phase20/BRIEF.md`.
Its voice rules, house rules, verification commands (`run_chapter.R`,
the dash and `@label.` greps), Bash rules, and report format all
apply. Ignore its file list and its 'out of scope' list. Then read, in
`THIRD-REVIEW-PLAN.md`, Findings 44 and 45 and Decisions D14, D18, and
D23 (Section 11a); and `docs/third-review/learning-science.md`, items
2 and 3 under its findings and the spacing, interleaving, and faded
example rows of its evidence table.

## Ground rules

- **Additions only (D18).** Cut nothing except a passage that is
  itself wrong; record any such removal.
- **Never change an existing id**, renumber an exercise, or rename an
  existing check. New ids, if any, are `{#sec-...}` on headings only.
- **Voice.** Questions and answers address the reader as 'you'
  (D17); exposition uses 'we'. US English, single quotes, no em or en
  dashes, sentences of at most 35 words, no contractions.
- **Compute, do not type**, any statement about this repository.
- **Do not edit** `_quarto.yml`, `references.bib`, `_llm-rule.qmd`,
  `_habits.qmd`, `glossary.qmd`, `conventions.qmd`, `preface.qmd`,
  `cheat-sheet-index.qmd`, `colophon.qmd`, `R/`, `inst/`,
  `DESCRIPTION`, or `.github/`. Put needed changes under 'For the
  lead' in your report, as exact text.

## The check format (the lead's PDF filter depends on it)

Every check is exactly this shape, with the answer nested inside the
check, and nothing after the answer's closing fence but the check's:

```
::: {.callout-note icon=false collapse=true}
## Check your understanding: <short title>

<question>

::: {.callout-note icon=false collapse=true}
## Answer

<answer>
:::
:::
```

The lead is writing a Lua filter that, in the PDF only, lifts each
`## Answer` callout out of its check and prints it at the end of the
chapter, keyed by number (D23). So an answer must make sense read
pages later: restate what it answers in its first clause, and do not
say 'above' or 'the figure below'. Use `@sec-`, `@fig-`, `@tbl-`
references instead. Do not put a check inside any other callout.

## Task A. One cumulative check per chapter (Finding 44)

In each chapter you own, add **one** new check immediately after the
closing `:::` of the 'Before you start' card (after any `include:
false` chunk that sits there), titled
`## Check your understanding: from earlier chapters`. It is a warm-up
retrieval question drawn from **two or more earlier chapters** (Ch 2
can draw only on Ch 1; Ch 3 on Chs 1 and 2). Prefer a short
diagnosis vignette in which the reader must name which determinant
layer failed and which earlier tool or rung addresses it: the survey
finds interleaving pays most when the categories are confusable, and
the book's layers (package versions, OS and system libraries, R
runtime and RNG, stale derived file, raw data, analysis code) are
exactly that. Do not test the current chapter's new material. Cite
each earlier chapter with its `@sec-` id. About 60 to 90 words of
question and 80 to 140 of answer. Check every claim in the answer
against the earlier chapter's text (grep it), and quote the ladder
rules as the book now states them (no rung guarantees BLAS; an
`RNGkind()` override is fixed only by explicit code; a Dockerfile
without a lockfile is L0).

## Task B. Faded examples (only the agents told to do this)

At the end of the named chapter's `## Worked example` section, add a
check titled `## Check your understanding: complete the <artifact>`.
It reprints the worked example's own artifact (the same Dockerfile,
`_targets.R`, or workflow file, verbatim from the section) as a
**display-only** block (a plain fence such as ```` ```dockerfile ````,
```` ```yaml ````, or ```` ```{.r} ````, never an executed chunk),
with **three or four** of its decisive lines replaced by numbered
placeholders such as `# (1) ____: pin the base image`. Fade the lines
that carry the chapter's argument (the digest pin, the snapshot date,
the `format = 'file'` target, the SHA-pinned action, the rebuild
trigger), not boilerplate. The answer gives each completed line and
one sentence on why it is that line and not a plausible wrong one.
About 150 to 250 words in all, plus the code block.

## Verification, before you report

1. `run_chapter.R` on every chapter you changed: `errors 0`.
2. The invariants and reading-time tests, with the locked library
   (the Phase 20 brief has the `env ... Rscript` prefix):
   `Rscript -e "tinytest::run_test_file('inst/tinytest/test-manuscript-invariants.R')"`
   and the same for `test-reading-times.R`, run from the repo root.
   If a reading-time test fails for your chapter, update that card's
   minutes to the value the message gives; that is the one card edit
   allowed.
3. The dash and `@label.` greps from the Phase 20 brief.
4. Do not render the book; the lead renders once for all agents.

## Report

Write to
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p24/agent<N>-report.md`
in the Phase 20 format, adding: words added per file; for each
cumulative check, the earlier sections each claim was checked
against (file:line); any claim resting on expert knowledge. End with
a short message to the lead.
