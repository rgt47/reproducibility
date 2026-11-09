# Phase 25 brief: verification pass
*2026-11-08 16:45 PST*

You are one of four agents verifying the claims of *Reproducible
Research for the Health Sciences* (repo
`/Users/zenn/prj/tch/12-reproducibility`, sources in
`analysis/report/*.qmd`, branch `phase-25-verification`) that so far
rest on expert knowledge (EK) or on a source nobody could open (U).
Read `THIRD-REVIEW-PLAN.md` Section 2 (evidence labels) and the Phase
25 row of the table in Section 9 first.

## You do not edit the book

Topics cut across files, so the lead applies every change. Edit no
file in the repository. Your output is a report with exact proposed
replacements.

## What to verify

1. **Mine the reports** named in your prompt for every claim labeled
   EK, `[EK]`, `[U]`, 'expert knowledge', 'not checked', 'not
   verified', 'assumed', or listed under 'claims resting on' or 'for
   Phase 25', that falls in your subject. Read the reports; do not
   rely on grep alone, since labels vary.
2. **Then grep the chapters** for further claims in your subject that
   no report labeled but that state a fact about a regulation,
   standard, tool behavior, version, date, count, or quotation. Pick
   those a careful reader would act on.
3. **Check the current text, not the report's quotation of it.**
   Many items were changed in Phases 19 to 24; find the sentence as it
   now stands (`grep -n`) and verify that.
4. **Verify against a primary source you open now**: the regulation
   (eCFR, or Cornell LII if eCFR will not open, saying so), the agency
   page, the standard, the official documentation or source code of
   the tool (a tagged release on GitHub is a primary source for
   behavior), the original paper. Run code where the claim is about
   behavior you can run here (R, git, quarto, shell) with the locked
   library prefix from the Phase 20 brief; Docker commands need
   `--platform linux/amd64`. Never cite a source you did not open.
   Never invent a URL, quotation, or section number.
5. **Classify each claim**: *verified* (source or run agrees),
   *corrected* (it was wrong; give the fix), *hedged* (the source is
   ambiguous or behavior varies; give a cautious rewording), or
   *removed* (unsupportable and not needed; give the deletion). Do
   not soften a verified claim.

## Report

Write to
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p25/agent<N>-report.md`:

1. A table, one row per claim: id, `file:line` (current), the claim in
   a few words, status, source (URL, or the command run), date
   accessed, one line of evidence.
2. For every *corrected*, *hedged*, or *removed* row, an exact
   replacement block:

   ````
   ### <id> <file>
   OLD:
   ```
   <text copied exactly from the current file, enough to be unique>
   ```
   NEW:
   ```
   <replacement>
   ```
   ````

   Keep the book's voice: US English, single quotes, no em or en
   dashes, sentences of at most 35 words, no contractions, 'we' in
   exposition and 'you' in exercises and solutions. Keep line widths
   near the surrounding text. Do not change ids or citation keys.
3. New BibTeX entries, if a correction needs a citation, under 'For
   the lead', with DOIs checked by `curl -sI https://doi.org/<doi>`.
4. What you could not verify, and why.

Keep the report factual and short per row. End with a message to the
lead of no more than 150 words.
