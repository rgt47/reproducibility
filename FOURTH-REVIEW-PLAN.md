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

Recorded 2026-11-26 at the Phase 29 checkpoint (AskUserQuestion):

| ID | Decision |
|---|---|
| D30 | Chapter 8 (Backends and Runtimes) moves to the appendices as 'Alternative runtimes and backends'; Ch 7 gains a short 'When Docker is not an option' section; Chapters 9 to 14 become 8 to 13. |
| D31 | The Shell Primer and Setup Appendix move into an unnumbered 'Getting set up' part placed just before Version Control, with pointers kept in the appendices. Chapter numbers do not change because of it. |
| D32 | Front matter: drop the PDF lists of figures and tables, place Conventions after the Introduction, and remove the duplicate License section from the Welcome page. Chapter 2's apparatus is not reordered. |

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
Committed as `b62183e`.

### Phase 28, Tier 2b novice on-ramps (`phase-28-onramps`)

Three agents drafted disjoint files under a shared brief
(`docs/fourth-review/phase28/BRIEF.md`; reports P, L, C in the same
directory); the lead wrote the Chapter 7 section, the closing
chapter, the Welcome page, the shared files, and the links. The
brief wrongly said `@sec-shell` was a valid target; the manuscript
test rejects every `@sec-` link to an unnumbered page, so all such
links are plain file links.

| Finding | Change | Evidence |
|---|---|---|
| R4-003 | Welcome page: reader stated per D26 (first-year graduate student, any empirical field, R from one course; no terminal, git, Docker, YAML, CI, or Quarto assumed); points to the primer and the setup checklist; `zzcollab` authorship noted | I |
| R4-004 | Primer: 'Opening a terminal' (macOS, Windows via WSL2 or Git Bash, RStudio and Positron), 'Getting unstuck' table, `mkdir`, `cat`/`less`, quoting, `~`; false opening sentence fixed; typed chapter numbers replaced; 'child shell' corrected; three checks and one exercise. Links to the primer from the prerequisites of Ch 4, 5, 7, 9, 10 | V (agent P ran the commands in bash and zsh; report P). Windows, RStudio, and Positron steps from official docs, untested |
| R4-014 | Primer 'Reading YAML' section; glossary entry; Ch 12 links to it | V: `yaml::yaml.load` on the example and on mis-indented and tab variants (report P) |
| R4-013 | Setup appendix opens with an eight-row machine checklist with check commands; anchors for its Docker sections | V: each check command run on this Mac; install URLs resolved (report P). RStudio not installed here; make on Windows untested |
| R7-01 | Ch 7 'Running the analysis inside the image' (`sec-docker-run`): build, `docker run --rm --platform -v -w`, output on the host, the image-only listing, a Pitfall for a mounted `renv` `.Rprofile`, a check | V: the showcase Dockerfile extracted from the chapter and built with `--platform linux/amd64` (Docker Desktop, Apple Silicon, 2026-11-25); five runs recorded in the scratchpad. The mounted `renv` activation failed with 'there is no package called jsonlite' after bootstrapping `renv` into the host project; `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE` and `Rscript --vanilla` each fixed it |
| R9-01 | Ch 9 'Anatomy of a literate document': a minimal `.qmd` displayed literally, three ways to render | V: rendered with Quarto 1.11.9 in a scratch directory; the book's display checked by a scratch render (report L). `quarto::quarto_render()` not run (package not installed) |
| R4-V02, R4-V12 | Ch 4 'Joining an existing project' (clone, pull, upstream, fetch, pull request); Exercise 5 solution corrected (`--no-track` and `git push -u origin`), since the old form set the branch to push to the lab's `main`; empty private repository and token note before the first push | V: every git command run against local bare repositories (report L); `gh` lines untested, cited |
| R12-01, R12-08 | Ch 12 'Your first workflow' (24-line workflow, where it goes, the Actions tab, the failed-step log, the fail-once habit) and a six-row 'Reading the workflow' table; prerequisite corrected; card 70 to 80 minutes | V: test script exits 1 on a failing test in a scratch package; workflow parsed by `yaml`; mis-indented copy's parser error recorded (report C). GitHub's own messages untested; status-checks sentence cited to GitHub docs |
| R4-012 | New closing chapter `11-closing.qmd` ('Where to Begin', Ch 14): the four-point conclusion moved from Ch 13 (only the `zzc verify` sentence reworded tool-neutrally), a staged plan, a one-page brief for a supervisor, advice for labs that do not yet work this way, and the habits; Ch 13 now points to it; contents, core-path table, preface count, and intro plan updated | I (diff of the moved text against `b62183e`) |

