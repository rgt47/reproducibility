# Third review: *Reproducible Research for the Health Sciences*
*2026-11-07 11:11 PST*

This document records the third review of the book. The first
(2026-09-07, a mechanical scan) and the second (2026-10-10, a full
reading with expert personas and a coverage sweep) are recorded in
`REFACTOR-PLAN.md`, Sections 1 to 8 and Section 10, together with
the implementation of Phases 0 to 18. Finding, phase, and decision
numbers continue from that document: findings from 29, phases from
19, decisions from D13.

## Status

Stage 1 (audit) and Stage 2 (plan) complete on 2026-11-07; all
twelve decisions are recorded in Section 11a. Stage 3 begins with
Phase 19. No chapter had been edited in this review at the time the
plan was written.

## Document map

1. Parameters. 2. Evidence labels and method. 3. Stage 1 inputs.
4. Executive summary. 5. Findings 29 to 45. 6. Correctness register.
7. Topic additions. 8. House rules and render checks.
9. Phases 19 to 25. 10. What not to do. 11. Decisions D13 to D24.
12. Limitations. The agents' reports are in `docs/third-review/`;
every finding below cites them by file name.

## 1. Parameters

Decided by the author on 2026-11-06 and 2026-11-07.

| Parameter | Choice |
|---|---|
| Scope | Audit, plan, and implement, with checkpoints |
| Text basis | Branch `voice-rewrite`: humanizer pass `ee7a639` and voice pass `d786c6b`, committed before the audit; the review doubles as the meaning-preservation check on the voice pass |
| Primary audience | MS and PhD students in the health sciences (biostatistics, epidemiology, public health) who know R and basic git (unchanged from 10.1) |
| Course format | One 10-week quarter (unchanged) |
| R library for renders | `renv.lock` restored: locked versions first on the library path (scratchpad library plus host copies verified to match all 59 locked versions); host R 4.6.0 against a locked R 4.6.1 |
| Expert personas | Academic biostatistician directing an MS program; pharmaceutical statistical programmer; research software engineer (same as 10.1) |
| Model book | *Happy Git and GitHub for the useR*, Bryan |
| Running example | The existing simulated cohort (`analysis/scripts/simulate_cohort.R`, `inst/baseline/`) |
| Learning-science survey and coverage sweep | Full rerun, not reused from 10-10 |
| Plan file | This separate file, linked from `REFACTOR-PLAN.md` Section 0 |

## 2. Evidence labels and method

The labels of `REFACTOR-PLAN.md` 10.3 are retained: [V] verified by
the lead (ran it); [I] inspected by the lead (read the source);
[A-V] an agent ran it; [A-I] an agent read the source; [EK] expert
knowledge, not checked; [U] unverified, source could not be opened.

Fourteen agents worked from shared briefs: five readers (A to E,
covering every file), three personas, an LLM-section reviewer, a
model-book reviewer, a learning-science researcher, and three
coverage researchers. All were read-only. Each reader first checked
the voice pass for meaning preservation (`git diff --word-diff
ee7a639 d786c6b`), then reviewed the chapters. The lead re-ran or
re-read the most consequential claims before accepting them; those
are marked [V] or [I] below, and everything else carries the
agent's label.

## 3. Stage 1 inputs

1. A first render with the host library failed at
   `04-dependencies.qmd:1148-1159` (chunk `tbl-cohort-deps`): there
   is no package called 'renv' on the host [V]. The same log shows
   14 R warnings in `03-research-compendium.qmd` [V].
2. `renv::dependencies()` over `analysis/report`, `R`,
   `analysis/scripts`, and `inst/tinytest` finds 11 distinct non-base
   packages; all are locked except the project package itself [V].
3. A second render, with the locked versions first on the library
   path, completed on 2026-11-07 for HTML and PDF with exit 0. Every
   changed chapter re-executed under `freeze: auto`. The log has no
   warnings; no HTML page contains `quarto-unresolved-ref` or
   `citation-missing`; the PDF text has no literal HTML entities.
   Dashes occur only in bibliography page ranges, published titles,
   and two computed outputs (a numeric confidence interval and an
   empty table cell) [V]. The PDF is 600 pages, against 598 after
   Phase 12, so the voice pass changed length by under 1 percent;
   it remains 51 percent longer than the 398 pages the second
   review already judged too long for one quarter (Finding 21) [V].
4. The render passed the second review's cleanliness criteria and
   was nonetheless broken in two ways those criteria cannot see. All
   12 links in `cheat-sheet-index.html` are literal
   `href="@sec-cheat-..."` [V]. Three chapter pages contain an
   accidental Pandoc example list (`<ol class="example">`) that
   swallows a cross-reference, at `01-reproducibility-crisis.qmd:275`,
   `03-research-compendium.qmd:487`, and `version-control.qmd:1932`;
   all three were introduced by the prose passes' rewrapping, which
   put `@sec-label.` at the start of a line inside a list item [V,
   compared with `f27c280`]. Section 8 adds both to the render checks.
5. Structural scan [V, by script]: 134,431 prose words in 13
   chapters (7,652 to 13,480 each); 62 executed chunks against 151
   display-only; 21 figures, all with alt text; 34 tables; 415
   callouts (28 to 39 per content chapter); 97 exercises, each with a
   solution; 128 checks. Prose words per figure or table range from
   1,613 (Chapter 5) to 3,996 (Chapter 13). The longest unbroken
   prose run is 1,515 words (Chapter 5).
6. Quotation inventory (`docs/third-review/quotations.md`): 13
   epigraphs and 6 cited inline quotations, for Phase 25.
7. The humanizer and voice passes flagged 53 suspected factual and
   consistency issues (`docs/third-review/factual-issues.md`). The
   readers and personas confirmed most of them. Item 8 was withdrawn
   by the lead (the hard-coded chapter numbers are correct); item 31
   was narrowed (true for the pinned 4.4.0 tags, not for
   `rocker/r-ver`); the second half of item 51 was refuted; and a few
   parts could not be settled (the `restore()` refusal in item 50,
   item 47b, and item 43 for one persona). Each report tabulates its
   own verdicts; no combined count was computed.

