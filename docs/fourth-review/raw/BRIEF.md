# Shared Brief for Fourth-Review Subagents
*2026-11-25 17:55 PST*

Repository root: `/Users/zenn/prj/tch/12-reproducibility`
Book source: `/Users/zenn/prj/tch/12-reproducibility/analysis/report/`
Full review prompt (read it first, all of it):
`/Users/zenn/prj/tch/12-reproducibility/docs/fourth-review-prompt.md`

You are one of several reviewers. You own only the files or topics
named in your assignment. The lead reviewer will reconcile all raw
reports into `docs/fourth-review/REVIEW.md`; you do NOT write that file.

## Hard rules

1. Do not edit any file in the book or repository except your own raw
   report at the path given in your assignment.
2. Do not run `quarto render`, `quarto preview`, any R package install,
   `renv::restore()`, or Docker. A render writes `_freeze` and `_book`.
   You may run read-only commands (cat, grep, sed -n, wc, find, git log).
3. Read every assigned file IN FULL. Long files: read them in chunks
   until finished. Do not sample.
4. Prior work: read
   `/Users/zenn/prj/tch/12-reproducibility/THIRD-REVIEW-PLAN.md` in full
   (991 lines). Then grep `REFACTOR-PLAN.md` and
   `docs/third-review/*.md` for your chapter filenames and topics.
   Do not re-raise an issue recorded as fixed unless the current source
   shows the fix is absent (cite file:line). Do not reopen a recorded
   decision (D1-D25) without a new argument; label such findings
   'Reopens Dxx'.
5. Evidence status for every finding: verified (you checked a primary
   source; give the URL or the exact command output), inspected (you
   read the book source and confirmed the problem), inferred, or
   unverified. Never call something verified without a URL or output.
   Your training data may be out of date as of November 2026: claims
   about current versions or policies that you did not check on the
   web are 'unverified'.
6. If you use web search (load it via ToolSearch query
   `select:WebSearch`; use a web-fetch agent if you have no fetch tool),
   keep queries generic. Never include the user's name, email, repo,
   or project details in queries.

## Raw report format

Write Markdown to your assigned raw file. Start with the title and a
timestamp line (`date "+%Y-%m-%d %H:%M %Z"`). Then:

1. `## Summary` (5 to 10 lines: overall judgment for your scope)
2. `## Strengths` (brief bullets)
3. `## Findings`, ordered by severity (blocking, then major, then
   minor). Each finding in this exact tight format:

```
### <short title>
- Location: <file.qmd>:<line>
- Quote: '<verbatim excerpt, at most 25 words, copied exactly>'
- Severity: blocking | major | minor
- Viewpoint: student | mentor | referee
- Evidence: verified (<url or command>) | inspected | inferred | unverified
- Prior: new | 'reopens Dxx' | 'fix for Finding NN incomplete'
- Problem: <one to three sentences>
- Why it matters: <one sentence, for this reader>
- Fix: <concrete wording, example to add, or cut>
```

4. `## Scope disclosure`: files read in full (with line counts), what
   you only skimmed, what you could not verify.

Do not limit the number of findings; be thorough, but keep each one
tight. House style for your prose: US English, no em dashes, single
quotes, no hyperbole, no emojis, blank line before every list.

When finished, reply to the lead with only: the raw file path, the
count of findings by severity, and the three most important findings
in one line each.
