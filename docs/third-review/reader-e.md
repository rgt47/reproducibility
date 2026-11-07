# Reader E: Chapter 13 and the front and back matter
*2026-11-07, third review*

## Five-line summary

1. Critical: Chapter 13 and the instructor key say the raw-data directory is gitignored. Only one filename is ignored, and the key marks the correct answer ('this must change before real patient data') as a 'common error' [V].
2. Major: Chapter 13 says Chapter 6 supplies the union model, but no earlier chapter teaches it. The two-layer model is also defined differently in Ch 7, in the Ch 13 body, and in the Ch 13 Exercise 1 solution [I].
3. Major: several typed statements about the repository are stale or wrong. CITATION.cff, the missing Dockerfile and .dockerignore, the colophon's 'no renv.lock', four instructor-guide answer keys, and the NIH DMS Plan location are all affected [V/I].
4. Major: the apparatus is broken in places. All 12 cheat-sheet-index links render as `href="@sec-..."`, and the preface promises a week table that the book's instructor guide does not contain [V/I].
5. The voice pass mostly preserves meaning. It introduces two real defects in Ch 13 (the conclusion's 'only ... also' contradiction, and the four restricted-data routes collapsed into an ambiguous sentence) and several new tics (6 'That is,' and 4 'Consider ...' openers in Ch 13).

Evidence labels: [V] ran it; [I] read the source; [EK] expert knowledge not checked; [U] could not open the source. Line numbers are current `voice-rewrite` sources.

---

## Part A. Meaning preservation of the voice pass (ee7a639 to d786c6b)

### Ch 13, 10-archiving-sharing.qmd

| # | Line | Before | After | Problem and fix |
|---|---|---|---|---|
| A1 | 1882-1886 | 'differ only in their directory layout, in whether a report is rendered, and in the last mile of publication, a package...' | 'differ only in their directory layout and in whether a report is rendered. They differ also in the last mile...' | Splitting the sentence makes 'only' contradict 'also' in the book's closing argument. Restore the single three-item sentence. **Major.** |
| A2 | 678-690 (callout) | Semicolon list: code and environment, always; de-identified data, only where...; a synthetic stand-in...; or, for data shareable under agreement, a citation... | 'It may carry de-identified data, only where the data's steward has made that determination, or a synthetic stand-in, labeled as such. For data that...' | The four routes are now three sentences, and the second can be read as 'only where the steward determined X or [where there is] a synthetic stand-in'. Line 698 then asks the reader to count 'the four routes named above'. Make it a four-item bulleted list. **Major.** |
| A3 | 18-25 | 'By the end of this chapter you will be able to decide..., state..., and deposit...' | 'the reader will be able to decide ... We shall also be able to state ... Finally, we shall be able to deposit' | Two actors in one paragraph, and 'we shall be able' makes the authors the learners. The card at 49 still says 'you'. Restore the second-person single sentence. |
| A4 | 241-245 | 'Depositing a compendium and labeling it "reproducible" without stating ... misrepresents the work.' | 'Consider depositing ... or merely by tag. That misrepresents the work.' | 'Consider' introduces a scenario, and 'That' then has no clear antecedent, which weakens a normative claim. Restore. |
| A5 | 169-172 | 'archiving and stewardship: depositing the finished compendium ... and recovering it when the pins have decayed' | 'archiving and stewardship. That is, the finished compendium is deposited ... and recovered ...' | 'That is,' glosses a noun phrase with a passive clause. Restore the colon form. |
| A6 | 1842 | 'The book's argument comes down to four points.' | 'In conclusion, the book's argument...' under the heading `## In conclusion` | The phrase is redundant with the heading. Delete 'In conclusion,'. |
| A7 | 1897-1901 | 'The reader who finishes this book with the judgment ... has learned the one thing...' | 'Consider the reader who ... That reader has learned...' | This softens the book's final sentence. Restore. |
| A8 | 1317-1333 | 'your compendium', 'whether you verified', 'your data-use agreement' | 'the compendium', 'the analyst', 'the data-use agreement' | The Verification paragraph that follows (1326-1333) still says 'yourself', 'you ran', 'you pinned', so one exchange now mixes 'the analyst' and 'you'. Use one form. The same applies at 1305 ('the analyst's setup'). |
| A9 | 829-830 (added) | 'Everything the four routes above implement is a response to...' | 'We have so far treated the deposit as the analyst's own decision. In practice, ...' | The new transition misstates the text. Lines 764-774 have just said that what may be deposited 'is settled by documents signed long before the deposit'. Drop the added sentence. |
| A10 | 426, 1241 | 'Even a correctly digest-pinned...'; 'The chunk cannot certify...' | 'Unfortunately, even ...'; 'Unfortunately, the chunk ...' | Both are new evaluative tics. At 1241 the limitation is by design, not unfortunate. Remove both. |
| A11 | 1200-1202 | '...which is cheaper insurance than it looks given how little either artifact costs to include.' | 'Given how little either artifact costs to include, this is cheaper insurance than it looks.' | Meaning is preserved. The underlying claim is weak, though: a SIF is gigabyte-scale (line 386 says 'a gigabyte or more'). Consider 'worth its size'. |

The other changes I read (about 140 sentence splits, 'However,' replacing ', but', and parenthetical rewrites) preserve meaning. Line 102 ('That is, it moves from...') and 1004/1038 ('That is,') are acceptable but repetitive.

**Counts, Ch 13** (all introduced by the voice pass):

- 'That is,': 6 (102, 169, 878, 956, 1004, 1038).
- 'We note that': 1 (219).
- 'Unfortunately,': 2 (426, 1241).
- Rhetorical questions added: 0. (The one at 904-906 predates the pass.)
- New 'Consider ...' sentence openers: 4 (241, 337, 538, 1897).

These cluster mildly: 'That is,' falls three times in 956-1038, and 'Consider' falls in the analyst's-contribution, two-layer, archiving, and conclusion sections.

### Front matter and appendices

| # | File:line | Problem | Fix |
|---|---|---|---|
| A12 | setup-appendix.qmd:22-25 | 'the flag `--platform linux/amd64` is then the only way to get a build at all; it is not an optimization. The reader is referred to that section before this one.' The clause order is inverted and the closing sentence is stilted. Before: '...is not an optimization but the only way to get a build at all. That section is worth reading before this one.' | Restore. |
| A13 | conventions.qmd:30-32 | 'The card gives an estimated reading time and the chapters and the statistical knowledge it assumes.' This is garbled ('it' has no antecedent). | 'The card gives an estimated reading time, the earlier chapters and statistical knowledge the chapter assumes, three to five objectives...' |
| A14 | conventions.qmd:124 | 'We work two datasets in the book' is unidiomatic. | 'We use two datasets'. |
| A15 | setup-appendix.qmd:108 | New 'Unfortunately,'. | Remove. |
| A16 | preface.qmd:69; shell-primer.qmd:141; instructor-guide.qmd:45 | One new 'That is,' each. The shell-primer one glosses a colon-style list. | Restore the colons. |

The other front-matter changes (index, colophon, glossary, instructor guide) preserve meaning. No rhetorical questions were added in these files.

---

## Part B. Findings ranked by severity

### Critical

**C1. The raw-data directory is not ignored; only one file is.**

- Where: 10-archiving-sharing.qmd:1235-1244 and Exercise 7 (1400-1409); instructor-guide.qmd:337-352.
- Evidence [V]: `.gitignore:37` lists `analysis/data/raw_data/cohort_raw.csv` only. `git check-ignore --no-index` matches that file and does not match `analysis/data/raw_data/extra.tsv` or `.../patients.csv`.
- What the chapter says: 1242 claims the chunk shows 'that the directory is excluded'. The check is `grepl('raw_data', ...)`, which the one-file entry satisfies.
- What the instructor key says: 'none of the three file-system findings would need to change for real patient-level data'. It lists 'Stating that the third check would need to change' as a common error. This is the wrong way round.
- Why it matters: a health-sciences student who takes this pattern to real data will commit any extract that has a different name. Exercise 8 of the same chapter builds its scenario on exactly that (`extra.tsv`).
- Fix:
  - Say at 1236-1244 that only the generated file is ignored, and that real data need a directory pattern (`analysis/data/raw_data/*` with a `!README.md` exception).
  - Make the exercise check use `git check-ignore`.
  - Invert the rubric: the third finding is the one that must change.

### Major

**M1. The union model is not taught before Chapter 13, and the two-layer model is defined three ways.**

- Prerequisites at 37-39 say 'Chapter 6 (@sec-dependencies) supplies ... the union model this chapter extends'. Line 111 says 'the union lockfile ... already did that capturing in @sec-dependencies'.
- `grep -i union` finds the term only in Ch 13, the glossary, the cheat-sheet index, and one table cell in Ch 5 (03-research-compendium.qmd:1040) [I].
- The three definitions of the two-layer model:
  - Ch 7 (05-containers.qmd:1173-1180): layer 1 is a lab-wide team image 'carrying the lab's preferred packages'; layer 2 is a thin per-project image.
  - Ch 13 body (333-377): layer 1 is the OS, R version, and system libraries; layer 2 is the package set.
  - Ch 13 Exercise 1 solution (1450-1456): the tidyverse, knitr, and rmarkdown belong in the environment layer.
- The glossary (749-752) follows the Ch 13 body. A reader cannot tell which definition the exercise grades.
- The Exercise 1 solution's last rule (1480-1482, 'the image cannot carry two versions') applies equally to the union lockfile, which also records one version per package. So it does not justify the placement.
- Fix: change the prerequisite to 'introduced here', with Ch 7 §'A first look' as the only antecedent. Pick one definition (the Ch 7 team-image/project-image split fits zzcollab and the solution) and align the body, the glossary, and the solution. Rewrite the two-version rule.

**M2. 'The cohort, continued' checks the wrong things and misses what the compendium lacks.**

- No `Dockerfile` and no `.dockerignore` exist in the repository [V: `file.exists` FALSE; `git ls-files`].
- The section (1245-1249) says what is missing is 'the part no file-system check can see': a DOI, an image, and a level statement. A Dockerfile is exactly what a file-system check can see, and the restricted-data section (710-712) makes a `.dockerignore` 'part of the deposit'.
- The compendium is therefore L1 at most, which the check answer (1266-1270) leaves open.
- Fix: add `file.exists('../../Dockerfile')` and `.dockerignore` to the chunk, and state the level it implies, computed inline.

**M3. CITATION.cff: stale description and a license conflict.**

- Line 639-640 says the file carries 'the placeholder affiliation `Your Institution`'. It now reads 'University of California, San Diego' [I]. The `orcid` field is still empty.
- More seriously, the file declares `license: CC-BY-NC-SA-4.0` for `type: software`, while LICENSE and DESCRIPTION give the code as CC0 [I].
- Line 601-603 tells the reader that Zenodo pre-fills deposit metadata from this file, so a deposit would record the wrong code license. That contradicts 1231-1234 ('would see the same answer') and the Exercise 9 solution (1756).
- Its `abstract` also claims the compendium 'Contains all data ... needed to reproduce the analyses', which is the over-claim the chapter warns against.
- Fix: correct the prose. Flag the license mismatch as a fourth check in 'The cohort, continued', which would be a strong teaching moment.

**M4. Exercise solutions contradict Ch 12.**

- Known-issue items 26 and 27 are both confirmed.
- Exercise 3 solution (1554) cites `make render`. 09-continuous-integration.qmd:2080 says 'There is no plain `make render` target', and the Makefile has none [I].
- Exercise 4 solution (1608-1610) accepts 'recorded output hashes' as L3 evidence. Ch 12 (1050-1056, 2219) says to hash raw data but compare estimates within a tolerance, and the glossary's L3 (778-782) requires a baseline test.
- Fix: write `make docker-render`. Replace 'recorded output hashes' with 'a passing baseline test against committed values within a stated tolerance'.

**M5. The NIH DMS Plan is not submitted 'as part of the budget justification' (838-842).**

- [I] I opened grants.nih.gov 'Writing a DMS Plan'. It says 'DMS Plans should be included within the "Other Plan(s)" field on the PHS 398 Research Plan'. Only 'a brief summary and associated costs' go in the budget and budget justification.
- Fix: 'submit a DMS Plan in the Other Plan(s) attachment of the application, with its costs in the budget justification'.

**M6. The capture/verification framing differs between the book's front and its last chapter.**

- preface.qmd:47-54 and index.qmd:27-31 say capture 'set[s] the level' and that verification is an act of validation that 'confirm[s]' it 'without capturing anything new'.
- The Ch 13 conclusion (1862-1869) and the glossary's 'Verification' (781-782) say L3 'is reached not by capture but by an act of verification', i.e. verification sets a level.
- A student reads the first framing on day one and the second in week 10. The T1-1 unification in REFACTOR-PLAN (line 2178) covered 00, 02, 08, 09, and the glossary, not the preface or index [I].
- Fix: in the preface and index, say that capture sets L0-L2 and that a one-time verification sets L3, while CI re-confirms it.

**M7. Ch 13's stack figure contradicts the convention it uses.**

- 94-95 says 'This chapter pins no layer ... for the first time'. Then 106-107 marks input data 'as captured here'.
- conventions.qmd:44-45 defines 'captures' as 'pins for the first time'.
- Fix: open with 'This chapter pins no new version, but it is the first to make the input-data layer durable...', or define 'captured' more broadly in Conventions.

**M8. The colophon's typed prose contradicts its own computed table.**

- colophon.qmd:67-68 says 'there is no `renv.lock` ... so the table above reports `no`'. `renv.lock` is tracked and `file.exists` returns TRUE [V], so a fresh render prints 'yes' beside prose saying 'no'.
- This happens in the passage that claims nothing is typed by hand.
- Fix: compute the sentence inline, and drop the 'planned but not yet complete' sentence or make it conditional.
- Known-issue item 34 is also confirmed: `freeze: auto` (`_quarto.yml:122`) means chunks may be replayed, not 'generated at build time'.

**M9. The instructor guide's answer keys are stale for four chapters** [V; ran each snippet with the locked library from the repo root].

- Ch 5 (instructor-guide.qmd:114-126): `sum(pillars)` is **2**, not 1, because `renv.lock` exists.
- Ch 6 (139-151): `unique(deps$Package)` returns `stats, survival, tibble, utils, withr`, not three packages. So 'tibble is the only contributed package' is wrong.
- Ch 8 (197): `renv.lock` is TRUE.
- Ch 12 (307-310): `length(missing)` is **2** (survival, withr), not 0.
- Ch 3 (65-69) and pipelines (269) still place the compendium at L0.
- Known-issue item 9 is confirmed: line 68 lists `utils` as recorded in the lockfile, and the guide's own Ch 6 rubric says base packages are excluded.
- Known-issue item 30 is confirmed:
  - Line 261 says 'both targets', but the fragment defines three.
  - 285-287 lists values the shown code does not compute. The values themselves are correct [V]: 338, 337, 1.
- Values I confirmed correct [V]: 337, 338, the three identifier columns, character/factor, 2 sexes, 9.5 percent missing, 1 duplicate, the seed `set.seed(20260908)`, and all four `expect_true` assertions passing.
- Fix: generate the keys from code chunks rather than typed `#>` output.

**M10. Cheat-sheet index: all links broken, titles stale, ch13 entry inaccurate.**

- [V] In the rendered `_book/cheat-sheet-index.html` all 12 links are literally `href="@sec-cheat-..."`. Markdown link syntax does not resolve Quarto cross-refs. Use `[Chapter 2: ...](01-reproducibility-crisis.qmd#sec-cheat-crisis)` or a bare `@sec-cheat-crisis`.
- Known-issue item 35 is confirmed. 'Chapter 2:The' has no space, and the titles differ from the chapters ('Managing Dependencies', 'Containers', 'Continuous Integration', 'Archiving and Sharing'). The instructor guide has the same title drift (233, 300, 324).
- The Ch 13 entry (78-81) lists `groundhog`, 'OSF deposition', and 'DataCite metadata'. None appears in Ch 13 (grep empty) [I].
- Line 4-5 says the appendix 'collects those tables', but it holds prose summaries only.
- Line 21, 'single most referenced table', is unsupported (item 42 confirmed).

**M11. The preface promises a week table that the book's instructor guide lacks.**

- preface.qmd:123-125 says the instructor guide has 'a week-by-week table'. `instructor-guide.qmd` has none. The table exists only in the root `INSTRUCTOR-GUIDE.md` (lines 23-34), which is not rendered.
- That root table agrees with `conventions.qmd:177-191` and with Ch 13 Exercise 4 (week 10) [I].
- Ch 13 Exercise 7's solution (1702-1705) calls the guide 'available to course instructors', but it is a public appendix.
- Fix: move the week table into the appendix and drop 'available to course instructors'.

**M12. Ch 13 relies on optional material, and its load is far above the plan.**

- The deposit, the worked example, Exercise 8, and the week-10 lab all depend on `apptainer build` and SIF from Ch 8, which the core path marks Optional (conventions.qmd:186).
- The body (lines 1-1349) is 9,289 words [V: `wc -w`]. REFACTOR-PLAN 10.11 budgets 4,500 for week 10.
- Fix:
  - Add a three-sentence self-contained explanation of `apptainer build` from a digest at 531-537.
  - Mark 'Funder and journal obligations' and the Software Heritage/Whole Tale paragraphs as optional reading.

### Minor

- **m1.** 945-951: 'four of the ten determinants' sits against nine layers in `R/stack_diagram.R:17-25` and conventions.qmd:40. The 'fonts and graphics device' it names is not a layer. Known-issue item 16 is confirmed for Ch 13. Use 'nine' and name layers from the stack.
- **m2.** 436: Dockerfile drift is called 'regression to L0', but the committed lockfile keeps L1. Item 47a is confirmed; write 'regression below L2'. Item 47b (1229, 'deposit example') is ambiguous between the template at 782 and the worked example. Could not tell; name the target explicitly.
- **m3.** Outline order: 73-89 lists Orientation before 'Where this sits on the stack', but the body has the reverse order (92 vs 131).
- **m4.** Cheat sheet 1793 and tbl-union caption say the union 'never shrinks', but 383-388 say it is pruned by deliberate removal. Write 'never shrinks unless pruned'.
- **m5.** Typed numbers:
  - 1105-1108 ('three packages', 'grows by only two, from three to five') is typed, though it matches [V]: 3, 5, 7, 9.
  - 1225 'All three are now in place' is typed.
  - Use inline `r` expressions, which the book itself teaches.
- **m6.** 1195-1196: 'a pinned package is pulled from CRAN' conflicts with 910-912, which says archived versions remain installable.
- **m7.** Exercise 5 solution (1625) hard-codes `snapshot_date = '2026-06-29'`, though the exercise asks for the creation date. It also needs a note that `rang` must be installed from the CRAN archive or GitHub. The 2026-08-22 archival is [V]: I opened cran.r-project.org/package=rang, which says it was archived 2026-08-22 'as issues were not corrected in time'.
- **m8.** The 'honest level' callout sits mid-chapter (931). conventions.qmd:104-106 says it closes chapters.
- **m9.** Glossary vs chapters:
  - 'Container image ... runs identically wherever a container runtime runs' (101-104) contradicts Ch 13 1404-1406 and 1519-1523 on emulation and different numerical behavior.
  - '`rang`, `groundhog`, and `capsule`: ... reconstruct a package set from a date' (507-510) misdescribes `capsule`, which 04-dependencies.qmd:1020-1029 says layers over `renv` [I].
  - 'Controlled access ... rather than releasing it on request' (106-108) is odd, since controlled access does release on an approved request. Ch 13's vocabulary has 'rather than to anyone who downloads'; use that.
  - Item 36 (octopus merges, 258) is confirmed [EK]: write 'a commit with more than one parent'.
- **m10.** setup-appendix:
  - Item 31 is partly confirmed [EK]. BuildKit `docker build` with an amd64-only `FROM` fails on arm64, but `docker run`/`pull` warns and emulates, so 35-37 and 152 should distinguish the two.
  - Item 32 is confirmed [EK]: a CRLF shebang gives 'bad interpreter' or 'no such file or directory', not `exec format error` (96).
  - Item 33 is confirmed [I]: 154 names one place twice, and 'three machines' (6) introduces four topics.
  - Line 18-20 says the book's Dockerfiles build on `rocker/tidyverse` and `rocker/verse`. Ch 7 also uses `rocker/r-ver:4.4.0` (05-containers.qmd:755), which has an arm64 build.
- **m11.** shell-primer:
  - 266-270 says glob behavior is identical in bash and zsh. zsh errors 'no matches found' on an unmatched glob where bash passes it literally [V: I hit exactly this zsh error in this session].
  - 230's `permission denied: ./greet.sh` is zsh's message, not bash's.
  - Item 38 is confirmed: '2026 syllabi comparison' and '2026 expert review' are uncited (also setup-appendix:9-11, 106).
- **m12.** Credits 20, 'sequence house style', looks like a typo (item 37 confirmed). instructor-guide.qmd:2 carries a hand-written timestamp that renders in the book.
- **m13.** Preface 97-99 says 'package registries'. Ch 13 treats container registries, and the preface omits restricted data and stewardship, which are the chapter's largest sections.
- **m14.** conventions 152-157, 'not a compromise' vs 'what it gives up is friction': mild tension (item 53 confirmed). Write 'a deliberate trade'.
- **m15.** [U] Whole Tale (648-653, 1809-1813) is described as a live platform. I did not check its current service status; worth confirming before calling it 'the most ambitious realization'.
- **m16.** [EK] Docker Hub's free tier (448-450: rate limits, one private repo) is plausible but changes often. Add an 'as of' date.

---

## Part B, per-file reader notes

### Ch 13 (10-archiving-sharing.qmd)

- **Reading time.** The body is 9,289 words, about 46 minutes of prose plus about 5 for the code. The stated 55 minutes fits the body only. With exercises, solutions, and the conclusion (about 3,850 more words) it is about 70 minutes.
- **Opening.** The five-person lab and the audit two years on motivate the chapter well for this audience. But the stack figure and its very abstract paragraph (94-115) come before the Orientation and are the hardest text in the chapter.
- **Closing.** The four-point conclusion plus the habits include consolidates the book well. Apart from the cheat sheet, the chapter's own content (team model, deposit, restricted data) gets no summary. A three-line chapter recap before 'In conclusion' would help.
- **Hardest passages:**
  1. 94-98 ('pins no layer ... for the first time. Both of its halves ... are stated as adding no new rung. Yet it is not neutral...').
  2. The figure caption at 119 (about 110 words, one sentence after 'which is why').
  3. 419-437 (the content-vs-bytes qualification).
- **Suggested rewrite of 94-98:** 'This chapter fixes no new version. It does two other things to the stack. It makes the input data durably findable for the first time, and it checks that the pins of earlier chapters still resolve years later.'
- **Pedagogy.** The 7 checks are answerable from the text. Exceptions: Exercise 1 (M1), 3 and 4 (M4), and 7 (C1). Exercises 2, 6, 8, and 9 have sound solutions; the Exercise 9 solution needs M3.
- **Callouts.** One vocabulary note, two important, 16 collapsible (checks plus solutions). Their use is appropriate. The restricted-data callout is the right weight but needs A2.
- **Duplication and sequence.**
  - `rang` is presented at length in Ch 6 (04-dependencies.qmd:995-1004) and again here. Ch 13 should say 'recall'.
  - The two-layer model duplicates and conflicts with Ch 7 (M1).
  - SIF comes from the optional Ch 8 (M12).
- **Running example.** The chapter does not touch the cohort data. Its cohort section is file checks only, which I ran [V] (TRUE, TRUE, TRUE), and `tbl-union` is computed [V]. The prose numbers are typed (m5).
- **Memorability.**
  - What works: 'a DOI names a deposit, and a SWHID names the bytes'; 'belt and suspenders'.
  - What would help: the 'recipe and cake' analogy (1490) is buried in a solution. Promote it into the body as the section's one-liner: 'the image is a cache; the recipe is the record'.

### Front matter

- **index (2.5 min), preface (5 min), conventions (6 min).** These are clear and well motivated; the preface's opening anecdote works.
- Problems: M6 and M11; the conventions card sentence (A13); the 'nine layers' vs Ch 13 'ten' mismatch (m1).
- Core-path table titles match the chapter H1s exactly [I].

### Appendices

- **shell-primer (9 min) and setup-appendix (7 min).** Practical and well sequenced; issues are m10 and m11.
- **cheat-sheet index.** Its links are broken (M10).
- **instructor guide (8 min).** Has the right structure, but its keys are stale (M9).
- **glossary (23 min to read, reference use).** Definitions mostly agree with the chapters; exceptions are listed in M1 and m9.
- **colophon, credits, copyright.** Short; colophon M8 and credits m12 apply. The copyright page's citation string differs from what CITATION.cff would generate (title 'reproducibility', v0.1.0). Align them with M3.

---

## Three concrete fixes, ranked

1. **10-archiving-sharing.qmd:1235-1244, Exercise 7, and instructor-guide.qmd:337-352.** Correct the gitignore claim and invert the rubric (C1). The same pass can add the Dockerfile, .dockerignore, and CITATION.cff license checks to 'The cohort, continued' (M2, M3) and compute every resulting statement inline.
2. **10-archiving-sharing.qmd:37-39, 333-377, 1450-1482; 05-containers.qmd:1162-1187; glossary.qmd:749-760.** Write one definition of the two-layer and union models, introduce the union model where it is first used, and fix the Exercise 1 rationale (M1).
3. **cheat-sheet-index.qmd (all links), instructor-guide.qmd (keys and week table), colophon.qmd:67-72.** Regenerate the apparatus from code: resolvable cross-refs, chunk-computed answer keys, the week table moved in from the root guide, and an inline colophon sentence (M8-M11). Apply the two Part A defects (A1, A2) in the same commit.

## Scope disclosure

- Not checked: I did not build Docker images, so the `find` leak check, `apptainer build`, and platform behavior are [EK].
- I did not run `rang`.
- I did not verify TRIPOD+AI item numbers, the HIPAA text, dbGaP, or the SWHID ISO number against their sources ([EK]; they agree with my knowledge).
- The rendered `_book` was mid-render. I used it only for the cheat-sheet hrefs, whose cause is in the source.
