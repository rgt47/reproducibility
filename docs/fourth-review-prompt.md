# Prompt: Fourth Critical Review of the Reproducibility Book
*2026-11-25 17:42 PST*

Copy everything below the rule into a fresh Claude Code session started
at the repository root (`~/prj/tch/12-reproducibility`).

---

You are conducting a full critical review of the textbook *Reproducible
Research for the Health Sciences: Compendia, containers, and
computational verification in R*. The Quarto source is in
`analysis/report/`; the chapter order is the `book.chapters` and
`book.appendices` list in `analysis/report/_quarto.yml`. The book runs
to roughly 176,000 words. Your review must be thorough, detailed, and
critical, and every criticism must be constructive: name the problem,
show where it occurs, explain why it matters for the intended reader,
and propose a specific fix.

Do not edit any book source. This is a review only.

## 1. Intended reader and purpose

Evaluate the book against this reader, stated by the author:

- First-year graduate students in disciplines that conduct empirical
  research and apply the scientific method.
- The material will be entirely new to most of these students.
- It will also be new to many of their faculty mentors, who may be
  skeptical, may not use these practices themselves, and may control
  whether the student is allowed the time to adopt them.
- The practices are nonetheless essential in the contemporary research
  environment, and the book must make that case.

The author's goals for the book:

1. **Persuasion first.** The opening material (front matter,
   `00-intro.qmd`, `01-reproducibility-crisis.qmd`,
   `02-levels-of-reproducibility.qmd`) must convince a reader who did
   not ask to be convinced. It should use many concrete, vivid, and
   verifiable examples and motivational material before it asks the
   reader to install or type anything.
2. **Accessibility for true novices.** No assumed knowledge of the
   shell, git, package management, containers, testing, or CI beyond
   what the book itself teaches.
3. **Contemporary.** Current as of late 2026: tools, versions, funder
   and journal policies, community norms, and the role of AI coding
   assistants in research code.
4. **Accurate.** Every factual, historical, statistical, and technical
   claim must be correct and supportable from a primary source.

## 2. Tension to evaluate explicitly

The title, subtitle, and preface frame the book for the *health
sciences* and for *R*. The stated audience is broader: graduate students
in any empirical, scientific-method discipline. Assess this mismatch
directly. Report:

- Where the health-science or R framing would lose a student in, for
  example, ecology, psychology, economics, physics, or engineering.
- Whether the examples in the persuasive chapters are drawn from a
  range of fields or concentrated in biomedicine.
- Whether the right resolution is to broaden the book, to narrow the
  stated audience, or to keep the health-science focus and add
  explicit bridges for other fields. Recommend one, with reasons.

Also assess how much the workflow depends on the author's own tool
`zzcollab` (used in `03-research-compendium.qmd`,
`09-continuous-integration.qmd`, and elsewhere). Judge whether a reader
learns transferable principles or only one tool's interface, whether
the dependence is disclosed, and whether a reader without that tool can
follow every chapter.

## 3. Prior work: read it first, do not repeat it

Three earlier reviews exist. Before reviewing, read:

- `THIRD-REVIEW-PLAN.md`, especially Findings 29-45, Decisions D13-D25
  (Sections 11 and 11a), and the completion record in Section 12.
- `REFACTOR-PLAN.md` (reviews one and two).
- The reports in `docs/third-review/`.

Rules:

- Do not re-raise a finding already recorded as fixed unless you verify
  in the current source that the fix is absent or incomplete; if so,
  say so and cite the file and line.
- Do not reopen a recorded author decision (for example D24, PDF
  accessibility, or the licensing change that superseded D25) unless
  you have a substantive new argument. If you do, label the finding
  'Reopens Dxx' and state the new argument.
- Prioritize what the earlier reviews did not cover. Earlier reviews
  leaned toward correctness, apparatus, and voice; this review should
  weigh persuasion, novice accessibility, breadth of audience, and
  currency at least as heavily.

## 4. Method

1. Read every chapter and appendix in full, in book order. Skimming or
   sampling is not acceptable. If you divide the work among subagents,
   give each one whole chapters, this entire prompt, and the prior-work
   rules in Section 3, and then reconcile their findings yourself:
   remove duplicates, resolve contradictions, and check any claim that
   reaches the final report.
2. Read from three viewpoints and attribute each finding to the
   viewpoint that produced it:
   - **Student:** a capable first-year PhD student, outside
     biostatistics, who has used R in one course and never used a
     terminal, git, or Docker.
   - **Skeptical mentor:** a productive mid-career principal
     investigator who has published for twenty years without these
     practices and doubts they are worth a student's time.
   - **Expert referee:** a research software engineer and methodologist
     who knows the current tooling and reproducibility literature and
     will notice anything outdated, oversimplified, or wrong.
3. Verify claims. For each factual claim you question, check a primary
   source (the original paper, the official documentation, the funder
   or journal policy text). Record the source. Mark every finding with
   its evidence status: **verified** (you checked a source or ran
   code), **inspected** (you read the book source and confirmed the
   problem), **inferred**, or **unverified**. Never present an inferred
   claim as verified.
4. Code. Where a chapter's correctness depends on a command or code
   chunk, state whether you executed it. Note how to render in this repo:
   the host R library lacks renv, so a render needs a library with the
   versions pinned in `renv.lock` (see the project notes). If you do not
   execute code, say so; do not imply you tested it.

## 5. What to assess

### 5.1 Persuasion and motivation (highest priority for Part I)

