# Fourth Critical Review: *Reproducible Research for the Health Sciences*
*2026-11-25 18:17 PST*

Review of the Quarto source in `analysis/report/` at `main` (`03708a2`),
conducted against the prompt in `docs/fourth-review-prompt.md`. Eight
reviewers each read an assigned part of the book in full. Their raw
reports are in `docs/fourth-review/raw/`, and this document reconciles
them. No book source was edited.

**Chapter numbering.** File names and book chapter numbers differ.
The mapping used throughout is: Ch 1 `00-intro`, Ch 2
`01-reproducibility-crisis`, Ch 3 `02-levels-of-reproducibility`,
Ch 4 `version-control`, Ch 5 `03-research-compendium`, Ch 6
`04-dependencies`, Ch 7 `05-containers`, Ch 8 `06-backends-runtimes`,
Ch 9 `07-literate-programming`, Ch 10 `pipelines`, Ch 11
`08-testing-quality`, Ch 12 `09-continuous-integration`, Ch 13
`10-archiving-sharing`.

**Evidence labels.**

- **Verified:** a primary source was opened (URL given in the raw
  report) or a command was run.
- **Inspected:** the problem was confirmed by reading the book source.
- **Inferred:** the problem follows from what was read, but was not
  checked directly.
- **Unverified:** the claim rests on memory or search summaries.

The lead reviewer searched the source for the verbatim quote of every
finding in the raw reports, with whitespace normalized: 207 quotes (8
blocking, 93 major, 106 minor). All 207 were found. Line numbers for
the findings in this document come from those matches.

**Finding IDs.**

- `R4-001` to `R4-020`: global findings (Section 3). The '4' is the
  review number.
- `R<chapter>-NN`: chapter findings (Section 4). For example, `R7-01`
  is the first finding for Chapter 7.
- `R4-Vnn`: Chapter 4, Version Control. The letter V keeps these IDs
  apart from the global findings.
- `RA-nn`: appendices and front matter.

---

## 1. Executive summary

**Overall judgment.** The book is technically careful, honest about
its own limits, and unusually rigorous for a textbook. It computes the
repository facts it reports rather than typing them, and it ran the
failure modes it describes. Measured against the stated reader, it
largely meets the goals of currency and accuracy and does not meet the
goals of persuasion and novice access:

| Goal | Judgment |
|---|---|
| 1. Persuasion first | **Not met.** The opening has no named real incident. The first real number appears on PDF page 41, the mentor's objections go unanswered, and the strongest policy argument sits in the last chapter. |
| 2. Access for true novices | **Not met.** The stated prerequisites exclude the reader. No chapter links to the shell primer. Three core chapters omit the one command the reader needs: `docker run`, `quarto render`, and a first CI push. |
| 3. Contemporary | **Largely met, with dated spots.** CI pins, the NIH Data Management and Sharing (DMS) policy and Rocker digests are current. Gaps: Docker's August 2026 terms, Typst, multi-architecture Rocker tags, rig and pak, the 2026 *Nature* reproduction studies, the OSTP memo and the NIH Public Access Policy. |
| 4. Accurate | **Mostly met.** Quoted statistics match their sources. The review found about a dozen substantive errors, one of which teaches a data-leaking `.dockerignore`. |

**The five most important problems.**

1. **The opening does not persuade a skeptic** (R4-001, R4-002,
   R4-007, R4-008). Every concrete story in Chapters 1 to 3 is an
   invented composite, and every real piece of evidence is an aggregate
   rate. The mentor's four likely objections are answered at most once,
   indirectly.
2. **The book screens out the reader it is meant for** (R4-003,
   R4-004, R4-013, R7-01, R9-01, R12-01). The Welcome page requires
   comfort at the command line and with git, and nothing links to the
   shell primer, which sits after the References. In Chapters 7, 9 and
   12 the reader learns about a tool but never runs it.
3. **The author's tool is central, undisclosed and not optional**
   (R4-005, R4-006). The book never says its authors wrote `zzcollab`
   and `zzrenvcheck`, or how to install them. The boxed 'With
   zzcollab' track promised by decision D2 does not exist. The worked
   examples in Chapters 5, 7 and 13 cannot be run without the tool.
   Some of what the book says about the tool is out of date, and some
   contradicts the book's own rules.
4. **Errors in guidance that protects data** (R13-01, R4-V03,
   R4-V01). The `.dockerignore` exercise implies that `*.csv` excludes
   CSV files in subdirectories, which it does not. The rule on
   protected health information (PHI) can be read as exempting
   repositories that are never pushed. The book never discusses
   whether a repository should be public or private.
5. **Length, load and no ending** (R4-011, R4-012). The core path is
   about 145,000 words, with roughly 2,000 words of apparatus before
   each chapter's first content section. Definitions repeat across
   Chapters 1 to 3. The book ends inside Chapter 13, after the
   solutions, without telling the reader what to do next.

**The three most important strengths.**

- **Computed, tested facts.** Repository state, lockfile excerpts,
  digests, the colophon and the cheat-sheet index are generated, and
  the failure modes were exercised. This is rare and should be kept.
- **The capture-versus-validation vocabulary and the 'honest level'
  callout.** Together they give the reader a portable way to state
  exactly what has been shown, and they are the book's best answer to
  'this is engineering, not science'.
- **The restricted-data material.** HIPAA routes, trusted research
  environments, the PHI incident response and the 2025 SPIRIT and
  CONSORT items are more complete than in any comparable text.

---

## 2. Audience and scope recommendation

**The mismatch.** The title, the subtitle, the Welcome page
(`index.qmd:60-62`) and the preface address quantitative health
scientists who already use R and git. The author's stated reader is a
first-year graduate student in any empirical field who has never used
a terminal.

