# Phase 31 Report A: Chapters 1 to 3, Habits, and the Restricted-Data Rule
*2026-11-26 09:05 PST*

Files edited: `analysis/report/00-intro.qmd`,
`01-reproducibility-crisis.qmd`, `02-levels-of-reproducibility.qmd`,
`_llm-rule.qmd`. `_habits.qmd` is unchanged (see R1-03). No shared
file was edited; no commit.

## Findings

| ID | Status | Change (file) | Evidence |
|---|---|---|---|
| R1-02 | Done | Intro tool catalog (13 names, 22 lines at old 209-230) cut to one paragraph (new 215-222) that keeps the 'nearly every layer' hedge and names the three core tools (`renv`, Docker, CI) with pointers; the next paragraph still needs `renv` and Docker, so they stay. 'A biostatistician' now 'An analyst'; 'Each chapter develops the part of `zzcollab`' now describes the D29 box pattern (00-intro) | I. All nine dropped citation keys are still cited in other chapters (grep); the three book-wide `@sec-intro` back-references (Ch 9 l. 199, closing l. 7, Conventions l. 161) do not rely on the cut tool names |
| R1-03 | Done (differently) | `_habits.qmd` is also included in `11-closing.qmd`, where glosses are redundant, so the glosses went in a short paragraph after the include in the intro (new 320-329): gate, baseline, tolerance, restricted data (worded to match the generalized `_llm-rule.qmd`) | I |
| R1-04 | Done | Each bar labeled with its unit ('of 100 studies', 'of 53 findings', 'of R files', 'of R scripts'); axis widened; prose 'comparably low' replaced ('not comparable ... each is low on its own terms'); caption and alt text updated, caption notes the Trisovic bar is pre-cleaning. File counts (9,078) and script counts were not used: no source opened today gives them | V: rendered PNG viewed, no clipped labels |
| R1-05 | Done | 'about 44 percent' after automated code cleaning, in the intro and in Ch 2 | V: arXiv 2103.12793 abstract, opened today: '74% of R files crashed in the initial execution, while 56% crashed when code cleaning was applied' |
| R1-06 | Text done; bib proposed | The three quantifiers now read 'about 99 percent' (intro twice, Ch 2 once). No 'preprint' wording added: the paper is published | V: `https://doi.org/10.36190/2025.49` resolves to `workshop-proceedings.icwsm.org/abstract.php?id=2025_49` (opened today): Saju, Holtdirk, Mangroliya, Bleier; R2CASS 2025, Workshop Proceedings of the 19th ICWSM; abstract gives 98.8% without dependency descriptions and 25.87% of scripts completing |
| R1-07 | Done | 'grim' to 'consistent and sobering'; 'damning' to 'telling' (intro, Ch 2); 'without flinching' to 'plainly' (intro, Ch 3); Ch 2 Exercise 4 solution rewritten as 'look again: the exercise asks where the binding constraint moves'. The second 'every quantitative health scientist' (Ch 2 Orientation) went with R2-07 | I |
| R2-01 | Done | New paragraph after the re-execution studies: the two failures are not independent; a field that cannot re-execute cannot diagnose a failed replication. Replication studies framed as context; Exercise 6 solution no longer says OSC measures a problem the book 'cannot fix', and points to the body. No section reordered | I |
| R2-04 | Partly done; move proposed | One paragraph on why model output is not reproducible now opens 'Collaborating with an LLM' (taken from `sec-llm-disclosure`, which keeps a one-sentence version), so the point stays in Ch 2 if the subsections move. The two subsections were not moved (out of scope) | I |
| R2-06 | Done, wording from reviewer's evidence | Clause after the Baker figures (Ch 2 new 373-377): 'By the article's own account, the online survey probably attracted respondents already concerned about the issue' | Not opened by me: nature.com redirects to login and an archive route was refused by the permission classifier. Wording rests on reviewer H's quote from the article PDF ('probably selected for respondents who are more receptive to and aware of concerns about reproducibility', `raw/H-verification-cases.md:84`) |
| R2-07 | Done | The trial-auditor vignette replaced by a thesis-revision scenario (reviewer's request a year later, hazard ratio 1.32 to 1.29, interval slightly wider; no null crossing). Updated together: chapter lead-in (l. 19), Outline, 'The student's failure', the 'naming the rung' check, and the stakes paragraph (reviewer, committee, regulator) | I. Numbers are illustrative, labeled by context as a scenario |
| R2-08 | Done | 'a widely cited settlement' | I |
| R2-09 | Done | Ch 2's 'from earlier chapters' check moved to the end of the chapter body, after 'The cohort, continued' and before 'Collaborating with an LLM' (new 1138-1168), so it does not travel with the LLM subsections if they move; retitled 'the chapter as a whole'; answer no longer uses Rocker or CI, only L1, L2, the R runtime, and `load_cohort()`. Ch 3's check left in place (not in the REVIEW row) | I. Other chapters still open with such a check. Grep of `conventions.qmd`, `preface.qmd`, `index.qmd`: none states that every chapter opens with one (Conventions only says most sections end with a Check) |
| R2-10 | Done for Goodman and Leek and Peng; ACM not | Goodman: 'reviewed the explicit and implicit definitions ... nonstandard and unsettled ... conflicting meanings'; further-reading bullet no longer claims a 'cleaner lexicon'. Ch 3: the floor metaphor is no longer attributed to Leek and Peng | V: Goodman abstract via Europe PMC REST (PMID 27252173). Leek and Peng body via `pmc.ncbi.nlm.nih.gov/articles/PMC4330755/` (summarizing fetch): supports 'even a reproducible analysis can suffer from many problems'; never says 'minimum standard' or 'floor'. ACM badging page returned 403 twice; the Ch 3 ACM passage (02:666-693) remains unverified |
| R2-11 | Done | Ch 2: OSC 'conducted replications of one hundred published studies'. Intro already said 'confirmed' for Begley | I |
| R3-01 | Done, scoped | Vignette kept hypothetical (it reports an odds ratio, a `glmer` fit, and no `glmer` default-optimizer change appears in the NEWS). New paragraph: lme4 1.1-20 (February 2019) changed the `lmer()` default optimizer from `bobyqa` to `nloptwrap`; NEWS records the revert setting | V: `https://raw.githubusercontent.com/lme4/lme4/master/inst/NEWS.Rd`, opened today, NEWS.Rd line 969 under 'CHANGES IN VERSION 1.1-20 (2019-02-04)'. Commit-pinned: `https://github.com/lme4/lme4/blob/632b07a5496e47fe31580a1d1fc1d88d722662e2/inst/NEWS.Rd`. The CRAN `news.html` and `NEWS` URLs returned 404 |
| R3-02 | Done | 'Two numbering schemes' section (62 lines) and its check removed; replaced by a footnote on 'The ladder' section; Outline line and Orientation clause removed. Exercise 4 kept in place (renumbering would shift Exercise 7, which the instructor guide may key) and made self-contained by listing the five levels. Not moved to Ch 5 (between-file move out of scope) | I: grep found no other reference to the section, its check, or 'tool-adoption'; the five levels checked against `zzcollab/vignettes/reproducibility-layers.Rmd:57-61` |
| R4-009 | Done (Python, Stata); MATLAB omitted | Ch 2, after the two R defaults: 'Nothing here is peculiar to R', Python 3.0 true division, Stata's `version` statement | V: PEP 238 (`peps.python.org/pep-0238/`) and the Stata manual `stata.com/manuals/pversion.pdf`, both opened today. No MathWorks source opened, so MATLAB is not named |
| R4-010 | Done | `_llm-rule.qmd`: 'confidential or restricted data (protected health information, licensed survey microdata, administrative records, export-controlled or proprietary data)'; IRB generalized to 'Any ethics approval and consent'; 'data use agreement, license, or provider's terms'. 'Identifiable records' kept, and the list marked 'for example'. Structure, title, habit 3, the NIH example, both references kept. 32 to 35 lines; 239 to 257 words. Grep of the text following each include in the other chapters finds no back-reference to 'IRB', 'protected health information', or 'data use agreement' | I |

Evidence labels: V = I ran it or opened the primary source today;
I = I read the book or tool source.

## Proposed changes to shared files (lead)

1. `references.bib`, replace `saju2025`:

```bibtex
@inproceedings{saju2025,
  title     = {Computational Reproducibility of {R} Code
               Supplements on {OSF}},
  author    = {Saju, Lorraine and Holtdirk, Tobias and
               Mangroliya, Meetkumar Pravinbhai and
               Bleier, Arnim},
  booktitle = {Workshop Proceedings of the 19th International
               {AAAI} Conference on Web and Social Media
               ({R2CASS} 2025)},
  year      = {2025},
  doi       = {10.36190/2025.49},
  url       = {https://workshop-proceedings.icwsm.org/abstract.php?id=2025_49}
}
```

2. Optional bib entries if the lead wants the new Ch 2 and Ch 3
   sentences cited: PEP 238 (`https://peps.python.org/pep-0238/`), the
   Stata `version` manual entry
   (`https://www.stata.com/manuals/pversion.pdf`), and the lme4 NEWS
   at the commit-pinned URL above. The sentences currently carry no
   citation.
3. R2-04 move: move `### What to delegate to a coding agent`
   (`sec-llm-delegate`) and `### Disclosing and recording model use`
   (`sec-llm-disclosure`) from Ch 2 to Ch 4 (Version Control, after
   its LLM section) or to an appendix; keep both ids. Ch 2 keeps the
   new opening paragraph. References to update or confirm after the
   move: `_llm-rule.qmd:33`; Ch 2 lines 1216 and 1726 (cheat-sheet
   row 'Record model use'; consider moving that row too);
   `version-control.qmd:1572, 1981`; `04-dependencies.qmd:1370`;
   `05-containers.qmd:1860`; `03-research-compendium.qmd:1817`;
   `07-literate-programming.qmd:1608`; `pipelines.qmd:1664`;
   `08-testing-quality.qmd:2035`; `09-continuous-integration.qmd:2031`;
   `10-archiving-sharing.qmd:1761, 1800`; `glossary.qmd:535, 541`.
   All are `@sec-` links (checked: the only `#sec-llm-` hits are
   the two section ids), so they resolve if the sections land in a
   numbered chapter or a lettered appendix; an unnumbered page
   would break them (hard rule 5).
4. R3-02 remainder: if the lead wants Exercise 4 of Ch 3 moved to the
   compendium chapter, Ch 3's Exercises 5 to 8 renumber; check the
   instructor guide first.

## Word counts (`wc -w`)

| File | Before | After |
|---|---|---|
| 00-intro.qmd | 2,256 | 2,362 |
| 01-reproducibility-crisis.qmd | 11,639 | 11,829 |
| 02-levels-of-reproducibility.qmd | 10,911 | 10,574 |
| _habits.qmd | 78 | 78 |
| _llm-rule.qmd | 239 | 257 |

## Verification

- tinytest: 456/456 before. After the first round of edits 455/455
  (invariants 381): `test-manuscript-invariants.R:68-73` asserts once
  per `## Answer`, so removing the Ch 3 check removes one assertion
  (inspected). Final run: 456/456 (invariants 382, reading times
  12/12). The return to 456 is not from my files (my answer count did
  not change between the runs); other Phase 31 agents were editing
  other chapters concurrently, so the cause is inferred, not
  verified. No reading-time card change was needed.
- Inline R: `` `r `` grep across the five files finds only the
  intended inline expressions in Ch 3's 'The cohort, continued'
  (lines about 1012 to 1050).
- Scratch render: the five files, `references.bib`, and a mirror of
  `R/`, `inst/`, `DESCRIPTION`, `NAMESPACE`, `renv.lock`, and
  `analysis/data/` copied to the scratchpad; `quarto render` of each
  chapter to HTML with `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`
  (final run; script `/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/render.sh`). All three: exit 0, 'Output
  created'. Warnings are only unresolved cross-references to other
  chapters and tables (expected); no R error, no `citation-missing`.
  The footnote renders in Ch 3; the revised figure was viewed.
- Searched the five files for em or en dashes and for 'grim',
  'damning', 'flinch', 'auditor', 'third decimal', 'ninety-nine': none
  remain.

## Not done, untested, or open

- MATLAB not named (no source opened). ACM badge definitions in Ch 3
  not verified (403). Baker caveat not opened by me (paywall).
- The full book render (HTML and PDF) was not run, per the hard rules;
  the PDF layout of the new footnote and the wider figure is unseen.
- The 'rests on faith rather than evidence' sentence (raw report tone
  list) was kept; it was not in my assigned R1-07 words.
- Sentence lengths: a script over the added diff lines
  (`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/sentlen.py`) flagged two
  real overlong sentences (the Python and Stata sentence, the
  `_llm-rule` opening), both split. One 39-word sentence remains in
  the Ch 2 Orientation ('What failed was everything around the
  statistics: ...'); it is carried over verbatim from the old
  vignette and parallels the intro.