- Does the opening make the case within the first few pages, or does it
  delay with definitions, conventions, and setup?
- Count and list the concrete cases used to motivate the material
  (retractions, failed replications, analysis errors with real
  consequences, policy and funding mandates, career benefits). For each,
  judge whether it is accurate, current, well sourced, and vivid enough
  to stay with the reader.
- Identify missing cases that would be stronger, more recent, or from
  fields not yet represented. Propose specific replacements or
  additions, with citations.
- Does the book answer the mentor's objections directly: 'this takes too
  long', 'my results have always been fine', 'reviewers do not ask for
  it', 'this is a software-engineering concern, not a science one'?
- Does it give the student language and evidence to make the case to
  their mentor and lab? If not, propose what to add.
- Is the tone convincing without being preachy, alarmist, or
  condescending to researchers who do not yet work this way?
- Is the benefit to the student (their own future work, thesis defense,
  job market, fewer lost weeks) made as concrete as the benefit to
  science in general?

### 5.2 Accessibility for novices

- Terms used before they are defined; forward references a novice
  cannot follow; acronyms left unexpanded.
- Steps that are too large or that silently assume knowledge (shell
  navigation, paths, environment variables, YAML, git mental models,
  image and container differences).
- Whether the shell primer and setup appendix are sufficient, placed
  where novices need them, and signposted from the chapters that depend
  on them.
- Cognitive load: chapters or sections that introduce too many tools or
  concepts at once. Propose splits or reorderings.
- Failure paths: does the book tell a novice what to do when an install,
  build, or push fails on their machine (macOS, Windows, Linux, Apple
  Silicon, university HPC without Docker)?
- Exercises: are they graded in difficulty, achievable by a novice, and
  aligned with the stated learning outcomes?

### 5.3 Structure and pacing

- Is the part and chapter order the right learning sequence for a
  novice? Evaluate in particular where version control, pipelines, and
  testing sit.
- Chapter length and balance (the chapters range from about 2,300 to
  17,400 words). Identify sections that could be cut, moved to an
  appendix, or turned into reference material.
- Whether the book works for a one-semester course and for self-study.
  Suggest a minimum viable path for a student short on time.

### 5.4 Currency (as of November 2026)

Check for outdated or missing material, including:

- R tooling: renv, pak, rig, Quarto, targets, testthat and tinytest,
  and current versions and recommended practice.
- Containers: Docker, Podman, Apptainer/Singularity for HPC, Apple
  Silicon and multi-architecture images, rocker images.
- CI: GitHub Actions current action versions and runtime deprecations,
  alternatives such as GitLab CI.
- Archiving and sharing: Zenodo, OSF, Software Heritage, DOIs for code,
  CITATION.cff, FAIR principles, data licensing.
- Policy: the NIH Data Management and Sharing Policy, implementation of
  the 2022 OSTP public-access memo by federal agencies, current journal
  code- and data-availability policies, and relevant changes outside
  the United States.
- AI coding assistants and large language models: how they affect
  reproducibility, provenance, verification, and disclosure. Judge
  whether the book's treatment is current, balanced, and practically
  useful rather than generic.
- Dates, version numbers, and phrases like 'recently' or 'new' that will
  age badly. Recommend how to make the book resist aging.

### 5.5 Accuracy

- Factual and historical claims about the reproducibility crisis and
  specific cases.
- Statistical claims (replication rates, effect sizes, survey figures):
  are numbers quoted correctly and with their caveats?
- Technical claims about how tools behave.
- Quotations and citations: does each source say what the book says it
  says? Are any references retracted, superseded, or misdated?

### 5.6 Prose and presentation

- Clarity, sentence-level density, and repetition across chapters.
- Consistency of terminology with the glossary.
- Figures, tables, and callouts: do they help a novice, and are any
  missing where a diagram would carry the explanation better than text?
- Conformance to the house style: US English, no em dashes, single
  quotes in prose where the book uses them, scholarly tone without
  hyperbole.

## 6. Output

Write the review to `docs/fourth-review/REVIEW.md`, with the date and
time on the line after the title. Use this structure:

1. **Executive summary** (one page at most): overall judgment of
   whether the book meets the author's four goals for the stated
   reader; the five most important problems; the three most important
   strengths, stated briefly.
2. **Audience and scope recommendation** (from Section 2 above).
3. **Global findings** that cut across chapters.
4. **Chapter-by-chapter findings**, in book order. For each finding:
   - ID (R4-001, R4-002, ...)
   - Location: `file.qmd:line`
   - Severity: **blocking** (wrong, misleading, or loses the reader),
     **major** (weakens the book materially), or **minor**
   - Viewpoint: student, mentor, or referee
   - Evidence status: verified, inspected, inferred, or unverified
   - Problem, why it matters for this reader, and the proposed fix
     (concrete wording, a specific example to add, or a specific cut)
5. **Proposed motivational case bank**: a table of real cases suited to
   the persuasive chapters, spanning several disciplines, with a
   one-line summary, the lesson it teaches, and a primary citation for
   each. Mark each as verified or unverified.
6. **Prioritized action plan**: findings grouped into tiers by impact
   and effort, with an estimate of page-count change.
7. **Scope disclosure**: what you read in full, what you only
   inspected, what code you executed, what claims you could not
   verify, and any chapters that received less attention than others.

Be direct. Where the book is wrong, say so. Where it is strong,
confirm this briefly and say why it works, but do not use strengths to
soften a negative finding.
