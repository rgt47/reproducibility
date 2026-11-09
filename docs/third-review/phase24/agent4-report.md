# Phase 24, Agent 4 report: Chapters 11 to 13
*2026-11-08*

Files edited: `analysis/report/08-testing-quality.qmd` (Ch 11),
`analysis/report/09-continuous-integration.qmd` (Ch 12),
`analysis/report/10-archiving-sharing.qmd` (Ch 13). Nothing was
cut. No id changed, and no exercise was renumbered. Nothing was
committed.

## 1. Items

| Item | File and current line | Action | Evidence |
|---|---|---|---|
| Task A, Ch 11 cumulative check (mixed diagnosis, three failures: package versions, OS and system libraries, stale derived file) | 08-testing-quality.qmd:87-120 | added | V (run_chapter), I (claims grepped) |
| Task A, Ch 12 cumulative check (two failures: RNG override in session configuration, BLAS layer) | 09-continuous-integration.qmd:89-123 | added | V, I |
| Task A, Ch 13 cumulative check (rung diagnosis: Dockerfile with no lockfile, tag not digest, green `R CMD check` without baseline) | 10-archiving-sharing.qmd:101-131 | added | V, I |
| Task B, Ch 12 faded workflow file | 09-continuous-integration.qmd:1586-1708 (after the 'which gate, and why' check, before `## Debugging a failed reproduction`) | added | V (verbatim check by script), I |

The Ch 11 item is the mixed diagnosis item the prompt required (three
failures, each sorted to its layer and earlier remedy). The Ch 12
item is also mixed (two failures).

**Task B details.** The worked example has no single workflow file,
so the check uses the chapter's main GitHub Actions example, the
condensed `compendium` workflow (09:528-594, originally 491-557),
and says so in its first sentence. Four placeholders:
(1) the `on:` trigger block (5 lines); (2) the `actions/checkout`
line; (3) `- uses: r-lib/actions/setup-renv@v2`; (4) the two-line
`zzrenvcheck::check_packages(strict = TRUE, error_on_fail = TRUE)`
call (the gate that goes red in the worked example). The check says
that two placeholders stand for a short block. A script
(`scratchpad/p24/a4_diff.R`) confirmed that the faded block differs
from the original only at those lines and keeps the order of every
other line (a structural check).

