# Fourth Review Plan
*2026-11-25 19:05 PST*

Implementation plan for the review-only fourth review. The findings
live in `docs/fourth-review/REVIEW.md` (IDs `R4-0xx` global,
`R<ch>-NN` by chapter, `R4-Vnn` Chapter 4, `RA-nn` appendices); the
prompt is `docs/fourth-review-prompt.md`; raw reviewer reports are in
`docs/fourth-review/raw/`. `THIRD-REVIEW-PLAN.md` remains the record
of reviews three and earlier.

## 1. Decisions

Recorded 2026-11-25 from the author's reply ('1. agree, 2. ok, 3 ok,
4 ok') to the four questions in REVIEW.md Section 6.

| ID | Decision | Supersedes or reopens |
|---|---|---|
| D26 | Audience: empirical researchers in any field who analyze data in R. Keep the health-science examples; add bridges (multi-field cases, a 'Translating the tools' appendix, Python and Stata boxes, a generalized restricted-data rule). The Welcome page and preface change; the title and subtitle remain the author's separate call. | Replaces the audience parameter in THIRD-REVIEW-PLAN Section 1 |
| D27 | Length: move most of Chapter 8 to an appendix (keep a 'When Docker is not an option' section in Chapter 7); cut about 3,000 words from Chapter 12 (capture matrix out, GitLab translation to an appendix); remove the repeated definitions across Chapters 1 to 3. | Reopens D18 and D10 |
| D28 | Add real cases from the REVIEW.md Section 5 bank, beginning with Duke (Baggerly and Coombes); make `targets` the core pipeline tool and Make the optional comparison. | Reopens A10 (under D18) and D3 |
| D29 | Implement D2 as decided: a boxed 'With zzcollab' track paired with 'By hand' blocks; tool vocabulary introduced in neutral terms first. The author's reply 'ok' to an either/or question is read as 'build D2 as decided'. | Confirms D2 |

## 2. Phases

Each phase on its own branch, stacked, verified by the tinytest suite
and a clean HTML and PDF render with the locked library, and committed
only with the author's approval. Tiers 2 and 3 renumber chapters or
move parts; each starts only after a checkpoint with the author.

| Phase | Branch | Content | Status |
|---|---|---|---|
| 26 | `phase-26-fourth-review-tier1` | Tier 1: correctness, safety, disclosure (REVIEW.md Section 6) | In progress |
| 27 | to be created | Tier 2a: persuasion (D28 cases, objections, mandates, 2026 studies) | Checkpoint first |
| 28 | to be created | Tier 2b: novice on-ramps (Welcome page per D26, primer, machine checklist, YAML, `docker run`, literate anatomy, first workflow, closing chapter) | Checkpoint first |
| 29 | to be created | Tier 3: structure (D27 moves and cuts, D29 track, D28 `targets` core) | Checkpoint first |
| 30 | to be created | Tier 4: currency and minor findings | After 29 |

## 3. Implementation record

### Phase 26, Tier 1 (`phase-26-fourth-review-tier1`)

Evidence labels: V = the lead ran it or opened the primary source;
I = the lead read the book or tool source.

| Finding | Change | Evidence |
|---|---|---|
| R13-01 | `.dockerignore` exercise premise now `**/*.csv`; solution explains root anchoring and the wider leak a bare `*.csv` causes; one body sentence on anchoring added near the deposit checks | I (Docker docs quoted by reviewer F) |
| R4-V03 | PHI rule: 'a local repository that is never pushed' | I |
| R4-V01 | Paragraph on private-by-default remotes and auditing the whole history before making a repository public | I |
| R4-V04 | `git filter-repo` install routes and the 2.47 requirement, checked by `-h` | I (GitHub docs quoted by reviewer B) |
| R4-005 | Preface disclosure that the authors write and maintain `zzcollab` and `zzrenvcheck`, with license and URLs; credits and two glossary entries updated | V: `gh repo view` (both public), `DESCRIPTION` License GPL (>= 3); neither repository has a LICENSE file, so GitHub shows no license |
| R7-02 | 'In essence the one shown earlier' replaced by the two differences (native arm64 on Apple Silicon; `OPENBLAS_NUM_THREADS` unset); the publishing switch noted as emulated amd64 | I: `modules/docker.sh:1413-1427` ignores `PLATFORM`, so no `PLATFORM=` override is printed; `docker.sh:1224` sets only `OMP_NUM_THREADS` |
| R8-01 | Binder `.binder/Dockerfile` block restored as A2-41 proposed (placeholder digest, as before) | I: `git show 343c589` |
| R4-016 | Glossary `digest()`, `docker pull`/`inspect`, and 'Tag and digest' aligned with Chapters 7 and 12 | I |
| R6-01 | Opening story rebased on `dplyr` 1.0.10 to 1.1.0, the C-locale ordering change; check answer updated | V: dplyr NEWS 1.1.0 'Breaking changes' |
| R6-02 | Both triad answers: only Code ⊆ DESCRIPTION is known to fail; check the lockfile with `renv::status()` | I |
| R11-01 | Wilson 2014 cited for testing; Wilson 2017's exclusion of unit tests stated and answered; further reading and Sandve description corrected | I (PLOS text quoted by reviewer E) |
| R11-02 | Lint step must set `LINTR_ERROR_ON_LINT`; two contradicting passages made conditional | V: `r-lib/actions` `examples/lint.yaml` sets `LINTR_ERROR_ON_LINT: true` |
| R5-02 | Worked example uses `zzc init --archetype analysis` then `zzc tidyverse`, and `make check-renv-no-fix`; one sentence on `make`; Chapter 13's CI shim uses `check-renv-no-fix` | I: `modules/help.sh:27-35`, `templates/Makefile:134-137` |
| R5-01 | States the tool's six archetypes and why the chapter teaches five | I: `modules/help.sh:28-29` |
| R5-03 | 'Seed determinism' renamed 'seeded baseline' in table, figure, alt text, solutions, and Chapter 12 | I |
| R12-05 | Exercise 5 seed claim carries the per-replicate-stream condition | I |
| R10-02 | `targets` claim limited to function dependencies loaded by `tar_source()` | I |
| R13-02 | Union model redefined as the union of packages the committed code uses; `snapshot.type('all')` named; glossary, table caption, exercise wording updated; paragraph on resolving `renv.lock` merge conflicts | V: renv `?settings` lists `settings$snapshot.type()` and `"all"` |
| R4-017 | Docker licensing paragraph states the 26 August 2026 agreement terms with a new bib entry `dockerssa2026`; Chapter 7 and the setup appendix point to it | V: agreement fetched by `curl`; Moby and Podman are Apache-2.0 (`gh api`) |
| R4-018 | Rocker architecture claim scoped to 4.4.0, with the 4.6.x state dated and a check command; setup appendix and cheat sheet aligned | V: Docker Hub tags API (tidyverse 4.6.1, 4.6.2 amd64+arm64; verse amd64 only) |
| R2-03 | Begley and Ellis: 'confirmed', selection and non-disclosure caveat; Errington et al. 2021 added (`errington2021`) with the abstract's figures | V: Crossref record and abstract |