## 4. Executive summary

The book's organizing ideas again drew unprompted praise from every
reviewer: the ladder, capture versus validation, the oracle
principle, the baseline test with a stated tolerance, and the
pinning recipe that was actually built and tested. All three
personas returned 'adopt with revisions'. The problems are of four
kinds.

1. **The book misdescribes its own repository.** At least eight
   chapters and the instructor guide state, in typed prose, a state
   the repository left a month ago: no `renv.lock` (it has been
   tracked since 5a99aa9), the cohort CSV committed (it has been
   gitignored since 786a7fc), the raw-data directory ignored (only
   one filename is), no copy of the extract tracked (a byte-identical
   copy is tracked at `inst/testdata/`). A fresh render already
   prints `renv.lock TRUE` beneath prose that says the file is absent
   (Finding 29).
2. **Several claims fail when run.** The Cox unit test the testing
   chapter prints fails on the book's own cohort; Chapter 12's
   autogradable Exercise 7 has the wrong answer; renv does detect
   `pacman::p_load()`; the showcase digest is a multi-architecture
   index, so 'one byte-identical filesystem' is false for a mixed
   Mac and Intel lab; stock git creates `master`, so the worked
   example's first push fails; Apptainer `--cleanenv` leaves the home
   directory mounted (Findings 30, 32).
3. **The guidance on restricted data has three critical gaps.** The
   LLM rule in all twelve chapters treats institutional approval of
   an endpoint as sufficient for data held under a data use
   agreement, which NIH's notice NOT-OD-25-081 contradicts; the
   archiving chapter and its rubric treat a one-file `.gitignore`
   entry as protecting a directory; the PHI history-rewrite recipe
   carries no warning that in a regulated repository it destroys
   records 21 CFR 11.10(e) says must persist (Finding 31).
4. **Fixes recorded as done in the second review were not all
   applied,** and one recorded correction was itself wrong
   (`actions/checkout` v7 does exist). The implementation record is
   therefore not a reliable statement of the text's state (Finding
   33).

The voice pass preserved meaning almost everywhere. The readers
found about 25 local defects (garbled splits, mixed persons, one
ambiguous PHI sentence, a roadmap that misorders its chapter) and a
set of new connective tics, chiefly 'That is,' (0 to 59 uses), a
template 'Unfortunately,' in nearly every chapter, and 'therefore'
roughly doubling (Finding 36). These are cheap to fix.

## 5. Findings

Each finding cites the reports in `docs/third-review/` (A to E for
the readers; MS, Pharma, RSE for the personas; LLM; Model).

### Finding 29. The book misdescribes its own repository (critical in aggregate)

Typed prose states a repository state that no longer holds, in
chapters 3, 4, 5, 6, 7, 8, 10, 13, the colophon, and the instructor
guide (A, B, C, E, MS, Pharma, RSE).

- `renv.lock` is tracked [V], yet 02-levels:922-924,
  03-research-compendium:1206-1251 and Exercise 8, 04:1141-1175,
  05:1323-1331, 06:757-793 and Exercise 7, pipelines:1281, 1306, and
  colophon:67-68 say it is absent and place the compendium at L0. The
  chunks are right; the next render already prints `TRUE` beneath
  them [V, freeze comparison]. The compendium is at L1.
- `cohort_raw.csv` is gitignored (`.gitignore:37`, Decision D7)
  [V], yet version-control:857-867, its honest-level callout
  (1357-1359), and Exercise 7 say it is committed on purpose (A).
- Only that one filename is ignored [V: `git check-ignore`]; any
  other file in `raw_data/` would be committed. 10:1235-1244 says the
  directory is excluded, and the instructor key (instructor-guide:
  337-352) lists the correct answer, 'this must change for real
  data', as a common error (E). Tier 1.
- `inst/testdata/cohort_raw.csv` is tracked and byte-identical to
  the gitignored extract, identifier columns included [V, MD5].
  The data are synthetic, so nothing has leaked, but the book
  teaches that the file must never be committed and ships it.
- No `Dockerfile` or `.dockerignore` exists, which 10's cohort
  section does not check (E). `CITATION.cff` declares the software
  CC-BY-NC-SA while `LICENSE` and `DESCRIPTION` say CC0, and the
  chapter tells readers Zenodo pre-fills deposits from that file (E).
- Four instructor-guide keys are now wrong: Ch 5 pillar sum 2 not 1,
  Ch 6 five packages not three, Ch 8 `renv.lock` TRUE, Ch 12
  `missing` length 2 not 0 (E [A-V]).

Root cause: the book teaches that numbers in prose must be computed,
but its statements about its own repository are typed. Remedy:
compute them (inline R over the existing chunks), narrate the
compendium climbing the ladder (Decision D13), and generate the
instructor keys from executed chunks.

### Finding 30. The central pinning claim is wrong for multi-architecture images (critical)

The showcase base digest `rocker/r-ver:4.4.0@sha256:73adab...` is an
OCI image index with separate `linux/amd64` and `linux/arm64`
manifests [V, `docker buildx imagetools inspect`]. The text says a
digest 'names one specific, byte-identical filesystem for one
specific platform' and that a pinned team image means 'every member
pulls byte-identical bytes' (05:254-256, 570-575, 600-602,
1182-1185, 1818). The showcase Dockerfile builds natively on arm64
with no `--platform` flag [A-V, RSE], contradicting 05:535-538 and
setup-appendix:160, and zzcollab builds arm64 on a Mac by default
[A-I, RSE]. A Mac student and an Intel labmate therefore build
different images from the 'same' digest, and a Mac-built image
pushed to a registry will not run on an x86 cluster. The Apple
Silicon section is also out of sequence (it cites pinning as
'already taught' before the section that teaches it), and the voice
pass inserted a transition that now contradicts it outright
(05:509-510) (B, RSE). Remedy: distinguish index and manifest
digests; pin the index and always pass `--platform linux/amd64`, or
pin the platform manifest (Decision D15); move the section after the
pinning section; align the recipe for this compendium with its
lockfile (R 4.6.1 on `noble`, not 4.4.0 on `jammy`).

