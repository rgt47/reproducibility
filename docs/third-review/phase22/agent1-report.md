# Agent 1 report: Phase 22, Chapters 2 and 3
*2026-11-08*

Files: `analysis/report/01-reproducibility-crisis.qmd` (Ch 2),
`analysis/report/02-levels-of-reproducibility.qmd` (Ch 3).

## 1. Items

| Item | File and location (current) | Action | Evidence |
|---|---|---|---|
| M2: new subsection 'What to delegate to a coding agent' `{#sec-llm-delegate}`, 293 words | 01, heading at about line 978 | added | I (counted with `wc -w` on the draft) |
| M1: disclosure passage rewritten as new subsection 'Disclosing and recording model use' `{#sec-llm-disclosure}`: slot template, journal-instructions placement with cover letter, keep prompts and transcripts, `LLM-USE.md` or README section with six fields, agent commits marked in message or trailer, exact identifier replacing 'approximately version Y', NIH funder sentence | 01, about lines 1024 to 1078 | fixed (rewrite of a defective passage) | I |
| M1: ICMJE cited in prose only | 01, disclosure | fixed, `@icmje2026ai` | I (page opened) |
| Minor 5: funder context | 01, last paragraph of disclosure | added, both notices opened | I |
| Minor 6: 'accessed October 2026' example date | 01 | removed with the old record example; slot template instead | I |
| Better prompt (Finding 40 item 1) | 01, first triple (three words) | added, about 60 words, supplies the definitions and asks for the quoted definition sentence as a check | I |
| Better prompt | 02, third triple (simulation) | added, about 60 words, names inputs and asks for one confirming command per layer | I; `sessionInfo()` printing BLAS and LAPACK lines V (ran on host R 4.6.0) |
| Minor 1: 'Models frequently conflate' | 01, first triple | rephrased as 'Check whether ...'; also dropped the training-data causal claim | I |
| Minor 1: 'The model will readily assert' | 01, third triple | rephrased as 'Check whether ...' | I |
| Minor 1: 'The model will read ... as L1' and 'It may report L3' | 02, first triple | rephrased as heuristic plus 'Check whether ...' | I |
| Minor 1: 'The model may propose ... It may also not distinguish' | 02, third triple | rephrased as 'Check whether ... Check also ...' | I |
| M4: duplicated 'fully reproducible' triple ('Draft the reproducibility statement') | 02, second triple | replaced by a ladder-placement triple that supplies the definitions (@tbl-ladder and the cumulative-rung paragraph), checks the cumulative rule, tag versus digest, and L3 without a baseline, and verifies with a known-answer case (Dockerfile without lockfile must not get L2) | I; consistent with canonical ladder rules |
| M3: 02 asks for a level without the definitions | 02 | addressed by the new triple; the first triple's prompt is unchanged | I |
| Agent cross-reference (Finding 40 item 5) | 01, second triple (agent investigating an R upgrade) | added one sentence: lockfile is protected, decision stays with the reader, `@sec-llm-delegate` | I |
| Agent cross-reference | 02 | not applicable: no triple has an agent executing commands | I |
| Format (M4 last bullet) | 01, 02 | already bold/italic triple format; no change | I |
| Protected paths named in prose exist in this repository | `inst/tinytest`, `inst/baseline`, `renv.lock`, `.github/workflows`, `analysis/data/raw_data` | checked with `ls -d`; prose says 'in this book's layout' and states nothing else about repository state | V |

Removals (D18), each because the passage was defective or replaced:

