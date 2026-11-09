# Agent 4 report, Phase 22
*2026-11-08*

Files: `analysis/report/06-backends-runtimes.qmd` (Ch 8),
`07-literate-programming.qmd` (Ch 9), `pipelines.qmd` (Ch 10).
No shared file was edited. No git state was changed.

## 1. Items

| Item | File and location | Action | Evidence |
|---|---|---|---|
| A6 freeze and cache section `{#sec-freeze}` | 07, new `##` after 'The landmines that break the seal' (after its check-your-understanding box) | added | V (run_chapter), I (Quarto and knitr pages) |
| A6 book facts computed inline | 07, chunk `freeze-facts` (`include: false`): reads `_quarto.yml`, `git ls-files analysis/report/_freeze`, and `.github/workflows/render-book.yml` | added | V: renders 'sets `freeze: auto`', '14 documents (50 files under `_freeze/`)', 'Its continuous-integration workflow runs a project render' |
| Ch 9 disclosure passage (M4, M1) | 07, after the LLM triples | replaced two paragraphs (about 280 words) with one paragraph pointing to `@sec-llm-disclosure`; nondeterminism point kept; reproducibility conclusion drawn, pointing to `@sec-llm-in-pipeline` | I; ids confirmed in 01 at lines 978 and 1020 |
| Ch 9 'fully reproducible' triple (M4) | 07, 'Check that this analysis is reproducible.' | replaced with 'Find the hidden state in this document.' (verification: delete `_freeze/` and cache, fresh-session render, run each flagged chunk alone) | I |
| Ch 9 better prompt | 07, after the LaTeX-error triple's Verification | added | I |
| Ch 9 Minor 1 | 07, knitr-chunk triple 'A model will often reach for convenience...because these are common in the training data' | rephrased as 'Check for ...' | I |
| A4 LLM inside the pipeline `{#sec-llm-in-pipeline}` | pipelines, new `##` immediately before 'Collaborating with an LLM' | added: dependency no rung pins; four practices (cache as committed derived data keyed by input hash, prompt version, model id; record id, parameters, date; prompts as code; re-query is a new measurement); restricted-data cross-reference; display-only `_targets.R` fragment labeled 'illustrative and abridged; not run', no API call | I (fragment not run, by design) |
| Ch 10 'fully reproducible' triple (M4) | pipelines, 'I set up a `targets` pipeline, so my analysis is now reproducible, right?' | replaced with a chapter-specific triple on adding an LLM coding step; includes the agent sentence and `@sec-llm-delegate` | I |
| Ch 10 better prompt | pipelines, after 'Convert my scripts to a `targets` pipeline' Verification | added | I |
| Ch 10 Minor 1 | pipelines, Makefile and `targets` Watch-for paragraphs ('will readily produce', 'will guess', 'More commonly', 'A third common error') | rephrased as 'Check for ...' | I |
| Ch 10 Exercise 9 and solution | pipelines, after Exercise 8 and after Solution 8 | added; no typed numbers | I (reasoning about `targets` invalidation; not executed) |
| Ch 8 format drift (M4) | 06, bold triple titles and bullet lists | normalized to `**Prompt.**` / `*Watch for.*` / `*Verification.*` paragraphs; the three bold titles removed | I |
| Ch 8 'carry no data' contradiction (M4) | 06, section opener | defect fix: 'need no data, but they can name it' | I |
| Ch 8 Minor 1 | 06, three Watch-for items ('A model may ...') | rephrased as 'Check that/whether ...' | I |
| Ch 8 better prompt | 06, after the Docker-to-Podman/Apptainer triple | added | I |
| Agent sentences (brief item 5) | Ch 10: added in the new triple. Ch 8 and Ch 9: none added; no triple there has an agent pushing, depositing, rewriting history, editing tests or baselines, or changing CI | partly | I |

Removals (defects, under D18): Ch 9's disclosure paragraphs (duplicate of Ch 2; placement 'methods section or acknowledgments' contradicted journal rules; version-and-date record superseded by the Ch 2 template); Ch 9 and Ch 10 duplicated 'fully reproducible' triples; Ch 8 bold triple titles (format normalization only); Ch 8 'carry no data' sentence.

## 2. Counts

| File | 'That is,' before/after | 'Unfortunately,' before/after |
|---|---|---|
| 06 | 0 / 0 combined | |
| 07 | 1 / 1 combined | |
| pipelines | 1 / 1 combined | |

(Counted with a combined grep; my edits added neither phrase, so the per-phrase split is unchanged from Phase 20.)

Dash grep and `@label.` grep: empty on all three files. No new line over 78 characters (all hits are pre-existing captions and tables).

## 3. run_chapter.R

- 06: baseline `errors 0 warnings 0`; final `errors 0 warnings 0`.
- 07: baseline `errors 1 warnings 0`; final `errors 1 warnings 0`. The one error is pre-existing and a harness artifact: the inline `knitr::inline_expr(...)` (shown as literal syntax in the cohort section) errors outside a knitting process. New inline values read correctly in their sentences (V).
- pipelines: baseline `errors 0 warnings 0`; final `errors 0 warnings 0`.

