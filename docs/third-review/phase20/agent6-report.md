# Agent 6 report: Chapter 13 and front/back matter
*2026-11-08*

Files edited (only these): `analysis/report/10-archiving-sharing.qmd`,
`setup-appendix.qmd`, `shell-primer.qmd`, `conventions.qmd`,
`credits.qmd`, `glossary.qmd` (four entries only). The line numbers
below are current, after the edits.

## 1. Items

| Item | File:line (current) | Action | Evidence |
|---|---|---|---|
| T1-1 one-file ignore | 10:1317-1405 | already fixed (Phase 19). Not touched. `git check-ignore` chunk prints `ignored` / `ignored as well` | V (run_chapter) |
| T1-11 CITATION.cff license | 10:690-705, 1350-1366 | already fixed (D25). Not touched. Inline value `CC-BY-NC-SA-4.0` | V |
| Union model credited to Ch 6, which never teaches it | 10:37-51, 104-125 | fixed. The prerequisite now says the union model is introduced in this chapter and gives a one-clause definition there. 'union lockfile ... in @sec-dependencies' becomes 'the lockfile of @sec-dependencies'. The objective's 'renv union model' becomes 'union model' (it is not an renv feature) | I |
| Two-layer model defined three ways | 10:287-291 (vocabulary), 241-245, 349-391, 1612-1615 (Ex 1), cheat sheet 1985 | fixed. One definition is used throughout: layer 1 is the lead-governed team image (OS, R, system libraries, and the packages every project in the lab uses, pinned by digest); layer 2 is the project lockfile, under the union model. This matches Ch 7 §'A first look' (05:1206-1234, team image with 'the lab's preferred packages' plus a thin per-project layer), so Ch 7 needs no change | I |
| Ex 1 two-version rule | 10:1647-1656 | fixed. Rewritten: an unusual version goes in that project's lockfile, which restores into the project library ahead of the image's copy. Within one project the union lockfile still records a single version | I; EK (project-library precedence over the image's site library) |
| Ex 3 `make render` | 10:1725-1729 | fixed. Now names `make docker-render` for an `.Rmd` report and states that there is no plain `make render` | I (Makefile targets grepped; matches 09:2082) |
| Ex 4 'recorded output hashes' as L3 | 10:1780-1788 | fixed. L3 evidence is now a baseline test that passes within a stated tolerance after a clean rebuild; text added on why a hash cannot express a tolerance. Also made L2 cumulative ('in addition') | I |
| NIH DMS Plan placement | 10:896-902 | fixed. The Plan goes in the 'Other Plan(s)' attachment; only a summary and the costs go in the budget and its justification. **New citation `@nihdmswriting`, bib entry below** | V (grants.nih.gov 'Writing a Data Management and Sharing Plan' page fetched 2026-11-08; quoted sentences confirmed) |
| Capture vs verification framing | 10:2052-2060 | fixed in Ch 13. Capture sets L0 to L2; L3 = a clean rebuild after which a baseline test passes within tolerance; `zzc verify` lifts to L3 only 'with such a baseline test in place' (MS). Check answer 10:1424 is now 'committed baseline within a stated tolerance'. The preface/index side of M6 belongs to other agents | I |
| Stack figure vs convention | 10:103-125; conventions:44-46 | fixed. Conventions now defines 'captures' as 'pins for the first time, or pins more tightly than an earlier chapter did', which is the definition already in `R/stack_diagram.R:45` roxygen. Ch 13's opening now says it fixes no new version but pins the input-data layer more tightly (Ch 5 captured it as locatable), so the figure's 'captured' mark agrees with the convention. Figure call and label unchanged | I |
| 'regression to L0' | 10:455-459 | fixed. The committed lockfile still holds L1, so the text now says the compendium 'has regressed below L2' | I |
| Dependence on optional SIF material (M12) | 10:45-51, 560-566 | fixed. The prerequisite names Ch 8 as optional and not required. The archiving section now explains the one `apptainer build ... docker://<image>@sha256:<digest>` command and offers `docker save` as the Docker-only route | I; EK (command semantics) |
| F36: conclusion 'only' vs 'also' (A1) | 10:2072-2076 | fixed. Restored to one three-item sentence | I |
| F36: four restricted-data routes collapsed (A2) | 10:738-749 | fixed. Now a four-item list, which the later 'four routes' references count correctly | I |
| F36: transition misstates preceding text (A9) | 10:888-891 | fixed. The added sentence is dropped; the paragraph opens 'Everything the four routes above implement...' | I |
| F36: four new 'Consider ...' openers (A4, A7, 337, 538) | 10:252, 353, 569, 2087 | fixed. All four restored to direct statements. 'Consider a concrete case' (156) predates the voice pass and is kept | V (grep) |
| F36: objectives mixed persons (A3) | 10:18-25 | fixed. Now 'you will be able to' throughout | I |
| F36: 'In conclusion,' under heading (A6) | 10:2032 | fixed | V (grep) |
| F36: LLM exchange mixes 'the analyst' and 'you' (A8) | 10:1482-1489 | fixed. The Verification paragraph is now imperative without 'you'/'yourself', matching the other two exchanges | I |
| F36: 'Unfortunately,' at 426 (A10) | 10:445 | fixed (removed). The second instance (A10, 1241) was already gone | V (grep) |
| F36: 'cheaper insurance' with gigabyte SIF (A11) | 10:1266-1269 | fixed. Now 'not free, but ... worth its size' | I |
| F41 'four of the ten determinants' / 'fonts and graphics device' | 10:1007-1016 | fixed. Count computed inline (`nrow(determinant_layers())` = 9); pinned and unpinned layers named from the stack. **Correction recorded:** 'By its own accounting ... ten' replaced with 'Measured against the 9 layers ... in @sec-levels' | V (inline evaluated) |
| F29 typed chunk numbers (m5) | 10:1166-1172 | fixed. 'three', 'two', 'three to five' computed from `added_sets` and `contributions$union_n` (3, 2, 3, 5). They render as digits | V |
| Outline order vs body (m3) | 10:82-87 | fixed (Tier 3, two-line swap) | I |
| Cheat sheet 'never shrinks' (m4) | 10:1986 | fixed. Now 'never shrinks unless deliberately pruned' | I |
| Setup: CRLF message | setup:98-103 | fixed. `exec format error` is replaced by `/bin/bash^M: bad interpreter: No such file or directory` (shell) and `no such file or directory` (runtime exec) | V for the bash message (ran a CRLF script on this Mac); EK for the container-runtime wording |
| Setup: `/mnt/c` duplication | setup:156 (table row) | fixed. The row now contrasts the Windows filesystem (`/mnt/c/...`) with WSL2's Linux filesystem (`/home/<user>/...`) | I |
| Setup: uncited '2026 expert review' (twice) | setup:3-11, 106-108 | fixed by removal. Both claims cite an internal simulated review; no bib entry is needed | V (grep '2026 expert' empty) |
| Setup: 'three machines' introduces four topics | setup:6 | fixed ('the machines') | I |
| Setup: garbled split (A12) | setup:15-25 | fixed. 'not an optimization but the only way'; 'That section of @sec-containers is worth reading before this one' | I |
| Setup: 'Unfortunately,' (A15) | setup:107 | fixed (removed) | V |
| Shell: zsh glob behavior | shell:258-275 | fixed. An unmatched glob is an error in zsh (`no matches found`) but is passed literally in bash; also covers an unquoted `--include=*.qmd` and the advice to quote | V (ran bash and zsh in an empty scratch directory) |
| Shell: `permission denied` is zsh's message | shell:226-234 | fixed. The transcript now shows bash's `bash: ./greet.sh: Permission denied`, with zsh's wording in a note | V (both run) |
| Shell: uncited '2026 syllabi comparison' | shell:3-9 | fixed by removal | V (grep) |
| Shell: 'That is,' (A16) | shell:138-141 | fixed (colon form) | V |
| Credits typo 'sequence house style' | credits:20 | fixed. Now 'the book's house style'. The intended word is unknown ('series'?); author to confirm | I |
| Conventions garbled split 30-32 (A13) | conventions:30-33 | fixed. Now 'names the earlier chapters and the statistical knowledge the chapter assumes' | I |
| Conventions 'We work two datasets' (A14) | conventions:125 | fixed ('We use') | I |
| Glossary: container image | glossary:101-106 | fixed. No longer says 'runs identically wherever a container runtime runs'. It now says the image fixes the files, not the machine (thread count and CPU vary), and that another architecture runs only under emulation, where numerical results can differ (consistent with the BLAS rule) | I |
| Glossary: capsule | glossary:510-517 (combined `rang`/`groundhog`/`capsule` entry, id unchanged) | fixed. Each tool is now described as in 04:1023-1063. `capsule` layers over `renv`, and only `rang` needs no prior lockfile | I |
| Glossary: controlled access | glossary:109-114 | fixed. 'releases them only to approved users under an agreement, rather than to anyone who downloads' | I |
| Glossary: merge commit | glossary:261-263 | fixed. 'a commit with more than one parent (usually two)' | EK |

## 2. Counts ('That is,' / 'Unfortunately,'), before -> after

| File | That is, | Unfortunately, |
|---|---|---|
| 10-archiving-sharing.qmd | 6 -> 0 | 1 -> 0 |
| setup-appendix.qmd | 0 -> 0 | 1 -> 0 |
| shell-primer.qmd | 1 -> 0 | 0 -> 0 |
| conventions.qmd | 0 -> 0 | 0 -> 0 |
| credits.qmd | 0 -> 0 | 0 -> 0 |
| glossary.qmd | 0 -> 0 | 0 -> 0 |

Before counts for the five non-chapter files come from the reader-E
report and my reading; I did not run grep before editing them. Ch 13's
before count is from grep. Every 'after' count is from grep. The dash
grep and the example-list grep are empty for all six files.

## 3. run_chapter.R

- `10-archiving-sharing.qmd`: baseline `errors 0 warnings 0` (11
  inline); final `errors 0 warnings 0` (16 inline). The new values
  read correctly in their sentences: 9; 3; 2; 3; 5.
- The other five files have no executed chunks and no inline R (grep
  for `{r` and `` `r `` returned 0), so run_chapter.R was not run on
  them.

## 4. For the lead

1. **Bib entry needed** (`references.bib`); Ch 13:902 cites it:

   ```bibtex
   @misc{nihdmswriting,
     author  = {{National Institutes of Health}},
     title   = {Writing a Data Management and Sharing Plan},
     url     = {https://grants.nih.gov/policy-and-compliance/policy-topics/sharing-policies/dms/writing-dms-plan},
     urldate = {2026-11-08}
   }
   ```

   Until it is added, the render will show an unresolved citation.
   No year is given on the page; add one if the house style requires
   it.
2. **Glossary 'Two-layer team model' (glossary:752-755)** is outside
   my four entries. It agrees with Ch 13 but is less specific. If the
   lead wants it aligned, append: 'The environment layer is the team
   image (the operating system, the R version, the system libraries,
   and the packages every project in the lab uses), pinned by digest;
   the package layer is the project lockfile.'
3. **Chapter 7** needs no change. Its §'A first look' already matches
   the chosen definition.
4. **Instructor-guide keys:** I found none made stale. The guide has
   no Ch 13 Ex 1, 3, or 4 key text matching 'make render', 'output
   hash', or 'two-layer' (grep). The Ex 7 key from Phase 19 is
   untouched.
5. **Cheat-sheet index** (`cheat-sheet-index.qmd:79`) says 'two-layer
   (environment/packages) model'. That is still compatible. Its other
   Ch 13 inaccuracies (groundhog, OSF, DataCite) belong to Phase 24.

## 5. Not done

- Preface and index side of the capture/verification framing (M6):
  those are not my files.
- Ch 13 Ex 7 solution 'available to course instructors' (M11): left
  for Phase 24, which removes the guide under D14.
- Tier 3 items left as they are: 'honest level' callout placement
  mid-chapter (m8); item 47b 'deposit example' ambiguity (10:1356);
  Ex 5 hard-coded `snapshot_date` (m7); `rang` 'recall' wording;
  Docker Hub 'as of' date (m16); Whole Tale status (m15);
  conventions 'not a compromise' (m14); setup item 31
  (`docker run`/`pull` emulates and warns, while BuildKit `build`
  fails).
- The 'pinned package is pulled from CRAN' conflict (m6, 10:1260) is
  also left unchanged.
- No trusted research environments, CONSORT/SPIRIT, git preflight, or
  regulated-sense glossary notes were added (out of scope by
  instruction).
- The final sentence of Ch 13 (2087-2091) is about 37 words, slightly
  over the 35-word guide. It restores the pre-voice-pass wording.
- The container-runtime CRLF message and the project-library
  precedence claim in the Ex 1 solution are EK, not run.
- The credits word was a guess at the intent. 'book's house style' is
  safe, but the author may have meant 'series'.