New bibliography entries: five GitHub documentation pages (URLs
checked, HTTP 200). New glossary entries: YAML, upstream (remote).

Verification (V): tinytest 452/452. Locked-library render: exit 0,
no warnings, no unresolved references or missing citations in the
HTML, no literal entities in the PDF. The Ch 9 listing prints
literally in the PDF (`pdftotext -layout`: header dashes, fenced
chunk, `#|` lines, and the inline expression). PDF 706 pages (682
before, +24); the closing chapter is Ch 14 in the TOC.

Not done in this phase (still open from Tier 2): R10-03 starter
project for the pipeline exercises; 'Before you run this' boxes for
`make` and `pre-commit` (Ch 10, 11); the Ch 8 Apptainer note; R12-08's
nested-quoting row. The primer and setup appendix stay in the
appendices until Phase 29 moves them (D27 scope).
Committed as `27d3449`.

### Phase 29, structure (`phase-29-structure`)

Moves only (D30 to D32); no prose was cut, so the moves can be
checked against `27d3449`. The Ch 12 cuts, the D29 zzcollab boxes,
the D28 `targets` switch, and the Ch 1 to 3 dedupe follow in a later
phase. **`REVIEW.md` and the raw reports use the old chapter
numbers**: old Ch 8 is now Appendix A, and old Ch 9 to 14 are now
Ch 8 to 13.

| Decision | Change | Evidence |
|---|---|---|
| D30 | `06-backends-runtimes.qmd` listed under `appendices` (Appendix A), id `sec-backends` kept; its 16 self-references now say 'this appendix'. Ch 7 gains 'When Docker is not an option' (`sec-docker-alternatives`); the Docker Desktop licensing paragraph moved there from the appendix, which keeps a one-sentence pointer; Ch 7 and the setup appendix point to the new section. Ch 9's opening check (R9-02) no longer needs the appendix: recast around a home-directory mount | V: the recast scenario run in the showcase image (home mounted at `/root`: `Rounding` sampler and different draws; `Rscript --vanilla`: default draws) |
| D31 | Shell Primer and Setup Appendix form Part II, 'Getting Set Up', before Part III, 'Organizing the Work' (Version Control, The Research Compendium); Part I, 'Foundations', now holds Ch 2 and 3. Intro, preface, and core-path table updated | V: PDF TOC |
| D32 | `\listoffigures` and `\listoftables` removed from `copyright.qmd` (TOC kept); Conventions follows the Introduction; the Welcome page's License section replaced by a pointer to the Copyright page | V: render |
| Renumbering | Three typed chapter numbers removed from prose; the instructor guide's headings, week table, and prose renumbered, and its quiz-chapter list now derived from `_quarto.yml` instead of typed | V: the derivation run on its own; the guide rendered (exit 0, no warnings) and lists Ch 2 to 12 |

Verification (V): tinytest 452/452 (Ch 7 card 55 to 65 minutes, by
the rule, after the new sections). The frozen `cheat-sheet-index`
and `colophon` outputs were cleared so they re-executed. Render:
exit 0, no warnings, no unresolved references or missing citations;
no duplicate `sec-`, `tbl-`, or `fig-` ids. PDF TOC: Chapters 1 to
13 in six parts, Appendix A. PDF 700 pages (706 before). The first
case box now falls on PDF page 24; under R4-002 the first real
number was on page 41.