### Finding 31. Restricted-data guidance has three critical gaps

1. **The LLM data rule.** All twelve LLM sections forbid sending
   restricted data to a model 'unless the endpoint is approved by the
   reader's institution for that data' (LLM, C1). For data under a
   data use agreement, the agreement governs: NIH NOT-OD-25-081
   treats sharing controlled-access data with third-party generative
   AI through prompts as a breach of the Data Use Certification, with
   no exception for institution-approved tools [A-I]. Remedy: a
   three-part condition (institution, IRB protocol, and agreement
   all permit it; if any is unclear, the answer is no), stated once
   in a shared include (Decision D19).
2. **The one-file `.gitignore`.** See Finding 29.
3. **History rewriting in a regulated repository.**
   version-control:723-773 ends the PHI response with
   `git filter-repo` and `git push --force --mirror`, with no warning
   that under GxP this is a controlled change that destroys records
   21 CFR 11.10(e) says must not be obscured (Pharma, C1). Remedy: a
   callout at step 3 (deviation, QA approval, documented record of
   what was removed).

The voice pass also made the PHI rule at version-control:697-699
ambiguous ('This holds even briefly on a branch...') [V]; restore
the original negation.

### Finding 32. Claims that fail when run

- **Cox oracle.** 08:1663-1675 states 'event count equals the number
  of non-missing outcomes'; on the cohort `fit$nevent` is 48 and
  non-missing outcomes 305 [V]. No test in `inst/tinytest/`
  exercises `fit_cox()`, though 08:588-591 says one was added (MS,
  D). Tier 1 for a chapter on oracles.
- **Ch 12 Exercise 7.** Its locked set omits `withr` and `survival`,
  so `missing` has length 2, not 0, and three names after `sandwich`
  [V]; the instructor key repeats the error (D, E).
- **pacman.** renv 1.2.3 detects packages passed to
  `pacman::p_load()` [V]; 07:637-653 and Exercise 8 say it cannot.
  `p_load()` cannot install `pacman` itself (07:1455) [A-V].
- **`tbl-integrity`.** It hashes a serialized tibble, not file bytes;
  the same values with a different class give a different digest
  [A-V]. The Exercise 3 solution and REFACTOR-PLAN:2224 call it a
  file-byte hash (D, Pharma).
- **Ch 12 Exercise 4.** `make check-renv` auto-fixes and passes, so
  it is not a gate; `docker-render-book` needs Docker inside
  `rocker/verse`; no restore step (D, RSE).
- **Default branch.** Stock git 2.56 creates `master` [V]; the worked
  example's `git push -u origin main` fails, and version-control:
  947-948 says `main` is the default (Model).
- **`git reset --hard`** is called 'always safe to try again' and
  'survivable' (version-control:1084-1088); reflog recovers commits,
  not uncommitted work (A [EK]). Tier 1.
- **Apptainer `--cleanenv`** leaves `$HOME`, `~/.Rprofile`, and the
  user library visible [A-V, RSE]; the book calls it the right
  default for a verified run (06:851, 966, 995, 1360). It also
  strips `SLURM_*`, breaking job arrays (RSE).
- **Parallel RNG.** Naive `mclapply` fails by irreproducibility,
  not shared streams; `clusterSetRNGStream()` still depends on
  worker count [A-V, MS].
- **Showcase digest.** Finding 30.

### Finding 33. The second review's implementation record is not reliable

Items REFACTOR-PLAN marks done that are still in the text: the
pacman claim (10.12 'Fix pacman'), hashing as verification in
Chapter 9 (only Chapter 12 was fixed), the seed in `.Rprofile`
(02:855-859), 'the question is not statistical' (Finding 19), the
trusted-research-environment section planned as Priority 1 at
REFACTOR-PLAN:1877 (no occurrence of any of its terms in Chapter 13
[V]), the
`LC_NUMERIC` passage in Chapter 3, the five duplicated 'fully
reproducible' LLM triples (D5), regulated-sense glossary notes
(10.12), and `testthat` in Chapter 6 (Finding 22) (C, MS, Pharma,
LLM). One recorded correction was wrong: Phase 16 removed
`actions/checkout@v7` on the ground that v7 does not exist, but
v7.0.1 was released on 2026-07-20 [V, `gh api`]. Remedy: Phase 19
re-verifies each of these by grep or by running, and every future
completion record states how it was checked.

### Finding 34. Regulated content misquotes and misattributes its sources

21 CFR 11.10(a) reads 'the ability to discern invalid or altered
records'; 08:1288 says 'discriminate' [I, Cornell LII text; eCFR
redirected]. Section 11.10 never mentions IQ or OQ, which 08:
1297-1299 and 1362-1369 attribute to it. The R Validation Hub white
paper gives trusted status to base and recommended packages, says
only that there is 'a reasonable case' for the tidyverse, and
requires tests for statistical modelling functions regardless of
risk score; 08:1334-1337 says long-established tidyverse packages
earn trusted status 'with no further work'. The same paper says Part
11 'is not relevant or mandatory' for statistical software itself,
and FDA's 2003 guidance applies enforcement discretion to 11.10(a)
validation, which undercuts the chapter's exercise framing [A-I,
Pharma]. A pull-request approval does not meet 11.50(a) by default
(Pharma, M5). 'Validation', 'verification', and 'audit trail' still
lack regulated-sense notes in the glossary.

### Finding 35. Statistical treatment below the audience's standard (Chapters 3 and 11)

