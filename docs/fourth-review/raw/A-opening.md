# Reviewer A: Persuasion and Opening (front matter, Chapters 1 to 3)
*2026-11-25 17:51 PST*

## Summary

The opening is accurate, careful, and well organized as an argument
for readers who already agree with it. It does not persuade a reader
who did not ask to be convinced. The opening chapters contain no named,
real incident in which a computational error had consequences. Every
real piece of evidence is an aggregate rate: two replication projects,
one survey, one theoretical paper, and two re-execution studies. Every
concrete story is a hypothetical composite, and all of them are
clinical or epidemiological. The first real number reaches the reader
on PDF page 41 of 671. Before it come about 20 pages of contents and
lists, a Conventions page full of undefined machinery ('nine layers',
'captures', 'validates', 'gate'), and a 600-word vocabulary section.
Chapter 2, titled 'The Reproducibility Crisis', puts about 2,000 source
words of card, check, a hypothetical vignette, a ladder definition, a
blank stack figure, and a vocabulary box before its evidence section.
Its own Exercise 6 solution then calls its lead evidence irrelevant to
the book. The skeptical mentor's four objections are answered at most
once, briefly, and indirectly. The student gets no language to bring
to a lab, and no concrete personal benefit is stated. Policy, funder,
and journal mandates are absent from the opening. The audience
statement (index.qmd) contradicts the author's new target reader. The
prose is measured and seldom preachy. The main tonal problem is a
presumptuous 'every health scientist has met this' framing, not
alarmism.

## Strengths

- The floor-not-ceiling argument (01:700-723) and the Exercise 5
  solution's corollary (01:1354-1356) are the best answers in the book
  to 'this is engineering, not science'.
- 02:223-230 is the one direct, well-judged answer to 'this takes too
  long': match the rung to the stakes.
- The replication-versus-re-execution split (00:123-131, 01:385-392) is
  conceptually clean, and fig-three-words is a good novice diagram.
- The R 3.6.0 and 4.0.0 defaults are now stated precisely (01:577-605).
  The executed RNG demonstration (tbl-rng-kind) is a good tactile
  example.