The setup page is retitled 'Setting Up Your Machine' (formerly
'Setup Appendix: Docker and Git on Your Own Machine'), since it now
sits in Part II and covers every tool; prose and link text say 'the
setup page'. File name and anchors are unchanged.
Committed as `fd068d4`.

### Phase 30, cuts and tracks (`phase-30-cuts-and-tracks`)

Four agents on disjoint files under `docs/fourth-review/phase30/BRIEF.md`
(reports X, Y, Z1, Z2 there); the lead did the shared files, the
Ch 1 dedupe, the glossary, and the boxes in files no agent owned.
Chapter numbers below are the new ones.

| Decision or finding | Change | Evidence |
|---|---|---|
| D29, R4-006 | 'With zzcollab' box defined in Conventions. Every `zzc` and `make <target>` command moved into boxes in Ch 3, 5, 6, 7, 8, 10, 11, 12 and the new forges appendix; tool vocabulary introduced in neutral words first; glossary entries for archetype, profile, progressive disclosure, the Five Pillars, and the baseline-file naming marked as zzcollab terms. Cheat-sheet rows that name a tool command are labeled '(zzcollab)'; one attribution remains in the closing chapter's prose | V: box-aware scan of all `.qmd` files finds no tool command outside a box except those labels |
| R4-006 by hand | Ch 5 worked example gains a by-hand path (`usethis`, `mkdir`, `devtools::check()`, `R CMD check`); Ch 7's worked example uses the plain `docker build` and `docker run` of `sec-docker-run`; 'Profiles as base images' is now 'Choosing a base image' | V: report Z1, run in a scratch directory under R 4.6.2 (both checks 'Status: OK') |
| Tool corrections | `zzc publishing` does not switch an existing project (uses `zzc docker --profile`); the Phase 26 `zzc init` then `zzc tidyverse` sequence replaced by `zzc init --archetype analysis`, `zzc renv`, `zzc docker --profile tidyverse` | I: zzcollab source lines in report Z1; no `zzc` command was run |
| R6-03, R6-04 | Ch 6 teaches `renv::status()` first, with a CI line that fails on drift; the condition that the project use renv's implicit snapshot type is stated; `zzrenvcheck` and the auto-snapshot hook boxed | V: report Z2 (scratch renv projects: `renv::status()` alone exits 0; the `$synchronized` line exits 1 on drift; under the explicit snapshot type the gate missed drift) |
| R11-06 | Ch 10 shows `styler`, `lintr` (with `LINTR_ERROR_ON_LINT`), and a test run that fails on a failing test, before the boxed make targets | V: report Z2 (lint step exited 31 on lints, 0 clean; bare `run_test_dir()` exits 0 on failure, the added `all_pass()` check exits 1) |
| R13-10 | Ch 12: the vignette cited by a commit-pinned URL with its unmeasured timings dropped; the 'system review' quotation removed (no such document exists) | V: report Z2 (`gh api`) |
| D27, R12-03 | Ch 11 (CI) cut from 18,573 to 15,895 words: capture test matrix removed; GitLab and presence-driven material moved to a new appendix `ci-other-forges.qmd` (`sec-ci-other-forges`, 1,672 words); repeated capture-versus-validation statements reduced; Exercise 3 solution essay cut; old Exercise 4 moved to the appendix, and the remaining exercises reordered so that Exercise 7 stays the cohort exercise the instructor guide keys | V: report X (`yaml` parses every block; `ci/dependency-gate.R` exits 0 then 1 on an unrecorded package in a scratch project) |
| R12-02 | Gate 2 of the main and faded workflows runs `Rscript ci/dependency-gate.R`; `zzrenvcheck` only in boxes | V: report X |
| R12-06 | Debugging sequence now starts with the failing step's log and bisects last | I |
| D28, R10-01, R10-09 | Ch 9: `targets` first and core, Make after it as 'GNU Make, for comparison (optional)'; other optional sections marked; exercises made consistent; the 'captures no determinant' claim stated once; title now 'Automating the Analysis: targets and Make' (book, Conventions, intro, preface, instructor guide) | V: report Y (every `targets` block run with targets 1.12.1 in a scratch library; three errors found and fixed: a fragment that failed with 'cohort_path not found', missing outdated targets in a solution, and `tar_visnetwork()` needing `visNetwork`) |
| R2-05 | Ch 1's definitions and its R-defaults and stack passages condensed to pointers to Ch 2 and 3 (about 330 words); Ch 2's apparatus untouched per D32 | I: Exercise 8 of Ch 2 still finds its premise in Ch 1 |