Not done in this phase: every Tier 2, 3, and 4 item; R7-02's tool
fix and the other `zzcollab` tool issues (outside this repository);
the instructor guide needed no change (grep found no affected answer).

Verification (V): tinytest 441/441 after the edits (441/441 before).
Full HTML and PDF render with the locked package versions first on
the library path (nine packages rebuilt at their `renv.lock`
versions; host R 4.6.2 against a locked 4.6.1): exit 0, no warnings
in the log, no `quarto-unresolved-ref`, `citation-missing`,
`class="example"`, or `href="@` in `_book/*.html`, no literal HTML
entities in the PDF text. PDF 674 pages (670 before). A first render
showed the new Docker citation as 'n.d.'; a `year` field fixed it.
Committed as `ebc8c5b`.

### Phase 27, Tier 2a persuasion (`phase-27-persuasion`)

Additive only; the moves and cuts of R4-002 and R2-05 wait for
Phase 29 (D27). Every new fact was checked by the lead against the
source named; nothing about a case goes beyond what was opened.

| Finding | Change | Evidence |
|---|---|---|
| R4-001 | Case box device added to Conventions. Four case boxes: Duke signatures (Ch 1, Intro); the JAMA COPD trial, Glatard's operating systems, and Reinhart and Rogoff (Ch 2) | V: Baggerly and Coombes abstract (Semantic Scholar); both Aboumatar abstracts (Europe PMC) show identical event rates with the arms exchanged; the retraction-and-republication link from Europe PMC; Glatard abstract (Europe PMC); Herndon, Ash, and Pollin working paper (PERI WP322, 2013, read in full for the figures used). Not opened: the JAMA notices (publisher returned 403), so the box states the reversal and frames its cause as an inference; the Duke box ends in 2009 and names no investigators beyond the two authors |
| R4-007 | New section 'Four objections, and what the evidence says' (`sec-four-objections`), a 'what this buys you' paragraph, and a 'Making the case to your lab' callout; Exercise 9 (memo to a supervisor) with solution and instructor-guide rubric | I; no time costs are stated, since none is sourced |
| R4-008 | `tbl-mandates`: NIH DMS, 2024 NIH Public Access Policy, OSTP 2022 memo, PLOS Computational Biology, AEA journals, dated 25 November 2026; the preface's uncited claim now points to it | V: NOT-OD-21-013, NOT-OD-25-101, and NOT-OD-25-047 text; OSTP memo PDF; PLOS and AEA policy pages, all fetched 2026-11-25. The OSTP repeal report was not verified and is not stated |
| R2-02 | SCORE (Tyner et al. 2026) beside the Open Science Collaboration; Brodeur et al. 2026 and Naudet et al. 2018 after the re-execution studies | V: Crossref and Europe PMC abstracts. Brodeur's 'highly selective' caveat rests on reviewer H's reading of the article PDF |
| R1-01 | Ch 1 claim broadened to 'in the health sciences and well beyond them'; Ch 2 objective no longer says 'health-sciences' | I |
| R1-07 | Ch 1 opening: 'Many quantitative researchers eventually meet' | I |

New bibliography entries (from Crossref): `baggerly2009`,
`aboumatar2018`, `aboumatar2019`, `bauchner2019`, `herndon2014`,
`glatard2015`, `brodeur2026`, `tyner2026`, `naudet2018`, and four
policy entries (`ostp2022`, `nihnot25101`, `ploscbcode`,
`aeadatacode`).

Chapter 2's reading time rises from 35 to 45 minutes under the
book's rule (the drift test required the change).

Verification (V): tinytest 442/442 (one new invariant check, for the
new exercise's solution). Locked-library render: exit 0, no warnings,
no unresolved references or missing citations in the HTML, no literal
entities in the PDF; all four case boxes and `tbl-mandates` present.
PDF 682 pages (674 before, +8). New prose checked against the voice
brief: no sentence over 35 words, mean about 20. The existing 'n.d.'
citations in the PDF belong to undated web pages already in the
bibliography; every new entry carries a year.