- Chapter 2 Exercise 1 (01:1114-1120, 'run a published article's code
  in your own field') is the most persuasive device in the opening,
  because the student generates the evidence personally.
- Tone is mostly scholarly, and the honest-level device models the
  calibrated claim the book asks of its readers.

## Motivating-case inventory (all cases in assigned files)

'Real' means a cited event or study. 'Hypothetical' means an invented
composite. The field is the field of the evidence, not of the framing.

| # | Case | file:line | Real or hypothetical | Field | Year | Source key | Accuracy and vividness |
|---|---|---|---|---|---|---|---|
| 1 | Script ran once; supplement will not knit; reviewer gets a folder | preface:3-13 | Hypothetical | Generic | n/a | none | Plausible and relatable; generic, low vividness |
| 2 | 'A result that ran only once' (new laptop, different number) | 00:20-34 | Hypothetical | Health framing | n/a | none | Relatable; no names, no stakes |
| 3 | OSC 39 of 100 replications judged successful | 00:97-99; 01:339-344 | Real (aggregate) | Psychology | 2015 | opensciencecollaboration2015 | Accurate, with the 36 percent caveat in 01 only; replication, not computation |
| 4 | Begley and Ellis, 6 of 53 'landmark' findings | 00:99-100; 01:344-348 | Real (aggregate) | Preclinical oncology | 2012 | begley2012 | Numbers match the paper (phase 25 V); described as 'reproduced'; no caveat that the 53 studies were not disclosed (see finding) |
| 5 | Ioannidis, 'most published findings are false' | 01:352-355 | Real (theoretical) | Biomedicine | 2005 | ioannidis2005 | Accurate summary; argument, not case |
| 6 | Baker survey: over 70 percent failed to reproduce others' work | 01:7-12, 355-361 | Real (opt-in survey) | Multidisciplinary | 2016 | baker2016 | Accurate (phase 25 V); self-selection caveat absent |
| 7 | Trisovic: about 1 in 4 of 9,000+ Dataverse R files ran | 00:107-110; 01:371-376 | Real (aggregate) | Mixed repository; field mix not stated | 2022 | trisovic2022 | Initial rate accurate; the 56 percent after-cleaning figure is omitted |
| 8 | Saju: about a quarter of OSF R scripts ran; 1 project in 6; about 99 percent with no dependency file | 00:110-116, 270-271; 01:376-383 | Real (aggregate, preprint) | OSF, field mix not stated | 2025 | saju2025 | Phase 25 corrected numbers; the work is an arXiv preprint; quantifiers vary across sites |
| 9 | R 3.6.0 `sample.kind` change | 00:184-189; 01:577-593 | Real (mechanism, no incident) | R software | 2019 | rcoreteam2019 | Accurate; a mechanism, not a consequence |
| 10 | R 4.0.0 `stringsAsFactors` flip | 00:189-195; 01:595-605 | Real (mechanism, no incident) | R software | 2020 | rcoreteam2020 | Accurate; a mechanism, not a consequence |
| 11 | Claerbout's reproducible geophysics | 01:513-526; epigraph 00:7-14 | Real (history) | Geophysics | 1990s | claerbout1992, buckheit1995 | Accurate origin story; not a failure case |
| 12 | Trial auditor: estimate moves, CI crosses null | 01:126-144 | Hypothetical | Clinical trial | n/a | none | Most vivid vignette, but contrived (see finding) |
| 13 | Cardiology registries, three observations | 01:544-550 (check) | Hypothetical | Cardiology | n/a | none | Teaching device only |
| 14 | PCA loadings differ across laptops | 01:668-674 (check) | Hypothetical | Generic | n/a | none | Teaching device only |
| 15 | Readmission off-by-one at L3 | 01:1331-1343 (solution) | Hypothetical | Health services | n/a | none | Good illustration of 'reproducible yet wrong'; buried in a solution |
| 16 | Heart-failure registry, OR 1.24 to 1.19 after an optimizer default change | 02:126-144 | Hypothetical | Epidemiology | n/a | none | Could be a real lme4 case (see finding) |
| 17 | Epidemiologist, sixth-decimal BLAS difference | 02:436-444 (check) | Hypothetical | Epidemiology | n/a | none | Teaching device only |
| 18 | Composite biostatistician walks up the ladder | 02:908-972 | Hypothetical | Biostatistics | n/a | none | Clear and well paced; not motivational |
| 19 | NIH rules on AI in applications and peer review | 01:1106-1110 | Real (policy) | US biomedical funding | 2023, 2025 | nihnot25132, nihnot23149 | About AI, not about reproducibility mandates |

Counts: 19 cases. Real: 11, of which 6 are aggregate rates or surveys,
2 are software mechanisms, 1 is a theoretical paper, 1 is history, and
1 is AI policy. Hypothetical: 8, all clinical or epidemiological except
two generic ones. Named incidents of a real computational error with a
real consequence (retraction, policy, patients, money): **0**. Real
evidence by field: psychology 1, preclinical oncology 1, biomedicine
theory 1, multidisciplinary or unstated 3, geophysics history 1. Real
evidence from ecology, economics, physics, engineering, neuroscience,
or the social sciences proper: none named as such.

## How long before the first compelling case

Measured three ways. The PDF is the 2026-11-09 build in `_book/`. It
predates commit 3b352ab (the Contents page removed from the PDF), so
page numbers may shift by one. Source word counts come from `wc -w`,
which counts YAML and chunk code, so they are approximate.

- **First composite vignette:** 00-intro:20, PDF page 39. Before it the
  reader passes the half-title, copyright, about 20 pages of table of
  contents, list of figures, and list of tables (PDF pages 9 to 28),
  the Welcome (index, about 490 words), the Preface (about 1,050
  words), and Conventions (about 1,240 words). That is about 2,800
  words of front-matter prose plus 20 pages of lists.
- **First real number:** 00-intro:96-100 (OSC, Begley), PDF page 41,
  after about 3,400 source words, of which about 620 are in the intro
  itself. What delays it within the intro is a definitions section
  (00:55-92) that Chapter 2 repeats.
- **First named real incident with consequences:** none in the
  assigned files.
- **Chapter 2:** the chapter opens on PDF page 51 and its evidence
  section is on page 57. About 2,070 source words (01:1-331) come
  first: the card, a 'from earlier chapters' check, a hypothetical
  orientation, a full ladder definition, a blank stack figure, the
  'analyst's contribution', and a 30-line vocabulary box.

## Findings

### No real incident anywhere in the persuasive chapters
- Location: 01-reproducibility-crisis.qmd:332
- Quote: 'We begin with the large replication studies, because they set the scale of the problem.'
- Severity: blocking
- Viewpoint: mentor
- Evidence: inspected (inventory above; grep for Potti, Baggerly, Reinhart, retract returns 0 in 00, 01, 02; phase25 agent4-report X1 agrees)
- Prior: 'reopens D18' (A10 was declined unless it replaced survey prose). The new argument: the author's fourth-review goal 1 puts persuasion first and asks for many concrete, vivid, verifiable cases. The third review did not weigh that goal, and its audience was readers already in the field.
- Problem: The case rests entirely on aggregate rates and invented composites. A skeptical PI discounts both: rates describe 'other people's sloppy work', and composites are not evidence. Chapter 2's exercise solutions (01:1354-1356) state the strongest lesson, 'reproducibility makes an error easier to find once someone suspects it', but no real story carries it.
- Why it matters: A reader who did not ask to be convinced remembers stories, not percentages, and a mentor will not cede student time on the strength of hypotheticals.
- Fix: Add a short boxed 'Case' (150 to 250 words) to Chapter 1 and three or four more to Chapter 2, drawn from the case bank below and spanning fields. Minimum set: Duke genomic signatures (Baggerly and Coombes 2009), placed next to 'A reproducible analysis can still be wrong'; Reinhart and Rogoff (Herndon, Ash, and Pollin 2014); the Chang structure retractions (Miller 2006); and cross-OS neuroimaging differences (Glatard et al. 2015), placed as the lead-in to the determinant stack. Fund the space from the triplicated definitions (separate finding).

### The first real evidence arrives on PDF page 41, behind apparatus
- Location: conventions.qmd:44
- Quote: 'A computational result rests on nine layers, from the hardware at the base to intrinsic non-determinism at the top'
- Severity: blocking
- Viewpoint: student
- Evidence: verified (`pdftotext` of `_book/Reproducible-Research-for-the-Health-Sciences.pdf`, 2026-11-09 build: Preface p. 29, Conventions p. 33, Introduction p. 39, OSC sentence p. 41; TOC, LOF, and LOT occupy pp. 9 to 28)
- Prior: new
- Problem: Before any reason to care, the reader meets the license (twice: copyright.qmd and index.qmd:70-82), contents, figure and table lists, a template description, and a Conventions page that assumes the ladder, the stack, 'captures', 'validates', 'gate', 'honest level', and a synthetic cohort. Inside Chapter 2 the same pattern repeats: six pages of apparatus before the evidence section (PDF pp. 51 to 57).
- Why it matters: The persuasive window is the first ten pages, and it is spent on machinery the reader has no reason yet to learn.
- Fix: (1) Move Conventions to immediately after the Introduction, or to an appendix linked from the first chapter card. (2) Drop the LOF and LOT from the front (copyright.qmd:25-35), or move them to the back. (3) Drop the duplicate License section in index.qmd:70-82. (4) Open 00-intro with a real case in its first paragraph, and replace the composite at 00:20-34. (5) In Chapter 2, put the evidence section directly after a one-paragraph orientation. Move the ladder definition (01:155-172), the blank stack figure (01:211-239), and the vocabulary box (01:272-308) after the evidence, or cut them, since Chapter 3 defines all three.

### Chapter 2 leads with evidence it later calls irrelevant
- Location: 01-reproducibility-crisis.qmd:1381
- Quote: 'The Open Science Collaboration measures a problem this book does not address and cannot fix.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected
- Prior: new
- Problem: The chapter, and the intro's figure, open with OSC and Begley (replication), then concede in a solution that these do not bear on the book's subject. The re-execution studies, which do bear on it, are rates with no story. A careful mentor will notice that the headline numbers are borrowed from a different problem.
- Why it matters: Borrowed alarm undermines credibility with exactly the reader who reads closely.
- Fix: Lead with computational cases (Trisovic, Saju, Glatard, Chang, Duke, Reinhart and Rogoff). Mention OSC, Begley, and Baker in one paragraph as context. Make the argument in Exercise 6's 'stronger version' explicit in the body: a field that cannot re-execute its analyses cannot diagnose why a replication failed.

### 'Health-sciences research' claim rests on non-health evidence
- Location: 00-intro.qmd:42
- Quote: 'It is nonetheless a claim that a great deal of published health-sciences research cannot currently support.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (the claim, and the objective at 01:52-54, 'a large fraction of published health-sciences research cannot be regenerated'); unverified (field composition of the Trisovic and Saju samples; neither abstract states it: arxiv.org/abs/2103.12793, arxiv.org/abs/2505.21590)
- Prior: new
- Problem: The re-execution evidence comes from Harvard Dataverse replication packages and OSF supplements, which the book does not describe as health-science samples. The replication evidence is psychology and preclinical oncology. No cited study measures re-execution of health-science analyses.
- Why it matters: A referee will reject the generalization, and a non-health student sees the book claim evidence for a field it did not sample.
- Fix: Say 'published research, across fields that deposit R code' and state each sample's composition. If a health-specific re-execution study is wanted, cite one only after opening it. Rewrite the 01:52-54 objective to match.

### The skeptical mentor's objections are not answered
- Location: 02-levels-of-reproducibility.qmd:223
- Quote: 'Matching the investment to the stakes.** Climbing the ladder costs effort, and not every analysis warrants the climb.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected (grep of 00, 01, 02, preface, and index for policy, funder, journal, career, thesis, and dissertation: no persuasive hits)
- Prior: new
- Problem: Of the four objections: 'takes too long' gets only the stakes judgment above, with no estimate of time cost. 'My results have always been fine' gets nothing; the Baker epigraph's 'more than half have failed to reproduce their own experiments' (01:9) is never developed. 'Reviewers do not ask for it' gets nothing in the opening; policy appears only in Chapter 13. 'A software-engineering concern' is answered abstractly at 01:637-644 and 01:712-723.
- Why it matters: The mentor controls the student's time, and these are the objections the student will hear in the first lab meeting.
- Fix: Add a section to Chapter 2, 'Four objections, and what the evidence says', one paragraph each. (a) Cost: a concrete estimate, such as L1 in under an hour with `renv::init()` and a CI template in an afternoon, and the cost of not doing it (the Ten Years Challenge, Perkel 2020). (b) 'My results are fine': you cannot know without re-running (Chang's own software; Glatard: the same pipeline, different OS, different results in a third of fMRI subjects). (c) Reviewers: name the NIH DMS Policy, journal code policies (cross-reference Chapter 13's journal table), and Stodden et al. 2018, already in references.bib, showing that policy alone did not produce reproducible artifacts. (d) Engineering versus science: the Duke case, where code errors decided patients' treatment arms.

### No language for the student to make the case to a lab
- Location: 01-reproducibility-crisis.qmd:146
- Quote: 'This book exists to prevent that failure, and in this chapter we shall establish that the failure is real, common, and specifically computational.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The book argues to the student, never through the student. No passage, exercise, or callout helps a first-year student raise the subject with a PI who has published for twenty years without these practices.
- Why it matters: The author states that mentors may control whether the student is allowed the time. A student convinced but unequipped changes nothing.
- Fix: Add a callout, 'Making the case to your lab', with three to five sentences a student can say. For example: 'I would like to spend one afternoon adding a lockfile so that the figures in my first paper can be regenerated when reviewers ask; here is what it costs and what it protects.' Add a low-cost first step that does not require the PI's buy-in (L1 on the student's own project). Add an exercise: write a 200-word memo to your PI proposing the minimum rung for your thesis project, citing two cases.