The sampler change in `tbl-baseline-rng` (0.0036) is about a quarter
of one Monte Carlo SE (0.0154) yet is framed as a failed
reproduction [A-V, MS]. At the default `B = 1000`, the bootstrap
bound's seed-to-seed SD is 0.215, so its second reported decimal is
noise [A-V]. The parallel-RNG advice is wrong (Finding 32). The
Chapter 3 worked example seeds in `.Rprofile`, contradicting Chapter
11. An optimizer-dependent estimate is called 'not statistical', and
the BLAS example is an incidence rate, which uses no BLAS (MS).
Remedy: report Monte Carlo SEs alongside seed-exact baselines, a
two-tier baseline check (seed-exact at 1e-8, then within 3 MCSE),
per-task parallel seeding, and the two Chapter 3 corrections.

### Finding 36. The voice pass: meaning preserved, about 25 local defects, new tics

Readers A to E read every hunk of `d786c6b`. None found a changed
number, name, citation, or ranking. The defects they did find:

- **Meaning or logic:** the PHI sentence (Finding 31); the Chapter 13
  conclusion split so that 'only' contradicts 'also' (10:1882-1886);
  the four restricted-data routes collapsed into an ambiguous
  sentence that a later line still counts as four (10:678-690); the
  Chapter 3 roadmap repeating an already misordered Outline
  (02:112-123); the Chapter 7 transition (Finding 30); a duplicate
  Chapter 11 roadmap naming the wrong closing section (08:169-174);
  the `git bisect` sentence now misdescribing how bisect is invoked
  (09:1500); a conditional made flat (08:958-962); a Chapter 13
  transition that misstates the preceding paragraph (10:829-830).
- **Garbled splits:** pipelines:283-286, 295-298; 01:484-490;
  02:1135-1146; conventions:30-32; setup-appendix:22-25.
- **Mixed persons in one passage:** the objectives of 08, 09, 10, and
  version-control mix 'the reader', 'we', and 'one'; several
  solutions switch from the exercise's 'you' to 'the reader'; the
  'machine that is not yours' device in Chapter 12, the book's most
  memorable line, was weakened to 'not the author's'.
- **Tics:** 'That is,' 0 to 59 uses, a third of them introducing a
  reason, example, or list rather than a restatement; 'Unfortunately,'
  added to nearly every chapter in front of a limitation the old
  text stated neutrally (it reads as a template); 'therefore' 13 to 29
  in one group and 6 to 19 in Chapter 12; 'We begin' three times in
  100 lines of Chapter 5; four new 'Consider ...' openers in Chapter
  13; a redundant 'In conclusion,' under the 'In conclusion' heading.
- **Rendering:** the three accidental example lists (Section 3).

Remedy: a targeted correction pass (Phase 20) using the readers'
line-level fixes, a cap of about three 'That is,' per chapter used
only to restate, removal of the added 'Unfortunately,' except where
a reader judged it apt, and one person per passage (Decision D17).

### Finding 37. The apparatus is broken

The cheat-sheet index links do not resolve, its titles are stale,
and its Chapter 13 entry lists tools the chapter does not cover. The
preface promises a week-by-week table in the instructor guide; the
rendered guide has none (it is only in the unrendered
`INSTRUCTOR-GUIDE.md`). The instructor guide is a public appendix
and holds the autograder keys, several stale. The colophon's prose
contradicts its own computed table (E, MS).

### Finding 38. Length and duplication

The PDF is 600 pages. Stated reading times are low: Chapter 11
about 65 minutes against 45, Chapter 12 about 80 against 50, Chapter
7 about 55 against 40 (B, D). Content repeats across chapters: the
NAS definitions and the stack paragraph almost verbatim in Chapters
1 to 3 (about 900 words recoverable, A); 'CI captures no new layer'
four times in Chapter 12; the lockfile-limits passage in both 6 and
7; the restricted-data LLM rule twelve times (about 600 words, LLM);
the disclosure argument twice; a roadmap paragraph and an Outline
list saying the same thing in most chapters (an artifact of the
voice pass). Candidate cuts from the personas: the Chapter 3
'Two numbering schemes', the Chapter 12 capture test matrix and one
of the two CI dialects, the Chapter 6 packrat lineage, the Chapter 9
Sweave lineage, and the Chapter 13 vendor discussion (MS, Pharma,
RSE). Length decisions wait for the learning-science and coverage
reports (Decision D18).

### Finding 39. Git setup and troubleshooting are missing

Nothing in the book covers git identity, credentials, the default
branch, or a first push; the setup appendix covers Docker only. On a
fresh install the first commit stops at 'Please tell me who you
are' [A-V]. Commands are mostly shown without expected output, and
there is no symptom-indexed troubleshooting for git (Model). Remedy:
a short git preflight in the setup appendix that points to the
corresponding *Happy Git* chapters, a 'When git refuses' table, and
abbreviated `#>` transcripts for the key commands.

### Finding 40. The LLM sections need one policy, agents as actors, and better prompts

Beyond the critical data rule (Finding 31): coding agents are treated
only as readers of data, never as actors who run, edit, commit, push,
and deposit; an agent's report that tests pass is not the analyst
seeing them pass; agents rewrite tests and baselines to reach green;
prompt injection is not mentioned (LLM, M2). The model disclosure
records omit the tool name, version, provider, and dates JAMA and
Elsevier require, and nothing says to keep prompts or where LLM use
is recorded in a compendium (M1). About 15 of 36 prompts are vague
and none asks for a verification step (M3). An LLM used inside an
analysis, as a reproducibility dependency, is not addressed (M5).

### Finding 41. The ladder is stated inconsistently across chapters