- Ch 2: the old disclosure paragraph ('a general-purpose language
  model, accessed October 2026'; 'approximately version Y'),
  replaced by the M1 text. All its non-defective content was kept
  (ICMJE authorship point, drift and nondeterminism sentences, the
  'written with AI assistance' sentence, the `sessionInfo()`
  analogy). The opener 'A final discipline belongs beside these
  three.' was dropped because the passage is now its own subsection.
- Ch 3: the 'Draft the reproducibility statement' triple (M4
  duplicate). Its point about naming which convention of
  'reproduced' is meant is not carried into the new triple; Ch 3's
  'Reproduced, replicated' section and Ch 2's kept triple cover it.

## 2. Counts

| File | 'That is,' before / after | 'Unfortunately,' before / after |
|---|---|---|
| 01 | 2 / 2 | 0 / 0 |
| 02 | 2 / 2 | 0 / 0 |

Dash grep and `@label.` grep: empty for both files (V).

## 3. run_chapter.R

- 01: baseline `errors 0  warnings 0`; final `errors 0  warnings 0`
  (0 inline expressions) (V).
- 02: baseline and final `errors 0  warnings 0`; inline values
  unchanged: `rung` => L1, `rung_name` => pinned packages,
  `next_artifact` => a container recipe, a `Dockerfile` (V).

No new executed chunks.

## Words added (net, `wc -w` HEAD versus working tree)

- 01: 8805 to 9386, +581 (delegate subsection about 293; the rest
  is the expanded disclosure, the better prompt, and the
  cross-reference sentence).
- 02: 10391 to 10610, +219.

## Sources opened (all 2026-11-08)

- ICMJE, 'Use of AI by Authors',
  https://www.icmje.org/recommendations/browse/artificial-intelligence/ai-use-by-authors.html.
  Supports: AI not an author because it cannot be responsible for
  accuracy, integrity, originality; humans responsible; disclose at
  submission in the cover letter and the appropriate section. No
  update date on the page; footer copyright 2026, hence year 2026.
- NIH NOT-OD-25-132, https://grants.nih.gov/grants/guide/notice-files/NOT-OD-25-132.html.
  Released 2025-07-17; applications substantially developed by AI
  not considered the applicant's original ideas.
- NIH NOT-OD-23-149, https://grants.nih.gov/grants/guide/notice-files/NOT-OD-23-149.html.
  Released 2023-06-23; reviewers may not use generative AI to
  analyze applications or write critiques.
- OWASP, LLM01:2025 Prompt Injection, https://genai.owasp.org/llmrisk/llm01-prompt-injection/.
  Indirect injection from external sources such as files; unclear
  whether fool-proof prevention exists.
- OWASP, LLM06:2025 Excessive Agency, https://genai.owasp.org/llmrisk/llm062025-excessive-agency/.
  Least privilege; human approval of high-impact actions.

JAMA and Elsevier were not opened; the text states placement
generically ('Journals differ about which section that is') and
cites neither. Pages were read through a summarizing fetch tool,
not in full; no quotation is used.

## Claims resting on EK

- Agent-side ignore settings are not a security boundary (phrased
  as 'a request the agent is expected to honor, not a control the
  operating system enforces').
- An agent asked to make a failure go away can change the check
  (expected value, baseline, tolerance, CI step allowed to fail).
- 'Journals differ about which section that is' (from llm-sections.md
  M1, which opened JAMA and Elsevier; not reopened by me).
- The trailer `Assisted-by: <tool name>` is an illustration, not a
  standard; the text says 'a trailer line used consistently, such
  as'.
- The NIH funder sentence compresses NOT-OD-25-132 to its AI point;
  the six-application cap is not mentioned.

## For the lead

BibTeX entries for `references.bib`:

```bibtex
@misc{icmje2026ai,
  author       = {{International Committee of Medical Journal
                  Editors}},
  title        = {Use of {AI} by Authors},
  year         = {2026},
  note         = {Recommendations for the Conduct, Reporting,
                  Editing, and Publication of Scholarly Work in
                  Medical Journals, section V.A},
  url          = {https://www.icmje.org/recommendations/browse/artificial-intelligence/ai-use-by-authors.html},
  urldate      = {2026-11-08}
}

@misc{nihnot25132,
  author       = {{National Institutes of Health}},
  title        = {Supporting Fairness and Originality in {NIH}
                  Research Applications},
  year         = {2025},
  note         = {Notice NOT-OD-25-132, released 17 July 2025},
  url          = {https://grants.nih.gov/grants/guide/notice-files/NOT-OD-25-132.html},
  urldate      = {2026-11-08}
}

@misc{nihnot23149,
  author       = {{National Institutes of Health}},
  title        = {The Use of Generative Artificial Intelligence
                  Technologies is Prohibited for the {NIH} Peer
                  Review Process},
  year         = {2023},
  note         = {Notice NOT-OD-23-149, released 23 June 2023},
  url          = {https://grants.nih.gov/grants/guide/notice-files/NOT-OD-23-149.html},
  urldate      = {2026-11-08}
}

@misc{owasp2025llm01,
  author       = {{OWASP GenAI Security Project}},
  title        = {{LLM01:2025} Prompt Injection},
  year         = {2025},
  note         = {OWASP Top 10 for LLM Applications 2025},
  url          = {https://genai.owasp.org/llmrisk/llm01-prompt-injection/},
  urldate      = {2026-11-08}
}

@misc{owasp2025llm06,
  author       = {{OWASP GenAI Security Project}},
  title        = {{LLM06:2025} Excessive Agency},
  year         = {2025},
  note         = {OWASP Top 10 for LLM Applications 2025},
  url          = {https://genai.owasp.org/llmrisk/llm062025-excessive-agency/},
  urldate      = {2026-11-08}
}
```

No DOIs, so no `curl -sI` checks. The OWASP author string is my
choice of corporate name (the pages are on genai.owasp.org); adjust
if the book uses another form.

Optional glossary entry (new term): **Prompt injection.**
Instructions embedded in content a model or agent reads (a README,
an issue, a CI log, a data file) that it then follows as if the
user had given them. See @sec-llm-delegate.

Optional cheat-sheet row (Ch 2): 'Record model use | `LLM-USE.md`
row: date, tool and identifier, purpose, files, prompt path,
verification'.

Instructor guide: no Ch 2 or Ch 3 exercise changed, so no key is
stale.

## Not done

- No render (per brief); the cross-reference `@sec-llm-delegate`
  from `_llm-rule.qmd` and from 01 resolves only if Quarto accepts
  an id on a `###` heading inside a numbered chapter, which it
  normally does but I did not render to confirm. Same for the new
  `@sec-llm-disclosure` id (nothing references it yet; 07's
  disclosure passage could point to it).
- Sentence lengths in the new text were checked by eye, not by
  script.
- JAMA and Elsevier not opened (requirements stated generically).
- No model was run to test any 'Watch for' item.

## Message to the lead

Report at this path. 'That is,' 2/2 in each file, 'Unfortunately,'
0/0. Both chapters run clean. `#sec-llm-delegate` exists in Ch 2 at
293 words; I also added `#sec-llm-disclosure` for the rewritten
disclosure passage, which Ch 7's agent may want to cite when it cuts
its duplicate. Five bib entries above are needed before render.