## 4. Words added

Words on added lines minus removed lines, from `git diff -U0` (script `a4_words.sh` in this directory):

| File | added | removed | net |
|---|---|---|---|
| 06 | 369 | 340 | 29 |
| 07 | 991 | 460 | 531 |
| pipelines | 1280 | 289 | 991 |

Ch 9: the freeze section is about 420 words including its chunk (about 1.2 pages, within the 1 to 1.5 the coverage report proposed). Ch 10 exceeds the one-page estimate for A4: the section is about 440 words plus the fragment, and the new triple, better prompt, Exercise 9, and its solution add about 550 more.

## 5. Sources opened

- Quarto, 'Managing Execution', https://quarto.org/docs/projects/code-execution.html, opened 2026-11-08. Supports: `freeze: true` never re-renders in a project render; `freeze: auto` re-renders only when source changes; results stored in `_freeze/`; advice to commit `_freeze`; freeze applies only to project renders (single-document render always executes); cache invalidation triggered by chunk source changes; `--cache-refresh`.
- Yihui Xie, 'Cache: Examples for the cache feature', https://yihui.org/knitr/demo/cache/, page dated 2011-12-04, opened 2026-11-08. Supports: the cache stores evaluation results, newly created objects, and `.Random.seed`; invalidated by chunk code and options (except `include`); data files, packages, and R version do not invalidate it unless tied in through `cache.extra` (examples: `R.version.string`, file modification time).
- Repository files read for computed facts: `_quarto.yml` (line 122, `freeze: auto`), `git ls-files analysis/report/_freeze` (50 files, 14 documents plus `site_libs`), `.github/workflows/render-book.yml` (project render `quarto render analysis/report --to html`; no commit back of `_freeze/`).
- TRIPOD-LLM not opened; not mentioned. JAMA's prompt requirement not cited (I did not open it).

## 6. Claims resting on EK

- Ch 9 and Ch 10: a provider can update or retire a model identifier, and one unchanged version need not return the same output twice. Phrased as possibility ('can', 'need not'). Ch 2 and the previous Ch 9 text made the same claim.
- Ch 10: that clinical notes are among the most identifying records a study holds, and that responses derived from them inherit the notes' restrictions.
- Ch 10 Exercise 9 solution: with no `_targets/` store every target is outdated; changing a literal argument in a target's command invalidates that target. Consistent with the chapter's own account of command hashing (I), not executed here.
- Ch 9: deleting `_freeze/` and cache directories forces re-execution (follows from the Quarto page, not tested).

## For the lead

BibTeX entries (keys already cited in 07):

```
@misc{quartoexecution,
  author       = {{Posit Software, PBC}},
  title        = {Managing Execution},
  howpublished = {Quarto documentation},
  url          = {https://quarto.org/docs/projects/code-execution.html},
  urldate      = {2026-11-08}
}

@misc{xieknitrcache,
  author       = {Xie, Yihui},
  title        = {Cache: Examples for the Cache Feature},
  howpublished = {knitr documentation},
  year         = {2011},
  url          = {https://yihui.org/knitr/demo/cache/},
  urldate      = {2026-11-08}
}
```

Glossary candidates (optional):

- **freeze (Quarto)**: a project option under which a project render reuses a document's stored results from `_freeze/` instead of executing its code; `auto` re-executes only when the document's source changes.

Cheat-sheet rows (optional), Ch 9 and Ch 10:

```
| `freeze: auto` | Re-executes a document only when its source changes; data, package, and R changes do not trigger it (@sec-freeze) |
| LLM response cache | A committed file of model responses keyed by input hash, prompt version, and model identifier; the pipeline reads it and never queries (@sec-llm-in-pipeline) |
```

Instructor guide: Ch 10 has a new Exercise 9; its key is the solution box (no numbers). No existing key is made stale. The colophon's freeze paragraph agrees with the new section.

## Not done

- No agent sentence in Ch 8 or Ch 9: none of their triples involves an agent taking irreversible or test-altering actions. Lead may judge otherwise for Ch 9's render agent.
- Did not render; `@sec-llm-disclosure`, `@sec-llm-delegate`, and the two new bib keys resolve only once Agent 1's Ch 2 and the lead's bib edits are in the same build (ids confirmed present in 01).
- The `_targets.R` fragment is not run by design (it names functions that do not exist in `R/`).
- Ch 10 is over the A4 page estimate (see Section 4).

## Message to the lead

Report at this path. Ch 9 gains `{#sec-freeze}` with live repo facts (`freeze: auto`, 14 frozen documents, CI project render); disclosure cut to one paragraph pointing to `@sec-llm-disclosure`. Ch 10 gains `{#sec-llm-in-pipeline}`, a new triple, a better prompt, and Exercise 9. Ch 8 triples normalized. run_chapter: 06 and pipelines 0/0; 07 1/0, same pre-existing harness artifact as baseline. Two bib entries above are needed. Decision: Ch 10 net growth is about 990 words, over the one-page A4 estimate.