One deliberate departure: the original file prints
`actions/checkout@v7`. Placeholder (2) asks for the line as
@sec-ci-secrets says a compendium should pin it, and the answer
gives `actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 #
v7.0.1` (identical to 09:781, the chapter's own SHA example), noting
that `@v7` in the condensed file is a teaching simplification (as
09:793-804 already says). If the lead wants strict verbatim, change
the question's last sentence and the answer's line to `@v7`, which
would weaken the item.

## 2. Words added (prose, code fences excluded; computed by script)

| File | Check | Question | Answer |
|---|---|---|---|
| 08 | from earlier chapters | 81 | 130 |
| 09 | from earlier chapters | 81 | 126 |
| 09 | complete the workflow file | 74 | 158 (plus a 62-line YAML block and three answer code blocks) |
| 10 | from earlier chapters | 69 | 116 |

Totals per file: 08 about 211; 09 about 439 plus code; 10 about
185. Longest sentence 30 words. No 'above' or 'below' in any answer.
Every answer opens by restating what it answers ('Of the three
failures in this warm-up', and so on).

## 3. Claims and where each was checked

Ch 11 check (08:87-120):

- No lockfile means L1 not reached; rungs cumulative:
  02-levels-of-reproducibility.qmd:519-531.
- `renv::snapshot()` writes and `renv::restore()` reads the lockfile:
  04-dependencies.qmd:1660-1661.
- A lockfile pins the R packages and nothing beneath them; GDAL is
  a system library, not an R package: 04-dependencies.qmd:1666;
  05-containers.qmd:137-140, 314-319.
- L2 only with digest-pinned base, dated snapshot, and lockfile
  restored inside: 05-containers.qmd:766-772.
- Stale output after a raw-data correction, rendered without error:
  pipelines.qmd:183-185, 236-240.
- Raw extract as `format = 'file'` target so `targets` rebuilds
  downstream: pipelines.qmd:866-875, 1242-1250.

Ch 12 check (09:89-123):

- Default sampler fixed by the R release at L2; override fixed only
  by explicit `RNGkind()` in analysis code:
  02-levels-of-reproducibility.qmd:380-385, 392.
- Seed in the analysis code at the call, not in `.Rprofile`:
  08-testing-quality.qmd:1624-1625; 02-levels-of-reproducibility.qmd:911-915.
- BLAS and LAPACK beneath `crossprod()` and `solve()`:
  02-levels-of-reproducibility.qmd:417-418.
- No rung guarantees BLAS; image determines which BLAS, thread count
  and processor vary: 02-levels-of-reproducibility.qmd:332-337, 395.
- Stated tolerance wide enough for reordered sums, too narrow for a
  changed coefficient: 08-testing-quality.qmd:820-826.

Ch 13 check (10:101-131):

- L0 is source under version control: 02-levels-of-reproducibility.qmd:1479.
- Rungs cumulative: 02-levels-of-reproducibility.qmd:519.
- Lockfile gives L1: 04-dependencies.qmd:1666, 813.
- L2 needs digest, dated snapshot, lockfile restored inside:
  05-containers.qmd:766-772.
- A tag can be rebuilt to different bytes: 05-containers.qmd:1658-1663.
- L3 is a CI job that rebuilds the image and runs a baseline test
  within a stated tolerance; a suite with no baseline test is not L3:
  09-continuous-integration.qmd:1009-1026 (originally 973-989).
- The phrasing 'a Dockerfile with no lockfile reaches only L0' is the
  brief's ladder rule. The book's text states the cumulative rule and
  'not L2' (05:1491, 05:766-772) but nowhere says 'L0' of that case in
  so many words [I: grep]; the answer derives it from the cumulative
  rule, which is consistent.

Task B answer:

- SHA line identical to 09:781 [I]. Tag movability: 09:763-779 [I].
- `setup-renv` restores the lockfile into the project library:
  09:555-558, 656 [I].
- `error_on_fail` default `!interactive()` and why to pass `TRUE`:
  09:502-507 [I]. The sentence 'with `FALSE` the step would print the
  missing package and still pass' follows from 09:502-505 ('or only
  prints a report') [I]; not run [U].
- Trigger rationale (`pull_request` tests before merge; `push` on
  `main` covers direct commits): expert knowledge of GitHub Actions
  semantics [EK], not run.

Claims resting on expert knowledge: the trigger rationale only.

## 4. Counts and verification

'That is,' plus 'Unfortunately,' (combined grep -c): 08: 2, 09: 2,
10: 0, before and after (no new instances added; the checks contain
neither phrase).

`run_chapter.R` final lines (baseline and after):

- 08-testing-quality.qmd: `errors 0  warnings 0`
- 09-continuous-integration.qmd: `errors 0  warnings 0`
- 10-archiving-sharing.qmd: `errors 0  warnings 0`

Tests (locked library, repo root):
`test-manuscript-invariants.R` all ok, 360 results;
`test-reading-times.R` all ok, 12 results. No reading-time card
changed (Ch 11 65, Ch 12 70, Ch 13 60 minutes).

Dash grep: empty in all three. `@label.` grep: empty in all three.

`git diff --stat` for the three files shows 9 deletions; all nine are
the lead's earlier instructor-guide pointer edits (D14), not mine.

## 5. For the lead

- Your `filters/pdf-answers.lua` should be checked on the Task B
  answer, which contains three fenced code blocks (yaml, yaml, r)
  inside the `## Answer` callout. I did not run the filter or render.
- The faded check's placeholders are YAML comments; inside the
  `run: |` block of placeholder (4) the comment would also be an R
  comment, so the block remains syntactically plausible. The file is
  display-only and is not meant to run.
- No shared-file change needed. No instructor-guide key made stale.
  No bib entry needed.

## 6. Not done

- Did not render the book (per brief).
- Did not run the lead's PDF filter on the new checks.
- The Task B answer's trigger rationale and the `error_on_fail =
  FALSE` behavior were not executed; they rest on the chapter's text
  and on expert knowledge.

## Message to the lead

Report: this file. Three cumulative checks added (Ch 11 is the mixed
three-failure diagnosis; Ch 12 a two-failure diagnosis; Ch 13 a rung
diagnosis), plus the faded `compendium` workflow in Ch 12 with four
placeholders. All three chapters run `errors 0 warnings 0`; both test
files pass; greps clean; 'That is,'/'Unfortunately,' unchanged.
Decision needed: placeholder (2) asks for the SHA-pinned checkout
rather than the condensed file's `@v7`. Keep, or revert to strict
verbatim.