### The student's personal benefit is never concrete
- Location: preface.qmd:5
- Quote: 'The script that produced last year's figures now errors on a colleague's laptop.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: Benefit is framed for science, auditors, and regulators (01:148-153). The student's own stakes appear only in this one preface sentence, and there in a colleague's voice. Absent throughout: the revision request nine months after submission, the committee member who asks for a re-run at the defense, the laptop that dies, reusing Chapter 2's code for Chapter 4 of the thesis, a public compendium as a job-market portfolio, and the weeks lost to reconstructing an environment.
- Why it matters: First-year students act on their own near-term interests far more than on the health of the literature.
- Fix: Add a 'What this buys you' paragraph near the start of Chapter 1, listing four concrete scenarios with the time each typically costs. Recast one Chapter 2 vignette as the student's own future self (the reviewer's revision request), and use the Ten Years Reproducibility Challenge as evidence that authors fail on their own code.

### Policy and funder mandates are absent from the opening
- Location: preface.qmd:15
- Quote: 'The health sciences have absorbed the lesson that a result must be reproducible in principle, and journals now ask for the code.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected (unsupported assertion; no citation; grep shows no NIH, OSTP, or journal-policy content in 00, 01, or 02 except AI rules at 01:1106-1110)
- Prior: new
- Problem: The book has verified policy material (NIH DMS Policy, the CONSORT and SPIRIT 2025 items, tbl-journal-code), but only in Chapter 13. The persuasive chapters never say the practices are increasingly required. The preface's 'journals now ask for the code' is uncited and, as a generalization, overstated.
- Why it matters: 'Reviewers do not ask for it' is the mentor's strongest practical objection, and the book's best answer is hidden in its last chapter.
- Fix: Add one paragraph to Chapter 2 (or a half-page table) naming three to five current mandates with dates, cross-referenced to Chapter 13. Hedge the preface: 'a growing number of journals and funders now ask for the code' with a citation.

