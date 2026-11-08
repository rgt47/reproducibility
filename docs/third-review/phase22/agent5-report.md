# Agent 5 report, Phase 22
*2026-11-08*

Files: `analysis/report/04-dependencies.qmd` (Ch 6),
`08-testing-quality.qmd` (Ch 11), `09-continuous-integration.qmd`
(Ch 12). Nothing was removed except reworded LLM 'Watch for'
sentences (Minor 1) and the closing 'competent at the syntax'
sentence in Ch 12, which was itself a model-behavior claim.

## 1. Items

| Item | File and line (now) | Action | Evidence |
|---|---|---|---|
| A7 code review section `{#sec-code-review}` | 08:1555-1606, new `##` after the 'three validations' check, before 'Testing across the archetypes' | fixed (added) | I, V run_chapter |
| A7 Exercise 9 (paired review) | 08:2084-2100 | added | I |
| A7 Exercise 9 solution | 08:2398-2441 | added | I; facts about `clean_cohort()` read from `R/cohort.R`; raw values inspected with Rscript (V) but not typed into the text |
| Ch 11 M2: agent edits tests; protected paths `inst/tinytest/`, `inst/baseline/`; `@sec-llm-delegate` | 08:1860-1868 | added | I |
| Ch 11 better prompt (failing-test triple) | 08:1851-1858 | added | I |
| Ch 11 Minor 1: 'tends to derive', 'will propose', 'will invent', 'will readily produce' | 08:1780, 1797-1804, 1820-1828 | fixed (rephrased as 'Check ...' / 'can') | I |
| Ch 12 self-report is not observation | 09:1834-1836 | added | I |
| Ch 12 agent adds `continue-on-error` / loosens `error_on`; `.github/workflows/` protected | 09:1838-1843 | added | I |
| Ch 12 prompt injection with secrets; cross-ref least privilege | 09:1843-1849; new id `{#sec-ci-secrets}` on existing heading 'Secrets, tokens, and pinned actions' (no id before; none changed) | added | I |
| Ch 12 Minor 7 `error_on = "error"` to single quotes | 09:1825 (LLM triple), also prose 09:402 and 09:585 for consistency | fixed | I |
| Ch 12 evidence retention, two sentences, cited | 09:1117-1123, in 'The honest level' callout | added | I (GitHub docs opened, see 3) |
| Ch 12 better prompt (six-hour simulation triple) | 09:1885-1893 | added | I |
| Ch 12 Minor 1: 'will frequently produce', 'will often reach for', closing 'competent at the syntax and unreliable about the semantics' | 09:1819-1821, 1856-1858, 1895-1897 | fixed; closing sentence also loses a lowercase 'that is,' | I |
| Ch 6 agent runs `renv::snapshot()`; `renv.lock` protected; `@sec-llm-delegate` | 04:1266-1272 | added | I; the overwrite behavior phrased as 'can' [EK] |
| Ch 6 better prompt (PPM snapshot triple) | 04:1308-1315 | added | I; uses the chapter's own `noble` binary-URL material (04:911-915) |
| Ch 6 Minor 1 'may suggest', 'may assert', 'may produce' | 04:1256-1259, 1278-1279, 1295-1299 | rephrased as 'Check for ...' (they were hedged, changed for consistency) | I |
| M4 format drift | all three | none needed: all use **Prompt.** / *Watch for.* / *Verification.* | I |
| M4 duplicated 'fully reproducible' triple | none of my chapters | not applicable | I |

Not changed on purpose: `error-on: '"warning"'` in YAML and the
`error_on = "warning"` inside shell `Rscript -e '...'` (09:854,
2151) need the inner double quotes; the cheat-sheet row (09:2354)
mirrors those forms and was left.

## 2. Counts ('That is,' / 'Unfortunately,')

| File | Before | After |
|---|---|---|
| 04-dependencies.qmd | 3 / 0 | 3 / 0 |
| 08-testing-quality.qmd | 2 / 0 | 2 / 0 |
| 09-continuous-integration.qmd | 2 / 0 | 2 / 0 |

Dash grep: empty for all three. `@label.` continuation grep: empty
for all three.

## 3. run_chapter.R (final)

- 04-dependencies.qmd: `errors 0  warnings 0`
- 08-testing-quality.qmd: `errors 0  warnings 0`
- 09-continuous-integration.qmd: `errors 0  warnings 0`

No new executed chunks were added.

## Words added (gross added-line words minus removed-line words, from `git diff -U0`)