Which rung secures the numerical libraries (L2 in Chapter 2, none in
Chapter 3, the container in a Chapter 3 solution); which layer the R
3.6.0 sampler belongs to (runtime or session configuration); whether
Docker without renv is L2 (Chapter 12's matrix) when the rungs are
cumulative; whether capture or verification sets L3 (preface and
index against Chapter 13 and the glossary); nine or ten layers; the
union model said to be supplied by Chapter 6, which never teaches it;
the two-layer model defined three ways (A, B, D, E). Remedy: a
'default versus override' table in Chapter 3 (A), one definition of
each model, and the alignment edits the readers list.

### Finding 42. The verification method of the prose passes was incomplete

The prose passes were checked by comparing code, citations, anchors,
links, numbers, and headings in the source. That caught nothing
wrong, and three rendering defects still got through, because the
defects appear only after Pandoc parses the rewrapped text. Remedy:
every prose edit is verified against the rendered HTML as well
(Section 8).

### Finding 43. The PDF prints every answer under its question (major)

All 128 'Check your understanding' answers appear directly beneath
their questions in the PDF [V, `pdftotext` of the 2026-11-07 build:
128 'Answer' headings, each immediately after its question].
Collapsed callouts hide them only in HTML, so Finding 6, recorded as
resolved, is resolved for the web edition alone, and
`conventions.qmd:56-59` ('attempting the question is not optional')
is true only there. Remedy: in PDF, move answers to the end of the
chapter or an answers appendix, keyed by number (Decision D23).

### Finding 44. Retrieval practice is dense but never spaced or mixed

The learning-science survey (`learning-science.md`) grades retrieval
practice and spacing as strong evidence. The book's practice dose is
high (85 percent of its 416 callouts are checks, answers, or
solutions, so the 415-callout count does not indicate overuse of
asides), but every check tests the section just read, with no delay
and no mixing across chapters, and there are no faded or completion
examples for Docker, CI, or `targets` [A-I]. Remedy: one short
cumulative check per chapter drawn from two or more earlier chapters
(the existing 'spacing' Exercise 8s are a start), and one faded
example each in Chapters 7, 10, and 12. The survey also finds that
the conversational-style effect does not extend to long sessions and
was measured for second person, not 'we', so further voice work
deserves low priority [A-I].

### Finding 45. Accessibility work recorded as done is incomplete

The PDF is untagged (`pdfinfo`: `Tagged: no`) [V]; per the survey,
`scrbook` cannot yet be tagged by Quarto, so a tagged edition needs
the `book` class with `pdf-standard: ua-2` [A-I]. In `fig-gates`,
two statuses differ by hue alone (contrast 1.34:1, same marker); the
stack figure used in twelve chapters shows rung by color only, with
8 of its 10 color pairs below 3:1; the Simpson figure's alt text
(07:453) misdescribes the cluster heights [A-V]. No automated
accessibility check runs. Remedy: shape or pattern encodings in both
figures, corrected alt text, an `axe` check on the HTML, and a
decision on PDF tagging (Decision D24).

## 6. Correctness register

Tier 1: a reader acting on it could be harmed, make a wrong
professional decision, or lose data, or the book's central claim
fails. Every Tier 1 fix is re-checked independently in Phase 19.

| Id | Defect | Location | Source | Evidence |
|---|---|---|---|---|
| T1-1 | One-file `.gitignore` presented as protecting the raw-data directory; instructor key inverted | 10:1235-1244, Ex 7; instructor-guide:337-352 | E | V |
| T1-2 | LLM rule: institutional approval treated as sufficient for DUA data | 12 sites (LLM report, C1) | LLM | A-I |
| T1-3 | PHI history rewrite with no GxP caveat | version-control:723-773, 1494-1502, cheat sheet | Pharma | A-I |
| T1-4 | Digest named as one filesystem; Apple Silicon advice wrong for the showcase image | 05:254-256, 507-608, 1182-1185, 1818; setup-appendix:18-37, 152-161 | B, RSE | V |
| T1-5 | Apptainer `--cleanenv` presented as isolating the host home | 06:851, 966, 995, 1360; Slurm script 936-947 | C, RSE | A-V |
| T1-6 | `git reset --hard` called always safe | version-control:1084-1088 | A | EK |
| T1-7 | Cox oracle wrong and untested | 08:588-591, 1663-1675 | D, MS | V |
| T1-8 | PHI rule made ambiguous by the voice pass | version-control:697-699 | A | V |
| T1-9 | 21 CFR 11.10(a) misquoted; IQ/OQ attributed to it; Part 11 scope misframed | 08:1285-1299, 1350-1369 | D, Pharma | I |
| T1-10 | The repository's own state misdescribed (lockfile, CSV, test-data copy, Dockerfile) | Finding 29 list | A, B, C, E | V |
| T1-11 | `CITATION.cff` software license conflicts with `LICENSE` and `DESCRIPTION` | `CITATION.cff`; 10:601-603, 639-640 | E | A-I |

Tier 2: wrong, misleading, or internally contradictory. Grouped by
chapter; line-level detail and fixes are in the cited reports.

| Chapter | Items | Source |
|---|---|---|
| 1 (00) | replicability defined as robustness (66-67); `stringsAsFactors` 'every model' (183-187) [A-V]; 'default random-number algorithm' (179-180); 'byte for byte' definition (38-40); Claerbout attribution (115); two different 'verbatim' Peng quotations (84-86 vs 02:7-9) | A, MS |
| 2 (01) | BLAS rung contradicts Ch 3 (650-654); sampler layer and rung (783-787, 814, 1156-1158, 1282-1285); simulation exposure (622-624) [A-V]; Trisovic attribution (576-580); Exercise 8 premise (1040-1048); 'single word' (807) | A |
| 3 (02) | stale L0 placement (914-956); 'below it' (1329-1330); inverted ACM logic (1242-1244); layer count; 'toward L3' (530-532); `.Rprofile` seed (855-859); 'not statistical' (91-104); BLAS example (352-374); `LC_NUMERIC` (342-345); `utils` in lockfile (953) | A, MS |
| 4 (VC) | committed CSV (857-867, 1357, 1587); forward reference to Ch 5 (196-199); default branch; FINAL counts (159-161); Ex 3, 5, 7, 8 solutions; habit 1 twice; worked example vs `tbl-audit-trail`; PR as regulated approval; 'r.thomas' handle | A, Model, Pharma |
| 5 (03) | stale pillars and L0 (1206-1251, Ex 7, 8); simulation gate 'second call' contradicts itself (849-852 vs 1329, 1584); `fig-gates` render cell (952); `here` path explanation (697-701); two 'strongest case' rows (1037, 1040); `R CMD check` claim needs qualifier (370-372); NHS RAP baseline reduced to its README criterion, though the cited page lists five (620-623, 667; `references.bib`:991) [A-I] | B, RSE, texts |
| 6 (04) | stale lockfile prose and Ex 7 (1141-1175); `survival` counting rule; `sample()` in stats (1188) [A-V]; 'pins the R version' and `@tbl-lockdiff` (1410-1413); packrat survey pointer (1616-1618); `renv/.gitignore` contents (1570-1573); `testthat` (1237); unpinned gate tool | B, Pharma, LLM |
| 7 (05) | Finding 30; 'no entry in the lockfile' (347-349, 1799-1800); base image vs lockfile R (1333-1341); `OMP_NUM_THREADS` alone (1712); Ex 7 premise (1503-1505); RNG cross-reference (1129); 'install. packages()' break (342-343); `docker inspect` for digests (1827) | B, RSE |
| 8 (06) | `--cleanenv` (T1-5); stale artifact check and key (757-793, 1102-1108); Binder overstated (636-638, 864-869); rix pin description and 'any machine' (453-454, 1203-1207, 404-405); 'rigour' in a rendered table (688); verse digest Ex 8 (1110-1117); SIF 'deterministic' (1347); rootless Docker; five routes vs none taken (539-548) | C, RSE |
| 9 (07) | pacman (637-653, 1455, Ex 8); verification as hashing (861-911, 1540-1547); 400-eye target (593-594); habit numbers (1653); 'single most cited sentence' (1672); disclosure record (1292-1295); TeX Live size | C, Pharma, LLM |
| 10 (pipelines) | ratio 'is what survives' [A-V unstable 45, 186, 138] (513-545); undefined file target (1276, 1299); stale L0 (1281, 1306); Ex 4 unsatisfiable (1423-1429); Ex 8 credits a baseline test that is absent (1717-1720); clean CI runner 'rebuilds exactly what is stale'; Make error wording (579) | C, RSE |
| 11 (08) | T1-7, T1-9; Validation Hub (1334-1337); MCSE vs sampler change; `B = 1000`; parallel RNG (954-974); rule of thumb vs L3 (1266-1269); abridged listing unlabeled (751-769); 338 vs 306 rows (1639); Ex 3 solution column names; regulated vocabulary 'narrower' vs 'broader'; `expect_inherits` contradiction | D, MS, Pharma |
| 12 (09) | Ex 7 and key; `tbl-integrity` hash; Ex 4 gate; honest-level callout (1064-1074); Docker-only L2 (1229); `.Rprofile` assumption on CI; checkout v7; unpinned `zzrenvcheck`; Outline omissions; 'first section'; GitLab image vs lockfile R | D, RSE, Pharma |
| 13 (10) | T1-1, T1-11; union model not taught (37-39, 111); two-layer model three definitions; Ex 3 `make render`; Ex 4 'output hashes' as L3; NIH DMS Plan placement (838-842) [A-I]; capture vs verification framing; stack figure vs convention (94-107); 'regression to L0' (436); Chapter 13 depends on optional SIF material | E, MS |
| Front and back matter | cheat-sheet links and titles; preface week table; instructor keys; colophon; glossary entries (container image, capsule, controlled access, merge commit); setup appendix CRLF message, `/mnt/c` duplication, uncited '2026' reviews; shell primer glob behavior in zsh; credits typo | E, Model, RSE |

Tier 3 (minor) items are listed in each report under 'Minor'.

## 7. Topic additions from the coverage sweep

Three researchers opened 26 course syllabi (15 North American, 2 UK,
7 continental European, 1 Australian, 1 Asian; Australia, New
Zealand, and Asia yielded almost nothing openable), 29 books,
lessons, and guidance documents, and the regulatory and tooling
changes of 2023 to 2026 (`coverage-syllabi.md`, `coverage-texts.md`,
`coverage-emerging.md`). Their joint conclusion: the book covers the
shared core at least as deeply as any course found, and goes well
beyond them on containers (7 of 26 courses), CI (5 of 26),
restricted data (1 of 26), data validation (1 of 26), and regulated
validation and Monte Carlo error (none). Breadth counts are lower
bounds, and topic lists came through a summarizing fetch tool.

Because the book is already 600 pages (Finding 38), each candidate is
weighed by breadth, fit, and settledness against its page cost. The
recommendation is to add only items that close a real gap for this
audience, and to fund them from the cuts in Finding 38.

| # | Addition | Breadth and source | Placement | Pages | Recommendation |
|---|---|---|---|---|---|
| A1 | Trusted research environments, Five Safes, output checking | Planned as Priority 1 in REFACTOR-PLAN:1877 (2,500 words) and never written: 0 hits in Ch 13 [V]; All of Us Workbench, EHDS (2025), UK SATRE | Ch 13, restricted-data section | 2 | Add |
| A2 | README computational requirements: software, randomness, runtime, hardware, output-to-code map | Social Science Data Editors template, JASA, TIER (texts) | Ch 5, README section (614-633) | 1 | Add |
| A3 | CONSORT 2025 and SPIRIT 2025 code-access items, plus a short journal-policy table (JASA, *Biostatistics*, AJE) | Both guidelines published April 2025 (SPIRIT item 6 opened; CONSORT via secondary source [U]) | Ch 13, near TRIPOD+AI (853-893) | 1 | Add, after Phase 25 confirms each policy |
| A4 | An LLM called inside an analysis as a reproducibility dependency: cached outputs as derived data, model identifier, versioned prompts | LLM reviewer and emerging researcher independently; JAMA requires prompts for AI used in research | Ch 10 (pipelines) | 1 | Add |
| A5 | Git preflight: identity, credentials, default branch, first push, symptom table | Model book; Happy Git spends five chapters on it | Setup appendix | 1 | Add (Finding 39) |
| A6 | Quarto `freeze` and cache, and what they do and do not guarantee | Texts; the book itself renders with `freeze: auto`, and its colophon misstates the effect | Ch 9, after 611 | 1 | Add |
| A7 | Reviewing analysis code: a checklist and a paired exercise | 5 of 26 syllabi; texts; Pharma (independent QC) | Ch 11, extending the double-programming paragraph | 1 | Add, short |
| A8 | Building and maintaining the package skeleton (`usethis`, `devtools`, `pkgdown`) | 12 of 26 syllabi; 0 grep hits for `devtools` or `usethis` in Ch 5 [V] | Ch 5, one section with the essential commands and a pointer to *R Packages* (2e); not a new appendix | 1 to 1.5 | Add as a section, not the 4 to 5 page appendix proposed |
| A9 | FDA review of R Submissions Pilot 4 on containers | R Consortium, May 2026 [A-I] | Ch 7, honest-level callout | 0.3 | Add, after Phase 25 confirms the quotation |
| A10 | A named forensic case (Duke, Baggerly and Coombes) | 3 of 26 syllabi | Ch 2, replacing part of the survey prose at 300-390 | net 0 | Optional (Decision D18) |

Not recommended, each with a one-sentence mention at most: citation
management (one sentence in Ch 9); GitHub Issues and large files (one
sentence in Ch 4); the I4R 2026 reproduction study (one citation in
Ch 2); institutional CODECHECK programs (one sentence in Ch 12);
Positron, webR, `rv`, `uv`, SBOMs, and the EU AI Act (agreeing with
10.10). Python, Shiny, SQL, web data, figure design, and research
ethics remain out of scope.

**Length arithmetic** [inferred, not measured]. A1 to A9 add about 9
to 10 pages. The cuts and consolidations in Finding 38 and the
personas' lists (the duplicated definitions and stack paragraph in
Chapters 1 to 3, one of the two CI dialects, the capture test matrix,
the packrat and Sweave lineages, 'Two numbering schemes', the Chapter
13 vendor discussion, the twelve LLM rules reduced to one include,
and one of each roadmap and Outline pair) are estimated at 25 to 35
pages. The net is a book of roughly 575 to 585 pages. That remains
far above a one-quarter reading load, which is why Decision D18 asks
whether to go further.