Word count: Ch 11 down 2,678; Ch 9 up 99; the boxes and by-hand
paths add about 1,300 words across Ch 5, 6, 7, 10, 12; the new
appendix holds the 1,672 words moved out of Ch 11.

Open for the author: `targets` is not in `renv.lock`, but Ch 9's
Exercise 7 has readers run it in the book's own clone (report Y
proposes adding it to the lockfile or using a scratch project).
Tool issues found (zzcollab and zzrenvcheck, outside this
repository): `zzrenvcheck` 0.10.0 exits 0 when `DESCRIPTION` is
missing; it misreports `here` as declared; its advice relies on the
auto-snapshot `make r` disables; the `CITATION.cff` template claims
'Contains all data'; `help.sh` says a profile command switches an
existing project, which it does not; a failed base-image pull leaves
a tag-only `FROM` line.

Verification (V): tinytest 456/456. A first render failed in Ch 10
(a prose code span beginning `` `r `` was executed as inline R) while
the render wrapper reported success; the span was reworded and the
wrapper now exits with Quarto's status. The second render: logged exit
0, no warnings, no unresolved references or missing citations, no
literal entities in the PDF. TOC: Ch 9 'targets and Make'; Appendix A
backends, Appendix B other forges. PDF 708 pages (700 before). The
instructor guide renders (exit 0).
Committed as `e73c46e`.

### Phase 31, currency and remaining findings (`phase-31-currency-minor`)

Six agents (A to F) on disjoint file groups under
`docs/fourth-review/phase31/BRIEF.md`; each report there has one row
per finding ID with what was run and every source opened on
2026-11-26. The lead merged the shared files.

**Agents' scope and status** (details and evidence in the reports):

| Agent | Files | Findings | Status |
|---|---|---|---|
| A | Ch 1 to 3, `_llm-rule.qmd` | R1-02 to R1-07, R2-01, R2-04, R2-06 to R2-11, R3-01, R3-02, R4-010, R4-009 (Ch 2 sentence) | Done; R2-04 move proposed only; R2-06 and R2-10 rest on sources that were paywalled or refused (Baker, ACM) |
| B | Ch 4, Ch 5 | R4-V05 to V11, V13, R5-04 to R5-10 | Done; R4-V08 table row and R5-09 by the lead or author |
| C | Ch 6, Ch 7 | R6-05 to R6-10, R7-03 to R7-14, R4-011 item 4 | Done; chapters grew (+361, +1,222 words) despite about 750 words cut |
| D | Ch 8, Appendix A, new Appendix C | R9-03 to R9-11, R8-02 to R8-05, R8-07 to R8-12, R4-009 | Done; R8-07 and R8-08 corrected from the review's wording after checking |
| E | Ch 9, Ch 10, `analysis/exercises/pipeline-start/` | R10-03, R10-07, R10-10, R11-03, R11-04, R11-07 to R11-13, R4-013 | Mostly done; exercise grading and testing Exercise 4 not done; pre-commit steps untested |
| F | Ch 11, Ch 12, Appendix B | R12-04, R12-07 to R12-12, R4-008 (Ch 12), R13-04 to R13-09, R13-11, R4-010 | Done; openICPSR page refused, so no discipline-repository row |

**Lead, shared files:** `apa.csl` committed and `_quarto.yml` points
to it (RA-08); `translating-tools.qmd` added as Appendix C; the
cheat-sheet index now reads the appendices, filters generic labels,
and points to the primer and setup page (RA-07; it had silently
dropped the backends appendix after Phase 29); glossary: capture,
validation, recipe (RA-11, R4-020), new CRAN, Dockerfile,
environment variable, kernel entries, Daemon and Podman corrected
(R8-02); bibliography: 17 entries from agent F (URLs checked;
Zenodo's page refuses automated requests), `pimentel2019` and the
`saju2025` proceedings version from the publisher, tinytest 1.4.3,
`githublargefiles` date; setup page: push-protection row (R4-V08) and
an emulated-build symptom row (R7-06); Conventions: MCSE marked
optional; `test-cohort.R` gains the missing-age bound the chapter's
listing shows (R11-12).

**Incident.** Agent C ran `docker image prune -f` while documenting
disk housekeeping, which deleted one untagged image on the author's
machine (an old ClickHouse image, about 997 MB). No tagged image or
volume was touched. The other agents were stopped from running any
destructive Docker command for the rest of the phase. Agent B
overwrote the lead's render script in the scratchpad by reusing its
file name; the lead's script was recreated under a distinct name.

**For the author:** R5-09 (Ch 5's de-identified study examples: cite
if they are the author's work); `targets` not in `renv.lock` (Ch 9
exercises); `R/cohort.R` names the logistic model
`run_primary_analysis()` while Ch 10 calls the Cox model canonical;
proposed moves of `sec-llm-delegate` and `sec-llm-disclosure` out
of Ch 2 (agent A's report lists the 17 references).

Verification (V): tinytest 458/458 (two new results: the missing-age
bound in `test-cohort.R` and one new check's answer). Full render:
logged exit 0, no warnings, no unresolved references or missing
citations, no literal entities in the PDF; TOC shows Appendices A
(backends), B (other forges), C (translating the tools). PDF 738
pages (708 before, +30). Instructor guide renders (exit 0). No
citation key is missing from `references.bib`.
Committed as `ab65524`; Phases 26 to 31 fast-forwarded into `main`
and pushed on 2026-11-26 (CI render and deploy succeeded).

### Phase 32, author decisions (`phase-32-author-decisions`)

Decisions recorded 2026-11-26 (AskUserQuestion):

| ID | Decision | Change |
|---|---|---|
| D33 | Ch 5's project-type examples stay hypothetical | One sentence states that every example in the walkthrough is hypothetical; the manuscript example is framed 'Suppose, for example' |
| D34 | `targets` exercises run outside the book's clone | Ch 9 Exercise 7 keeps its `nrow()` part in the clone (the instructor guide keys it) and moves the `_targets.R` part into a copy of the starter project, so `targets` enters that project's lockfile, not the book's |
| D35 | Rename the logistic driver | `run_primary_analysis()` is now `run_logistic_analysis()`; its documentation no longer claims to be the baseline-checked analysis (the Cox model of `fit_cox()` is); `NAMESPACE` and `man/` regenerated; `test-cohort.R` updated |
| D36 | Move Ch 2's agent-governance subsections to an appendix | 'What to delegate to a coding agent' and 'Disclosing and recording model use' moved verbatim (666 words) to new Appendix D, 'Working with Coding Agents' (`coding-agents.qmd`, `sec-coding-agents`), anchors kept so all 16 references resolve; Ch 2 keeps a pointer paragraph |

Verification (V): tinytest 461/461. Render: logged exit 0, no
warnings, no unresolved references or missing citations; TOC shows
Appendix D. PDF 740 pages (738 before). Instructor guide renders
(exit 0).

### Tool issues closed (2026-11-27)

The tool issues recorded above (Phase 26: R7-02's platform and
`OPENBLAS_NUM_THREADS` gaps; Phase 30: the zzrenvcheck 0.10.0 gate
that exits 0 without `DESCRIPTION`, the mislabeled lockfile warning,
the auto-snapshot advice, the `CITATION.cff` abstract, the profile
help, the tag-only `FROM` fallback) are fixed in `zzcollab` 0.4.1 and
`zzrenvcheck` 0.11.1 (both tagged 2026-11-27). The plan and the
evidence are in `docs/fourth-review/TOOL-FIX-PLAN.md`, Phases T-A to
T-D. The 'With zzcollab' boxes now describe those versions; the
Conventions box names them.