- 04-dependencies.qmd: about 126 net (202 added, 76 removed by rewording)
- 08-testing-quality.qmd: about 1,047 net (1,143 added, 96 removed).
  Of this, the A7 section is about 380 words (about one page);
  Exercise 9 is about 140 and its solution about 330; the LLM
  additions about 150. A7 as a whole is therefore about 2.5 pages,
  over the 1-page estimate in Section 7, because of the exercise and
  solution. The solution can be cut to its last paragraph plus two
  of the four bullets if the lead wants to hold A7 nearer 1.5 pages.
- 09-continuous-integration.qmd: about 249 net (386 added, 137
  removed).

## Sources opened

- GitHub Docs, 'Configuring the retention period for GitHub Actions
  artifacts and logs in your organization',
  https://docs.github.com/en/organizations/managing-organization-settings/configuring-the-retention-period-for-github-actions-artifacts-and-logs-in-your-organization,
  opened 2026-11-08. Supports: artifacts and logs are retained 90
  days by default before automatic deletion; configurable 1 to 90
  days (public repositories) and 1 to 400 days (private). The text
  says only 'an organization can change within limits'; I did not
  open the repository-level page, so the text does not claim it.
- Local files read: `R/cohort.R` (cleaning rules for the exercise
  plan), Ch 11 cohort sections, `persona-pharma.md` Section 3,
  `coverage-syllabi.md` m3, `llm-sections.md`.

## Claims resting on EK (phrased cautiously)

- 'One defensible arrangement is to double-program the outputs a
  decision rests on ... and to review the rest' (08). Stated as an
  option, not as industry practice; no source opened.
- An agent running `renv::snapshot()` 'can overwrite the lockfile
  with the state of whatever library it finds' (04). I did not test
  renv's non-interactive behavior on a fresh clone with a missing
  library.
- Agents 'can' edit tests, add `continue-on-error`, and be steered by
  planted text; from llm-sections.md M2 (OWASP LLM01 cited there, not
  reopened by me). No new citation added for prompt injection.
- 'Most analyses, regulated or not, are checked instead by review'
  (08): a general statement, uncited.

## For the lead

1. BibTeX entry (needed; 09 now cites `@githubretention`):

```
@misc{githubretention,
  author       = {{GitHub}},
  title        = {Configuring the Retention Period for {GitHub}
                  Actions Artifacts and Logs in Your Organization},
  howpublished = {GitHub Docs},
  url          = {https://docs.github.com/en/organizations/managing-organization-settings/configuring-the-retention-period-for-github-actions-artifacts-and-logs-in-your-organization},
  urldate      = {2026-11-08}
}
```

2. `@sec-llm-delegate` is referenced from 04, 08, and 09 and does not
   yet exist in any `.qmd` (grep: only `_llm-rule.qmd`). It depends
   on Agent 1.
3. Instructor guide (`sec-ig-ch08`): Exercise 9 is new. Suggested key
   (no numbers; per-pair work): 'Graded on the review record: at least
   one comment per question 1 to 6 that applies; replies from the
   author; an `all.equal()` comparison after sorting by `mrn`; one
   discrepancy attributed to review and one to comparison (or a
   reasoned "none"). Expected findings include age rows dropped
   instead of set to missing, missing-outcome rows dropped in
   cleaning, and an unstated rule for which duplicate to keep.'
4. Optional cheat-sheet row for `#sec-cheat-testing` (I did not add
   it, to stay inside the size estimate): `| Code review (six
   questions) | Output traces to code; raw inputs; plan's exclusions;
   seed at the call; tests changed with a reason; clean log. |`
5. Optional glossary entry: 'Protected path. A file or directory,
   such as `inst/tinytest/`, `inst/baseline/`, `renv.lock`, or
   `.github/workflows/`, whose every change the analyst reviews line
   by line before merging, whoever or whatever made it.'

## Not done

- The persona's other QC items (`diffdf` / `arsenal::comparedf`, TFL
  footers with program path and data cut) were not added; the
  exercise uses base `all.equal()` to avoid packages outside
  `renv.lock` (not checked whether either is in the lockfile).
- No render; cross-references (`@sec-code-review`, `@sec-ci-secrets`,
  `@sec-llm-delegate`) are unresolved until the lead renders.
- I did not reread the whole of each chapter; the chapter
  'Orientation' and exercise-count prose were not updated to mention
  the new section or Exercise 9 (grep found no exercise count stated).

## Message to the lead

Report at this path. Counts unchanged (3/0, 2/0, 2/0); all three
files `errors 0 warnings 0`; dash and `@label.` greps empty. Needs
from you: the `githubretention` bib entry, Agent 1's
`sec-llm-delegate`, and an instructor key for Ch 11 Exercise 9.
Decision: A7 runs about 2.5 pages with exercise and solution, over
the 1-page estimate; trim the solution if you want it shorter.