## 8. House rules and render checks (additions)

1. **No typed statement about the repository.** Any sentence about
   which files exist, which rung the compendium occupies, or what a
   chunk printed is an inline R expression over a chunk result.
2. **No typed expected value in an exercise or key.** Instructor
   keys and autogradable answers come from executed chunks.
3. **Every printed test is run.** A test shown in the text exists in
   `inst/tinytest/` or is labeled illustrative and abridged.
4. **A clean render additionally requires:** no `class="example"` in
   any rendered HTML page; no `href="@` in any rendered page; the
   inline-code and citation invariants of the voice pass, checked
   against the rendered HTML as well as the source.
5. **No line inside a list item may begin with `@label.`;** a lint
   in `inst/tinytest/test-manuscript-invariants.R` enforces it.
6. **'That is,' only to restate,** at most about three per chapter;
   no template evaluative openers ('Unfortunately,') before a
   limitation stated neutrally; one person per passage.
7. **Completion records state how each item was verified** (grep,
   run, or reading), and a fix is recorded done only after the
   check.

## 9. Phases

Each phase on its own branch from `voice-rewrite` (or from `main`
after the author merges it), verified by a clean HTML and PDF render
under Section 8, tests passing, and one commit. Estimates are lead
working sessions.

| Phase | Label | Content | Estimate |
|---|---|---|---|
| 19 | E1, Tier 1 | T1-1 to T1-11; re-verify the Finding 33 items; independent re-check of each fix | 1 to 2 |
| 20 | E2, correctness and voice | Tier 2 register; compute-not-type sweep (Finding 29) with inline R and regenerated instructor keys; the voice-pass corrections and tic reduction (Finding 36); the three example-list fixes and the new lints | 2 to 3 |
| 21 | Statistics and regulated content | Finding 35 (MCSE, two-tier baseline, per-task seeding) with a new tinytest; Finding 34 corrections and glossary notes; scope paragraph in the preface (Decision D20) | 1 to 2 |
| 22 | Content gaps | git preflight and troubleshooting table (Finding 39); shared LLM include, agents paragraph, disclosure template, one better prompt per chapter, LLM inside an analysis (Finding 40); approved coverage additions (Section 7) | 2 |
| 23 | Reading times and defective duplication | corrected reading times on every chapter card; reconcile or remove only the duplications that are themselves defects (D18: no other cuts); checkpoint before any renumbering | 1 |
| 24 | Apparatus and accessibility | cheat-sheet links and titles, week table into the rendered instructor guide, colophon, glossary alignment (Findings 37, 41); PDF answer placement (Finding 43, D23); figure encodings, alt text, `axe` check, PDF tagging (Finding 45, D24); one spaced cumulative check per chapter and three faded examples (Finding 44) | 2 |
| 25 | Verification pass | the 19 quotations, every [EK] and [U] claim, dated facts (`rang` archival, git and R versions, SWHID), each marked verified, corrected, hedged, or removed with URL and date | 1 |