### Audience statement contradicts the intended reader
- Location: index.qmd:54
- Quote: 'Comfort at the command line: running a shell command, editing a text file, and using `git` at a basic level.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new (the third review's Parameters table fixed the audience as health-science students who know R and basic git; the fourth-review prompt's reader has never used a terminal or git, and is in any empirical discipline)
- Problem: The index assumes shell and git comfort, and names only public health, biostatistics, and epidemiology (index:60-62). Chapter 2's card (01:44-47) says 'No R fluency beyond reading a short script is assumed', which contradicts the index's 'R at a working level' (index:51). A novice reading the Welcome is told the book is not for them.
- Why it matters: The first page of the book screens out the stated reader.
- Fix: Either rewrite index:49-64 to the new reader ('no shell, git, or container experience assumed; the Shell Primer and Setup Appendix supply it; examples come from health research, and the principles apply to any empirical field'), or restore the narrow audience and drop the broader goal. Reconcile 01:44-47 with whichever is chosen.

### Health-science and R framing excludes other disciplines
- Location: 00-intro.qmd:22
- Quote: 'Every quantitative health scientist has met the failure this book exists to prevent.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: Places where an ecology, psychology, economics, physics, or engineering student would feel addressed to someone else: title and subtitle (half-title:1-3); index:7-8 ('a health scientist will recognize'), 60-64; preface:15-23 ('The health sciences have absorbed'); 00:22, 43-44, 256 ('A biostatistician thereby obtains'); 01:43-44 (prerequisite 'a hazard ratio, or an odds ratio'), 126-127, 148-153 (regulator, clinical recommendation), 947 ('health-sciences example'), 1127 ('the study's clinical conclusion'); 02:402-404 ('staples of health research'), 520 (column 'Health-research reading'), 702-711 (FDA validation box); conventions:138-172 (both datasets clinical). R-only framing: 00:223-235 and the whole determinant stack name R defaults only, with no sentence acknowledging Python, Stata, or MATLAB users, whose analogous defaults change too.
- Why it matters: Every hypothetical is clinical, and the student from another field reads each as a reminder that the book is not about their work.
- Fix: Recommendation: keep the health-science focus (the datasets, restricted-data, and regulatory material are its distinctive strength) and add explicit bridges, rather than broaden or narrow. Concretely: (1) one sentence in index and preface naming the transferable scope; (2) a cross-discipline case bank in Chapter 2 (below), so that the real evidence spans five or more fields; (3) a 'Beyond R' paragraph in Chapter 1 noting that the stack and ladder apply to Python (`requirements.txt`, `uv.lock`), Stata, and MATLAB; (4) generic wording in prerequisites ('reading a regression table') and in exercises ('the study's main conclusion').

### Definitions, R defaults, and the stack paragraph are stated two or three times
- Location: 00-intro.qmd:211
- Quote: 'It records the analysis logic and, if the reader is fortunate, the data.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (the same sentence at 01:629-630; NAS definitions at 00:57-79, 01:437-457, 02:634-655; Peng spectrum at 00:81-92, 01:528-539, 02:572-576; Leek and Peng 'floor' at 00:73-76, 01:702-707, 02:648-651; the two R defaults at 00:181-199 and 01:569-605)
- Prior: 'reopens D18' (Finding 38 identified about 900 recoverable words; D18 chose no cuts). The new argument: under a persuasion-first goal, the repetition is not neutral. It is the material that delays the first case in each chapter, and it is the space needed for the case bank.
- Problem: A reader of Chapters 1 to 3 in sequence reads the same definitions three times and the same stack paragraph twice, nearly verbatim.
- Why it matters: The repetition consumes exactly the pages where persuasion must happen, and a reader notices the reuse.
- Fix: Keep the vocabulary in Chapter 2 and the stack in Chapter 3. Reduce Chapter 1 to a two-sentence pointer for each, and spend the recovered words on two real cases.

### A 180-line LLM and agent-governance section sits in the persuasive chapter
- Location: 01-reproducibility-crisis.qmd:1014
- Quote: '### What to delegate to a coding agent {#sec-llm-delegate}'
- Severity: major
- Viewpoint: student
- Evidence: inspected (01:932-1110 covers the include, three prompt triples, agent delegation, protected paths, OWASP prompt injection, disclosure templates, `LLM-USE.md`, commit trailers, and NIH grant rules)
- Prior: new (placement only; the content was added in Phase 22 for Finding 40)
- Problem: A first-year student who has not yet seen a lockfile, CI, or a branch is told to protect `inst/tinytest/`, `inst/baseline/`, `renv.lock`, and `.github/workflows/`, and to withhold registry and DOI credentials. These are forward references to six later chapters. The section is the chapter's longest non-exercise block and dilutes the argument.
- Why it matters: It doubles the jargon load of the persuasive chapter, and the persuasive point about AI (a model's output is not reproducible, 01:1082-1094) is lost inside governance detail.
- Fix: Keep a short paragraph in Chapter 2 on why AI-generated code raises the stakes for reproducibility. Move sec-llm-delegate and sec-llm-disclosure to Chapter 4 (version control, where branches and merges are taught) or to an appendix, and update the include's cross-reference.

### Replication studies described in re-execution words
- Location: 00-intro.qmd:100
- Quote: '@begley2012 reproduced only 6 of 53 landmark findings.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected; verified for the source wording (phase25 agent4 L3: 'scientific findings were confirmed in only 6 (11%) cases', nature.com/articles/483531a)
- Prior: new
- Problem: Under the National Academies convention the book adopts a few lines earlier, Begley and Ellis tested replication. 01:347 says 'could be reproduced' and 01:340 says OSC 're-ran one hundred published studies', which suggests re-execution.
- Why it matters: The book warns at length (02:673-694) that word-swaps mislead silently, then commits one in its first evidence sentence.
- Fix: 'confirmed only 6 of 53' (00:100, 01:347); 'conducted replications of one hundred published studies' (01:340).

### Begley and Ellis cited without the caveat that the 53 studies were not disclosed
- Location: 01-reproducibility-crisis.qmd:345
- Quote: 'Begley and Ellis, working from within industry, reported that only six of fifty-three landmark findings could be reproduced'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (from memory, the commentary states that the studies were not identified because of confidentiality agreements; I could not open the article: the Nature page redirected to login and the mirror returned 404)
- Prior: new
- Problem: A book about verifiable claims cites, as its second piece of evidence, a claim whose underlying studies and data were never published. A methodologist mentor will raise this.
- Why it matters: Uncaveated, it hands the skeptic an easy rebuttal.
- Fix: Verify, then add one clause: 'in a commentary that did not identify the studies, so the figure cannot itself be checked'. That clause is also a small lesson in the book's theme.

### Trisovic quoted at the initial failure rate only
- Location: 00-intro.qmd:107
- Quote: 'They found that roughly one in four executed without error, and that was before asking whether the output matched.'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (arxiv.org/abs/2103.12793 abstract: '74% of R files crashed in the initial execution, while 56% crashed when code cleaning was applied')
- Prior: new
- Problem: The second figure is the more persuasive one for this book, because it shows that simple coding practice (the book's subject) recovers a substantial share. Omitting it reads as selecting the grimmest number.
- Why it matters: Reporting both figures is more honest and makes a better argument.
- Fix: Add 'and automated code cleaning raised that to about 44 percent, which shows how much of the failure is mechanical' at 00:110 and 01:376.

### Saju is a preprint, and its numbers are quantified three ways
- Location: 00-intro.qmd:270
- Quote: '@saju2025 found that most deposited code supplements carry no dependency description at all'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (arxiv.org/abs/2505.21590: arXiv submission, 27 May 2025, no journal stated); inspected for the variants ('nearly every project' 00:115-116; 'most' 00:270-271; 'Close to ninety-nine percent' 01:381-383)
- Prior: new
- Problem: The text presents a preprint as settled evidence and uses three different quantifiers for one figure.
- Why it matters: A referee will flag an uncaveated preprint used as one of two pillars of the computational case.
- Fix: Say 'a 2025 preprint' once, and use 'about 99 percent' at all three sites.

### fig-failure-rates sets incomparable units side by side
- Location: 00-intro.qmd:135
- Quote: 'Reported success rates in four studies, separated by what each measured.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: The four bars count different units: subjective replication judgments of studies, confirmed findings, R files, and R scripts. One source is a commentary, not a study. The text then calls them 'comparably low' (00:127-128).
- Why it matters: A methodologist will object to a bar chart that invites comparison across units.
- Fix: Label each bar with its unit ('of 100 studies', 'of 53 findings', 'of 9,078 files', 'of 460 scripts'), and replace 'comparably low' with 'each low on its own terms'.

### The trial-auditor vignette is contrived
- Location: 01-reproducibility-crisis.qmd:136
- Quote: 'The point estimate has moved in the third decimal place, however, and one confidence interval no longer excludes the null.'
- Severity: minor
- Viewpoint: mentor
- Evidence: inferred
- Prior: new
- Problem: A third-decimal shift crosses the null only if a bound sat within about 0.001 of it. A regulatory primary analysis held at L0 with an unrecorded `library()` environment is unlikely in sponsor practice, which a pharma-literate mentor will notice.
- Why it matters: A vignette that a domain expert finds implausible costs more credibility than it gains.
- Fix: Replace it with a real case (Duke), or make it a thesis-revision scenario: a student's dissertation analysis, re-run for a reviewer's request a year later.

### The optimizer vignette could be a real, checkable case
- Location: 02-levels-of-reproducibility.qmd:132
- Quote: 'A package that the analysis relied upon has changed its default optimizer, and the estimate now returned is 1.19.'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (lme4 is believed to have changed its default optimizers across 1.1.x releases; I did not open its NEWS)
- Prior: new
- Problem: A real default change in a widely used mixed-model package would turn this from an invented example into evidence.
- Why it matters: A real package and version number is more persuasive and teaches the reader where to look (NEWS files).
- Fix: Check the lme4 NEWS for the release that changed the `lmer` or `glmer` default optimizer. If confirmed, name the package and version, and keep the `allFit()` advice.

### 'Two numbering schemes' imports a tool's internal scale into the core argument
- Location: 02-levels-of-reproducibility.qmd:750
- Quote: '## Two numbering schemes, and which this book uses'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: 'reopens D18' (Finding 38 listed it as a candidate cut). The new argument: in Chapter 3, which a novice reads in week 1, it teaches a second scale that the reader will not meet until they read zzcollab's own documentation.
- Problem: About 60 lines and an exercise (02:1210-1214) are spent disambiguating a vignette the reader has not seen.
- Why it matters: It adds cognitive load at the point where the ladder is first being learned.
- Fix: Replace the section with a two-sentence footnote, and move Exercise 4 to the compendium chapter.

### zzcollab's authorship is not disclosed where it is introduced
- Location: index.qmd:37
- Quote: 'The concrete vehicle throughout is `zzcollab`, an open-source R framework built around the levels ladder.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (no authorship statement in index, preface:57-71, or credits:3-10); inferred that the book's team wrote it (bib key `thomas2026zzcollab`, credits:3-7 'accompanying methodological paper')
- Prior: new
- Problem: The preface says the choice is 'honestly motivated' but does not say that the book's authors wrote the tool.
- Why it matters: A referee and a skeptical mentor expect a conflict-of-interest statement, and its absence invites suspicion out of proportion to the issue.
- Fix: Add to preface:59: 'which we developed alongside this book; every chapter names the general tool it composes, so that a reader can follow without it.'

### The Chapter 2 'from earlier chapters' check comes before the chapter begins and relies on untaught terms
- Location: 01-reproducibility-crisis.qmd:116
- Quote: 'A container built from a Rocker image would have, since it pins the operating system and the runtime, the rung the book calls L2'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new (placement; the check was added in Phase 24 for Finding 44)
- Problem: The check sits before the Orientation. Its answer uses Rocker, container, L2, `renv`, and CI, none of which Chapter 1 teaches beyond naming. In a chapter whose job is persuasion, it is a quiz before the case.
- Why it matters: Spaced retrieval is valuable, but here it delays the argument and confronts the novice with undefined terms.
- Fix: Move the 'from earlier chapters' check to the end of the chapter in Chapters 2 and 3 (or after the first section), and limit its answer to terms already taught.

### The introduction names tools a novice cannot yet parse
- Location: 00-intro.qmd:204
- Quote: 'The stack includes the operating system and its system libraries, the numerical libraries that implement linear algebra, the language runtime'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (00:201-259 introduces BLAS-level 'numerical libraries', locale, contrasts, `knitr`, `renv`, Docker, Rocker, CI, Nix, `rix`, Podman, Apptainer, and GitLab in about 60 lines, with no glosses)
- Prior: new
- Problem: For the stated novice reader, this is a tool catalog, though the text says it avoids one: 'We introduce each tool where the chapter ahead needs it, not in one early catalog' (00:236-237).
- Why it matters: The reader meets thirteen unfamiliar names in the chapter meant to persuade.
- Fix: Cut 00:223-235 to one sentence ('each layer has a mature tool, introduced in the chapter that needs it') and drop the alternatives list.

### The habits box uses vocabulary not yet defined
- Location: _habits.qmd:9
- Quote: '4. Make every gate able to fail, and watch it fail once.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (included at 00-intro:332 and 10-archiving-sharing:2317; 'gate', 'baseline', 'tolerance', and 'restricted data' are undefined at 00-intro)
- Prior: new
- Problem: The seven habits end Chapter 1 as slogans the novice cannot yet interpret. Habits 4 and 5 are opaque at that point.
- Why it matters: A motto list is a good persuasive device only if each line is understood.
- Fix: Add a one-clause gloss to each habit in the Chapter 1 instance ('a gate: an automated check that can block a merge'), or show the box only in Chapter 13 and give a three-habit preview in Chapter 1.

### The restricted-data include is long and repeated, and is placed before the persuasive point of each LLM section
- Location: _llm-rule.qmd:4
- Quote: 'One rule comes first (habit 3). Never paste or upload protected health information, identifiable records, or data held under a data use agreement'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (32 lines, included in 12 chapters per grep; the content was verified in Phase 19)
- Prior: 'reopens D19' only as to placement and length, not content. The new argument: for a non-health reader, 'protected health information' and 'IRB' twelve times reinforces the exclusion described above.
- Problem: The rule is correct and important. Repeated verbatim, it is the most-read passage in the book, and it speaks only in health-data terms.
- Why it matters: A non-health student reads the same boxed health-data warning twelve times.
- Fix: Keep the full box once (Chapter 2 or 4). Elsewhere, use a one-line reminder with a cross-reference, and generalize the wording to 'confidential or restricted data (for example, protected health information, student records, proprietary or licensed data)'.

### Tone: presumption, and a few charged words
- Location: 00-intro.qmd:96
- Quote: 'The case for taking this seriously is empirical, and it is grim.'
- Severity: minor
- Viewpoint: mentor
- Evidence: inspected (also 'more damning' 00:104-105 and 01:336; 'rests on faith rather than evidence' 01:153; 'without flinching' 00:324 and 02:175; 'missed the exercise' 01:1320; 'Every quantitative health scientist has met' 00:22 and 01:126-127)
- Prior: new
- Problem: The text is not preachy overall, but 'grim' and 'damning' signal advocacy to a skeptic. 'Every ... has met' presumes an experience a first-year student has not had and a mentor may deny. 'Missed the exercise' is mildly condescending in a solution.
- Why it matters: A skeptical reader discounts advocacy language and resists presumption.
- Fix: 'The evidence is consistent and sobering'; 'more telling, because more avoidable'; 'Many analysts eventually meet...'; drop 'without flinching'; rewrite 01:1319-1321 as 'If you answered "the data" for every archetype, look again: the exercise asks where the binding constraint moves.'

### Preface claims the chapter opening motivates 'from a concrete research problem', but the problems are invented
- Location: preface.qmd:144
- Quote: 'It opens with learning objectives and an orientation that motivates the chapter from a concrete research problem.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (both Orientations in 01 and 02 open with 'Consider', followed by a composite)
- Prior: new
- Problem: 'Concrete' is true only in the sense of specific. None of the orientations in Chapters 2 and 3 is a real problem.
- Why it matters: This compounds the lack of real cases.
- Fix: Make at least the Chapter 2 and 3 orientations real cases, or say 'an illustrative research problem'.

## Proposed case bank for the persuasive chapters

| Case | Field | Lesson | Primary citation | Status |
|---|---|---|---|---|
| Duke genomic signatures; simple row or column offsets; patients assigned to trial arms on the results | Cancer genomics, clinical trials | Code errors reach patients; forensic re-analysis found them | Baggerly and Coombes, Ann. Appl. Stat. 3(4):1309-1334, 2009, doi:10.1214/09-AOAS291 | verified, abstract (arxiv.org/abs/1010.1092): 'several simple errors that may be putting patients at risk'; 'row or column offsets'. Trial timeline from authors' supplement page only, unverified |
| Reinhart and Rogoff spreadsheet error excluding five countries | Macroeconomics, policy | An unreproducible spreadsheet informed austerity debates | Herndon, Ash, and Pollin, Camb. J. Econ. 38(2):257-279, 2014 | unverified (search summary only) |
| Homemade software flipped two columns; three Science papers retracted | Structural biology | Your own code can invalidate years of work | Miller, Science 314:1856-1857, 2006; retraction, Science 314:1875 | unverified (search summary only) |
| Same neuroimaging pipelines give different results on different OS builds | Neuroimaging | The OS and math libraries are part of the result | Glatard et al., Front. Neuroinform. 9:12, 2015, doi:10.3389/fninf.2015.00012 | verified, abstract (frontiersin.org): Dice coefficients 'as low as 0.59'; ICA 'differ between operating systems in one third of the tested subjects' |
| Excel converts gene symbols to dates; about one in five papers with Excel gene lists affected | Genomics | Tool defaults silently corrupt data | Ziemann, Eren, and El-Osta, Genome Biol. 17:177, 2016 | unverified (search summary: 19.6 percent; follow-up 30.9 percent in 2021) |
| Scientists try to re-run their own ten-year-old code | Many (physics, neuroscience, computing) | 'My results are fine' fails on your own code | Perkel, Nature 584:656-658, 2020; ReScience C Ten Years Challenge | unverified (search summary: 43 proposed, 28 reports) |
| Journal policy alone did not produce reproducible artifacts | Multidisciplinary (Science) | Mandates need practice | Stodden, Seiler, and Ma, PNAS 2018 (`stodden2018`, already in bib; phase 25 verified 44 and 26 percent) | verified by phase 25 (cite as such) |
| Trisovic: 74 percent of files fail initially, 56 percent after cleaning | Multidisciplinary repository | Much failure is mechanical | trisovic2022 | verified, abstract (arxiv.org/abs/2103.12793) |
| Python NMR scripts give OS-dependent results due to file ordering | Chemistry | Silent platform behavior | Reported 2019; registry notice cites PMID 31591889 | unverified: authors, journal, and mechanism not retrieved; do not use until opened |

Gaps the bank leaves: ecology, physics proper, and engineering still
lack a verified case. An I4R mass-reproduction study in economics and
political science would fill the social-science gap. That 'reopens'
Section 7's 'not recommended' for I4R, on the same persuasion argument.
It is unverified here.

## Scope disclosure

- **Read in full:** half-title.qmd (3 lines), copyright.qmd (35),
  index.qmd (82), contents.qmd (52), preface.qmd (152), conventions.qmd
  (209), 00-intro.qmd (332), 01-reproducibility-crisis.qmd (1,488, in
  three chunks), 02-levels-of-reproducibility.qmd (1,553, in four
  chunks), _habits.qmd (13), _llm-rule.qmd (32); BRIEF.md;
  fourth-review-prompt.md; THIRD-REVIEW-PLAN.md (991 lines, in two
  parts).
- **Grepped, not read:** REFACTOR-PLAN.md (read only lines 1540-1620,
  Findings 17 to 19); docs/third-review/*.md for my filenames and for
  persuasion terms. One grep was truncated at 80 lines, so a few
  reader-a, reader-e, and persona-ms lines past that point may be
  unseen. I read reader-a's Chapter 1 to 3 sections and the phase25
  agent4 verification table rows via grep.
- **PDF:** page measurements come from `pdftotext` of the 2026-11-09
  build, which predates commit 3b352ab; offsets may differ by one page.
  No render was run. No code was executed.
- **Web checks:** Trisovic and Saju abstracts, Baggerly and Coombes
  abstract, and Glatard abstract opened (verified). Ziemann, Herndon,
  Miller, Perkel, and the NMR-script case rest on search-engine
  summaries only (unverified). Nature, Springer, and PubMed pages
  redirected or blocked. Begley and Ellis's confidentiality statement
  was not checked. The field composition of the Trisovic and Saju
  samples was not established.
- **Not assessed:** whether the case bank's suggested placements fit
  page budgets; chapters outside my assignment except grep hits for
  zzcollab in credits.qmd and 03.
