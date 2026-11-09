# Phase 22 brief: content additions
*2026-11-08*

You are one of six agents adding content to *Reproducible Research
for the Health Sciences* (repo `/Users/zenn/prj/tch/12-reproducibility`,
chapters in `analysis/report/`, branch `phase-22-content`). Each
agent owns the files named in its prompt; edit only those.

**First read** the Phase 20 brief,
`/Users/zenn/prj/tch/12-reproducibility/docs/third-review/phase20/BRIEF.md`.
Its voice rules, house rules, verification commands (`run_chapter.R`,
the dash and `@label.` greps), Bash rules, and report format all
apply. Ignore its file list and its 'out of scope' list; this brief
replaces them. Then read, in `THIRD-REVIEW-PLAN.md`: Section 7 (the
additions table A1 to A9), Findings 39 and 40, and Decisions D18 and
D19 in Section 11a. Then `docs/third-review/llm-sections.md` M1 to
M5 and Minor 1, 4, 5, and the coverage report named in your prompt.

## Ground rules for additions

- **Additions only (D18).** Do not cut material except a passage
  that is itself defective (wrong, or contradicting the new text);
  record any such removal.
- **Size.** Keep to the page estimates in Section 7 (about 330
  words per page). Report the words you added per file.
- **Placement.** A new section gets a `{#sec-...}` id. Never change
  an existing id or renumber exercises; new exercises go after the
  last one (Exercise 9, 10) with solutions in the same order.
- **Cite only what you opened.** Every new factual claim about a
  guideline, policy, regulation, or tool either cites a source you
  opened in this session (give the URL and date in your report and
  put a BibTeX entry under 'For the lead'; check DOIs with
  `curl -sI https://doi.org/<doi>`), or is marked EK in your report
  and phrased cautiously. Never invent a course, URL, or quotation.
  Prefer stating a requirement in your own words to quoting.
- **No product names in prose** for LLM tools (the book's existing
  rule); use slots such as `<tool name>`.
- **Compute, do not type**, any statement about this repository.
- **New executed chunks** must run in a few seconds and must not need
  network access or packages outside `renv.lock` (check it).

## The LLM sections (Finding 40), every agent in its own chapters

Each chapter has a 'Collaborating with an LLM' section of triples
(**Prompt.** / *Watch for.* / *Verification.*). In each chapter you
own:

1. **Add one 'A better prompt' element** to one existing triple,
   formatted `*A better prompt.*` after its *Verification.*. It names
   the inputs, the constraints, the expected output, and asks the
   model to say how its answer can be checked. About 60 words. Keep
   the vague prompt as the contrast. llm-sections.md M3 gives an
   example for the containers chapter.
2. **Rephrase claims about model behavior** stated as fact ('models
   frequently conflate', 'will very likely open with') into
   instructions ('Check for ...') (Minor 1).
3. **Normalize the format** to the bold/italic triple if your chapter
   drifts (M4, last bullet).
4. Where llm-sections.md M4 names a duplicated 'fully reproducible'
   triple in your chapter, replace it with a chapter-specific triple
   (this is a defect fix, allowed under D18).
5. Where your chapter has an agent that executes commands (push,
   deposit, rewrite history, edit tests or baselines, change CI),
   add one or two sentences tied to that triple saying what stays
   with the analyst, and cross-reference `@sec-llm-delegate` (the
   section Agent 1 creates in Chapter 2).

The lead adds a short agents paragraph to `_llm-rule.qmd` pointing to
`@sec-llm-delegate`; do not edit that file.

## Shared files

Do not edit `_quarto.yml`, `references.bib`, `_llm-rule.qmd`,
`_habits.qmd`, `glossary.qmd`, `instructor-guide.qmd`,
`cheat-sheet-index.qmd`, `R/`, `inst/`, `DESCRIPTION`, or `.github/`.
Put needed changes (bib entries, glossary entries for new terms,
cheat-sheet rows) under 'For the lead' in your report, as exact text.

## Report

Write to
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p22/agent<N>-report.md`,
in the Phase 20 format, adding: words added per file; every source
opened (URL, date, what it supports); and claims resting on EK.
End with a short message to the lead.