## 10. What not to do

- Do not restore the second person wholesale; the voice was the
  author's choice, and the defects are local.
- Do not fix the stale repository prose by retyping the new state;
  compute it, or it will go stale again.
- Do not treat the second review's implementation record as evidence
  that an item is fixed; check the text.
- Do not add topics from the coverage sweep without weighing the
  length cost against Finding 38.
- Do not change zzcollab's architecture default from this book's
  branch; record it for the tool (Decision D15).

## 11. Decisions

Recorded here with options and the lead's recommendation; asked with
AskUserQuestion once Section 7 is complete.

- **D13. How the book describes its own compendium.** (a) Compute the
  state live and narrate the compendium climbing the ladder chapter
  by chapter (recommended); (b) describe the compendium as each
  chapter imagines it at that point and say so explicitly.
- **D14. The instructor guide.** (a) Keep it public as self-check
  keys, move the week table in, and plan the graded labs as the real
  assessment (recommended); (b) remove it from the rendered book and
  ship it separately.
- **D15. Digest guidance.** (a) Pin the index digest and always pass
  `--platform linux/amd64` (matches HPC and CI; recommended); (b) pin
  the platform manifest digest. Separately, whether zzcollab's
  arm64 default should change (a tool decision).
- **D16. The test-data copy of the extract.** (a) Replace
  `inst/testdata/cohort_raw.csv` with a small synthetic fixture
  without identifier columns, and use the old copy as a worked
  example of a leak (recommended); (b) keep it and explain it.