**How deep the health framing goes.** It is thin: about 1 to 5 health
terms per 1,000 prose words (Reviewer G's structural count). It is,
however, concentrated where a non-health reader arrives first:

- the Welcome page;
- the clinical-audit orientation of Chapter 2;
- the 'Health-sciences example' column in Chapter 5;
- the regulated-validation section of Chapter 11;
- the HIPAA, NIH and biomedical-journal material in Chapter 13;
- the restricted-data include, repeated in 12 chapters.

**How deep the R framing goes.** R is structural. Every capture tool
from Chapter 6 onward is R-specific, and Python, Julia, Stata, SAS,
MATLAB and SPSS together appear 17 times.

**Recommendation: state the reader as an empirical researcher who
analyzes data in R, keep the health-science examples, and add explicit
bridges.** Do not broaden to other languages.

- **Reasons.** Broadening would be a rewrite. Narrowing to health
  scientists would discard the author's stated reader for no gain,
  since most of the principles transfer unchanged. The health material
  is the book's distinctive strength, and the persuasive evidence is
  already drawn mostly from outside health.
- **Bridges.** A multi-field case bank in Chapters 2 and 3 (Section 5).
- **Bridges.** A one-page 'Translating the tools' appendix: `renv`
  against `uv` or `pixi` lockfiles and Stata `version`; `tinytest`
  against `pytest`; `knitr` against Jupyter; `targets` against
  Snakemake.
- **Bridges.** A one-paragraph 'If you work in Python or Stata' box in
  Chapters 6, 8 and 9.
- **Bridges.** Generic wording in prerequisites and exercises.
- **Bridges.** A restricted-data rule that names survey microdata,
  administrative records, and export-controlled or proprietary data
  alongside PHI (R4-010).

**Author's own tools.** Reviewers B, C, F and G agree that the book's
principles are mostly taught before the tool (Chapter 12's dependency
gate is a good model). The dependence nevertheless fails Section 2's
test in three places: it is undisclosed, it cannot be installed from
anything in the book, and three worked examples cannot be followed
without it (R4-005, R4-006).

This is an author decision. It changes the Welcome page, the preface,
and possibly the subtitle.

---

## 3. Global findings

### R4-001 No named real incident anywhere in the persuasive chapters

- Location: `01-reproducibility-crisis.qmd:334`; `00-intro.qmd:20-34`;
  `08-testing-quality.qmd:148`; `07-literate-programming.qmd:167`
- Severity: **blocking**
- Viewpoint: mentor
- Evidence: inspected. A grep for Potti, Baggerly, Reinhart, Herndon,
  Ziemann, Aboumatar, Eklund, Chang and Foote across all chapters
  returns nothing. Reviewer A's inventory counts 19 cases: 11 real,
  all aggregate rates, mechanisms, theory or history; 8 hypothetical,
  all clinical or generic. Real cases with consequences: zero.
- Prior: **Reopens D18** (A10, the Duke case, was declined in the third
  review on length grounds). The new argument is that persuasion is
  now the author's first goal, and A10 was never weighed against it.
- Problem: a skeptical principal investigator discounts aggregate rates
  ('other people's sloppy work') and composites ('not evidence'). The
  strongest lesson in Chapter 2 appears only in an exercise solution
  (`01:1354-1356`): reproducibility makes an error easier to find once
  someone suspects one. No real story carries it. Chapters 9 and 11
  also motivate with invented cases.
- Why it matters: a reader who did not ask to be convinced remembers
  stories, and a mentor will not give a student time on the strength
  of hypotheticals.
- Fix:
  - Add boxed real cases of 150 to 250 words: one in Chapter 1, three
    or four in Chapter 2, one each in Chapters 9 and 11. Draw them from
    the case bank (Section 5) and span at least four fields.
  - Minimum set: Duke/Baggerly and Coombes (2009); the JAMA COPD
    retraction and republication (2019); Reinhart and Rogoff
    (Herndon, Ash and Pollin 2014); Glatard et al. (2015) on results
    that change across operating systems.
  - Chapter 9: one sentence citing Nuijten et al. (2016), already in
    `references.bib:172` but cited nowhere: half of psychology papers
    using significance tests had at least one inconsistent p-value
    (verified, PMC abstract).
  - Chapter 11: one case of a code or data error that changed a
    published result.
  - Pay for the space from R4-002 and R2-05.

### R4-002 The persuasive window is spent on apparatus

- Location: `conventions.qmd:44`; `copyright.qmd:25-35`;
  `index.qmd:70-82`; `01-reproducibility-crisis.qmd:1-331`
- Severity: **blocking**
- Viewpoint: student
- Evidence: verified. `pdftotext` on the 2026-11-09 PDF shows pages
  9-28 for the contents and lists, the Preface at page 29, Conventions
  at 33, the Introduction at 39, and the first real number at 41. The
  lead confirmed that `copyright.qmd` at HEAD still emits
  `\tableofcontents`, `\listoffigures` and `\listoftables`.
  Chapter 2's evidence section starts on page 57, six pages after the
  chapter opens. Reviewer G found 1,859 to 2,624 words before the first
  content section in every chapter.
- Prior: new
- Problem: before any reason to care, the reader meets two license
  statements, about 20 pages of contents and lists, and a Conventions
  page built on terms the book has not yet defined ('nine layers',
  'captures', 'validates', 'gate', 'honest level'). Chapter 2 repeats
  the pattern: a card, a check, a composite, the ladder, an empty stack
  figure and a vocabulary box all come before the evidence.
- Why it matters: the first ten pages are the persuasive window.
- Fix:
  - Move Conventions after the Introduction, or into an appendix
    linked from the first chapter card.
  - Drop the lists of figures and tables, or move them to the back.
  - Remove the second license statement (`index.qmd:70-82`).
  - Open the Introduction with a real case.
  - In Chapter 2, put the evidence directly after a one-paragraph
    orientation, and move or cut the ladder, the stack and the
    vocabulary block, which Chapter 3 defines anyway.

### R4-003 The stated prerequisites exclude the stated reader

- Location: `index.qmd:51-62`; `01-reproducibility-crisis.qmd:44-47`
- Severity: **blocking**
- Viewpoint: student
- Evidence: inspected (text read directly)
- Prior: new. The audience parameter changed:
  `THIRD-REVIEW-PLAN.md:36` assumed R and basic git. This finding does
  not reopen a decision.
- Problem: the Welcome page requires 'Comfort at the command line ...
  using `git` at a basic level' and the ability to render R Markdown or
  Quarto. It names only public health, biostatistics and epidemiology.
  The Chapter 2 card contradicts it ('No R fluency beyond reading a
  short script'), and so does `shell-primer.qmd:4-7`.
- Why it matters: the first page tells the intended reader that the
  book is not for them.
- Fix: rewrite as 'R from one course. No terminal, git, Docker, or
  Quarto experience is assumed; the Shell Primer and Setup Appendix
  take you from a first terminal to a first commit. Examples come from
  health research; the principles apply to any empirical field.'
  Reconcile the Chapter 2 card with this.

### R4-004 No chapter links to the shell primer, and it does not start at first contact

- Location: `shell-primer.qmd:3-23`; `_quarto.yml:78-82`;
  `version-control.qmd:57-64`; `00-intro.qmd:316-330`
- Severity: **blocking**
- Viewpoint: student
- Evidence: inspected. The lead searched every `.qmd` file for
  `shell-primer` or `sec-shell`. The only matches are the primer itself
  and `contents.qmd`, the table of contents. The Chapter 4
  prerequisites name only the git preflight.
- Prior: new
- Problem:
  - Nothing links to the primer: no chapter, card, preface or 'How to
    use this book' section. It sits after the References.
  - It starts at `pwd`. It never says how to open a terminal on macOS
    or Windows, or in RStudio or Positron.
  - It never says which Windows shell to use. PowerShell aliases `ls`,
    `cd` and `rm` with different behavior.
  - It omits `mkdir`, `cat`, quoting, Ctrl-C, Tab, `--help` and `~`.
  - It has no checks or exercises.
  - Its first sentence ('Every chapter in this book runs commands') is
    false for Chapters 1 to 3.
- Why it matters: the first `git init` in Chapter 4 is where the
  novice stalls, and the help that exists is invisible from there.
- Fix:
  - Move the primer and the setup appendix into an unnumbered 'Getting
    set up' part before Chapter 4.
  - Link `@sec-shell` from the prerequisites of Chapters 4, 5, 7 and
    10, and from 'How to use this book'.
  - Add an 'Opening a terminal' section, a recommendation of one
    Windows shell (WSL2, or Git Bash for the git chapters), a table of
    ways to get unstuck, three folded checks, and a five-minute
    exercise.

### R4-005 Authorship of `zzcollab` and `zzrenvcheck` is not disclosed, and the tools cannot be installed from the book

- Location: `preface.qmd:57-71`; `credits.qmd:3`;
  `03-research-compendium.qmd:630`; `09-continuous-integration.qmd:506`;
  `04-dependencies.qmd:691-713`; `glossary.qmd:871-873`;
  `references.bib:916-923`
- Severity: major
- Viewpoint: referee, mentor
- Evidence: inspected (Reviewers A, B, C, F and G independently). Greps
  for 'we developed', 'our tool', 'install zzcollab' and the repository
  URL find nothing.
- Prior: new
- Problem:
  - The preface defends the choice ('honestly motivated') but does not
    say the authors wrote the tools.
  - The credits call `zzcollab` 'the framework at the center of this
    book'.
  - The Five Pillars and the archetypes are cited to an unpublished
    whitepaper by the same 'rgtlab curriculum team', with no URL.
  - `zzrenvcheck` is installed in the main CI workflow from 'a personal
    repository' without naming whose.
  - Chapter 13 calls a single-maintainer tool a 'bus factor of one'
    (`10:1191`), which sits awkwardly beside all of this.
- Why it matters: a referee or mentor who finds the authorship
  independently will discount the whole book. The book's own
  disclosure rules for LLM use make the omission conspicuous.
- Fix:
  - Add to the preface: '`zzcollab` and `zzrenvcheck` are written and
    maintained by the authors of this book; every chapter states the
    principle first and shows how to proceed without them.'
  - Give the repository URL, the license and a pinned version.
  - Give `thomas2026zzcollab` a named author and a resolvable URL or
    DOI.
  - Change 'at the center of this book' to 'the running example's
    framework'.

### R4-006 Decision D2's 'With zzcollab' track is not implemented; tool vocabulary is taught as the field's

- Location: `03-research-compendium.qmd:1020-1035, 1428-1462`;
  `05-containers.qmd:1330-1361`; `10-archiving-sharing.qmd:1370-1373`;
  `08-testing-quality.qmd:1388`; `glossary.qmd:27-30, 498-504, 778-780`
- Severity: major
- Viewpoint: student, referee
- Evidence: inspected. `grep -i 'with zzcollab'` finds nothing, and
  `conventions.qmd:86-124` lists no tool box. In Chapter 5, 'pillar'
  occurs 86 times and 'archetype' 92 times.
- Prior: **fix for D2 incomplete** (REFACTOR-PLAN:2071-2075). This does
  not reopen the decision.
- Problem:
  - Tool commands (`zzc`, `make docker-*`, `make r`, `make style`,
    `zzc verify`) are interleaved with the main text rather than boxed.
  - Several terms are taught and glossed as if they were field
    vocabulary: the Five Pillars, the archetypes, 'profiles',
    'progressive disclosure' (which already has a different meaning in
    interface design) and the `test-baseline-*` naming rule.
  - The established literature grades compendia differently: Marwick
    et al. (2018) use small, medium and large.
- Why it matters: a reader without the tool cannot run the worked
  examples. A student who uses these terms with an outside committee
  member will not be understood.
- Fix:
  - Introduce each construct in neutral words, then attribute the name
    to `zzcollab` once.
  - Box every tool command in a 'With zzcollab' callout, paired with a
    'By hand' block (`usethis::create_package()` plus `mkdir -p`,
    `Rscript -e 'devtools::check()'`, `quarto render`,
    `styler::style_dir()`).
  - Mark the glossary entries '(zzcollab term)'.
  - Add the device to Conventions.

### R4-007 The mentor's objections are unanswered; the student gets neither language nor a personal benefit

- Location: `02-levels-of-reproducibility.qmd:223`;
  `01-reproducibility-crisis.qmd:146`; `preface.qmd:5`
- Severity: major
- Viewpoint: mentor, student
- Evidence: inspected. A grep of Chapters 1 to 3, the preface and the
  Welcome page for policy, funder, career, thesis and dissertation
  finds no persuasive use.
- Prior: new
- Problem:
  - 'Takes too long' gets one paragraph on matching rigor to the
    stakes, with no estimate of time.
  - 'My results have always been fine' gets nothing.
  - 'Reviewers do not ask for it' gets nothing before Chapter 13.
  - 'Software engineering, not science' is answered only abstractly.
  - Nothing helps a first-year student raise the subject with a PI.
  - The benefit to the student (a revision request nine months later,
    a committee re-run, a failed laptop, reusing code across thesis
    chapters, a job-market portfolio) is never stated.
- Why it matters: the mentor controls the student's time, and the
  student acts on near-term personal interest.
- Fix:
  - Add a section to Chapter 2, 'Four objections, and what the evidence
    says', with one paragraph each and the cases from R4-001.
  - Give a concrete cost: L1 in under an hour, a CI template in an
    afternoon.
  - Add a callout, 'Making the case to your lab', with sentences the
    student can use and a first step that needs no buy-in.
  - Add an exercise: a 200-word memo to the PI.
  - Add a paragraph, 'What this buys you'.

### R4-008 Policy mandates are absent from the opening and incomplete in Chapter 13

- Location: `preface.qmd:16`; `10-archiving-sharing.qmd:1026, 1115`
- Severity: major
- Viewpoint: mentor
- Evidence:
  - The preface claim 'journals now ask for the code' is uncited
    (inspected).
  - NIH Public Access Policy in force from 1 July 2025
    (NOT-OD-25-101): verified.
  - The OSTP memo's deadline of 31 December 2025: verified from the
    memo PDF.
  - That OSTP is repealing the memo comes from one news report (AIP
    FYI, 20 May 2026): **unverified as to outcome**.
  - The PLOS Computational Biology code policy (since 2021) and the
    AEA verification policy: verified.
- Prior: new. `coverage-emerging.md:66, 104` set the OSTP memo aside
  as 'concerns manuscripts, not code', which is not a recorded
  decision. The memo also covers supporting data.
- Problem: the strongest answer to 'reviewers do not ask for it' is
  hidden in the last chapter, and even there it is NIH DMS only. There
  is no OSTP memo, no NIH Public Access, no NSF, UKRI, Wellcome or
  Horizon Europe. The journal table lists three health and statistics
  journals.
- Why it matters: a mentor funded by NSF, or outside the United States,
  finds nothing that applies to them.
- Fix:
  - Add a dated paragraph or half-page table of funder and journal
    mandates to Chapter 2, cross-referenced to Chapter 13.
  - Add a funder table to Chapter 13: NIH DMS and Public Access, the
    OSTP memo with its 2026 status hedged, NSF, UKRI, Wellcome and
    Horizon Europe. Open each agency's page before printing.
  - Add PLOS Computational Biology and the AEA to the journal table.
  - Hedge the preface: 'a growing number of journals and funders'.

### R4-009 R-only framing with no bridge for other languages

- Location: `07-literate-programming.qmd:414`; `06-backends-runtimes.qmd`
  (conda only); every chapter from Chapter 6 on
- Severity: major
- Viewpoint: student
- Evidence: inspected. Pimentel et al. (2019) is verified (PDF p. 1:
  24.11 percent of notebooks ran, 4.03 percent reproduced). Proposed
  Python tool names (`uv.lock`, `pixi.lock`) and Stata `dyndoc` are
  unverified.
- Prior: new argument against `THIRD-REVIEW-PLAN.md` Section 7
  ('Python ... out of scope'). The proposal is bridges, not coverage of
  Python.
- Problem: the literate-programming landmines are stated only in R
  terms, although the strongest published evidence for hidden-state
  failures comes from Jupyter. Licensed software inside containers
  (Stata, MATLAB) is never mentioned.
- Why it matters: psychology, economics and engineering students
  cannot map the rules onto their own documents.
- Fix: the translation appendix and boxes described in Section 2, plus
  the Pimentel citation in Chapter 9.

### R4-010 The guidance on restricted data speaks only of PHI

- Location: `_llm-rule.qmd:4`; `version-control.qmd:730-935`;
  `10-archiving-sharing.qmd` (sections on trusted research environments,
  HIPAA and NIH)
- Severity: major
- Viewpoint: student
- Evidence: inspected. The include is 32 lines and appears in 12
  chapters.
- Prior: 'reopens D19' as to placement and length only, not content.
- Problem: psychology and economics students hold licensed survey and
  administrative data, and engineering students hold export-controlled
  or partner-proprietary data. None of these is named, and a 32-line
  PHI box is repeated twelve times.
- Why it matters: the outside reader concludes the book's most careful
  guidance does not apply, when most of it does.
- Fix:
  - Keep the full box once, in Chapter 2 or 4.
  - Elsewhere, use a one-line reminder with a cross-reference.
  - Generalize the wording to 'confidential or restricted data (for
    example protected health information, licensed survey microdata,
    administrative records, export-controlled or proprietary data)'.

### R4-011 Length and cognitive load for the new reader

- Location: `conventions.qmd:180-202`; `preface.qmd:125-139`;
  `09-continuous-integration.qmd`; `06-backends-runtimes.qmd:48`
- Severity: major
- Viewpoint: student, mentor
- Evidence: inspected. `wc -w` gives about 176,000 words in the book
  and about 145,000 on the core path. The chapter cards total about 570
  minutes at 200 words a minute. The reading rate is an assumption.
- Prior: **Reopens D18 and D10.** The new argument is that both were
  decided for readers 'who know R and basic git'. This reader must also
  fit the primer, setup and first-contact debugging into the same ten
  weeks.
- Problem:
  - About 2,000 words of apparatus precede each chapter.
  - Definitions repeat across Chapters 1 to 3 (R2-05).
  - 'A lockfile pins packages but not the OS' is restated about six
    times across Chapters 6 and 7.
  - 'A pipeline captures no determinant' appears about ten times.
  - 'Capture versus validation' appears about nine times in Chapter 12.
  - Chapter 8 (10,000 words on Nix, Slurm, Binder and devcontainers)
    sits between Docker and the first validation chapter.
  - Chapter 12 is 17,400 words, including a second implementation of
    its workflow for GitLab.
- Why it matters: 'this takes too long' is the mentor's first
  objection, and the book's own size supports it.
- Fix:
  1. Offer a labeled minimum viable path of about four weeks, to an
     honest L1 plus a baseline test. Reviewer G's raw report lists its
     section anchors.
  2. Move most of Chapter 8 into an appendix, 'Alternative runtimes and
     backends'. Keep a two-page 'When Docker is not an option' section
     in Chapter 7.
  3. Cut about 3,000 words from Chapter 12. Move the capture test
     matrix to the tool's documentation and the GitLab translation to
     an appendix.
  4. Cut about 2,500 words of repetition from Chapters 6 and 7, and the
     repeated definitions in Chapters 1 to 3.
  5. Mark optional sections in their headings (Chapter 10: Snakemake,
     Nextflow, workflowr, LLM in pipelines; Chapter 11: regulated
     validation, MCSE, parallel streams).

### R4-012 The book has no ending and no call to action

- Location: `10-archiving-sharing.qmd:2249-2317`; `_quarto.yml:74-76`
- Severity: major
- Viewpoint: mentor
- Evidence: inspected
- Prior: new. `reader-e:215` judged the conclusion adequate as
  consolidation, but did not assess its placement or a call to action.
- Problem:
  - 'In conclusion' comes after nine exercises, their solutions, the
    cheat sheet and the further reading.
  - It restates points without a plan, and its one concrete action is
    `zzc verify`.
  - The final part holds a single chapter that mixes team governance,
    registries, deposit, restricted data, policy and the conclusion.
- Why it matters: a book that opens by persuading should close by
  telling the persuaded reader, and the doubting mentor, what to do
  next.
- Fix: write a separate closing chapter of 1,500 to 2,000 words with:
  - an adoption ladder by time (this week, this month, before
    submission);
  - a one-page brief for the mentor (cost, gain, mandates, risk);
  - a return to the opening cases;
  - advice for when the lab does not do this yet.

### R4-013 Machine prerequisites and failure paths are missing

- Location: `setup-appendix.qmd:1-15`; `08-testing-quality.qmd:2098`;
  `pipelines.qmd`; `06-backends-runtimes.qmd:1261`
- Severity: major
- Viewpoint: student
- Evidence: inspected. Greps for Rtools, xcode-select and install
  instructions for `make` find nothing. The `precommit` setup steps and
  the fact that Apptainer is Linux-only are verified against their
  official documentation.
- Prior: new
- Problem:
  - The setup appendix covers only Docker and git. Nothing says how to
    install R, an editor, Quarto, renv, a TeX distribution, `make` or
    the `pre-commit` framework, and there is no Linux section.
  - The R `precommit` package does nothing until the Python
    `pre-commit` tool is installed and `use_precommit()` is run.
  - Apptainer needs Linux, WSL2 or Lima.
- Why it matters: the first install failure comes before any concept.
- Fix:
  - Open the setup appendix with a 'Machine checklist' table: tool,
    first chapter that needs it, install page, check command, expected
    output.
  - Add a 'Before you run this' box to Chapters 10 and 11.
  - Add a 'Where Apptainer runs' note to Chapter 8.

### R4-014 YAML is required but never taught

- Location: `09-continuous-integration.qmd:53`; 11 uses across the book
- Severity: major
- Viewpoint: student
- Evidence: inspected (no definition, and no glossary entry)
- Prior: new
- Problem:
  - YAML carries the Quarto headers, the CI workflows, `CITATION.cff`
    and `zzcollab.yaml`.
  - Chapter 12 says 'no YAML is written from scratch here', yet its
    Exercise 4 asks for a complete `.gitlab-ci.yml`.
  - `${{ }}` expressions and block scalars are never explained.
- Why it matters: indentation errors are among the first failures a CI
  novice meets.
- Fix:
  - Add a one-page 'Reading YAML' section to the shell primer and a
    glossary entry.
  - Add a six-row 'Reading the workflow' table beside the first
    workflow in Chapter 12.

### R4-015 Acronyms are used without expansion

- Location: first uses are listed in Reviewer G's acronym audit
  (for example `01-reproducibility-crisis.qmd:680`)
- Severity: major
- Viewpoint: student
- Evidence: inspected. A script pass found the first uses, which were
  then checked by hand.
- Prior: new
- Problem: CRAN, BLAS, LAPACK, NIH, FDA, CFR, HIPAA, QEMU, SHA and IRB
  are never expanded. CI is formally expanded only in Chapter 12, and
  WSL only after its first use.
- Why it matters: to a non-biostatistics novice, acronyms in the
  persuasive chapters read as insider talk.
- Fix:
  - Expand each at first use in book order, and add glossary entries.
  - Add a lint to the manuscript-invariants test.

### R4-016 Two glossary entries contradict corrected chapter text

- Location: `glossary.qmd:748`; `glossary.qmd:195`; `glossary.qmd:211-213`
- Severity: major
- Viewpoint: referee
- Evidence: inspected
- Prior: **fix for Finding 30 (T1-4) incomplete; fix for Finding 33
  incomplete.**
- Problem:
  - 'The same digest always denotes the same bytes' contradicts
    Chapter 7, which distinguishes index digests from per-platform
    manifest digests.
  - The `digest()` entry recommends hash comparison for computational
    outputs, which Chapter 12 rejects for floating-point estimates.
  - The `docker inspect` entry contradicts the cheat sheet's
    `buildx imagetools inspect`.
- Why it matters: the glossary restates errors the third review
  classed as Tier 1.
- Fix: rewrite all three entries to match the chapters. Reviewer G's
  raw report gives the wording.

### R4-017 Docker Desktop licensing

- Location: `06-backends-runtimes.qmd:334`;
  `05-containers.qmd:850-852`; `setup-appendix.qmd:141-151`
- Severity: major
- Viewpoint: mentor
- Evidence: verified, independently by Reviewer D and by the lead.
  The lead downloaded the agreement with `curl` on 2026-11-25. It is
  marked 'Last updated on August 26, 2026'.
  - 'Educational Use' is 'limited to individual members of an
    educational organization enrolled in a classroom learning
    environment solely for academic or research purposes'. It 'does
    not include use by multiple individuals under a coordinated
    arrangement', with members of the same 'research group' given as
    the example.
  - 'Government Entities shall not use Docker Desktop ... without a
    paid subscription'. The definition includes 'state, local, or
    public education entities' of a US state.
  - Reviewers G and H read the shorter docs page
    (`docs.docker.com/subscription/desktop-license`), which lists
    'Education' without qualification. The agreement is the binding
    document.
- Prior: new. Phase 25 row A2-48 verified only the shorter page.
- Problem: the book presents education as an exception institutions
  merely disagree about. Chapter 7 says 'unlicensed' without
  explanation, and the setup appendix tells students to ask IT for
  Docker Desktop without mentioning licensing.
- Why it matters: a lab following Chapter 7 may be out of compliance,
  and at a US public university the government-entity clause may apply
  outright. The mentor is the one who will be asked to pay.
- Fix:
  - State the August 2026 terms with their date.
  - Add one sentence each to Chapter 7 and the setup appendix pointing
    to Chapter 8.
  - Name free alternatives after checking their current licenses:
    Podman Desktop, Docker Engine on Linux or WSL2, Colima.

### R4-018 Rocker's 'amd64 only' claim is out of date for the book's own R

- Location: `05-containers.qmd:914`; `setup-appendix.qmd:24`;
  the Chapter 7 cheat sheet (`05:2076`)
- Severity: major
- Viewpoint: referee
- Evidence: verified (Docker Hub tags API, 2026-11-25). Tag 4.4.0 of
  `rocker/tidyverse` is amd64 only. Tags 4.6.1 and 4.6.2 are amd64 and
  arm64. `rocker/verse` 4.6.1 and 4.6.2 are amd64 only.
- Prior: new
- Problem: a claim true of 4.4.0 is stated as a fact about the profile
  bases. A Mac reader on 4.6.x with the tidyverse base will build a
  native arm64 image silently, which is the riskier case.
- Why it matters: the setup appendix exists to predict what a Mac
  student sees, and here it predicts wrongly.
- Fix:
  - Replace the claim with a check: run
    `docker buildx imagetools inspect <image>`, and if no
    `linux/arm64` line appears, the flag is required.
  - Keep the rule that the book always passes
    `--platform linux/amd64`.
  - Rebuild the showcase on `rocker/r-ver:4.6.x`, using Chapter 6's
    lockfile unedited.

### R4-019 Versions are typed by hand, and relative time phrases will age

- Location: Reviewer G's aging audit (for example
  `07-literate-programming.qmd:410`, 'most recent is Quarto')
- Severity: minor
- Viewpoint: referee
- Evidence: inspected. `_variables.yml` exists, but the book never uses
  it (no `{{< var >}}`).
- Prior: new
- Problem: renv 1.2.3, git 2.56.0, targets 1.12.0, R 4.4.0, 4.4.1 and
  4.6.1, `actions/checkout` v7.0.1 and Docker Desktop menu paths are
  typed in many places. 'Most recent', 'is young' and 'will change in
  Git 3.0' will become false. R 4.6.2 and renv 1.3.1 are already out.
- Fix:
  - Keep the dated 'checked on' stamps.
  - Keep versions in one place (`_variables.yml` or computed from
    `renv.lock`).
  - Add a colophon table of the versions and policies this edition was
    checked against.
  - Replace relative phrases with dated ones.

### R4-020 The glossary lacks novice terms and has duplicate entries

- Location: `glossary.qmd:3-8`, together with the overlapping and
  misfiled entries Reviewer G lists
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem:
  - There are no entries for Dockerfile, YAML, shell, terminal, working
    directory, path, environment variable, PHI, IRB, CRAN, hash or
    tolerance.
  - Four entries cover RNG seeding.
  - 'Recipe' has only Make's meaning, although the book uses it 46
    times for Dockerfiles.
  - 'The Five Pillars' and 'The level ladder' are filed under T.
- Fix: add the missing entries, merge the overlapping ones, split
  'Recipe', and refile the misplaced entries.

---

## 4. Chapter-by-chapter findings

Blocking and major findings are given in full. Minor findings are
tabulated; each row's raw report holds the full text. Problems already
covered by a global finding above are not repeated.

### Chapter 1, Introduction (`00-intro.qmd`)

#### R1-01 The 'health-sciences research' claim rests on evidence from other fields

- Location: `00-intro.qmd:43`; `01-reproducibility-crisis.qmd:53`
- Severity: major
- Viewpoint: referee
- Evidence: verified. The arXiv HTML of Saju et al. describes 'R
  projects in the social sciences and psychology'. Trisovic's field mix
  is unverified.
- Prior: new
- Problem: none of the four studies cited re-executed health-science
  analyses.
- Why it matters: a clinical mentor will see that the headline claim
  about their field rests on other fields' data.
- Fix:
  - Add Naudet et al. 2018 (*BMJ*, doi:10.1136/bmj.k400; verified
    abstract): data were available for 17 of 37 randomized trials, and
    14 of those 17 reproduced fully on their primary outcomes.
  - Otherwise, write 'published research, including in the health
    sciences'.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R1-02 | `00-intro.qmd:204-235` | student, inspected | Thirteen tools are named in about 60 lines of an introduction that says it avoids a catalog. Cut to one sentence. |
| R1-03 | `_habits.qmd:9` | student, inspected | Habits 4 and 5 use 'gate', 'baseline' and 'tolerance' before they are defined. Gloss each term, or show a three-habit preview here. |
| R1-04 | `00-intro.qmd:135` | referee, inspected | `fig-failure-rates` compares studies, findings, files and scripts on one axis, and the text calls the results 'comparably low'. Label each bar with its unit. |
| R1-05 | `00-intro.qmd:107`; `01:374` | referee, verified | Trisovic is quoted at the rate before cleaning only. Add that automatic cleaning raised success to about 44 percent. |
| R1-06 | `references.bib:442` | referee, verified | `saju2025` cites arXiv, but the paper was published in the ICWSM 2025 workshop proceedings (doi:10.36190/2025.49) with four named authors. The text uses three different quantifiers for one figure. |
| R1-07 | `00-intro.qmd:96`, `:22` | mentor, inspected | 'Grim', 'damning' and 'Every quantitative health scientist has met' read as advocacy. Use 'sobering' and 'Many analysts eventually meet'. |

### Chapter 2, The Reproducibility Crisis (`01-reproducibility-crisis.qmd`)

#### R2-01 The chapter leads with evidence it later calls irrelevant

- Location: `01-reproducibility-crisis.qmd:1382`
- Severity: major
- Viewpoint: mentor
- Evidence: inspected
- Prior: new
- Problem: the replication studies (OSC, Begley) open the case, and an
  exercise solution then says they measure 'a problem this book does
  not address and cannot fix'.
- Why it matters: a careful mentor will see borrowed alarm.
- Fix:
  - Lead with computational cases (Trisovic, Saju, Brodeur, and the
    real cases from R4-001), with OSC, Begley and Baker as context.
  - Put the 'stronger version' argument in the body: a field that
    cannot re-execute its analyses cannot diagnose why a replication
    failed.

#### R2-02 The 2026 *Nature* reproduction and replication studies and Errington (2021) are absent

- Location: `01-reproducibility-crisis.qmd:365`
- Severity: major
- Viewpoint: referee
- Evidence: verified. The PDF of Brodeur et al. (2026,
  doi:10.1038/s41586-026-10251-x) reports 'more than 85% of published
  claims were computationally reproducible' in a sample the authors
  call 'highly selective'. The abstract of Tyner et al. (2026, SCORE)
  reports 55.1 percent of 274 claims. The abstract of Errington et al.
  (2021) reports 46 percent success, with effects 85 percent smaller.
- Prior: **fix for THIRD-REVIEW-PLAN Section 7 incomplete** (it
  advised citing the I4R study; none is cited).
- Problem: the 'growing body of work' stops at 2025.
- Why it matters: Brodeur is the strongest evidence that enforced
  deposit works, which is the mentor's practical question.
- Fix:
  - Add two or three sentences after the Saju paragraph.
  - Cite SCORE beside OSC.
  - Cite Errington beside Begley.

#### R2-03 Begley and Ellis are cited without their caveats

- Location: `01-reproducibility-crisis.qmd:346`
- Severity: major
- Viewpoint: referee
- Evidence: verified. The Nature page text says papers 'were
  deliberately selected that described something completely new', and
  none of the 53 is named.
- Prior: new. Phase 25 checked the number, not the caveats.
- Problem: the second piece of evidence cannot itself be checked. The
  chapter also says 'could be reproduced' for what was a replication.
- Why it matters: it hands the skeptic an easy rebuttal in a book about
  claims that can be checked.
- Fix: write 'confirmed only 6 of 53, in a commentary that chose
  deliberately novel findings and did not name the studies', and cite
  Errington et al. (2021) beside it.

#### R2-04 A 180-line section on LLM and agent governance sits in the persuasive chapter

- Location: `01-reproducibility-crisis.qmd:1014`
- Severity: major
- Viewpoint: student
- Evidence: inspected. Lines 932 to 1110 cover protected paths, OWASP
  prompt injection, `LLM-USE.md`, commit trailers and NIH grant rules.
- Prior: new (placement only; the content came from Phase 22)
- Problem: the section points ahead to six later chapters, and it
  dilutes the one persuasive point about AI: that a model's output is
  not reproducible.
- Why it matters: it doubles the jargon load of the chapter meant to
  persuade.
- Fix:
  - Keep one paragraph in Chapter 2.
  - Move `sec-llm-delegate` and `sec-llm-disclosure` to Chapter 4 or an
    appendix.

#### R2-05 Definitions and the stack paragraph appear two or three times across Chapters 1 to 3

- Location: `00-intro.qmd:211`; `01:629-630`; NAS definitions at
  `00:57-79`, `01:437-457` and `02:634-655`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: **Reopens D18** (Finding 38). The new argument is that this
  repetition is what delays the first case in each chapter.
- Problem: the same sentence appears verbatim at `00:211` and
  `01:629`, and the NAS definitions and the Peng spectrum appear three
  times.
- Why it matters: the repetition takes up the pages where persuasion
  has to happen.
- Fix: keep the vocabulary in Chapter 2 and the stack in Chapter 3,
  reduce the Chapter 1 versions to pointers, and spend the space on
  cases.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R2-06 | `01:355` | referee, verified | The Baker survey is quoted without the article's own warning that the sample was self-selected. Add one clause. |
| R2-07 | `01:136` | mentor, inferred | In the trial-auditor vignette, a shift in the third decimal place makes a confidence interval cross the null, which is implausible. Replace it with a real case or a thesis-revision scenario. |
| R2-08 | `01:433` | referee, unverified | 'Most widely followed in the health sciences' has no source and contradicts `02:676-679`. Use 'a widely cited settlement this book adopts'. |
| R2-09 | `01:116` | student, inspected | The 'from earlier chapters' check comes before the orientation and uses terms not yet taught (Rocker, L2, CI). Move it to the end of the chapter. |
| R2-10 | `01:429` | referee, unverified | Goodman (2016), the body of Leek and Peng, and the ACM badge definitions are still unopened. Use 'conflicting meanings' until someone with library access checks them. |
| R2-11 | `00:100`; `01:340` | referee, verified | Replication studies are described in re-execution words ('reproduced', 're-ran'). Use 'confirmed' and 'conducted replications of'. |

### Chapter 3, Levels of Reproducibility (`02-levels-of-reproducibility.qmd`)

No blocking or major findings beyond R4-002, R4-007 and R2-05.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R3-01 | `02:132` | referee, unverified | The optimizer-default vignette could be a real case from lme4's NEWS. Check the NEWS file and, if a real change fits, name the package and version. |
| R3-02 | `02:750` | student, inspected | 'Two numbering schemes' spends about 60 lines and an exercise on a tool-internal scale, in week 1. Reduce it to a footnote. **Reopens D18.** |

### Chapter 4, Version Control (`version-control.qmd`)

#### R4-V01 Public versus private repositories is never discussed

- Location: `version-control.qmd:1420`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: the chapter equates L0 with a public remote. It never says
  that a health-data project should normally start private (or on an
  institutional forge), that making a repository public exposes its
  entire history, or whether a private repository counts as
  'locatable'.
- Why it matters: this is the most consequential click a student makes
  on GitHub.
- Fix: add a paragraph and a check: create the repository private
  unless publication has been decided, and before making it public,
  audit `git log --all --stat`.

#### R4-V02 Exercise 5 needs commands the chapter never teaches

- Location: `version-control.qmd:1871`; solution at `2089-2105`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: `git clone`, `fetch`, `upstream` and opening a pull request
  are never taught. The GitHub CLI appears only in the appendix.
- Why it matters: the realistic first-week task, cloning the lab's
  repository, has no instructions.
- Fix: add a 'Joining an existing project' subsection covering
  `clone`, `pull`, `gh repo clone` and `gh pr create`, and finish the
  Exercise 5 solution.

#### R4-V03 The PHI rule's second clause reads as an exemption

- Location: `version-control.qmd:780-782`
- Severity: major
- Viewpoint: student
- Evidence: inspected (read by the lead): 'not even in a local
  repository that will ever be pushed'
- Prior: **fix for T1-8 incomplete**
- Problem: the clause is ungrammatical, and its natural reading exempts
  a repository that is never pushed.
- Why it matters: this is the chapter's gravest rule.
- Fix: write '... and not even in a local repository that is never
  pushed.'

#### R4-V04 The history-rewrite recipe omits the install and the version requirement

- Location: `version-control.qmd:821`
- Severity: major
- Viewpoint: student
- Evidence: verified. GitHub's documentation says
  `--sensitive-data-removal` needs `git filter-repo` 2.47 or later,
  installed separately.
- Prior: new
- Problem: in an incident, the command fails with 'not a git command'
  or 'unknown option'.
- Why it matters: it fails under time pressure and pushes the reader
  toward bad advice.
- Fix: add the install commands and `git filter-repo --version`.

#### R4-V05 Regulated-records material overloads a novice chapter

- Location: `version-control.qmd:473-507, 1470-1478, 2130-2138`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new. D20 kept the material; this finding concerns placement
  only.
- Problem: backdated commits, SHA-256, signing and 21 CFR 11.10(e) and
  11.50(a) all appear in the core path, and 11.50(a) appears three
  times.
- Why it matters: they crowd out the everyday cycle a novice must
  automate first.
- Fix: put them in one collapsible 'For regulated work' callout.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R4-V06 | `vc:1647` | referee, inspected | The `check-ignore` transcript uses `raw_data/`, which defeats the `!` re-include the chapter recommends. Use `raw_data/*`. |
| R4-V07 | `vc:747` | student, inspected | Large files and line endings are not signposted. Add GitHub's 100 MiB limit, Git LFS (which does not make PHI safe), and a pointer to the Windows line-endings step. |
| R4-V08 | `vc:765-769` | referee, verified | Secret scanning and push protection are not mentioned. Add a sentence and a row to the refusals table; it detects token formats, not PHI. |
| R4-V09 | `vc:58-61` | student, inspected | No graphical route is given (RStudio's Git pane, Positron, GitHub Desktop). Add one paragraph. |
| R4-V10 | `vc:339-342, 441-461` | referee, unverified | 'Still names it `master`' and 'SHA-1 remains the default' will become false with Git 3.0. Qualify both 'as of git 2.x'. |
| R4-V11 | `vc:1283-1285` | student, inspected | '`amend` and `rebase` discussed earlier' were only named. Fix the cross-reference. |
| R4-V12 | `vc:1688-1707` | student, inspected | The worked example never creates the remote or mentions authentication with a token. Add two lines and `gh repo create --private`. |
| R4-V13 | `vc:59-61`, 1168-1215 | student, inspected | The plotting code for figures is printed in novice chapters, and the prerequisite miscounts the R chunks. Set `echo: false` on figure chunks. |

### Chapter 5, The Research Compendium (`03-research-compendium.qmd`)

#### R5-01 The chapter's facts about `zzcollab` are out of date: six archetypes, not five

- Location: `03-research-compendium.qmd:1026`
- Severity: major
- Viewpoint: referee
- Evidence: verified. `zzcollab/modules/config.sh:574` lists
  'manuscript, analysis, book, package, simulation, blog'. This
  repository's `.zzcollab-state` says `archetype=book`.
- Prior: new. REFACTOR-PLAN:1711 already noted six.
- Problem: the table, figure, objectives, exercises and glossary
  hard-code five archetypes. The book's own repository uses the sixth,
  which the chapter never mentions.
- Why it matters: `zzc help` contradicts the chapter.
- Fix: teach six, or say five of six and why. Better, compute the list
  from the tool.

#### R5-02 The worked example uses a deprecated command, and its 'gate' fixes problems instead of failing

- Location: `03-research-compendium.qmd:1430, 1448`
- Severity: major
- Viewpoint: referee
- Evidence: verified. The zzcollab sources show that `check-renv` is
  documented as 'strict + auto-fix', that `check-renv-no-fix` is the
  variant that fails, and that `zzc analysis` is a deprecated alias.
- Prior: **fix for Finding 32 incomplete** (the same defect, now in
  Chapter 5)
- Problem: the gate cannot fail, which breaks habit 4. The example also
  runs `make docker-*` two chapters before Docker is taught.
- Why it matters: the chapter's one demonstration of a gate uses a
  command that cannot fail.
- Fix: use `zzc init --archetype analysis` and
  `make check-renv-no-fix`, or the neutral path from R4-006.

#### R5-03 The 'seed determinism' label contradicts the chapter's own baseline rule

- Location: `03-research-compendium.qmd:1211`, together with
  `tbl-archetypes`, `fig-gates` and four solutions
- Severity: major
- Viewpoint: referee
- Evidence: inspected
- Prior: **fix for a Tier 2 item incomplete**
- Problem: the prose was corrected, but the table, the figure and the
  solutions still name the gate by the property the text calls
  insufficient.
- Why it matters: students remember tables and figures.
- Fix: rename it 'Seeded baseline' everywhere.

#### R5-04 Package-development vocabulary is used without definition

- Location: `03-research-compendium.qmd:44-46, 598-610`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: tarball, roxygen, `NAMESPACE`, `Imports`, `Suggests`,
  `@export`, vignette and `load_all()` all appear without a gloss.
- Why it matters: the chapter's central argument rests on these terms.
- Fix: add six one-line entries to the vocabulary box, pointing to
  *R Packages* (2e).

#### R5-05 The archetype-weight table points ahead to six chapters

- Location: `03-research-compendium.qmd:1349-1357`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: a 5-by-6 table of terms such as 'union lockfile', 'sealed
  render' and 'R-universe' sits in the core path.
- Why it matters: it is the densest page in the chapter, and none of it
  is actionable yet.
- Fix: move it to Chapter 13 or the cheat-sheet index.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R5-06 | `vc:878-896` | student, inspected | Chapter 4 borrows the archetypes before Chapter 5 defines them. Move the comparison and Exercise 3 to Chapter 5. |
| R5-07 | `03:1429-1450` | student, inspected | The `$` prompts break copy and paste, and the convention is inconsistent across chapters. Drop them (see also `conventions.qmd:17-22`). |
| R5-08 | `03:1813-1817` | referee, inspected | 'Universal gate' is overstated for an analysis whose `R/` is empty. Add the qualifier. |
| R5-09 | `03:1074-1078` | referee, inspected | An uncited 'representative deployment' names a real study population. Cite it or call it hypothetical, and add non-health examples. |
| R5-10 | `03:2053-2058` | referee, inspected | Further reading cites *R Packages* 1e and spells Nüst two ways. Cite `wickham2023` and use 'Nüst'. |

### Chapter 6, Pinning Packages with renv (`04-dependencies.qmd`)

#### R6-01 The opening `dplyr` story does not match the `dplyr` NEWS

- Location: `04-dependencies.qmd:152`; `04:206-209`
- Severity: major
- Viewpoint: referee
- Evidence: verified (`curl` of the dplyr NEWS). The 1.2.x entries
  contain no change to a grouping default. Version 1.1.0 changed the
  ordering in `group_by()` to the C locale.
- Prior: new
- Problem: an invented package change is presented as a familiar real
  situation.
- Why it matters: it violates the accuracy goal when a real change is
  available.
- Fix: rebase the story on the real 1.1.0 C-locale change and cite the
  NEWS entry, or label it hypothetical.

#### R6-02 Logic error in the dependency-triad answers

- Location: `04-dependencies.qmd:896`; `04:1516-1523`
- Severity: major
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: the answers claim that a package missing from `DESCRIPTION`
  must also be missing from the lockfile. It can still be recorded
  there, as a transitive dependency or through an implicit snapshot.
- Why it matters: it is the chapter's one formal argument.
- Fix: write 'Only the first inclusion is known to fail; check the
  lockfile with `renv::status()`.'

#### R6-03 The dependency gate relies on the author's tool when `renv` already provides the check

- Location: `04-dependencies.qmd:812`; `04:691-713`
- Severity: major
- Viewpoint: referee
- Evidence: verified. renv's reference pages show `status()` reporting
  packages 'used and not recorded', and `dependencies()` parsing
  `.Rmd` and `.qmd` files.
- Prior: new
- Problem: the 'code-only scanner' is a straw man, and the built-in
  check is never taught.
- Why it matters: a reader without the tool is not taught the check
  they already have.
- Fix:
  - Teach `renv::status()` first, with a CI line whose behavior has
    been checked.
  - Present `zzrenvcheck` second, for what it adds.

#### R6-04 The auto-snapshot hook overrides the analyst's judgment, and the tool's snapshot type differs from the book's

- Location: `04-dependencies.qmd:520`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (`zzcollab templates/.Rprofile:136-140, 222-230`).
  The effect on packages used only in scripts is inferred.
- Prior: new
- Problem: judgment 1 makes snapshot timing the analyst's call, yet the
  tool snapshots on every session exit. New projects are initialized
  with `explicit` snapshots, while this repository uses `implicit`.
- Why it matters: the reader cannot tell which behavior governs their
  lockfile.
- Fix: state the default and how to disable it, and record the
  snapshot type as a tool issue.

#### R6-05 Current tools are missing: rig, pak, system requirements, Bioconductor, arm64 binaries

- Location: `04-dependencies.qmd:986-1013, 914-959`
- Severity: major
- Viewpoint: referee
- Evidence: verified (renv NEWS and CRAN; Posit's Public Package
  Manager page)
- Prior: new
- Problem: the chapter says the lockfile cannot install R but never
  names `rig`. It omits `pak`, `renv::sysreqs()` and how renv records
  Bioconductor releases, and it treats Linux binaries as amd64 only.
- Why it matters: for students without containers, `rig` is the only
  step between L1 and Docker.
- Fix: add about 300 words to 'The limits of renv'.

#### R6-06 Undefined forward references and an uncited whitepaper

- Location: `04-dependencies.qmd:236-237, 1321-1327, 1704-1734`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: 'Develop below' is never delivered. The 'two-test
  procedure', 'your stated convention' and the 'oracle' rule are used
  before they are defined, and the chapter mentions a Dockerfile one
  chapter early.
- Why it matters: the novice is asked to apply rules nobody has given
  them.
- Fix: state the two tests with a three-row example, and cite the
  whitepaper or remove the reference.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R6-07 | `04:946-952` | student, inspected | The HTTP user-agent requirement is too vague to act on. Give the `options(HTTPUserAgent = ...)` line. |
| R6-08 | `04:1466-1469` | referee, unverified | 'Current `renv` does not write a `Hash`' may hold only for enriched records. Test it and hedge. |
| R6-09 | `04:361-363` | referee, verified | renv 1.3.1 was released five days before the excerpt was written with 1.2.3. Add 'stable across 1.1.0 to 1.3.1'. |
| R6-10 | `04:1384-1388` | student, unverified | The `rang` exercise implies Docker is needed. Name `rang::resolve()`. Note also that `rang` was archived on CRAN on 2026-08-22 (verified; see R13-08). |

### Chapter 7, Containers (`05-containers.qmd`)

#### R7-01 The chapter never shows how to run a container or get the project into one

- Location: `05-containers.qmd:415-427`
- Severity: **blocking**
- Viewpoint: student
- Evidence: inspected. `grep 'docker run' 05-containers.qmd` finds
  nothing. The book's first `docker run` is at `06:316`, and the
  showcase Dockerfile copies only `renv.lock`.
- Prior: new
- Problem: the reader can build an image but has no way to use it
  without `zzc`'s `make r`.
- Why it matters: the reader cannot run the analysis inside the L2
  recipe, which fails Section 2's test of following a chapter without
  the tool.
- Fix: add a section, 'Running the analysis inside the image', with
  three commands and their output: `docker build --platform`,
  `docker run --rm -v "$PWD":/project -w /project ... Rscript ...`,
  and an interactive session. Include the WSL2 filesystem note and one
  check question.

#### R7-02 The worked example's tool contradicts the chapter's platform and thread rules

- Location: `05-containers.qmd:1343`; `05:932-935`; `05:1363-1370`
- Severity: **blocking**
- Viewpoint: referee
- Evidence: inspected (zzcollab source). `templates/Makefile:47-52`
  selects `linux/arm64` on arm64 hosts.
  `modules/docker.sh:1223-1227` sets `OMP_NUM_THREADS` only.
- Prior: **fix for Finding 30 incomplete.** D15 recorded the arm64
  default as a tool issue, but the chapter still tells the reader the
  tool implements the book's rule.
- Problem: the chapter calls the generated Dockerfile 'in essence, the
  one shown earlier'. On a Mac, however, the tool produces the native
  arm64 image with one thread variable that the chapter warns against.
- Why it matters: the worked example is the part a novice actually
  runs.
- Fix: pass `PLATFORM=linux/amd64` in the text and add
  `OPENBLAS_NUM_THREADS` to the tool, or list the differences
  explicitly.

#### R7-03 No guidance on when not to use Docker, or where Docker is unavailable

- Location: `05-containers.qmd:37-50, 443-459, 847-860`
- Severity: major
- Viewpoint: mentor
- Evidence: inspected
- Prior: new
- Problem: the chapter assumes Docker Desktop. It does not say that
  high-performance computing (HPC) clusters rarely allow Docker, that
  licensing may forbid it (R4-017), or that some analyses do not need
  L2. The setup appendix is not among its prerequisites.
- Why it matters: 'Does my student need this?' is the mentor's first
  question.
- Fix: add a three-row callout, 'Do you need a container, and can you
  run one?', and name the setup appendix in the prerequisites.

#### R7-04 The image explanation omits the kernel, and 'recipe' names two things

- Location: `05-containers.qmd:406`; `05:402-403, 431`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: an image is called 'quite literally, a snapshot of a fully
  installed computer'. In fact it contains no kernel, and Docker
  Desktop runs a hidden Linux virtual machine. The text also calls both
  the image and the Dockerfile a 'recipe'.
- Why it matters: the virtual machine explains Docker Desktop's
  resource limits and why the CPU can still change results.
- Fix: correct the sentence, use one analogy, and add a
  Dockerfile-to-image-to-container diagram.

#### R7-05 The GDAL failure that opens the chapter is never fixed, and `apt` packages are unpinned

- Location: `05-containers.qmd:162-170, 796-808`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (no `apt-get` in Chapter 6 or 7). That renv has
  had `sysreqs()` since 1.1.2 is verified.
- Prior: new
- Problem: no Dockerfile installs a system library. Packages installed
  with `apt` resolve against the live archive at build time.
- Why it matters: spatial, imaging and XML packages are common, and a
  reader copying the showcase hits the chapter's own opening failure.
- Fix:
  - Add an `apt-get install libgdal-dev ...` variant.
  - Add a paragraph saying `apt` packages are fixed only in the built
    image.
  - Show `renv::sysreqs()`.

#### R7-06 Emulation is presented as a cost in time only

- Location: `05-containers.qmd:949`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (the zzcollab sources note that QEMU emulation
  crashes pandoc). Verified: Apple says macOS 27 is the last release
  to fully support Rosetta. Docker's behavior after macOS 27 is
  unverified.
- Prior: new (concerns wording, not D15)
- Problem: emulated builds can crash. The Rosetta option is not
  mentioned, and the book's always-amd64 strategy is exposed to a
  platform change during the book's life.
- Why it matters: a student whose emulated build crashes will assume
  the fault is theirs.
- Fix: write 'slower and occasionally fails outright'; give the
  Rosetta and build-on-CI routes; add a row to the symptom table.

#### R7-07 Disk use and resource failures are not addressed

- Location: `05-containers.qmd:505-520`
- Severity: major
- Viewpoint: student
- Evidence: verified (Docker Hub compressed sizes: verse 1.96 GB,
  tidyverse 1.1 GB, r-ver 0.42 GB)
- Prior: new
- Problem: the chapter argues from image size without giving any
  sizes, and never shows `docker system df` or `docker image prune`.
- Why it matters: a 256 GB laptop fills up within weeks.
- Fix: add a table of sizes and a 'Housekeeping' paragraph.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R7-08 | `05:1283` | referee, inspected | 'Works on my machine cannot arise' contradicts the chapter's own statement that the CPU still matters. Qualify it. |
| R7-09 | `05:1858-1860` | student, inspected | The Exercise 3 solution recommends tidyverse, while the worked example chooses minimal. **Fix for reader-b incomplete.** |
| R7-10 | `05:1217-1220` | referee, unverified | `rocker/r-ver` lacks pandoc, qpdf and LaTeX for `R CMD check --as-cran`. Add the qualifier. |
| R7-11 | `05:1213-1216` | referee, unverified | 'A manuscript needs the publishing base' ignores Typst and TinyTeX. See R9-03. |
| R7-12 | `05:611-667` | referee, verified | The tag-rebuild figure narrates rebuilds of a 4.4.0 tag that has not changed since 2024. Label it 'illustrative'. |
| R7-13 | `05:1738-1739` | referee, inspected | 'Chapter 6' is typed beside a cross-reference. Delete it. |
| R7-14 | `05:744-750` | referee, inspected | The `WORKDIR` rationale cites `renv::init()`, which the recipe does not call. Reword. |

### Chapter 8, Backends and Runtimes (`06-backends-runtimes.qmd`)

#### R8-01 The Binder worked example introduces a Dockerfile that is not there

- Location: `06-backends-runtimes.qmd:1014`
- Severity: major
- Viewpoint: student
- Evidence: verified. `git show 343c589` shows the block was deleted,
  and the lead read the text: the sentence ends in a colon followed by
  two blank lines.
- Prior: **fix for A2-41 incomplete**
- Problem: Phase 25 removed the block instead of replacing it.
- Why it matters: this is the only place that shows the Binder route
  that preserves the pin.
- Fix: restore the two-line Dockerfile proposed in A2-41. Add a lint
  for a colon followed by a blank line.

#### R8-02 Rootless Podman also needs administrator setup

- Location: `06-backends-runtimes.qmd:246`; `glossary.qmd:138-141`
- Severity: major
- Viewpoint: referee
- Evidence: verified (the Podman rootless tutorial requires
  `/etc/subuid` entries, and root must add them)
- Prior: new
- Problem: the chapter claims Podman and Apptainer 'run without
  administrative rights'.
- Why it matters: students will hit `newuidmap` errors on clusters.
- Fix: correct the sentence and the glossary entry, and change
  Podman's 'best fit' in the table.

#### R8-03 A pinned image does not pin the CPU

- Location: `06-backends-runtimes.qmd:970`
- Severity: major
- Viewpoint: referee
- Evidence: inferred (OpenBLAS's run-time selection of code paths by
  CPU)
- Prior: new
- Problem: the move from laptop to cluster implies identical numbers.
- Why it matters: a student will blame the pin for a difference in the
  sixth decimal.
- Fix: add two sentences linking to the tolerance-based baseline.

#### R8-04 Container commands omit `--platform`, contrary to D15

- Location: `06-backends-runtimes.qmd:319`, with other Podman and
  Apptainer commands
- Severity: major
- Viewpoint: referee
- Evidence: inspected (the flag appears only in the LLM section); that
  `apptainer build` takes `--arch` is verified
- Prior: **fix for Finding 30 and D15 incomplete**
- Problem: the multi-architecture failure fixed in Chapter 7 returns
  here.
- Why it matters: every Apple Silicon reader meets it.
- Fix: add `--platform linux/amd64` and `--arch amd64` to the commands,
  plus one sentence of explanation.

#### R8-05 Apptainer runs only on Linux, and no failure paths are given

- Location: `06-backends-runtimes.qmd:1261`; `06:1142`
- Severity: major
- Viewpoint: student
- Evidence: verified (Apptainer's install documentation says a Linux
  virtual machine is required on Windows and macOS). Binder's limits
  (1 GB guaranteed, 2 GB maximum) are verified.
- Prior: new
- Problem: the chapter never mentions Lima or WSL2, the `singularity`
  command, `module load`, login-node restrictions or Binder timeouts,
  and its Slurm script is admittedly untested.
- Why it matters: most students own a Mac or a Windows laptop.
- Fix: add a 'Where Apptainer runs' note, a five-row 'When it fails'
  table, and vocabulary entries for 'login node' and 'partition'.

#### R8-06 Placement and length suit an appendix (see R4-011)

- Location: `06-backends-runtimes.qmd:48`
- Severity: major
- Viewpoint: mentor
- Evidence: inspected
- Prior: **Reopens D18**
- Fix: as in R4-011, item 2.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R8-07 | `06:1132` | referee, inspected | 'Should also choose its seed' conflicts with Chapter 11's per-task streams. Point to `replicate_streams()`. |
| R8-08 | `06:989` | referee, verified | `--no-home` has no effect when the working directory is `$HOME`. Add the caveat. |
| R8-09 | `06:168` (and 22-25, 67-69) | student, inspected | The three motivating situations change between the opening, the objectives and the orientation. Make them consistent. |
| R8-10 | `06:479`, 1386 | referee, inspected | R 4.4.x is typed beside a 4.6.1 lockfile. Compute the version as Chapter 7 does. |
| R8-11 | `06:728` | referee, inspected | Double quotes appear in printed R code, against the house style. Convert them. |
| R8-12 | `06:345` | student, partly verified | The SingularityCE fork continues under the old name. Add one sentence. |

### Chapter 9, Literate Programming (`07-literate-programming.qmd`)

#### R9-01 The chapter never shows the syntax or the command it teaches

- Location: `07-literate-programming.qmd:588`
- Severity: **blocking**
- Viewpoint: student
- Evidence: inspected. The lead confirmed that no chunk uses
  `echo: fenced`. Displayed chunks use `echo: true`, which shows the
  code but hides the fence and the `#|` options, and the others use
  `include: false`. The only `quarto render` in the chapter is inside
  a regular expression.
- Prior: new
- Problem: the prerequisites assume no prior exposure to chunk syntax,
  yet no fenced chunk is displayed and no render command is taught
  except `make docker-render`. 'If we read the source of that sentence'
  is impossible in the PDF.
- Why it matters: Exercises 1 to 3 and the chapter's first objective
  cannot be completed from the chapter.
- Fix: add an 'Anatomy of a literate document' section with a minimal
  `.qmd` shown verbatim (`echo: fenced`). Give the three ways to render
  it: `quarto render`, the Render button, and
  `quarto::quarto_render()`.

#### R9-02 The opening check requires the optional Chapter 8

- Location: `07-literate-programming.qmd:92`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new (a side effect of the Phase 24 checks)
- Problem: the check turns on Apptainer's home mount, which the core
  path skips.
- Why it matters: the core-path student fails the first check of a
  core chapter.
- Fix: recast the check with a Docker `-v "$HOME"` mount, and keep the
  Apptainer version as an optional part.

#### R9-03 Typst is absent; 'PDF means LaTeX' is out of date

- Location: `07-literate-programming.qmd:902`
- Severity: major
- Viewpoint: referee
- Evidence: verified (Quarto's Typst documentation: the Typst CLI ships
  with Quarto). A grep finds no mention of Typst anywhere.
- Prior: new
- Problem: the case for a 4.2 GB amd64-only publishing image omits the
  lighter option.
- Why it matters: a referee will read the omission as dated.
- Fix: add a paragraph on `format: typst` and a row in the cheat sheet.

#### R9-04 The worked example is R Markdown and bookdown in a Quarto-first chapter

- Location: `07-literate-programming.qmd:1204`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: the only complete document shown uses `output:` and
  `opts_chunk$set()`, which a `.qmd` file ignores.
- Why it matters: a student who copies it gets no PDF and no
  explanation.
- Fix: rewrite the example as `report.qmd`, add a two-column table
  from R Markdown to Quarto, and state which to start with.

#### R9-05 'Pin LaTeX in the image' leaves TeX Live unpinned

- Location: `07-literate-programming.qmd:938`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (`zzcollab modules/docker.sh:222-239` documents
  the problem and pins `tlnet-final` for this reason)
- Prior: new
- Problem: `tlmgr` installs against the default redirector, which
  fetches whatever is current at each rebuild.
- Why it matters: the claim overstates what was pinned.
- Fix: add a sentence on frozen TeX Live snapshots, the TeX analogue
  of a dated CRAN snapshot.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R9-06 | `07:1282` | referee, inspected | The check answer calls the inline `Sys.Date()` 'the same seal', although freeze breaks it. Rewrite, and mention `date: today`. |
| R9-07 | `07:1452` | student, inspected | In Exercise 2, frozen project renders hide the effect of removing the seed. Render the single file. |
| R9-08 | `07:1031` | referee, inspected | 'Signed presentation' overstates a footer. Write 'dated, traceable'. |
| R9-09 | `07:931` | referee, inspected | The described publishing-profile detection would miss `format: pdf`, and its playbook is uncited. Make the rule tool-neutral. |
| R9-10 | `07:909` | referee, unverified | 'The single most common cause' is an unsupported superlative. Write 'a common cause'. |
| R9-11 | `07:1148` | student, inspected | The directory names disagree with the compendium layout. Use `inst/tinytest/` and `analysis/scripts/`. |

### Chapter 10, Pipelines (`pipelines.qmd`)

#### R10-01 The core path says Make is core, but core material depends on `targets`

- Location: `pipelines.qmd:50`; `08-testing-quality.qmd:114-118`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: **fix for D3 incomplete**
- Problem: the objectives, the worked and faded examples, Exercises 3,
  4, 7 and 9, and Chapter 11's warm-up all need `targets`, and the
  optional sections are not marked in the body.
- Why it matters: the reader cannot tell what to skip.
- Fix:
  - Mark optional headings inline.
  - Make the affected exercises optional, or give Make-only variants.
  - Reword Chapter 11's answer.
  - A minor finding (R10-04) argues for swapping which of the two is
    core.

#### R10-02 `targets` is presented as unable to miss a dependency

- Location: `pipelines.qmd:1859`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (contradicts `pipelines.qmd:303-309, 894-906`)
- Prior: new
- Problem: files read inside functions and functions from installed
  packages are not tracked.
- Why it matters: the exercise ends on the false sense of safety the
  chapter warns against.
- Fix: limit the claim to helpers loaded by `tar_source()`.

#### R10-03 Exercises presume the student's own analysis, and their difficulty is not graded

- Location: `pipelines.qmd:1718`; testing Exercises 1 to 5
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: a first-year student often has no multi-script analysis, and
  no starter project is offered. The solutions sentence is false for
  Exercises 6 to 9. Testing Exercise 4's answer is always 'validation'.
- Why it matters: the stated learning outcomes cannot be practiced.
- Fix:
  - Ship the worked example's four scripts as a starter directory.
  - Grade the steps: a faded Makefile, then a Makefile, then `targets`.
  - Replace testing Exercise 4.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R10-04 | `conventions.qmd:199` | student, inferred | Make `targets` the core and Make the optional comparison, since `targets` needs no external binary. **Reopens D3.** |
| R10-05 | `pipelines.qmd:1042` | referee, verified | The callout says 'This chapter's own practice runs `tar_make()` and `make`', but the repository has no `_targets.R`. Reword. |
| R10-06 | `pipelines.qmd:1778` | student, inspected | The Exercise 2 solution points to the wrong exercise. Fix the pointer. |
| R10-07 | `pipelines.qmd:1172` | referee, inferred | `clustermq` is named, but `crew` is the current route. Name both. |
| R10-08 | `pipelines.qmd:1686` | student, inspected | Exercise 7 omits generating the CSV and running `load_all()`. Add both steps. |
| R10-09 | `pipelines.qmd:959` and about nine other sites | mentor, inspected | 'Captures no determinant' is restated about ten times. State it once. |
| R10-10 | `pipelines.qmd:501` | referee, inspected | The Cox fit ignores the paired eyes in `survival::diabetic`. Add `cluster(id)` or a note. |

### Chapter 11, Testing and Code Quality (`08-testing-quality.qmd`)

#### R11-01 Wilson et al. (2017) is cited for testing it explicitly declines to recommend

- Location: `08-testing-quality.qmd:1309`; `:2524`
- Severity: major
- Viewpoint: referee
- Evidence: verified. The 'What we left out' section of the PLOS
  article reads 'we have left unit testing off this list'.
- Prior: new
- Problem: the cited source agrees with the mentor's objection.
- Why it matters: a skeptical mentor who follows the citation finds
  support for their view.
- Fix: cite Wilson et al. (2014, recommendations 5a to 5c) for
  testing. Name the 2017 position and answer it: data validation and
  baseline tests pay off even in solo exploratory work.

#### R11-02 `lintr::lint_dir()` in CI cannot fail, and three passages disagree

- Location: `08-testing-quality.qmd:1434`; `:1794-1797`; Exercise 6
  solution
- Severity: major
- Viewpoint: referee
- Evidence: verified (the lintr CI vignette: the step errors only with
  `LINTR_ERROR_ON_LINT=true`). The repository's `Makefile` lint target
  has the same defect.
- Prior: **fix for Phase 25 incomplete**
- Problem: the step looks like a gate but cannot fail, which breaks
  habit 4.
- Why it matters: a student gets a check that always passes and
  believes it is a check.
- Fix: set `LINTR_ERROR_ON_LINT: true`, make the other two passages
  conditional on that step, and record the Makefile target as a tool
  issue.

#### R11-03 'No new statistics are introduced' is untrue for a non-biostatistician

- Location: `08-testing-quality.qmd:47`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: the chapter introduces Monte Carlo standard error, false-
  alarm rates and L'Ecuyer-CMRG streams.
- Why it matters: the prerequisite box misleads the out-of-field
  reader the book wants to reach.
- Fix: mark the MCSE and parallel-streams sections optional and state
  the prerequisite honestly.

#### R11-04 No bridge to `testthat`, coverage, snapshots or data-validation packages

- Location: `08-testing-quality.qmd:504`
- Severity: major
- Viewpoint: referee
- Evidence: inspected. Package versions are unverified.
- Prior: new. The coverage sweep noted the gap, and no decision
  rejected it.
- Problem: students will meet `testthat` 3e everywhere else, yet data
  validation is hand-rolled, and `validate`, `pointblank` and `covr`
  are absent.
- Why it matters: without a bridge the skills do not transfer to the
  ecosystem the student will work in.
- Fix: add a five-row table from `tinytest` to `testthat`, a
  three-rule `validate::validator()` example and one sentence on
  `covr`, keeping `tinytest` as the book's tool.

#### R11-05 Testing comes after three environment chapters

- Location: `08-testing-quality.qmd:1`; `_quarto.yml` order
- Severity: major
- Viewpoint: mentor
- Evidence: inferred
- Prior: new (no recorded decision on chapter order)
- Problem: the cheapest and most visibly scientific practice comes
  late. A reader who stops after Part II has learned to pin a wrong
  answer exactly.
- Why it matters: the order delays the practice most likely to
  persuade a skeptical mentor.
- Fix: move the paradox, oracle, unit and data-validation sections to
  follow Chapter 5, or at least swap Chapters 10 and 11. Measure the
  cost in cross-references first.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R11-06 | `08:1388` | student, inspected | `make style`, `make lint` and `zzc verify` appear without plain equivalents. See R4-006. |
| R11-07 | `08:1380` | referee, verified | The Air formatter (Posit; pre-commit hook added in 0.10.0) is absent. Add one sentence. |
| R11-08 | `08:2526` | referee, verified | Sandve et al. (2013) do not cover testing. Write 'adjacent ground of provenance'. |
| R11-09 | `references.bib:88` | referee, verified | The `tinytest` entry cites version 1.2.4 (2020); the current version is 1.4.3. |
| R11-10 | `08:1086` | student, inspected | The rendered sentence reads 'the upper bound 0 ... 1.5 to 5.' Write '0 decimal places'. |
| R11-11 | `08:1030` | student, inspected | The book uses two cohort analyses (logistic and Cox) without saying which is primary. Add one sentence. |
| R11-12 | `08:707` | referee, inferred | The age-range assertion passes when every age is `NA`. Add a missingness bound. |
| R11-13 | `08:517` | student, inspected | No test-run output is ever shown. Add a transcript with one failure. |

### Chapter 12, Continuous Integration (`09-continuous-integration.qmd`)

#### R12-01 No on-ramp: the student never creates, pushes or watches a workflow

- Location: `09-continuous-integration.qmd:53`; `:514-593`;
  `:2068-2159`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem:
  - The first workflow shown is a 60-line, three-gate file that needs
    a tool installed from GitHub.
  - The chapter never shows where the file goes, the Actions tab, a
    red step's log, or a YAML error.
  - No exercise has the student push a workflow and watch it pass,
    then fail.
  - Costs (setup time, CI minutes on private repositories) are never
    stated.
- Why it matters: the chapter teaches about CI rather than how to use
  it.
- Fix: add 'Your first workflow' (about 800 words), with
  `usethis::use_github_action()` or a 15-line file, screenshots, an
  'Exercise 0' that goes green then red, and a note on cost.

#### R12-02 The main workflow requires `zzrenvcheck` when a gate that needs only renv is already in the chapter

- Location: `09-continuous-integration.qmd:506`; `:563-584`;
  `:1594-1716`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (`ci/dependency-gate.R` is at `09:486-496`)
- Prior: **fix for D2 incomplete**
- Problem: the canonical workflow, its faded copy, the GitLab file and
  the cheat sheet all depend on the author's personal repository.
- Why it matters: a student in another lab gets a workflow that relies
  on one person's repository.
- Fix: use `Rscript ci/dependency-gate.R` and collect the tool items in
  one callout.

#### R12-03 Length: what to cut or move (see R4-011)

- Location: `09-continuous-integration.qmd:1328-1394` (capture matrix);
  `:841-1001` (GitLab); `:2280-2329` (Exercise 3 essay)
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: **Reopens D18 and D10**
- Fix: as in R4-011. The estimated saving is 3,000 to 3,500 words.

#### R12-04 No diagram of the CI pipeline

- Location: `09-continuous-integration.qmd:411-627`
- Severity: major
- Viewpoint: student
- Evidence: inspected (the only figure is `fig-stack-ci`)
- Prior: new (`learning-science.md:74` recommended one; it was not
  adopted)
- Problem: the trigger, the runner, the two jobs and the three gates
  exist only in prose and YAML.
- Why it matters: this is the chapter's central mental model.
- Fix: add one flow figure mapped to the YAML lines.

#### R12-05 The Exercise 5 seed claim drops the condition the book elsewhere requires

- Location: `09-continuous-integration.qmd:2439`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (contrast `10:2078-2085`)
- Prior: **fix for Finding 35 incomplete**
- Problem: 'The same hundred replicates' holds only for serial streams
  or streams assigned per replicate.
- Why it matters: a statistics audience will design the CI check
  around a correspondence that may not exist.
- Fix: insert the Chapter 13 sentence and a cross-reference to the
  per-task streams.

#### R12-06 The debugging sequence puts reading the error message last

- Location: `09-continuous-integration.qmd:1831`
- Severity: major
- Viewpoint: student
- Evidence: inferred
- Prior: new
- Problem: the most expensive move, bisection, comes first, and reading
  the log comes last.
- Why it matters: a novice spends an afternoon bisecting a failure
  that the first log line explains.
- Fix: reorder: read the log, reproduce locally, compare environments,
  then bisect.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R12-07 | `09:786-793` | referee, verified | A SHA pin also freezes the action's Node runtime. GitHub removed Node 20 in September 2026, and `checkout@v4` still declares node20. Add a sentence. |
| R12-08 | `09:543, 576, 595, 1046` | student, inspected | Nested quoting, `${{ }}`, `GITHUB_PAT` and block scalars are unexplained. Add a table (see R4-014). |
| R12-09 | `09:883, 2341` | referee, verified | `rocker/verse:4.6.1` is amd64 only. Add a comment for GitLab runners. |
| R12-10 | `09:2236-2244` | student, inspected | The solutions introduce extra 'gates'. Write 'checksum manifest' and 'verify job'. |
| R12-11 | `09:2184-2191` | referee, inferred | The Exercise 1 solution overstates what CI catches when a tag moves. Qualify it. |
| R12-12 | `09:921`, 518 | referee, verified | R 4.6.2 is current. Add 'the R version in the lockfile, not the newest release'. |

### Chapter 13, Archiving and Sharing (`10-archiving-sharing.qmd`)

#### R13-01 The `.dockerignore` exercise teaches a pattern that does not exclude the data

- Location: `10-archiving-sharing.qmd:1782` (premise); `:2121-2124`
  (solution)
- Severity: **blocking**
- Viewpoint: referee
- Evidence: verified. Docker's build-context documentation says
  '`*.md` ... files under subdirectories are still included'. The lead
  read the premise and the solution.
- Prior: new
- Problem: `*.csv` excludes only top-level files, so the real extract
  in `analysis/data/raw_data/` is also copied into the image. The
  solution implies that only the `.tsv` leaked. The guidance in the
  body (`10:806`, 'excludes the data directory') is correct; the
  exercise contradicts it.
- Why it matters: in the patient-data chapter, a student who copies
  `*.csv` sends the extract to a registry and then to Zenodo.
- Fix: rebuild the exercise around `analysis/data/raw_data/**` versus
  `**/*.csv`. Add one sentence to the body explaining that patterns are
  anchored at the root of the build context.

#### R13-02 The 'union model' contradicts renv's behavior as Chapter 6 teaches it

- Location: `10-archiving-sharing.qmd:435`; `:324-327`
- Severity: major
- Viewpoint: referee
- Evidence: inspected (`04-dependencies.qmd:1697`)
- Prior: **fix for reader-e M1 incomplete**
- Problem: under implicit snapshots, unused packages drop out of the
  lockfile. The chapter never says what produces an install-based
  union, nor how to resolve a merge conflict in `renv.lock`.
- Why it matters: a student who follows Chapter 6 and then expects
  Chapter 13's behavior will see packages vanish from the lockfile.
- Fix: redefine the union in terms of packages the code uses, explain
  `snapshot.type('all')`, and add a paragraph on merge conflicts.

#### R13-03 'The Dockerfile, not the image, is the guarantee' overstates durability

- Location: `10-archiving-sharing.qmd:461`; `:449-464, 1866-1870`
- Severity: major
- Viewpoint: referee
- Evidence: inferred
- Prior: new
- Problem: a rebuild depends on Docker Hub, the `apt` mirrors and the
  dated package snapshot all surviving. Over a decade the deposited
  image is the more durable artifact.
- Why it matters: a reader who deposits only the recipe loses the
  route most likely to work in 2036.
- Fix: retitle the section 'The Dockerfile is the record; the archived
  image is the fallback', and qualify 'can be rebuilt'.

#### R13-04 The repository landscape is too narrow, and Zenodo's version DOIs are missing

- Location: `10-archiving-sharing.qmd:578`
- Severity: major
- Viewpoint: student
- Evidence: verified (the GitHub-Zenodo integration works only for
  public repositories; Zenodo's help pages describe concept and version
  DOIs)
- Prior: new
- Problem: the chapter names only Zenodo, dbGaP and Software Heritage.
  OSF, Dryad, openICPSR and institutional repositories are absent.
- Why it matters: a student outside health will not find their field's
  repository, and citing the concept DOI cites a moving target.
- Fix: add a 'Choosing a repository' table and three sentences on the
  integration and version DOIs.

#### R13-05 No guidance on choosing a license

- Location: `10-archiving-sharing.qmd:647`
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: the chapter shows that a license is required but never helps
  the reader choose one, and the book's own three-license example is
  the hardest case.
- Why it matters: the license is the one deposit decision a student has
  to make alone.
- Fix: add a five-row decision table pointing to choosealicense.com and
  `usethis::use_*_license()`.

| ID | Location | Viewpoint, evidence | Issue and fix |
|---|---|---|---|
| R13-06 | `10:663-672` | referee, verified | Zenodo ignores `CITATION.cff` when a `.zenodo.json` exists, and a CFF license list means OR. Add two sentences. |
| R13-07 | `10:1030` | student, verified | The NIH DMS transition rules for active awards (NOT-OD-26-100) are omitted. Add one sentence. |
| R13-08 | `10:1748-1754` | student, verified | `rang` was archived on CRAN on 2026-08-22. Give an install route and fix the hard-coded date. |
| R13-09 | `10:1378-1379` | referee, inspected | The `find ... '*raw_data*'` inspection relies on file names, so it does not catch unanticipated files. List the `COPY` destination instead. |
| R13-10 | `10:406-409, 1187-1192` | referee, inspected | The 'system review' and vignette quotations are uncited. Cite them with URLs or remove them. |
| R13-11 | `10:555-556` | student, inspected | A sentence is garbled by rewrapping. Reorder it. |

### Appendices and front matter

| ID | Location | Severity | Viewpoint, evidence | Issue and fix |
|---|---|---|---|---|
| RA-01 | `05-containers.qmd:852-860` | major | student, inspected | The Docker sections of the setup appendix are linked once, inside a callout. Link them from the Chapter 7 card and the first `docker build`, and add anchors. |
| RA-02 | `setup-appendix.qmd:123-139` | minor | student, inspected | The route for a locked-down laptop depends on the optional Chapter 8. Add a three-line Codespaces quick start. |
| RA-03 | `setup-appendix.qmd:23-24` | minor | student, inspected | 'Profiles' (a `zzcollab` term) is used before it is defined. Reword. |
| RA-04 | `setup-appendix.qmd:48-55` | minor | referee, verified with limited confidence | The Rosetta option is omitted. Add one sentence. |
| RA-05 | `shell-primer.qmd:36, 59, 197` | minor | referee, inspected | Chapter numbers are typed. Use cross-references. |
| RA-06 | `shell-primer.qmd:184-190` | minor | referee, inferred | 'Subshell' should be 'child shell'. |
| RA-07 | `cheat-sheet-index.qmd:26-47` | minor | student, inspected | The index lists bare labels without meanings and omits the primer and the setup tables. Render two columns. |
| RA-08 | `_quarto.yml:147` | minor | referee, inspected | The CSL file is fetched from the network, which by the book's own definition is a landmine. Commit `apa.csl` locally. |
| RA-09 | `conventions.qmd:17-22` | minor | student, inspected | The `$` convention is inconsistent, and its example is `zzc status`. Use one convention and `git status`. |
| RA-10 | `04-dependencies.qmd:52` and four others | minor | student, inspected | Objectives are labeled two ways. Use one label. |
| RA-11 | `glossary.qmd:71-74, 829-844` | minor | student, inspected | Validation, verification and capture are hard to tell apart in the glossary. Say that validation without a baseline confirms L2. |

---

## 5. Proposed motivational case bank

Compiled by Reviewer H, with verification upgrades from Reviewer A.

- **Verified:** the DOI resolves and the abstract or text was read.
- **Citation only:** the DOI resolves, but the details come from search
  summaries. Check them against the paper before printing.
- **Unverified:** neither was confirmed.

None of these cases is in the book now. The Duke case was declined
under D18 and is reopened in R4-001.

| # | Case | Field | Summary | Lesson | Citation | Status |
|---|---|---|---|---|---|---|
| 1 | Duke genomic signatures | Clinical genomics | Forensic re-analysis found 'several simple errors that may be putting patients at risk', including row and column offsets. | Unreproducible analyses can reach patients | Baggerly and Coombes, *Ann. Appl. Stat.* 2009, doi:10.1214/09-AOAS291 | Verified (abstract); trial timeline citation only |
| 2 | JAMA COPD trial | Clinical medicine | A programming error reversed a reported benefit into harm; the article was retracted and republished in 2019. | A script error changed a clinical conclusion | *JAMA* 2019, doi:10.1001/jama.2019.14503 | Citation only |
| 3 | Reinhart and Rogoff | Economics | A spreadsheet range omitted countries, though selective exclusions and weighting mattered more than the cell error. | Sharing the working file let outsiders find the error | Herndon, Ash and Pollin, *Camb. J. Econ.* 2014, doi:10.1093/cje/bet075 | Citation only |
| 4 | Gene names turned into dates | Computational biology | About one in five genomics papers with Excel gene lists had conversion errors (2016); 30.9 percent by 2021. | A silent software default corrupts published data | Ziemann et al., *Genome Biol.* 2016, doi:10.1186/s13059-016-1044-7; Abeysooriya et al., *PLOS Comput. Biol.* 2021 | Verified (abstract) |
| 5 | NMR scripts that depend on the operating system | Chemistry | Calculated shifts from published Python scripts 'depended on the operating system'. | The operating system is a determinant, outside health too | Bhandari Neupane et al., *Org. Lett.* 2019, doi:10.1021/acs.orglett.9b03216 | Verified (abstract); mechanism unverified |
| 6 | Chang structure retractions | Structural biology | An error in homemade software led to five retractions, three in *Science*. | Your own unreviewed code is a single point of failure | Miller, *Science* 2006, doi:10.1126/science.314.5807.1856 | Citation only |
| 7 | Neuroimaging results that vary by operating system and version | Neuroimaging | FreeSurfer volumes differed by version and workstation. In Glatard et al., independent component analysis results differed between operating systems in one third of subjects. | Version and platform are part of the result | Gronenschild et al., *PLOS ONE* 2012; Glatard et al., *Front. Neuroinform.* 2015, doi:10.3389/fninf.2015.00012 | Verified (both abstracts) |
| 8 | Cluster failure in fMRI | Neuroimaging statistics | Null analyses showed that parametric cluster inference was invalid at the nominal familywise error rate. | Software defaults need empirical checks (the 70 percent figure is a familywise rate) | Eklund et al., *PNAS* 2016, doi:10.1073/pnas.1602413113 | Verified (abstract) |
| 9 | NARPS, 70 teams | Neuroimaging | 'No two teams chose identical workflows', and results varied. | Shared workflows expose analytic variation | Botvinik-Nezer et al., *Nature* 2020, doi:10.1038/s41586-020-2314-9 | Verified (abstract) |
| 10 | Many analysts, one data set | Psychology | Twenty-nine teams estimated one effect, with odds ratios from 0.89 to 2.93. | Code makes analytic choices inspectable | Silberzahn et al., *AMPPS* 2018, doi:10.1177/2515245917747646 | Citation only |
| 11 | Replication in economics and social science | Economics, social science | 11 of 18 economics experiments replicated, and 13 of 21 *Nature* and *Science* experiments. | Replication failure is not unique to medicine | Camerer et al., *Science* 2016; *Nat. Hum. Behav.* 2018 | Verified (abstracts) |
| 12 | Abortion and crime | Economics | Omitted interaction terms in the code; the original authors dispute the magnitude. | Code must implement the stated model | Foote and Goetz, *QJE* 2008, doi:10.1162/qjec.2008.123.1.407 | Citation only |
| 13 | I4R mass reproduction (positive) | Economics, political science | More than 85 percent of claims were computationally reproducible under mandatory code policies; the sample is 'highly selective'. | Enforced deposit works | Brodeur et al., *Nature* 2026, doi:10.1038/s41586-026-10251-x | Verified (PDF) |
| 14 | SCORE | Social and behavioral sciences | 55.1 percent of 274 claims replicated. | The current benchmark beside OSC | Tyner et al., *Nature* 2026, doi:10.1038/s41586-025-10078-y | Verified (abstract) |
| 15 | Reproducibility Project: Cancer Biology | Preclinical biomedicine | Effects were 85 percent smaller, with 46 percent success overall. | The open successor to Begley and Ellis | Errington et al., *eLife* 2021, doi:10.7554/eLife.71601 | Verified (abstract) |
| 16 | Shared trial data re-analyzed | Clinical trials | 14 of 17 trials with available data fully reproduced; data were available for 17 of 37. | Re-execution evidence specific to health | Naudet et al., *BMJ* 2018, doi:10.1136/bmj.k400 | Verified (abstract) |
| 17 | Open data at *Cognition* | Psychology | Reusable data rose after the policy, but many reproductions needed the authors' help. | Availability is not reproducibility | Hardwicke et al., *R. Soc. Open Sci.* 2018, doi:10.1098/rsos.180448 | Citation only |
| 18 | Code availability in ecology | Ecology | Only 27 percent of eligible articles shared code, against 79 percent that shared data. | Policy without enforcement leaves code unshared | Culina et al., *PLOS Biol.* 2020, doi:10.1371/journal.pbio.3000763 | Verified (abstract) |
| 19 | Ocean acidification and fish | Ecology | A transparent replication found 'negligible effects'. | Open methods let a field correct itself | Clark et al., *Nature* 2020, doi:10.1038/s41586-019-1903-y | Verified (abstract) |
| 20 | Leakage in ML-based science | Many fields | Leakage reported in 17 fields, affecting 294 papers. | A teachable class of error | Kapoor and Narayanan, *Patterns* 2023, doi:10.1016/j.patter.2023.100804 | Citation only |
| 21 | CODECHECK of CovidSim (positive) | Epidemiological modeling | An independent check reproduced the Report 9 tables, with small variations. | Runnable code let a contested model be verified quickly | Eglen 2020, doi:10.5281/zenodo.3865491 | Citation only |
| 22 | Ten Years Reproducibility Challenge | Computational science | Researchers tried to re-run their own decade-old code, with mixed success. | Your future self is the first reader | Perkel, *Nature* 2020, doi:10.1038/d41586-020-02462-7 | Citation only (sources disagree on counts) |
| 23 | Tuberculosis drugome | Computational biology | Reproducing one method took several months. | Unrecorded workflows cost months | Garijo et al., *PLOS ONE* 2013, doi:10.1371/journal.pone.0080278 | Verified (abstract) |
| 24 | LIGO open data (positive) | Physics | Open gravitational-wave data with tutorials. | Open data as standard practice in a large collaboration | Abbott et al., *PRL* 2016; gwosc.org | Citation only; release history unverified |
| 25 | England's lost COVID-19 cases | Public health informatics | 15,841 cases were omitted after a spreadsheet limit was hit. | Manual, format-bound steps fail silently | Press reports only | Unverified; do not use until the Public Health England statement is opened |
| 26 | Statistical reporting errors (in `references.bib`, uncited) | Psychology | Half of papers had at least one inconsistent p-value; one in eight had a gross inconsistency. | The mismatch between prose and code that the sealed render prevents | Nuijten et al. 2016 (`nuijten2016`) | Verified (PMC abstract) |
| 27 | Notebook re-execution | Data science (Python) | 24 percent of 863,878 notebook executions ran; 4 percent reproduced. | Hidden state in literate documents | Pimentel et al., MSR 2019 | Verified (PDF) |

Coverage: twelve or more disciplines. Positive cases are numbers 13,
21 and 24; numbers 16 and 17 are mixed. Physics and engineering remain
thin, and the one physics case has only a verified citation. A verified
engineering case is still needed.

---

## 6. Prioritized action plan

Page estimates assume about 260 words per PDF page: the current PDF
has 670 pages for about 176,000 source words. This is an approximation
(inferred).

**Tier 1: correctness, safety and disclosure** (small effort, about
+8 pages)

| Items | Effort |
|---|---|
| R13-01 `.dockerignore`; R4-V03 PHI clause; R4-V01 public versus private | Low |
| R4-005 disclosure and install pointer; R7-02 tool platform and thread mismatch (text plus a tool fix) | Low |
| R8-01 restore the Binder block; R4-016 glossary contradictions; R6-01 `dplyr` story; R6-02 triad logic; R11-01 Wilson citation; R11-02 lint gate; R5-02 auto-fixing gate; R12-05 seed condition; R10-02 `targets` claim; R13-02 union model | Low to medium |
| R4-017 Docker licensing; R4-018 Rocker architectures; R5-01 six archetypes; R2-03 Begley caveats | Low |

**Tier 2: persuasion and novice on-ramps** (medium to high effort,
about +35 pages)

| Items | Effort |
|---|---|
| R4-001 real cases (5 to 7 boxes); R4-007 objections section, 'Making the case to your lab' and 'What this buys you'; R4-008 mandates table; R2-02 the 2026 studies | Medium |
| R4-003 Welcome page; R4-004 primer moved, linked and extended; R4-013 machine checklist; R4-014 YAML | Medium |
| R7-01 `docker run`; R9-01 anatomy of a literate document; R12-01 first workflow; R4-V02 cloning; R10-03 starter project | Medium |
| R4-012 closing chapter with a brief for the mentor | Medium |
| Section 2 bridges: translation appendix, boxes for Python and Stata, generalized restricted-data rule | Medium |

**Tier 3: structure and length** (high effort, about −30 pages net of
relocation)

| Items | Effort |
|---|---|
| R4-002 front matter reordered, lists of figures and tables dropped (about −10 pages) | Low |
| R4-011 Chapter 8 moved to an appendix; Chapter 12 cut by about 3,000 words; Chapters 6 and 7 cut by about 2,500; Chapters 1 to 3 cut by about 900; optional sections marked | High |
| R4-006 D2 track implemented in Chapters 5, 7, 11, 12 and 13 | High |
| R11-05 earlier placement of testing; R10-04 swap of core and optional pipeline tools | High; measure first |

**Tier 4: currency and polish** (low effort, about +5 pages): R6-05,
R9-03, R9-04, R11-04, R11-07, R13-04, R13-05, R4-019, R4-015,
R4-020, and every minor finding.

**Net estimate:** about +15 to +20 pages if every tier is applied,
against about +48 pages if Tier 3 is skipped. This rests on the
words-per-page assumption, not on measurement; render after each phase
and measure.

**Author decisions needed before Tier 2:**

1. The audience statement (Section 2).
2. Whether to reopen D18 for Chapter 8, Chapter 12 and the repeated
   definitions.
3. Whether to reopen A10, D18 and D3 for the case bank and the choice
   of core pipeline tool.
4. Whether to implement D2 as decided or revise it.

**Issues for the `zzcollab` tool, outside the book:**

- the arm64 default build;
- the missing `OPENBLAS_NUM_THREADS`;
- `check-renv` auto-fixing instead of failing;
- the `make lint` target that cannot fail;
- `explicit` snapshot type versus the book's `implicit`;
- the deprecated `zzc analysis` alias;
- the six archetypes against the book's five.

---

## 7. Scope disclosure

**What was read.**

- Reviewer A: front matter, Chapters 1 to 3, `_habits.qmd` and
  `_llm-rule.qmd`, in full.
- Reviewer B: Chapters 4 and 5, in full.
- Reviewer C: Chapters 6 and 7, in full.
- Reviewer D: Chapters 8 and 9, in full.
- Reviewer E: Chapters 10 and 11, in full.
- Reviewer F: Chapters 12 and 13, in full.
- Reviewer G: the shell primer, setup appendix, cheat-sheet index,
  glossary, credits, colophon, `_quarto.yml`, the Welcome page, the
  preface and the Conventions page, in full. Reviewer G's cross-cutting
  analysis of the chapters rests on grep, heading extraction, targeted
  reads and structural counts, not full reading.
- Reviewer H: Chapters 1 and 2 in full, with targeted reads of
  Chapters 3, 8, 12 and 13.
- Every reviewer read `THIRD-REVIEW-PLAN.md` in full.
- `REFACTOR-PLAN.md` and `docs/third-review/` were searched by keyword,
  not read in full. A duplicate of a second-review item is therefore
  possible.

**What the lead reviewer checked.**

- The quoted text of all 207 findings in the raw reports, by
  whitespace-normalized search (script in the session scratchpad). All
  were found.
- Direct reads of the `.dockerignore` premise and solution, the PHI
  clause, the Binder gap, the Welcome-page prerequisites, the
  literate-programming seal passage, the `wilson2017` and `lint_dir`
  sites, and the Docker licensing sentence.
- A grep confirming that nothing links to `sec-shell`.
- The lead repeated one reviewer's web check: the Docker subscription
  agreement (R4-017). No other web check was repeated.

**Code executed.** No render, R chunk, Docker, Podman, Apptainer, git
operation on a scratch repository, or CI run was performed by anyone.
Commands that were run: `curl` against CRAN, Docker Hub and Docker
legal pages; `gh api`; `pdftotext` on the existing 2026-11-09 PDF; and
grep, `wc` and short Python counting scripts.

**Approximations and limits.**

- PDF page numbers come from the 2026-11-09 build, which predates
  commit `3b352ab`, so offsets of one page are possible.
- The only HTML build on disk is a stale July build, so no claim about
  a rendered page was checked against current output (frozen JSON was
  read instead).
- Reading rates, words per page and health-term densities are
  assumptions or regex counts.
- Several web pages were read through a summarizing fetch tool.
  Quotations from them are as that tool returned them, and one such
  tool misreported an NIH notice before the raw text was read.

**Claims not verified.**

- The outcome of the OSTP memo repeal.
- Docker Desktop's behavior after macOS 27, and its default for
  Rosetta.
- Whether actions declaring node20 fail or only warn.
- The field mix of Trisovic's sample.
- Goodman (2016), the body of Leek and Peng, and the ACM badging page.
- The `Hash` behavior of current renv.
- The availability of `make` on Windows.
- The current versions of `testthat` and `validate`.
- The case-bank details marked 'citation only'.

**Uneven attention.**

- Chapter 3 received the least scrutiny: one reviewer in full, the
  case-verification reviewer only in part. It has the fewest findings,
  which may reflect coverage rather than quality.
- The exercise answer keys in the instructor guide
  (`analysis/instructor-guide/`) were not reviewed.
- Figures and alt text were reviewed only where a finding touched
  them.

**Simulated viewpoints.** The student, mentor and referee viewpoints
are personas simulated by model reviewers, not human readers. Human
second readers for the regulatory, restricted-data and statistics
material, and a pilot with actual first-year students, remain
necessary before the book's claims about its own accessibility can be
called verified.