- **D17. Person in objectives and solutions.** (a) 'You' in learning
  objectives, exercises, and their solutions; 'we' in exposition
  (recommended, matches the template card); (b) 'we' throughout.
- **D18. Length.** (a) Make the Finding 38 cuts and the A1 to A9
  additions, and keep the core path and optional marks as the answer
  to the one-quarter load (net about 20 pages shorter; recommended);
  (b) additionally move Chapter 8 and the second half of Chapter 10
  to an online-only 'Further topics' part, which takes them out of
  the PDF (an estimated further 80 to 100 pages, which would need
  measuring); (c) additions only, no cuts. A10 (the Duke case) is
  included under (a) only if it replaces survey prose of equal
  length.
- **D19. LLM sections.** (a) One shared include for the data rule and
  the agents paragraph, chapter-specific additions kept (recommended);
  (b) one LLM chapter or appendix replacing the twelve sections.
- **D20. Regulated material.** (a) Correct it, add a preface sentence
  that computer-system validation is out of scope, and keep a short
  section (recommended); (b) cut it to a paragraph and a pointer.
- **D21. CI action pins.** Update to `actions/checkout` v7.0.1 by SHA
  and mention Dependabot or Renovate (recommended), or keep v4.2.2
  with a stated date.
- **D22. Merge order.** Merge `voice-rewrite` into `main` before
  Phase 19 (recommended), or branch Phase 19 from `voice-rewrite`.
- **D23. Answers in the PDF.** (a) Move PDF answers to the end of
  each chapter, keyed by number, leaving HTML collapsed
  (recommended); (b) a single answers appendix; (c) accept that the
  PDF shows answers and change `conventions.qmd` to say so.
- **D24. PDF accessibility.** (a) Switch to the `book` class with
  `pdf-standard: ua-2` and measure the page and layout effects before
  committing (recommended); (b) keep `scrbook` untagged and state in
  the colophon that the HTML edition is the accessible one.

### 11a. Decisions recorded (author, 2026-11-07)

| Decision | Choice | Effect on the phases |
|---|---|---|
| D13 Own compendium | Compute it live | Phase 20: inline R for every repository statement; the compendium is narrated at L1 |
| D14 Instructor guide | Remove from the rendered book | Phase 24: drop `instructor-guide.qmd` from `_quarto.yml`; ship it separately; fix the preface pointer and every chapter link to it (for example 02:1317-1322); update `test-manuscript-invariants.R` if it lists the file; regenerate the keys from executed chunks in the separate guide |
| D15 Digest guidance | Index digest plus `--platform linux/amd64` | Phase 19 (T1-4); zzcollab's arm64 default recorded as a tool issue, not changed here |
| D16 Test-data copy | Replace with a synthetic fixture without identifier columns; teach the old copy as a leak example | Phase 19 (T1-10); `inst/tinytest/` tests that read the fixture are updated and re-run |
| D17 Person | 'You' in objectives, exercises, and solutions; 'we' in exposition | Phase 20 |
| D18 Length | Additions only, no cuts | Phase 22 adds A1 to A9 (about 9 to 10 pages); Phase 23 is reduced to corrected reading times and the duplications that are themselves defects (the twelve LLM rules under D19, the roadmap and Outline pairs that disagree); the book grows to about 610 pages. A10 is not added. |
| D19 LLM sections | Shared include | Phase 19 writes `_llm-rule.qmd` with the corrected rule (T1-2); Phase 22 adds the agents paragraph to it |
| D20 Regulated material | Correct and scope | Phase 19 (T1-3, T1-9); Phase 21 glossary notes and the preface scope sentence |
| D21 CI action pins | `actions/checkout` v7.0.1 by SHA, plus Dependabot or Renovate | Phase 20 |
| D22 Merge order | Merge `voice-rewrite` into `main` first | Done before Phase 19 (local, not pushed) |
| D23 PDF answers | End of each chapter, PDF only | Phase 24 |
| D24 PDF tagging | Trial the `book` class with `pdf-standard: ua-2`, measure, adopt only if acceptable | Phase 24, on its own branch |

## 12. Limitations

- **The expert reviewers are simulated personas,** not people. Human
  second readers are needed for the regulatory, restricted-data, and
  statistical chapters before any catalog listing.
- **Renders used host R 4.6.0 against a locked 4.6.1,** with locked
  package versions confirmed for all 59 packages. No Docker image of
  the project was built; one agent built the showcase Dockerfile
  natively on arm64 only.
- **No CI service, Slurm, Podman, Binder, or Nix was run.** Those
  findings rest on documentation and expert knowledge as labeled.
- **The eCFR could not be opened** (it redirected); the CFR wording
  rests on the Cornell LII text and is scheduled for Phase 25.
- **The lead did not read every chapter in full.** The readers did;
  the lead re-checked the Tier 1 items and a sample of the others as
  labeled.
