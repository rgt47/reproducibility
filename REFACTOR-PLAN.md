# Refactoring Plan: *Reproducible Research for the Health Sciences*
*2026-09-07 18:38 PDT*

## 0. Status

**A second review was conducted on 2026-10-10 and is reported in
Section 10.** Unlike the scan below, it read every chapter, checked
technical claims by running them, and surveyed coverage against 30
syllabi and 28 reference texts. It found eleven Tier 1 defects,
including that the L3 stamp can be awarded to a compendium whose
tests fail and that no CI gate the book teaches can fail on what it
checks. Phases 6 to 14 and Decisions D1 to D12 are in Section 10.

**Phases 0, 1, and 2 were applied on 2026-09-07 and 2026-09-08.**
Their acceptance criteria were checked by running them, with one
criterion deliberately not met and recorded as such in Phase 2.
**Phase 3 was attempted on 2026-09-08 and withdrawn**; its artifacts
were written and then removed, and the reasons are recorded in the
phase itself because they constrain any future attempt. Finding 5
therefore remains open. Phase 4 is not started.

**Finding 11 and Phase 5 were added and Phase 5 applied on
2026-09-08**, after a question from the author surfaced a defect the
original review missed: the introduction promised a running example
compendium that the book did not contain. It now does, with one
acceptance criterion left deliberately unmet and argued against in the
phase. The defect was a promise-versus-delivery mismatch, which a
mechanical scan cannot detect, and it would have ranked second among
the findings had it been caught on 2026-09-07.

**Phase 4 was partly applied on 2026-09-08.** The glossary is done;
the index was decided against and the reasoning recorded; exercise
rebalancing was measured and deliberately not actioned; catalog
submission and photograph sourcing need the author. The glossary
extraction exposed two consistency defects in the chapters, a
duplicated heading and two competing entry formats, both now fixed.

Three claims in the first draft of this plan were corrected on
2026-09-07 after being tested rather than inferred. They are marked
**[corrected 2026-09-07]** where they appear.

1. **The page estimate was wrong by a factor of 1.8.** The plan
   estimated ~168 pages from a 450-words-per-page divisor. The book
   was subsequently rendered to PDF for the first time and is **304
   pages** at 6.5 by 9 inches. The divisor did not account for code
   blocks, callouts, and figures. The true figure is closer to 250
   words per page.
2. **The PDF builds, and it has a table of contents.** Both were
   listed as unknown. `quarto render --to pdf` completes with no
   errors under LuaTeX, and the table of contents runs from page 9.
   This confirms rather than overturns the earlier reading of
   `copyright.qmd`.
3. **Open Textbook Library eligibility is now verified, not
   assumed.** The plan flagged its own claim about NoDerivatives as
   unverified. OTL accepts Creative Commons licenses with the sole
   exception of the ND component, which it stopped accepting in
   November 2016. NC and SA are both acceptable. See Finding 4.

A regression guard was added as part of Phase 0. `inst/tinytest/
test-manuscript-invariants.R` asserts the Phase 0 gains directly:
every check has an answer, every answer sits behind a collapsed
callout, every labeled figure has alt text, every chapter named in
`_quarto.yml` exists, and the license declarations agree. With
`test-cohort.R` added in Phase 5 the suite now runs 180 assertions, up
from 69, and replaces the tautological `expect_true(TRUE)` stub. The
concealment predicate was mutation-tested against the pre-change
sources to confirm it fails when it should.

## 1. Purpose and method

This document reports a mechanical review of the book sources in
`analysis/report/`, conducted on 2026-09-07, and converts the
measurements into a phased plan with acceptance criteria a script can
check.

The organizing principle is worth stating before any finding, because
it determines what was measured. Open licensing reliably buys access
and retention; it buys no pedagogy at all. Clinton and Khan (2019,
*AERA Open*) pooled 22 comparisons over roughly 100,000 students and
found a learning difference of essentially zero (g = 0.01, p = .87),
alongside substantially lower course withdrawal (OR = 0.71, p = .005).
Everything below is therefore about craft and adoptability. A book is
not better because it is free; it is merely reachable.

**What was measured.** Word counts, exercise counts, published
solutions, executable versus display-only code fences, rendered
figures, retrieval checks, section-level code incidence, alt text,
license declarations, table-of-contents provision per output format,
and bibliography recency. Counts were taken from the 13 body chapters
named in the `chapters:` block of `_quarto.yml`, excluding
`half-title`, `copyright`, `index`, `preface`, `conventions`,
`references`, `credits`, and `colophon`.

**What this does not cover.** It is not a reading. It makes no
judgment about whether the prose is correct, clear, or well
organized, and it makes no judgment at all about cultural relevance,
which cannot be measured by grep. See Section 8.

**Prior review documents.** A search of the repository found none.
Nothing here supersedes an earlier document, because there is no
earlier document. The `colophon.qmd` does, however, contain a
standing commitment from the author about the book's own
reproducibility level, and Finding 4 adopts that commitment rather
than proposing a new one.

## 2. Executive summary

**The original diagnosis, as written on 2026-09-07.** The book had 72
exercises and no published solutions, so the single technique the
learning-science evidence rates highest was present in form and absent
in effect. It had 14 computed artifacts across 75,648 words, of which
only 4 were figures, leaving 9 of 13 chapters with nothing to look at
over 304 pages. Its license was declared four times in three
contradictory ways, and the reader-facing declaration carried a
NoDerivatives clause that disqualified the book from the Open Textbook
Library. And the book's own compendium, in a book about compendia, was
an empty scaffold with no lockfile and no Dockerfile.

**What now stands, after Phases 0 to 2 and 5 [updated
2026-09-08].** Three of those four are closed. All 72 exercises have published solutions,
though roughly 30 of them are statements of what a good answer
establishes rather than answer keys, because those exercises operate
on the reader's own data. The figure count is 10 and every chapter
carries at least one computed artifact, though five of the six new
figures are drawn schematics rather than displays of computed
findings, which Section 8 treats at length. The license is CC BY-NC-SA
4.0 for the prose and CC0 for the code, declared consistently across
five files, and OTL eligible.

**The fourth is only partly closed, and what remains of it is now the
leading finding.** Phase 5 populated the data directories and gave the
compendium real functions and real tests, so the repository is no
longer a bare scaffold. But there is still no `renv.lock` and no
`Dockerfile`, and the CI gate renders from a committed freeze cache
and so never re-executes the book's R code. A reviewer who clones the
repository of a book about computational verification still meets an
unpinned environment and an unexercised gate.

Phase 3 was attempted on 2026-09-08 and withdrawn rather than
completed. Three constraints defeated it: committing a `Dockerfile`
silently switches the shared CI gate to building a multi-gigabyte
image, the CI workflow is shared across the `~/prj/tch` books and must
not diverge for one of them, and `renv` will not emit package hashes
for a library it does not itself manage, which was confirmed on two
platforms. A lockfile without hashes would contradict what the
dependencies chapter teaches. The phase sets out what a future attempt
needs.

**A fifth problem was found on 2026-09-08 and is not in the original
diagnosis at all.** The introduction promises that each chapter builds
its concept 'inside a running example compendium' and that a reader
following along 'will finish with a reproducible project of their
own'. The running example is named in 2 of 13 chapters, the data
directories are empty, every worked example is declared synthetic or
unexecuted, and the testing chapter calls five functions that do not
exist. In a book about the distance between what an analysis claims
and what it delivers, an unkept promise in the front matter is a
credibility defect before it is a pedagogical one.

**Phase 5 closed it the same day.** The book now ships a seeded
generator writing a 401-row synthetic extract, six documented
functions in `R/`, 180 test assertions across the four kinds the
testing chapter teaches, and three chapters computing from
`survival::diabetic`. A reader can now follow along. See Finding 11
and Phase 5.

Tersely, the strengths. The 25 'Check your understanding' sections
place their answers adjacent to their questions, which is the
placement the evidence asks for and which most open textbooks get
wrong. The bibliography is current, with 9 entries from 2024 or later
out of 84, so the 'references trail off a decade ago' complaint does
not apply. The prose is single-authored, which buys the consistency
that the multi-author open textbook corpus conspicuously lacks. These
do not offset the findings below.

## 3. Measured state

| Property | Measured | Target from evidence |
|---|---|---|
| Body chapters | 13 | n/a |
| Total words (body) | **93,686 (was 75,648)** | n/a |
| Pages | **372 (was 304 pre-solutions)** [corrected 2026-09-07] | ~140 for one semester (Downey, guideline only) |
| Words per chapter | 3,892 to 7,117 | even weight, or exercises proportional |
| Exercises | 72 (6 per chapter, 12 chapters) | n/a |
| Published solutions | **72 of 72 (was 0)** | 1 per exercise (Dunlosky) |
| Retrieval checks | 25 | 1 per major section, so ~159 |
| Checks concealing the answer | **25 of 25 (was 4)** | 25 of 25 |
| Technical sections | 159 | n/a |
| Code-bearing sections | 36 (upper bound) | n/a |
| Executable chunks | **20 (was 14)** | up to 36, realistically fewer |
| Rendered figures | **10 (was 4), verified in `_book`** | see Finding 3 |
| of which display computed findings | **5 (was 4)** | see limitations, Section 8 |
| of which are drawn schematics | **5 (was 0)** | see limitations, Section 8 |
| Rendered tables | **12 (was 10)** | n/a |
| Total computed artifacts | **23 (was 14)** | see Finding 3 |
| Display-only code blocks | **74 (was 54; solutions added some)** | see Phase 2: mostly not convertible |
| Chapters with zero figures | **3 of 13 (was 9)** | see Finding 3, revised |
| Chapters with zero artifacts | **0 of 13 (was 1)** | 0 |
| Figures with `fig-alt` | **10 of 10 (was 0 of 4)** | all informative figures |
| Ambient images | 0 (cover excluded) | very few; see Finding 3b |
| License declarations | **5 files, agreeing (was 3 answers)** | prose and code each declared once |
| Glossary | **93 terms, 1 appendix (was none)** | 1 |
| Index | none | **decided against; see Phase 4** |
| TOC, HTML | present (`toc: true`) | present |
| TOC, PDF | **present, pages 9 onward, verified** | present |
| Bibliography entries | 84, 9 from 2024+ | current |
| `freeze` | `auto`, `_freeze/` committed | n/a |
| Clean build, cache cleared | **verified 2026-09-08, both formats** | passes |
| Companion data | **populated: 401-row extract (was empty)** | n/a |
| Running example promised in intro | yes | yes |
| Chapters using the running example | **5 of 13 (was 2)** | most; see Finding 11 |
| Undefined functions in examples | **0 (was 5)** | 0 |
| Test suite | **181 assertions (was a tautology)** | n/a |

## 4. Findings, ranked

### Finding 1. A reader cannot check their own work

**Measured.** 72 exercises across 12 chapters, uniformly 6 per
chapter. Zero published solutions, verified by grepping every heading
in every source file for 'solution' or 'answer': the only four matches
are the nested answer callouts inside 'Check your understanding'
sections in `05-containers.qmd` and `10-archiving-sharing.qmd`, which
belong to the checks and not to the exercises. There is no solutions
appendix; the `appendices:` block contains only `credits.qmd` and
`colophon.qmd`.

**Why it matters.** Dunlosky et al. (2013, *Psychological Science in
the Public Interest*) rate practice testing as one of only two
high-utility techniques. The mechanism is feedback. An exercise
without a published answer does not deliver feedback, so it does not
deliver the effect. For a self-study reader, which the web edition's
audience largely is, an unanswered exercise is closer to a suggestion
than to practice.

**Complication specific to this book.** Several exercises are not
self-checkable in the ordinary sense. Exercise 4 of
`04-dependencies.qmd` asks the reader to time an install against a
dated Posit Package Manager snapshot; the answer is a number that
varies by machine and network. Exercises that ask the reader to
provision cloud resources or to argue a position in a paragraph have
no single correct response. The remedy for these is a worked
discussion of what a good answer establishes, not an answer key, and
the plan should not pretend otherwise.

**Action.** Write a solutions appendix, or per-chapter answer
sections. Prefer per-chapter, immediately after the Exercises heading,
inside a collapsed callout, because Çetinkaya-Rundel, Diez and Barr
(2013, *TISE*) name solution adjacency as a design principle and
because the book already uses exactly that pattern for its checks.

### Finding 2. Almost all the code is inert

**Measured.** 54 display-only fences (` ```r `, ` ```bash `,
` ```yaml `, and similar) against 14 executable ` ```{r} ` chunks
across the 13 body chapters. No chunk anywhere carries `eval: false`,
so the display-only blocks are genuinely un-executed rather than
suppressed chunks, which would be a different finding. The
distribution is uneven: `version-control.qmd` has 13 display blocks
and 1 executable chunk, `08-testing-quality.qmd` has 11 and 1.

**Why it matters.** Display-only code is unverified code. Nothing
proves it runs, and the book's own argument, that computed output and
the code beside it cannot drift apart, applies to the book itself.
This is also the upstream cause of Finding 3: a chapter with no
executed code can produce no computed artifact, so the two should be
scheduled together rather than as separate workstreams.

**Complication specific to this book.** Much of the display-only code
is shell, Docker, YAML, and Makefile content that cannot execute
inside a knitr chunk and should not. The 54 figure is an upper bound
on what is convertible, and the achievable number is substantially
lower. The convertible subset is the R code: `version-control.qmd` and
`08-testing-quality.qmd` are the two chapters where inspection
suggests real R blocks are being shown rather than run.

**Action.** Triage the 54 blocks into three piles: convertible R,
shell or config that must stay display-only, and code that should
become a computed artifact. Convert the first pile. Report the pile
sizes, because the number is not currently known and this plan does
not assert one.

### Finding 3. There is very little to look at

**Measured.** 4 rendered figures in the entire book, confirmed by
listing `_book/*/figure-html/`: `fig-determinant-stack`,
`fig-gates`, `fig-simpson`, and `fig-pipeline-dag`. Nine of thirteen
chapters render no figure at all, including `00-intro.qmd`,
`01-reproducibility-crisis.qmd`, `04-dependencies.qmd`,
`05-containers.qmd`, `06-backends-runtimes.qmd`,
`08-testing-quality.qmd`, `09-continuous-integration.qmd`,
`10-archiving-sharing.qmd`, and `version-control.qmd`. There are also
10 computed tables, which are artifacts but are not figures. There are
zero `![...]` image inclusions, so there is no ambient imagery of any
kind beyond the cover.

A caution on method, because the naive count misleads here. Counting
`fig-` labels credits chapters with figures they do not have, since
`07-literate-programming.qmd` prints figure syntax as an illustration
of the syntax. The counts above are taken from the rendered output
directory, not from labels.

**Why it matters.** 'The textbook contains only words' and coverage
'thin when it comes to examples' are verbatim complaints in the
Belikov and McLure (2020, *IJOER*) corpus of 954 reviews.
Comprehensiveness sits at 73.0% positive, below every criterion except
cultural relevance and modularity.

**Target, technical figures.** Conditional, per code-bearing section:
one rendered artifact per section that shows code or data. Of 159
technical sections, 36 are code-bearing and 123 are prose-only, so the
target is 36 rendered artifacts against the current 14. Note that the
36 counts sections containing a fence of any kind, including bash,
YAML, and Dockerfile blocks that will never render an artifact, so 36
is an upper bound and the achievable number is lower. It will also
move once Finding 2's conversions land, so it must be re-measured
rather than treated as fixed.

**Do not set a uniform per-section figure count.** A quota forces
invented plots into prose sections, and an invented plot costs the
same effort as a real one while working against the reader.

**The chapter the conditional rule exempts wrongly.**
`01-reproducibility-crisis.qmd` has 10 technical sections, 1 of them
code-bearing, and no figure. It is also the chapter that makes the
book's empirical case, citing Baker's 1,500-scientist Nature survey and
the Open Science Collaboration replication study, both of which have
published numbers that would render directly as figures. The
conditional rule would exempt it precisely because it has the worst
deficit. Name it as an explicit exception and add code so that it
earns artifacts. `00-intro.qmd` is the second such case: 12 technical
sections, no code, no figures, no exercises, and no checks.

### Finding 3b. Ambient images: the recommendation is very few, and possibly none

**Measured.** Zero ambient images. No `images/README.md`, no
`CONTRIBUTING.md`, and no style guide states an image policy, so
there is no standing rule to adopt.

**Recommendation.** A small number of contextual photographs, on the
order of three to five, each CC-BY or CC0 and each attributed in
`credits.qmd`, placed at the first substantive mention of their
subject. Not a per-section budget and not a per-chapter one.

The arithmetic refutes the per-section alternative without argument.
One ambient image per technical section is 159 images, roughly one
every 475 words, and it carries four costs: it requires color interior
printing and so defeats a low-priced paperback; it adds tens of
megabytes to a PDF; it turns a small alt-text task into a large one;
and it places decoration inside explanations.

The three ambient kinds are not equivalent and should not share a
budget:

| Kind | Support | Disposition |
|---|---|---|
| Photographs of contexts and people | Affirmative, via cultural relevance | Use, sourced and attributed |
| Portraits of scientists | Neutral | Use sparingly |
| Generated metaphor figures | Negative | Exclude |

Exclude generated metaphor figures, on three grounds. They have no
provenance to record, and this book's `credits.qmd` requires
attribution. They are the purest decoration the category admits. And
in a book about research integrity and computational verification,
unattributed generated imagery invites the sharpest available review.
This last is a consistency risk the author may not have weighed, and
is raised as such rather than as a rule.

**Do not add part-opener images or part-opener prose pages.** A part
opener serves a reader moving through the book in order, and the
reading-compliance evidence says that reader is rare. It strengthens
Organization, at 78.0% positive already one of the corpus's stronger
criteria, rather than Modularity at 62.5%, which is served at section
and chapter level. `00-intro.qmd` already carries a map of the book's
structure, so a part opener would repeat that argument four times.

**Evidential asymmetry, stated because it matters.** The Dunlosky and
Belikov findings above are read from primary sources. The coherence
principle and the seductive-details literature invoked against ambient
imagery are background knowledge in this review and were **not**
verified against Mayer or the primary articles. Treat the ambient
caution as grounds for restraint, not prohibition.

### Finding 4. The license blocks adoption, and the repository does not know what it is

**RESOLVED 2026-09-07 (Phase 0).** The prose is now CC BY-NC-SA 4.0
and the code CC0, declared consistently in `LICENSE`, `DESCRIPTION`,
`CITATION.cff`, `copyright.qmd`, and `index.qmd`. `CC BY-NC-SA 4.0`
and `CC0` are both in R's `license.db`, verified by reading it, so
`R CMD check` raises no license warning. The finding is retained
below as the record of what was wrong.

**Verification of the eligibility claim [corrected 2026-09-07].** The
original text below asserted that ND 'disqualifies the work as an open
educational resource in most catalogs' and flagged the claim as
unverified. It is now checked against the Open Textbook Library's own
criteria: OTL accepts GNU and Creative Commons licenses **with the
sole exception of the ND component**, which it stopped accepting in
November 2016, on the stated grounds that NoDerivatives prevents
revising and remixing. CC BY is recommended but not required, and
neither NC nor SA is excluded. CC BY-NC-SA 4.0 is therefore eligible.

Two further OTL criteria matter and were not in the original finding.
A complete **portable file (PDF or EPUB) is required**, which promotes
the PDF build from housekeeping to a hard prerequisite for Phase 4;
the PDF has since been built and is 304 pages. And the work must be
**affiliated with a higher education institution**, a scholarly
society, or a professional organization, or in use at multiple
institutions; the author's UCSD affiliation satisfies this.

Sources: <https://open.umn.edu/opentextbooks/books>,
<https://open.umn.edu/opentextbooks/textbooks/submit>.

**Measured, before the fix.** Four files declared a license and they
gave three answers.

| File | Declares |
|---|---|
| `analysis/report/copyright.qmd` | CC BY-NC-ND 4.0 (prose), CC0 (code) |
| `analysis/report/index.qmd` | CC BY-NC-ND 4.0 (prose), CC0 (code) |
| `DESCRIPTION` | GPL-3 |
| `CITATION.cff` | GPL-3 |
| `LICENSE` | neither; a bare `YEAR:`/`COPYRIGHT HOLDER:` stub |

**Why it matters, in two separate ways.**

First, the reader-facing license itself. ND and NC variants are widely
held to disqualify a work as an open educational resource, because
revision and remix are the defining affordances; the Open Textbook
Library rubric treats modularity and adaptability as criteria, and
modularity is already the weakest criterion in the corpus at 62.5%
positive. A no-derivatives clause makes the book unmodifiable by
adopters as a matter of law, which is the strongest possible version
of the corpus's most common complaint. CC BY is the standard
recommendation.

Second, the disagreement. GPL-3 applied to prose is a red flag that
usually blocks catalog listing on its own. An adopter who checks two of
these files learns that the authors do not know what the license is,
which is a credibility cost independent of which license is correct.
The `LICENSE` stub is an unfilled template.

**Action.** Decide one license, apply it in all four files, and fill
the `LICENSE` stub. If the intent is an open textbook, that license is
CC BY 4.0 for the prose with CC0 retained for code. If the intent is
to reserve commercial and derivative rights, that is a legitimate
choice, but it should be made knowingly and the book should stop being
described as an open textbook.

### Finding 5. The book's own compendium is an empty scaffold

**Measured.** No `renv.lock`. No `Dockerfile`. `analysis/data/raw_data`
and `analysis/data/derived_data` are both empty. `inst/tinytest/`
contains one file whose entire content is `expect_true(TRUE)`.
`.devcontainer/devcontainer.json` references an image named
`reproducibility` that the repository provides no means to build.
The CI workflow renders `--to html` only, and because `_freeze/` is
committed (29 tracked files), CI does not re-execute the R chunks, so
the render gate does not currently verify that the book's code runs.

**Why it matters.** This is not a hidden defect. `colophon.qmd`
already states that 'pinning the book's own environment to the
standard the later chapters develop, a lockfile and a container, is
planned rather than complete' and commits to disclosing the book's own
level honestly. This finding therefore adopts the author's standing
commitment and reports the gap against it rather than proposing a new
rule. The gap is that the book teaches L2 and its own compendium sits
at L0.

The credibility exposure is specific and worth naming: a reviewer who
clones the repository of a book about computational verification finds
an empty data directory, a tautological test, and a devcontainer
pointing at an unbuildable image. That is the sharpest available
review of this particular book, and it is cheap to close.

**Action.** Add `renv.lock` and a `Dockerfile`. Make the devcontainer
buildable or remove it. Either replace the stub test with a real one
or remove `inst/tinytest/` until there is something to test; a
tautology is worse than an absence in a book that argues tests are
evidence. Consider a periodic CI job that renders with the freeze
cache cleared, so the render gate actually exercises the code.

**Partially addressed 2026-09-07 (Phase 0).** Two of the three
credibility exposures are closed. The tautological test is replaced by
69 manuscript-invariant assertions, and the devcontainer now starts
from `rocker/verse:4.4.0`, a public image that exists, with an inline
note to switch to the project image once the Dockerfile lands. The
lockfile, the Dockerfile, the empty data directories, and the
freeze-cleared CI job remain open and are Phase 3.

### Finding 6. Retrieval practice is well placed but reveals its answers too early

**RESOLVED 2026-09-07 (Phase 0).** All 25 answers now sit behind their
own collapsed callout. The scan found four patterns rather than the
three the original text describes: 15 bare-prose answers, 4 with an
`*Answer.*` lead-in, 2 wrapped in a non-collapsing
`appearance='minimal'` callout, and the 4 correct ones. All are now
identical. `conventions.qmd`, the book's own key to its callout
types, was updated in the same pass, since its specimen still told the
reader to 'click to expand the answer' and would otherwise have
misdescribed the convention it documents.

**Measured, before the fix.** 25 'Check your understanding' sections across the body
chapters (2 per chapter, 3 in `version-control.qmd`, 0 in
`00-intro.qmd`). All 25 sit inside a collapsed callout that contains
both the question and its answer. Only 4 of the 25, the two in
`05-containers.qmd` and the two in `10-archiving-sharing.qmd`, nest a
second collapsed callout around the answer.

**Why it matters.** The placement is right and most open textbooks get
it wrong, so this is a near miss rather than a defect. But the
mechanism of practice testing is the retrieval attempt, and when
expanding the callout reveals question and answer in a single motion,
the retrieval attempt becomes optional. Twenty-one of twenty-five
checks currently make it optional.

**Action.** Wrap the answer of every check in the nested collapsed
callout that four of them already use. This is a mechanical edit and
the pattern is already in the book, which makes it one of the highest
ratios of pedagogical gain to effort in this plan.

### Finding 7. Practice is uniform, and the chapters are not

**Measured.** Exactly 6 exercises and exactly 2 checks in every
chapter but two, against chapter lengths from 3,892 to 7,117 words, a
1.8-fold range. `00-intro.qmd`, at 3,892 words and 12 technical
sections, has 0 exercises and 0 checks. **[corrected 2026-09-08:** the
introduction was counted here as a chapter and is not one. It uses
none of the chapter template and is front matter in substance, so its
zeros are correct rather than missing. It should be excluded from this
finding's denominator, which makes the range 4,531 to 7,388 words
across the twelve chapters that do carry exercises. See the retraction
in Phase 4.**]**

**Why it matters.** Uniform counts across chapters of unequal length
signal a template rather than a judgment. The reader gets the same
amount of practice for 15 pages as for 9. This is a weaker finding
than the ones above and should not displace them.

**Action.** After Finding 1 lands, revisit the counts and let the
longer chapters carry more. Do not restructure prose to equalize
lengths.

### Finding 8. Nothing is findable except by search

**Measured.** No glossary heading in any file. No index in either
format. The HTML edition sets `toc: true` with a docked sidebar and
`search: true`. The PDF sets `toc: false` in `_quarto.yml`, but
`copyright.qmd` injects `\tableofcontents` inside a
`content-visible when-format='pdf'` block, so the PDF does have a
table of contents. The common failure of a tocless long PDF does not
apply here.

**Complication.** Every body chapter contains a section titled 'The
vocabulary of this chapter', so the raw material for a glossary
already exists in 13 places and needs collecting rather than writing.

**Action.** Collect the 13 vocabulary sections into a single glossary
appendix, cross-linked from each chapter. Add `\printindex` and index
entries for the PDF, or accept that the PDF is navigable by TOC alone
and say so.

### Finding 9. No informative image carries alt text

**RESOLVED 2026-09-07 (Phase 0).** All 4 figures now carry `fig-alt`,
confirmed present in the rendered HTML. The alt text describes the
visual structure rather than repeating the caption, since a reader
using a screen reader already receives the caption.

**Measured, before the fix.** Zero of 21 source files contain `fig-alt`. Four figures
are informative by construction, since each has a substantial
`fig-cap` describing what it shows.

**Why it matters.** WCAG 2.1 requires alt text for informative images.
The corollary is also the classification test used in Finding 3b: an
image that needs a description is carrying information, and one that
does not is an object screen reader users are told to skip.

**Action.** Add `fig-alt` to all 4 figures now, and to every figure
added under Finding 3. Four is a trivial task today; it will not stay
trivial if it is deferred until the figure count reaches 36.

### Finding 10. Distribution is unaddressed

**Measured.** The book is deployed to Netlify at
`reproducibility.rgtlab.org`. No catalog listing, no print edition,
and no ISBN. **[corrected 2026-09-07]** The original text said no PDF
had been built in this working tree, which was true at the time. One
has since been built: `quarto render --to pdf` completes with no
errors under LuaTeX and produces a 304-page PDF at 6.5 by 9 inches
with a table of contents beginning on page 9. The OTL portable-file
requirement is therefore satisfiable, though CI still renders
`--to html` only, so nothing yet guards the PDF against breaking.

**Why it matters.** Discoverability is a barrier for roughly half of
faculty, and perceived quality is mediated by colleague recommendation
and peer review rather than intrinsic merit, so soliciting a catalog
review is a credibility act and a distribution act at once. Format
pluralism also matters: over a quarter of students in one e-textbook
pilot believed they would have learned more from paper.

**Complication, now cleared.** Catalog listing was blocked by Finding
4 until the license was resolved. It was resolved in Phase 0, and the
PDF requirement is met, so OTL submission is no longer gated on
anything in this plan. It is gated only on the author judging the book
complete enough to submit, since OTL requires a complete textbook.

**Action.** Submit to the Open Textbook Library when the book is
judged complete. Add `--to pdf` to the CI render so the portable file
cannot silently break. Consider print-on-demand, which is compatible
with a free web edition.

### Finding 11. The book promises a running example it does not deliver

**Added 2026-09-08. This finding was missed by the original review**,
and the omission is instructive: it cannot be found by a mechanical
scan, because it requires reading the introduction's claims against
what the chapters actually contain. It would rank second, immediately
after the solutions finding, had it been caught on 2026-09-07.

**Measured.** `00-intro.qmd` states that 'each chapter develops a
concept and then builds it, in R and at the shell, inside a running
example compendium', and that 'the reader who follows along will
finish with a reproducible project of their own'. Against that
promise:

- The running example, an incident-diabetes cohort, is named in 2 of
  13 chapters, `03-research-compendium.qmd` and `version-control.qmd`.
- `analysis/data/raw_data/` and `analysis/data/derived_data/` are both
  empty, so there is nothing to follow along with.
- Every worked example is either declared synthetic ('the data are
  synthetic and no packages are installed') or declared unexecuted
  ('the shell sessions below are illustrative and are not executed').
- The testing chapter's examples call `load_cohort`, `clean_cohort`,
  `fit_model`, `bootstrap_ci`, and `run_primary_analysis`. None of
  these functions exists anywhere in the repository, and `R/` is
  empty.

A reader cannot follow along, and cannot finish with a reproducible
project of their own.

**Why it matters.** Two of the evidence base's findings converge here.
Çetinkaya-Rundel, Diez and Barr (2013, *TISE*) put example first and
method second as a design principle, and Comprehensiveness sits at
73.0% positive in the Belikov and McLure corpus, with 'thin when it
comes to examples' a verbatim reviewer complaint. But the sharper
point is not pedagogical. An unmet promise in the front matter is a
credibility defect in a book whose subject is the gap between what an
analysis claims and what it delivers, and it sits three pages from an
epigraph about advertising the scholarship rather than delivering it.

**Complication specific to this book.** The promise cannot be kept by
a real dataset alone. The confidentiality thread requires an extract
carrying protected information, which no public dataset has, and the
data-validation chapter requires defects, which clean data lacks. See
Phase 5 for why this points at one real dataset and one committed
generator rather than a choice between them.

**Action.** Phase 5.

## 5. Phased plan

All effort figures are estimates in working days. **No part of this
plan has been executed.**

### Phase 0. The one-line fixes -- COMPLETE 2026-09-07 (actual: ~1 day)

Each of these was a small, mechanical edit. They were listed first
because they cost almost nothing and are the items most likely to be
lost behind a large phase.

1. **Done.** `LICENSE` rewritten as an explicit dual declaration:
   CC BY-NC-SA 4.0 for prose, CC0 for code. `DESCRIPTION` set to
   `CC0` (it governs the R package, which is code), `CITATION.cff`
   to `CC-BY-NC-SA-4.0`, and the NC-ND references in `copyright.qmd`
   and `index.qmd` replaced, each with a plain-language sentence on
   what the license permits. `LICENSE` added to `.Rbuildignore`.
2. **Done.** `fig-alt` added to all 4 figures, describing visual
   structure rather than repeating the caption. Confirmed present in
   the rendered HTML.
3. **Done.** All 25 check answers are behind their own collapsed
   callout. `conventions.qmd`, the book's key to its own callout
   types, updated to match.
4. **Done.** `test-basic.R` deleted; `test-manuscript-invariants.R`
   added with 69 assertions over the structures this plan cares
   about.
5. **Done.** `.devcontainer` repointed at `rocker/verse:4.4.0`, a
   public image that exists, with an inline note to switch to the
   project image when the Dockerfile lands in Phase 3.

**Acceptance, all verified by running them.** `grep -c fig-alt`
returns 4 against 4 figures; `grep -c '^## Answer'` returns 25 against
25 checks; five license files agree; `grep expect_true(TRUE)` returns
nothing; `run_test_dir('inst/tinytest')` reports 69 passing
assertions; `quarto render --to html` and `--to pdf` both complete
without error.

**One correction to note.** The original item 1 said 'reconcile to one
license'. That was wrong: the five files do not govern the same thing,
and forcing one license on all of them would have licensed the code
under NC-SA, which would stop a reader copying a snippet into
commercially funded work. Prose and code are declared separately.

### Phase 1. Solutions -- COMPLETE 2026-09-08 (est. 12 to 18 days)

**Done.** All 72 exercises across 12 chapters have published
solutions, each in its own collapsed callout under a `## Solutions`
section immediately after `## Exercises`. Verified: 12 chapters x 6
solutions present in the rendered HTML; `## Exercise n` callout titles
do not leak into the table of contents; the invariant suite asserts
one solution per exercise and each behind a collapsed callout.

**The open-ended share was larger than estimated.** Roughly 30 of the
72 exercises operate on the reader's own analysis, machine, or field
and have no answer key. Those boxes state what a good answer
establishes and name the failure modes worth looking for, and the
section preamble of each chapter says how many of its exercises work
that way. This is the feasibility caveat the plan flagged, now
quantified: the phase delivered 42 answers and 30 rubrics, not 72
answers.

**Cost.** The book grew from 75,648 to 93,686 words, a 24 percent
increase, and the PDF from 304 to 372 pages.

**Original task list follows.**

6. Write worked solutions for all 72 exercises, as a collapsed
   `## Solutions` callout immediately after each `## Exercises`
   heading.
7. For the exercises that have no single correct answer, write a
   discussion of what a good answer establishes, and mark them as
   such rather than faking a key.

**Acceptance.** Every chapter with an `## Exercises` heading has a
`## Solutions` heading within the same file, and the count of numbered
items under it equals the count under Exercises.

**Note on this estimate.** It is the largest single item in the plan
and it is the one most likely to be understated, because the count of
exercises requiring discussion rather than answers is not yet known.

### Phase 2. Execute the code, then harvest the figures -- COMPLETE 2026-09-08, one criterion not met (est. 8 to 12 days)

**The triage changed the phase's shape.** Of 74 display fences, 43 are
bash, YAML, Docker, Nix, Make, or JSON and executing them is
meaningless. Of the 31 R fences, 18 are body text and most must also
stay display: `renv::init()`, `rix()`, `tar_make()`,
`knitr::opts_chunk$set()`, and `options(repos=)` would mutate the
book's own render if executed. **Almost nothing was convertible**, so
the premise that inert code was the upstream cause of the figure
deficit was wrong. The figures were written directly instead.

**Done.** Six new computed figures, taking the book from 4 to 10, and
from 14 to 20 computed artifacts. Note before reading further that
**five of the six are drawn schematics rather than displays of
computed findings**; only the introduction's gained a figure plotting
real data. Section 8 sets out why this is structural for a book about
infrastructure and what it constrains. `00-intro` had zero artifacts and
now has a two-panel chart of the four re-execution and replication
studies it already cited. `01` gained the reproducibility /
replicability / robustness grid. `04` gained the dependency triad as
nested sets. `version-control` gained a commit graph. `05` gained the
tag-versus-digest drift timeline. `08` gained a defect-by-test-kind
matrix whose empty bottom row is the reproducibility paradox. Every
one carries `fig-alt`.

**Acceptance criterion deliberately not met.** The criterion was 'no
body chapter renders zero figures'. Three chapters still do:
`06-backends-runtimes`, `09-continuous-integration`, and
`10-archiving-sharing`. Each already carries a computed table that
covers the same ground a figure would (`tbl-backends` gives tool by
axis by what-it-pins; `tbl-integrity` demonstrates the hashing;
`tbl-union` shows the union growth), so the only available figures
were duplicates of existing artifacts. Per this plan's own rule
against manufactured figures, they were not added. **The criterion was
wrong and should be restated** as: no body chapter renders zero
computed *artifacts*, which is now satisfied by all 13.

**Original task list follows.**

8. Triage the 54 display-only blocks into convertible R,
   must-stay-display, and should-become-an-artifact. Report the
   three counts.
9. Convert the convertible R blocks to `{r}` chunks.
10. Add computed figures for the sections that now execute, targeting
    the code-bearing section count re-measured after step 9.
11. Add code and figures to `01-reproducibility-crisis.qmd`
    specifically, using the Baker survey and Open Science
    Collaboration figures the chapter already cites, and to
    `00-intro.qmd`.
12. Add `fig-alt` to every figure added.

**Acceptance.** No body chapter renders zero figures; the count of
PNGs under `_book/*/figure-html/` rises from 4; every `fig-` label in
a `{r}` chunk has a sibling `fig-alt`.

### Phase 3. The book's own compendium -- ATTEMPTED AND WITHDRAWN 2026-09-08

**Status: not done, by decision, and Finding 5 remains open.** A
`Dockerfile`, a `.dockerignore`, an `renv.lock`, and three CI changes
were written on 2026-09-08 and then removed. The reasons are recorded
here because they are constraints on any future attempt, not
second thoughts.

**Reason 1: adding a `Dockerfile` silently changes what CI does.** The
shared `render-book.yml` selects its backend by artifact presence,
`if [ -f Dockerfile ]`, so committing one switches the gate from a
host render to building a multi-gigabyte image on every push and pull
request. The gate is only required to confirm that the HTML renders,
so that is a large cost for no gain, and it is incurred by the mere
existence of the file rather than by any workflow edit.

**Reason 2: the CI workflow is shared across the `~/prj/tch` books and
must stay identical.** Ten of the thirteen textbook repositories carry
a byte-identical copy of the zzcollab template. Any fix belongs in
`zzcollab/templates/workflows/render-book.yml` and propagates to all
of them, so a change made for this book alone is the wrong shape. The
three edits attempted here, rendering every declared format, installing
TeX on the host runner, and a weekly run with the freeze cache
cleared, were reverted for that reason.

**Reason 3: `renv` will not produce a lockfile with hashes for a
library it does not manage.** This was tested twice, not inferred. A
snapshot on the host produced 46 records with no `Hash` field and raw
`DESCRIPTION` bloat; the first diagnosis, that this was an artifact of
Homebrew-built macOS packages, proved wrong when the same snapshot run
inside `rocker/verse:4.6.1` on linux, against packages installed from
Posit Package Manager, produced hashless records too. A lockfile
without hashes contradicts what the dependencies chapter teaches about
what a lockfile records, and fabricating the hashes would be worse: a
hash that does not match what a restore installs fails the restore.
Producing a correct lockfile requires `renv` to perform the
installation itself, which is a larger job than this phase scoped.

**What a future attempt would need.** A lockfile built by
`renv::init()` and `renv::restore()` inside the project rather than
snapshotted from an ambient library; a decision about where the
`Dockerfile` should live so that CI does not pick it up, or an
agreed change to the shared template; and the template change made in
zzcollab and propagated, not hand-applied here.

**What remains true.** Finding 5 stands unaddressed: no lockfile, no
container, empty data directories, and a CI gate that renders from a
committed freeze cache and therefore never re-executes the book's R
code. The `colophon.qmd` already discloses this honestly, and that
disclosure is now the only thing covering it.

**Original task list, retained for a future attempt.**

13. Add `renv.lock` and a `Dockerfile`.
14. Add a CI job that renders with the freeze cache cleared.
15. Update `colophon.qmd` to state the level actually reached.
16. Build the PDF and fix whatever breaks. **(Done separately: the PDF
    builds, 372 pages, verified 2026-09-08.)**

**Acceptance.** `renv.lock` and `Dockerfile` exist at the repository
root; a CI run with `_freeze/` removed renders clean; a PDF builds.
Only the last of the three is currently satisfied.

### Phase 4. Findability and distribution -- PARTLY COMPLETE 2026-09-08 (est. 4 to 6 days)

**Task 17, the glossary: done.** `glossary.qmd` collects 93 unique
terms from the twelve 'vocabulary of this chapter' sections into one
alphabetical appendix, registered first in the `appendices:` block.
Every entry cross-references the chapter that develops it, and all
references resolve in the render, verified by grepping the output for
unresolved markers. The per-chapter vocabulary sections remain in
place; the appendix is a second view of them, not a replacement.

This was extraction rather than authoring, which is unusual: the
general warning is that a glossary cannot be lifted from bolded
first-use terms. It worked here only because the book already
maintains twelve curated definition lists. A book without them would
face a writing job.

**Two defects the extraction exposed, both now fixed.** Neither was
visible to the original scan.

1. `09-continuous-integration.qmd` carried the heading 'The vocabulary
   of this chapter' **twice**, once bare and once inside the callout.
   The bare one rendered as a real section and put a spurious entry in
   the table of contents.
2. Vocabulary entries came in two formats. Ten chapters used
   `- **Term.** Definition`; two, the crisis and compendium chapters,
   used `- **Term**: definition` with a lowercase opening. Sixteen
   entries were normalized to the majority form.

**Seven terms were defined in two chapters each**, in different words:
dated snapshot, determinant stack, forge, lockfile, render gate,
research compendium, and `R CMD check`. The definitions agree in
substance, so this is a consistency observation rather than a
contradiction. The glossary keeps the definition from the chapter that
owns the concept and cites both chapters in reading order. The
duplicate definitions remain in the chapters, which is defensible for
a book meant to be read in pieces, but the author may prefer to
converge their wording.

**Task 18, the index: decided against, and documented here rather than
implemented.** The book has no `\index{}` markup anywhere and no index
infrastructure. Building one is not a configuration change; it needs
index entries at every occurrence across 93,000 words, which is a
larger job than the glossary was and cannot be generated. Three things
argue for not doing it now: the HTML edition has full-text search, the
PDF has a five-page table of contents from page 9, and the new
glossary gives term-level entry into all twelve chapters. An empty or
thin index would be worse than none. Revisit if a print edition is
actually commissioned, when an index earns its cost.

**Task 19, exercise rebalancing: measured, not actioned.** Words per
exercise now runs from 755 in the crisis chapter to 1,231 in the
pipelines chapter, a 1.6-fold spread. Equalizing at roughly 950 would
mean adding about seven exercises, each needing a worked solution.
That is deliberately left undone: writing exercises to hit a ratio is
the same quota-driven padding this plan rejects for figures, and
Finding 7 is the weakest finding in the document.

**A retraction [2026-09-08].** Earlier revisions of this plan named
`00-intro.qmd` as the larger outlier, on the grounds that it carries
4,270 words with no exercises, no retrieval checks, and no vocabulary
section, and left the question open as an authorial decision. That
framing was wrong and is withdrawn. The introduction uses **none** of
the chapter template: it has no Learning objectives, no Orientation,
no analyst's contribution, no vocabulary section, no checks, no honest
level, no worked example, no exercises, and no further reading. It is
a narrative survey with its own headings, internally consistent, and
it is front matter in substance even though `_quarto.yml` lists it
among the chapters.

Two things confirm the exemption rather than merely excusing it.
First, every term the introduction sets in bold is either a structural
label (`Part I, Foundations`) or a term that the crisis chapter's
vocabulary section already owns, so a vocabulary section here would
duplicate that one and worsen the seven duplicate definitions recorded
above. Second, an introduction surveys rather than teaches a
technique, so exercises would be exercises about a preview.

No action. The apparent gap is a correct editorial choice, and the
plan should not have implied otherwise for as long as it did.

**Tasks 20 and 21 remain, and both need the author.** Submitting to
the Open Textbook Library requires judging the book complete, which is
not a reviewer's call. Sourcing three to five attributed contextual
photographs requires selecting images and verifying their licenses,
which should not be done by an agent that cannot confirm provenance.

**Original task list follows.**

17. Collect the 13 'vocabulary of this chapter' sections into a
    glossary appendix.
18. Decide on an index for the PDF, and implement or document the
    decision.
19. Rebalance exercise counts against chapter length.
20. Submit to the Open Textbook Library.
21. Add three to five attributed contextual photographs, per Finding
    3b, and credit them in `credits.qmd`.

**Acceptance.** A glossary appendix appears in `_quarto.yml`; the
exercise count per chapter correlates with word count; every added
image has a credits row and either a `fig-alt` or an explicit null
alt.

### Phase 5. Deliver the running example -- COMPLETE 2026-09-08, one criterion not met (est. 10 to 15 days)

**This phase closes a defect the original review missed**, and it is
recorded that way rather than as an enhancement. See Finding 11.

**Done.** The book now has data, functions, and tests behind the
promise its introduction makes.

- `analysis/scripts/simulate_cohort.R` writes a 401-row synthetic
  incident-diabetes extract from a fixed seed into
  `analysis/data/raw_data/`, which was previously empty. It carries
  fabricated record numbers, names, and dates of birth for the
  confidentiality thread, and five deliberate defects for the
  validation thread: 32 missing outcomes, two date formats in one
  column, a duplicated record, an age of 400, and a sex coded three
  ways. Re-running it reproduces the file byte for byte, verified by
  checksum.
- `R/cohort.R` supplies `load_cohort`, `clean_cohort`, `fit_model`,
  `summarise_fit`, `bootstrap_ci`, and `run_primary_analysis`, all
  roxygen-documented, with `tibble`, `stats`, and `utils` declared in
  `DESCRIPTION`. That is the code-to-`DESCRIPTION` inclusion the
  dependencies chapter teaches, now satisfied by the book itself.
- `inst/tinytest/test-cohort.R` adds tests in all four kinds the
  testing chapter distinguishes. The suite is 180 assertions. Its
  data-validation block asserts both that the cleaned data is clean
  and that the raw extract is still dirty, so a later change to the
  generator cannot quietly render those tests vacuous.
- `conventions.qmd` sets out the two datasets and their different
  jobs, and argues the synthetic choice rather than apologizing for
  it.
- Three chapters compute from `survival::diabetic`: the testing
  chapter tabulates the trial arms as a hand-checkable oracle, the
  literate-programming chapter reports real counts through inline
  expressions, and the pipelines chapter measures the cost of each
  step of a real analysis.

**Task 23 was dropped, not deferred.** The plan called for renaming
the running example to a retinopathy trial across eleven mentions.
That was wrong. Chapters 3 and `version-control` describe a *registry
extract carrying protected information*, which is exactly the
synthetic cohort's job, so their prose stands unchanged and the
incident-diabetes name is correct for what it names. The real data
enters under its own name where computation happens.

**Acceptance: four of five met.** `analysis/data/raw_data/` is not
empty; the generator reproduces exactly; no function named in an
example is undefined; three chapters compute from the real data.

**The fifth criterion is not met, and it was the wrong criterion.** It
required the count of figures displaying computed findings to exceed
4; it remains 1. What the real data yielded was two computed tables
and inline values, not figures. A Kaplan-Meier curve would satisfy the
letter of it, and no chapter in this book is about survival analysis,
so it would be a decorative plot in an infrastructure text: precisely
the manufactured figure this plan warns against in Finding 3 and in
**What not to do**. The criterion was written before the data was
chosen, and it assumed a book with analyses to display. The honest
restatement is *artifacts*, not *figures*, which stands at 23 across
the book. Left unmet and recorded rather than satisfied cosmetically.

**A defect the phase found in itself.** The first run of the
data-validation tests failed: the generator was producing patients as
young as 15 while the validation asserted an adult enrollment
criterion. The generator was wrong and was corrected. This is the
argument for data-validation tests made on the book's own data.

**A temptation the phase refused.** The fitted HbA1c coefficient
initially sat 2.2 standard errors above the generator's known truth.
It was not reseeded. Choosing a seed until an estimate looks right is
indefensible in a book about research integrity, and a perfectly
reproducible analysis sitting two standard errors from a known truth
is a live instance of the reproducibility paradox. The subsequent age
correction changed the draw as a side effect and it now sits at 1.1
standard errors, which is a consequence rather than a target.

**Original task list follows.**

22. Add `survival::diabetic` as the book's computational running
    example. It is 394 individual-level rows from a randomized trial
    of laser treatment for diabetic retinopathy, with patient
    identifiers, two eyes per patient, and time-to-event outcomes.
    `survival` is a **recommended** package, so it ships with every R
    installation and adds no lockfile entry, which matters because
    Phase 3 established that this book cannot currently produce a
    valid lockfile.
23. Rename the running example from an incident-diabetes cohort to the
    retinopathy trial. Eleven mentions across `00-intro.qmd`,
    `03-research-compendium.qmd`, and `version-control.qmd`.
24. Write `analysis/scripts/simulate_cohort.R`, a committed generator
    with a fixed seed producing a synthetic cohort that carries fake
    identifiers, names, and dates of birth, together with deliberate
    defects: missing outcomes, two date formats, a duplicated
    identifier, an implausible age. Write its output to
    `analysis/data/raw_data/`, which is currently empty.
25. Give the two datasets different jobs, and say in the text which is
    which and why. The real data carries the computation; the
    synthetic cohort carries the confidentiality thread and the
    data-validation tests.
26. Replace the phantom functions in the testing chapter,
    `load_cohort`, `clean_cohort`, `fit_model`, `bootstrap_ci`, and
    `run_primary_analysis`, with real functions in `R/`, and make that
    chapter's test examples executable against them.
27. Demonstrate the ladder concretely by carrying one analysis from L0
    to L3 rather than describing each rung abstractly.

**Why the running example must be two datasets, not one.** The
confidentiality lessons require an extract the reader is allowed to
mishandle: write the `.gitignore` before the first commit, observe
that deleting a file does not remove it from the history. A public
dataset has no protected information by construction, so no real
dataset can carry that thread. Equally, real data is too clean for the
data-validation chapter, whose tests need something to catch; the
defects would have to be introduced deliberately in any case. The two
requirements point at a generator, and the generator should be
presented as a demonstration of the book's own thesis rather than
apologized for: a committed script with a fixed seed is *more*
reproducible than a downloaded extract, having no external dependency,
no link rot, and no access control.

**Do not use `palmerpenguins`.** It is a package, so it needs a
lockfile entry the book cannot currently produce, and the
literate-programming chapter already uses synthetic three-species
bill-length data, so the real thing would sit awkwardly beside it.
**Do not use `MASS::Pima.tr`** despite its being a recommended
package: the dataset was collected from the Akimel O'odham community
and is widely circulated without that context, which is a poor choice
for a book whose weakest measured criterion is cultural relevance.

**The tension to decide before starting.** Modularity is the weakest
criterion in the reviewer corpus at 62.5% positive, and an example
threaded through thirteen chapters is exactly what makes a book hard
to assign in pieces. The mitigation is that each chapter loads the
data afresh and states what it is, rather than depending on state
established three chapters earlier. That keeps the example running
without making the chapters ordered, and it should be a rule of the
phase rather than an afterthought.

**Acceptance.** `analysis/data/raw_data/` is not empty; the generator
runs from a fixed seed and reproduces its output exactly; no function
named in a testing-chapter example is undefined; at least three
chapters compute a figure or table from `survival::diabetic`; the
count of figures displaying computed findings, currently 1 of 10,
exceeds 4; and no chapter's use of the example requires having read a
previous chapter.

## 6. What not to do

- **Do not add an ambient image per section.** 159 images, one every
  475 words. See the arithmetic in Finding 3b.
- **Do not add part-opener images or part-opener prose pages.** The
  book's introduction already maps its own structure.
- **Do not commission generated metaphor figures.** No provenance to
  attribute, in a book that argues for provenance.
- **Do not set a uniform per-section figure quota.** It manufactures
  plots nobody needs.
- **Do not restructure the book to hit a page target.** The ~168-page
  estimate is above Downey's ~140-page guideline, but that guideline
  is one author's opinion, not an empirical result, and per-chapter
  length matters more than the total.
- **Do not rewrite the check callouts from scratch.** Their placement
  is already correct; only the concealment needs adding.
- **Do not fix the PDF table of contents.** It is not broken. The
  `toc: false` in `_quarto.yml` is compensated by an explicit
  `\tableofcontents` in `copyright.qmd`, and a second one would
  produce two.

## 7. Sequencing

**[updated 2026-09-08]** Phases 0, 1, and 2 are done. Phase 3 was
attempted and withdrawn, so it and Phase 4 (findability and
distribution) remain, and they are independent of each other.
**Phase 5 was added and applied on 2026-09-08.** It partially
subsumed Phase 3 as predicted: `analysis/data/raw_data/` is now
populated by a committed generator, which closes the empty-data part
of Finding 5 without a container or a lockfile. What remains of
Finding 5 is the lockfile and the container themselves, and the CI
gate that renders from a committed freeze cache. A manual
freeze-cleared build was run on 2026-09-08 and passed in both formats,
so the code is known to execute today; nothing keeps it that way.
Phase 4
is unblocked: the license permits catalog listing and the PDF exists,
so OTL submission waits only on the author judging the book complete.
The original reasoning below, that Phase 2 should precede Phase 3
because executing the code is what makes a container worth building,
turned out not to apply: almost no code was convertible, so the
container is worth building for the render alone.

**[updated 2026-09-07]** One sequencing item moved. Adding `--to pdf`
to the CI render was implicitly Phase 3 housekeeping; it should be
done early, because the PDF is now an OTL prerequisite and CI does not
currently build it, so it can break without anyone noticing.

What remains is tasks 20 and 21 of Phase 4, both of which need the
author rather than a reviewer, and the parts of Phase 3 that Phase 5
did not subsume: the lockfile, the container, and a CI gate that
actually re-executes the code. If only one phase is ever done, do Phase 1. If a
second is ever done, do Phase 5. Both are done.

## 8. Limitations of this analysis

- **This is a scan, not a reading.** It counts structures. It cannot
  tell whether the prose is correct, clear, well organized, or
  appropriately pitched, and those are four of the ten Open Textbook
  Library criteria.
- **A mechanical scan cannot detect a promise-versus-delivery
  mismatch, and this one missed a major finding [added 2026-09-08].**
  Finding 11, that the introduction promises a running example
  compendium the book does not contain, was not found on 2026-09-07
  and surfaced only when the author asked an unrelated design
  question. No grep finds it: every sentence in the introduction
  parses, every chapter named in `_quarto.yml` exists, and the gap is
  visible only by reading the front matter against the body. Any rerun
  of this procedure should treat the introduction's promises as a
  checklist and verify each one against the chapters, and should treat
  'what does this book tell the reader it will do for them' as a
  question the scan cannot answer. It is the same class of blind spot
  as cultural relevance, and it produced a finding that would have
  ranked second.
- **Cultural relevance was not assessed and cannot be assessed
  mechanically.** It is the weakest criterion across the Belikov and
  McLure corpus at 66.6% positive. The one adjacent thing measured is
  that the book's personas are unnamed generic roles: 71 references to
  'a colleague', 'a reviewer', 'a collaborator', 'a biostatistician',
  'a student', with no named individuals. That is consistent with a
  deliberate authorial choice and it is also consistent with the gap
  the guidance names when it asks for diversified names and contexts.
  This review cannot distinguish the two. Route it to a human reading
  pass.
- **The page count was an estimate and it was wrong.
  [corrected 2026-09-07]** The original figure of ~168 pages came from
  dividing words by 450. The book has since been rendered and is 304
  pages. A divisor near 250 fits a 6.5 by 9 inch page carrying code
  blocks and callouts. Any other quantity in this plan derived from a
  words-per-page heuristic should be treated with the same suspicion;
  none currently is.
- **The book builds clean from scratch, verified 2026-09-08.** This
  closes a gap the plan carried from Phase 2 onward. Every render up to
  that point replayed the committed `_freeze/` cache, so nothing had
  established that the book's R code still executed. `_freeze/` was
  deleted and both formats rebuilt from nothing: all 23 executable
  chunks re-ran without error, the ten figures regenerated, and the
  inline computed values in the literate-programming and pipelines
  chapters recomputed to the same numbers. The book's code is
  therefore verified to execute, which is a stronger claim than any
  made before it. **The CI gate still does not do this**, so the
  guarantee holds as of that date and is not maintained; that part of
  Finding 5 stands.
- **The book has now been rendered, in both formats
  [updated 2026-09-07].** The original analysis read figure counts from
  a pre-existing `_book/` directory of unknown vintage and marked every
  rendered-output claim as untested. Both formats have since been built
  from the current sources: `quarto render --to html` and
  `--to pdf` complete without error, the figure count of 4 is confirmed
  against freshly rendered PNGs, the alt text is confirmed present in
  the HTML, and the PDF table of contents is confirmed to begin on page
  9. What remains untested is whether the PDF builds in CI, which
  renders `--to html` only, and whether the R chunks still execute from
  scratch, since `_freeze/` is committed and was not cleared for these
  builds.
- **The code-bearing section count of 36 is an upper bound.** It
  counts sections containing a fence of any kind, including bash,
  YAML, JSON, Dockerfile, Makefile, and Nix blocks that will never
  render an artifact. It will also move once Phase 2's conversions
  land, so it must be re-measured rather than treated as fixed.
- **The print-cost claim in Finding 3b is directional only.** Color
  interior printing costs a multiple of monochrome; the multiple was
  not verified against a vendor quote.
- **The argument against part-opener images is reasoning, not a
  literature finding.** It follows from the reading-compliance
  evidence and the relative weakness of Modularity against
  Organization, but no study tested part openers.
- **The coherence and seductive-details evidence is unverified.** It
  is background knowledge in this review and was not checked against
  Mayer or the primary articles. It is used as grounds for restraint,
  not prohibition.
- **Phase 1 feasibility, now measured [updated 2026-09-08].** The
  plan said it did not know how many exercises lacked a self-checkable
  answer. Roughly 30 of 72 do. Those received a statement of what a
  good answer establishes rather than an answer key, and each
  chapter's Solutions preamble says how many of its exercises work
  that way. The count is approximate because the boundary is a
  judgment: 'argue why X' has no key but does have a determinate
  core, and was answered.
- **Effort estimates [updated 2026-09-08].** Phases 0, 1, and 2 have
  been executed; their estimates can now be checked against reality
  and Phase 2's was wrong in kind rather than degree, since the
  display-block conversion it was built around turned out to be
  almost entirely inapplicable. The Phase 3 and Phase 4 estimates
  remain estimates and neither has been executed.
- **What the figures are not [corrected 2026-09-08].** An earlier
  version of this bullet said that two of the six new figures were
  schematics rather than computed results. That was an undercount, and
  the correction matters because it changes how Finding 3 should be
  read. **Five of the six are schematics.** Only `fig-failure-rates`
  in the introduction plots real data: its four values are the
  published success rates of the studies the chapter cites. The other
  five, the reproducibility grid, the dependency triad, the commit
  graph, the tag-versus-digest timeline, and the defect-by-test-kind
  matrix, are hand-specified tibbles encoding a structure the chapter
  argues for, drawn with `ggplot2`.

  By the working definition used in Finding 3 these still count as
  technical figures, since that definition admits 'a diagram of a
  structure the chapter builds', and they are computed in the sense
  that the build produces them and they cannot drift from their
  source. They are **not** the chapter showing the reader what its own
  code produced, which is the stronger thing the reviewer complaint
  asks for. A reader deciding whether the figure count answers 'the
  textbook contains only words' should weigh the two categories
  separately: the count rose from 4 to 10, and the count of figures
  displaying computed findings rose from 4 to 5.

  The reason the ratio came out this way is structural rather than
  lazy, and it constrains what any future phase can achieve. This is a
  book about infrastructure: its chapters argue about lockfiles,
  images, and gates, and contain very little data to plot. The one
  chapter carrying published numbers received the one data figure.
  Raising the count of findings-displaying figures would require
  introducing analyses the book does not currently perform, which is
  a different and larger proposal than adding figures.

  The six were verified to render, to carry alt text, and to match
  their captions and alt text, checked by viewing each rendered PNG.
  Four of the six carried defects visible only that way, an ordering
  error that contradicted its own caption, a missing glyph, a label
  collision, and buried arrowheads, none of which produced an error or
  a warning. None has been reviewed by anyone but their author for
  whether they teach well.
- **Print concealment is unresolved [added 2026-09-08].** Phase 0's
  concealment fix and Phase 1's solution callouts both rely on
  collapsed callouts, which render expanded in PDF. The print reader
  therefore sees every answer immediately below its question. This is
  a format limitation rather than a defect, and print convention
  (adjacent-but-offset, as OpenIntro does) accommodates it, but a
  reader who wants print concealment needs answers moved to an
  appendix, which was not done and would be a substantial
  restructuring.
- **Evidence status by finding** (heading renamed 2026-10-10). Findings 1, 3, 4, 5, 6, 8, and 9
  rest on counts that were verified by running commands and reading
  their output, with the figure count cross-checked against the
  rendered output directory rather than against labels. Finding 2's
  count of 54 is verified; its claim about which blocks are
  convertible is inferred from inspecting two chapters. Finding 7 is
  verified. Finding 10 is inspected, not tested.

## 10. Second review: reading, experts, and coverage (2026-10-10)
*2026-10-10 18:14 PDT*

Sections 1 to 8 report a mechanical scan, and Section 8 says plainly
that the scan could not judge whether the prose is correct, clear,
or well organized. This section reports the review that does: a full
reading of every chapter, three simulated expert reviews, a
learning-science survey, a model-book comparison, a review of the
LLM sections, and a worldwide coverage sweep. Findings continue the
numbering of Section 4 (from Finding 12); phases continue the
numbering of Section 5 (from Phase 6). Nothing in Sections 1 to 8 or
the appendix (renumbered Section 11 on 2026-10-10, formerly 9) is
withdrawn, but Decision D6 reopens one Phase 1 choice explicitly.

### 10.1 Parameters

Decided by the author on 2026-10-10.

| Parameter | Choice |
|---|---|
| Scope | Audit and plan; no chapter edits in this pass |
| Primary audience | MS and PhD students in the health sciences (biostatistics, epidemiology, public health) who know R and basic git |
| Course format | One 10-week quarter |
| R library for renders | Local library, `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE` (no `renv.lock` exists) |
| Expert personas | Academic biostatistician directing an MS program; pharmaceutical statistical programmer; research software engineer |
| Model book | *R Packages* (2e), Wickham and Bryan |
| Running example | The existing simulated cohort (`analysis/scripts/simulate_cohort.R`) |
| Existing plan | Extend (this section) |

### 10.2 Executive summary

The book's organizing ideas are sound and every reviewer said so
unprompted: the L0 to L3 ladder, the distinction between capturing
reproducibility and validating it, the 'honest level', the oracle
principle for tests, and the sealed render. The problems are not in
the ideas. They are in whether the machinery the book teaches
actually does what the book says it does, and on that question the
review found the book's central claims undelivered.

1. **The top rung is not delivered by the tool.** `zzc verify --full`
   stamps a compendium 'L3, verified' when the image rebuilds and the
   test target exits 0. The test target exits 0 even when a test
   fails, and no output is ever compared with a baseline. A
   compendium with failing tests is stamped L3 (Finding 12).
2. **None of the three CI gates the book teaches can fail on what it
   claims to check.** R CMD check does not see `analysis/`; its
   `error_on = "error"` passes undeclared dependencies; the
   dependency gate defaults to `error_on_fail = FALSE`; and no render
   gate exists in either workflow (Finding 13).
3. **The showcase Dockerfile neither builds nor pins what it claims
   to pin** (Finding 14), and the lockfile chapter teaches a lockfile
   format renv no longer writes (Finding 15).
4. **Restricted patient data is the largest gap for this audience.**
   The archiving chapter sends 'the code, the data' to a public
   repository with no word on de-identification or controlled access;
   the LLM prompts invite pasting a cohort data frame; CI is taught
   with no guidance for data that cannot be committed (Finding 16).
5. **The running example is both broken and unused.** Its generator
   corrupts the ground truth it plants errors in, and almost no
   chapter uses it (Finding 17).
6. **The book is roughly 30 percent too long for one quarter** and
   repeats its core definitions up to five times (Finding 21).

This repository itself does not reach the level the book teaches:
its CI renders HTML from a committed freeze cache and runs no tests,
and its own test files exit with zero assertions when the package is
built (Finding 25). In a book on computational verification, that is
the first thing a critical reader will check.

**Document map.** 10.3 method and evidence; 10.4 findings 12 to 28;
10.5 the tiered correctness register; 10.6 house rules; 10.7 the
revised chapter template; 10.8 habit list and motto; 10.9 the
running example and its canonical analysis plan; 10.10 topic
additions from the coverage sweep; 10.11 the one-quarter core path;
10.12 per-chapter actions; 10.13 phases 6 to 14; 10.14 what not to
do; 10.15 decisions; 10.16 limitations; 10.17 defects outside the
book.

### 10.3 Method and evidence

Twelve read-only agents (four readers, three personas, one
learning-science and model-book researcher, one LLM-section
reviewer, three coverage researchers) worked from shared briefs and wrote
reports to the session scratchpad; the lead reviewer re-checked the
most consequential claims before accepting them. Every claim below
carries one of these labels:

- **[V]** verified: the lead reviewer ran it and observed the result.
- **[I]** inspected: the lead reviewer read the source and confirmed.
- **[A-V]** an agent ran it; the lead did not re-run.
- **[A-I]** an agent read the source or documentation.
- **[EK]** expert knowledge, not checked against a primary source.
- **[U]** unverified: the source could not be opened.

The renders were run by the lead on 2026-10-10: HTML (22 pages, no
warnings, no `quarto-unresolved-ref` or `citation-missing`) and PDF
(398 pages, no LaTeX warnings, no literal HTML entities; em dashes
appear only inside published reference titles) [V]. Both renders
reused the committed `_freeze` cache, so they show the book builds,
not that its code runs today. The PDF has grown from 304 pages on
2026-09-08 to 398, about 31 percent; the cause was not isolated
[V for the counts; cause U].

### 10.4 Findings

#### Finding 12. The L3 stamp is unfalsifiable

`zzc verify --full` (zzcollab `modules/verify.sh:238-266`) marks a
project L3 when `make docker-build` and `make docker-test` both exit
0 [I]. `docker-test` (`templates/Makefile:341`) runs
`R -e "tinytest::run_test_dir('inst/tinytest')"`, which exits 0
with a failing test [V: deliberately failing test, exit status 0].
Nothing compares any output to a recorded baseline [I]. The book
defines L3 as a verified analysis 'whose recorded outputs have been
shown to regenerate' (`index.qmd`, `00-intro.qmd:474-478`,
`08-testing-quality.qmd:501-505`, `09-continuous-integration.qmd:528-560`)
[A-I]. The book's culminating claim therefore rests on a mechanism
that cannot fail.

Related: the same-session reproducibility test
(`08:453-459`, `03:1037-1040`) runs seeded code twice in one session,
so it cannot detect a change in R's RNG defaults [I by reasoning;
A-V: passes under `sample.kind = 'Rounding'`]; the baseline test the
chapter shows does not exist in `inst/tinytest/` [A-I]. And L3 is
equated with the ACM 'Results Reproduced' badge (`02:416-417`,
`:509-511`), which requires an independent team; what L3 describes
is closer to ACM's 'repeatability' [U: the ACM page could not be
opened; EK].

#### Finding 13. The CI the book teaches cannot fail

- R CMD check is described as checking 'the whole compendium'
  (`03:203-229`, `09:245-255`), but the compendium's `.Rbuildignore`
  excludes `^analysis$` [I], so analysis scripts are never checked
  [A-V twice: a syntax error and a missing package in
  `analysis/scripts/` passed]. The ch09 worked example (`09:842-858`)
  depends on a failure that cannot occur.
- Both workflows use `error_on = "error"` (`09:337`, `09:476`), so
  undeclared dependencies, which R CMD check reports as WARNINGs,
  pass [A-V]. The r-lib/actions default is `"warning"` [A-I].
- The dependency gate calls `zzrenvcheck::check_packages(strict =
  TRUE)` (`09:343-344`) without `error_on_fail = TRUE`; the default
  is `FALSE` (zzrenvcheck `R/compare.R:70`) [I], so it reports and
  exits 0 [A-V]. `strict` means 'also scan tests and vignettes', not
  the check described [A-I]. zzrenvcheck is never installed in the
  workflow and is not on CRAN [A-I].
- Neither workflow contains the render gate the text promises as the
  third gate [A-I]. CI never builds the project Dockerfile, so it
  validates nothing at L2 despite `09:508-511` [A-I].

#### Finding 14. The showcase Dockerfile does not build or pin

The Dockerfile at `05-containers.qmd:450-473`, the book's model of
an L2 image [I]:

- calls `renv::init(bare = TRUE)` with no `WORKDIR` and no `force =
  TRUE`; renv refuses to initialize a project that contains `$HOME`
  [A-V: refusal reproduced locally, no Docker build run];
- pairs `rocker/r-ver:4.4.0`, built on Ubuntu 22.04 (jammy), with a
  `__linux__/noble` (24.04) binary URL [A-I: Rocker Dockerfiles at
  tag R4.4.0]; zzcollab's `get_ubuntu_codename` has the same defect
  [A-I];
- sets the dated snapshot in `Rprofile.site`, which
  `renv::restore()` ignores in favor of the lockfile's recorded
  repositories unless `RENV_CONFIG_REPOS_OVERRIDE` is set [A-I renv
  documentation; EK], so `05:439-443` and `05:476-479` overstate what
  the snapshot governs.

Further: Rocker uses OpenBLAS, not reference BLAS (`05:595-597`)
[A-I]; the decimal-mark table (`05:540-574`, also `02:292-293`)
shows a locale effect R does not have, since R holds `LC_NUMERIC` at
`C` [A-V twice]; zzcollab never sets `OMP_NUM_THREADS` though
`05:761` and `05:783` say it does [A-I]; Apple Silicon and amd64
emulation are never taught although `rocker/tidyverse` and
`rocker/verse` are amd64-only [A-I]; and Nüst et al. (2020) is cited
for digest pins and dated snapshots, which its text does not
recommend (`05:336-340`) [A-I].

#### Finding 15. The lockfile chapter teaches an obsolete format, and its auto-fix misrecords versions

- renv 1.2.3 writes lockfile records with DESCRIPTION metadata and
  no `Hash` or `Requirements` field [V: lead snapshot]; the format
  changed in renv 1.1.0 [A-I]. `04:142-144`, `04:195-242`, and
  Exercises 1 and 2 (`04:923-960`) describe what students will not
  see. The old `Hash` was a hash of DESCRIPTION fields, never of
  package contents, so 'byte-identical' was never true [A-I].
- `make check-renv`'s auto-fix, taught at `04:451-466`, writes the
  **current CRAN version** into `renv.lock`, not the installed one
  (zzrenvcheck `R/autofix.R:162-170`) [I]. The lockfile then passes
  the gate while describing an environment that did not produce the
  result.
- renv's snapshot omits packages listed only in `Suggests`, so the
  'triad invariant' can fail by renv's own action, while the chapter
  recommends `Suggests` for analysis-only packages [A-V].
- The 'recommended packages need no declaring' rule (`04:367-370`,
  `conventions.qmd:92-95`) is contradicted by the chapter's own
  `survival` example and by R CMD check [A-V].

#### Finding 16. Restricted data is the largest content gap

The audience works with patient data. Three independent reviews
reached this finding [A-I x3; I grep].

- `10-archiving-sharing.qmd` contains no occurrence of
  de-identification, PHI, consent, data-use agreement, or controlled
  access [I grep], and `10:556-557` says the deposited compendium
  'carries the code, the data' [I].
- No LLM section says restricted data may go only to an approved
  endpoint; `08:959` prompts 'Write data-validation tests for this
  cohort data frame' [I]. NIH NOT-OD-25-081 forbids sharing
  controlled-access data with public generative-AI tools [A-I].
- CI, Binder, and Codespaces are taught with no guidance for data
  that is gitignored because it is PHI [A-I]; the predictable student
  response to a red render gate is to commit a sample of the data
  [inferred].
- NIH, the Data Management and Sharing Policy, trusted research
  environments, and the Five Safes appear nowhere [I grep].
- 'The history is the audit trail' (`version-control.qmd:225-275`)
  and 'append-only', 'tamper-evident' (`:272`, `:494`) overstate git:
  author and date are client-asserted and rewritable [A-V: a commit
  forged with a false name and a 2019 date].

#### Finding 17. The running example is broken and largely unused

- `simulate_cohort.R:83` assigns `'Female'` to 18 random rows
  regardless of true sex [I]; cleaning then 'repairs' nine true males
  to `F`, and all tests pass on the corrupted data [A-V]. A planted
  pathology must be recoverable, or the data-validation lesson
  teaches the wrong thing.
- The cohort is labeled 'incident' diabetes yet 15.8 percent of it
  meets the HbA1c diagnostic threshold at baseline, and it is
  analyzed with logistic regression despite variable follow-up [A-V].
- Of the 13 chapters, none of 00 to 07 uses it; the ch02 worked
  example invents `cohort.csv` and a Cox model while
  `cohort_raw.csv` already has `incident_dm` and `followup_days`
  [A-I x3]. Four late chapters use four different datasets [A-I].
- The committed CSV has `mrn`, `patient_name`, and `dob` columns [I]
  and is tracked in git [I], while the version-control chapter
  teaches that raw data must never be committed. `analysis/data/
  README.md` describes Palmer Penguins [I]. See Decision D7.
- The generator is byte-reproducible: a fresh run matched the
  committed CSV (MD5 `63665139b559eec7687d2af423358f96`) [A-V].

#### Finding 18. Factual errors in the history and the motivating examples

- R 3.6.0 'changed the default random-number algorithm' and 'every
  simulation' draws differently (`00-intro.qmd:168-170`,
  `01:391-393`): only `sample()`'s discrete-uniform method changed;
  `rnorm()` is identical under both [V].
- `stringsAsFactors` 'altered every model' (`00-intro.qmd:175-176`):
  `lm()` coefficients are identical for character and factor
  predictors [V]; the change matters for level-dependent code only.
- Trisovic et al. (2022): 'fewer than one in four' files ran
  (`00-intro.qmd:97-99`, figure at `:134` plots 24 percent); the
  paper reports 74 percent failing, about 26 percent succeeding
  [A-I; EK]. Chapter 01 (`:208`) has it right; ch01 `:412-416`
  attributes package churn over time to a study that does not track
  files over time [A-I].
- Peng (2011) misquoted inside quotation marks (`00-intro.qmd:76-77`)
  [A-I]; `@peng2009` cited for work that is `@peng2006` (`02:1029`)
  [A-I].
- `pacman::p_load()` invisible to renv (`07:481-487`): renv 1.2.3
  detects it [A-V].
- rocker/verse renders PDF with no runtime installs (`07:606-609`):
  it ships minimal TeX Live, and zzcollab itself pre-installs 25 more
  LaTeX packages [A-I].
- Apptainer: the OCI digest does not 'carry through' to the SIF and
  host environment and `$HOME` leak in by default, so 'provably the
  one used on the laptop' (`06:632`) is false; Docker has a rootless
  mode (`06:135-138`); rix pins a dated rstats-on-nix fork, not a
  NixOS commit (`06:352-363`) [A-I].
- `targets` catches a content change with an unchanged timestamp
  (`pipelines:537-538`): not under default `trust_timestamps` [A-V];
  the `report` target (`pipelines:513-516`) never tracks
  `report.Rmd`, so a prose edit leaves a stale report [I; A-V].
- Rebuilds 'byte-for-byte identical' (`10:269`) contradicts
  `05:505-513`; regulatory submissions 'call for bit-for-bit results'
  (`05:1116`) misstates the FDA 2015 statement [A-I].
- The example DOI `10.5281/zenodo.7654321` (`10:693`) resolves to a
  real record [A-V]. `rang` was archived on CRAN on 2026-08-22, and
  `dockerize_rang()` does not exist [A-V].
- A `.gitignore` line with a trailing comment (`version-control.qmd:562`)
  ignores nothing [A-V].

#### Finding 19. Statistical treatment below the audience's standard

- Monte Carlo error is treated as noise to pin with a seed; no Monte
  Carlo standard error is taught. Changing the sampler moved a
  bootstrap upper bound from 5.149 to 5.268, against a Monte Carlo SD
  of 0.125 across seeds [A-V].
- An optimizer-sensitive mixed-model estimate is called 'not
  statistical' (`02:48-60`); it is a fragile fit, which is a
  statistical fact [A-I].
- Chapters 07 and 09 recommend hashing outputs (exact comparison);
  chapter 08 rejects exact comparison for floating point. Hashing
  coefficients fails on a one-ulp change that `all.equal()` accepts
  [A-V]. The ch09 checksum demo hashes R serialization, not file
  bytes, so it changes between a tibble and a data frame [A-V].
- The recommended seeding pattern (`08:471-478`) overwrites the
  caller's RNG stream [A-V]; *R Packages* (2e) section 6.5 says to
  restore global state with `withr` [A-I].
- A test that 'no hazard ratio is negative' (`03:725-727`) cannot
  fail [I].
- Parallel RNG streams and missing-data mechanisms are absent [A-I].

#### Finding 20. 'Validation', 'verification', and 'audit trail' collide with their regulated meanings

The glossary's 'Validation' (`glossary.qmd:746-753`) and the L3
'verified' label are research usages; in pharmaceutical work the
same words mean computer system validation under 21 CFR 11.10(a)
and the EMA's 2023 guideline, which lists statistical software in
scope [A-I]. The book has a 'warning about the words' for
reproduced versus replicated (`02:460-520`) but none for these.
Double programming and package risk assessment (R Validation Hub)
are absent [A-I grep]. Graduates entering CROs and industry will
meet the other meaning in their first month.

#### Finding 21. Too long for one quarter, with core content repeated

- Body prose is about 77,100 words excluding exercises (3,600) and
  solutions (17,600) [A-V], about 7,700 words per week over ten
  weeks; the persona's target for a lab course taken alongside
  first-year theory is about 5,000 [A-I, persona judgment].
- The intro's 'Why the failures are computational, not statistical'
  (`00-intro.qmd:163-198`) is a near-verbatim, weaker copy of
  `01:375-435` and carries both errors in Finding 18; 220 shared
  8-word sequences between intro and ch01 [A-V].
- The ladder is defined in full five times; the opening anecdote is
  told three times (preface, intro, ch01) [A-I].
- Archetype sections recur in every chapter and again in exercises,
  costing several thousand words [A-I].
- 'The honest level' callout recites the same L0 to L3 summary in
  most chapters [A-I x4].
- The intro says 'twelve-week course' (`00-intro.qmd:544`) [A-I].

#### Finding 22. The LLM sections predate coding agents and omit governance and disclosure

4,928 words (about 4.7 percent of the book) in 36 prompt,
watch-for, verification triples [V count]. Strengths: the
verification steps are executable and well chosen [A-I]. Problems
[A-I]:

- they assume a chat partner; 'cannot see your directory'
  (`version-control.qmd:978-979`) and 'has no access to your session'
  (`01:641-642`) are false for coding agents that edit files, run
  shells, and open pull requests;
- no data-governance rule (Finding 16);
- no disclosure guidance (ICMJE requires it) and no statement that
  LLM output is itself not reproducible (nondeterminism, retired
  model IDs, unrecorded prompts);
- five triples repeat the same 'do not let the model claim full
  reproducibility' point; `04:820` names testthat in a tinytest
  book.

#### Finding 23. Coverage is deep on infrastructure and thin on everyday practice

Across 30 comparable courses with opened syllabi, containers appear
in 5, CI in 4, Apptainer in 2, DOI archiving in 2, and Nix in 0
[A-I; 7 of 30 re-opened by the agent, 23 not re-checked]. The most
widely taught topics the book lacks or only mentions are licensing
(9 of 30), debugging a failed reproduction (9), README and data
dictionary documentation (8), a shell primer (7), and git recovery
and merge conflicts (6) [A-I; I grep: no `conflict`, `revert`,
`reset`, or `restore` in the version-control chapter; README once
each in ch04 and ch08]. The textbook and reference sweep (28
sources) agrees on README, licensing and `CITATION.cff`, code
review, and project-oriented paths (`here`) [A-I]. The book is at or
beyond its sources on dependencies, containers, CI concepts,
testing, literate programming, and the LLM topic [A-I]. See 10.10.

#### Finding 24. The exercises cannot be graded at scale

Of 30 exercises classified in five chapters, 12 depend on the
student's own paper, analysis, or data, which is ungradeable and,
in a health-sciences program, a PHI risk; about 4 have checkable
code output [A-I]. All 72 solutions are printed in the book. None of
the exercises builds on the shared cohort. A template repository
with planted defects, autograded by CI, is the standard remedy, and
it cannot work until Findings 12 and 13 are fixed.

#### Finding 25. This repository does not reach the level it teaches

- `.github/workflows/render-book.yml` renders HTML only, from the
  committed `_freeze` cache, installs only knitr and rmarkdown on the
  host path, and runs no tests [I].
- `inst/tinytest/test-cohort.R` and `test-manuscript-invariants.R`
  call `exit_file()` when the book sources or raw extract are absent,
  as they are in a built package [I]; under `test_package()` they
  report 'All ok, 0 results' [A-V].
- No `renv.lock` and no Dockerfile (REFACTOR-PLAN Finding 5,
  unchanged) [I].

#### Finding 26. Currency

`actions/checkout@v4` (current v7.0.1, released 2026-07-20,
per the GitHub API on 2026-10-11 [V]; the audit's 'v6' was
itself out of date) and no mention of
`r-lib/actions` (`09`) [A-V]; renv cited at 0.12.0 and *R Packages*
at the first edition [A-I]; zzcollab now has six archetypes, a
`--bare` mode, and `zzc analysis` is a deprecated alias (`03`)
[A-I]; Make targets `ci-check`, `ci-render`, `render` named in ch09
do not exist in zzcollab's Makefile [A-I]; the 'four of ten
determinants' figure comes from a June 2026 internal review that
predates digest pinning [A-I]; `targets` 1.12.0 prints a skip summary
rather than names (`pipelines:579-583`) [A-V].

#### Finding 27. Accessibility

The `fig-gates` colors have 1.64 to 2.35:1 contrast, below the WCAG
1.4.11 minimum of 3:1, and status is conveyed by color alone [A-V].
No automated accessibility check is configured [A-I]. The Simpson
figure's alt text describes descending clusters that the data do not
show (`07:330`) [A-V].

#### Finding 28. Presentation: the dose of practice, not its design, is the issue

The learning-science survey grades retrieval practice and spacing as
strong evidence (classroom meta-analysis g = 0.50; Cepeda et al.
2006) [A-I; several primary pages login-gated, see report]. The book
places two retrieval checks per roughly 7,500-word chapter and no
cumulative exercises. Callouts are not overused (about four per
chapter besides solutions), but `conventions.qmd` advertises Tip and
Warning callouts that appear once in 13 chapters [A-V]. The prose is
strongly third person ('the reader'); evidence for a conversational
register is moderate [A-I]. From *R Packages* (2e), the device most
worth borrowing is a 'whole game' chapter: one end-to-end, executed
pass through a single compendium that later chapters extend [A-I].

### 10.5 Correctness register

Tier 1: a reader acting on it would lose data, expose PHI, or ship
an irreproducible result believing it reproducible. Tier 2: wrong or
misleading, low direct harm. Tier 3 items (spelling, stale
version strings, cross-reference slips) are listed in the per-chapter
actions.

| ID | Location | Defect | Evidence | Fix in |
|---|---|---|---|---|
| T1-1 | zzcollab `verify.sh:238-266`, `templates/Makefile:341`; book `00:474-478`, `08:501-505`, `09:528-560` | L3 stamped with failing tests; no baseline comparison | V, I | zzcollab, then 02, 08, 09 |
| T1-2 | `09:337-344`, `09:476-479`; `03:203-229` | No CI gate can fail on what it claims | I, A-V | 03, 09 |
| T1-3 | `05:450-473` | Showcase Dockerfile fails and mispins | A-V, A-I | 05 |
| T1-4 | `04:195-242`, `04:451-466`; zzrenvcheck `autofix.R:162-170` | Obsolete lockfile format; auto-fix records CRAN-current versions | V, I | 04, zzrenvcheck |
| T1-5 | `10:356-391`, `10:556-557` | Public deposit with no data protection | I | 10 |
| T1-6 | all LLM sections; `08:959` | No restricted-data rule for LLM use | I, A-I | every chapter's LLM section (D5) |
| T1-7 | `simulate_cohort.R:83` | Planted error destroys ground truth | I, A-V | generator, tests |
| T1-8 | `08:453-459`; `03:1037-1040` | Reproducibility test cannot detect what it claims | I, A-V | 08 |
| T1-9 | `pipelines:513-516` | Report target misses edits to the report source | I, A-V | pipelines |
| T1-10 | repository CI and `inst/tinytest/` | The book's own verification is vacuous | I, A-V | repository |
| T1-11 | `version-control.qmd:225-275`, `:272`, `:494` | Git presented as an audit trail | A-V | version-control |
| T2-1 to T2-37 | see Findings 14 to 27 | Factual and technical errors listed there | as labeled | per chapter |

T1-11 is Tier 1 only for readers entering regulated work; it is kept
here because the book does not say which readers it is written for.

### 10.6 House rules (additions)

1. Every gate shown in the book must be demonstrated to fail. Each
   CI, test, or verification recipe is accompanied by the deliberate
   breakage that turns it red.
2. Every executed claim about a tool is run in the book, against a
   pinned version, or labeled as illustrative static text with the
   version it describes.
3. No exact-equality comparison of floating-point results without a
   stated tolerance; hashes are for files and data, not estimates.
4. No prompt in the book carries data. Every LLM passage that could
   tempt a reader to paste data says where restricted data may and
   may not go.
5. The running cohort is the default example; another dataset needs
   a stated reason.
6. One definition per term, in one place, linked thereafter. The
   ladder is defined once in ch02 and summarized once in the intro.
7. Claims about zzcollab describe what the current source does, with
   the version, and are re-checked at each tool release.
8. US English, no em dashes, single quotes in prose, native pipe,
   `<-`, snake_case, 2-space indentation, tinytest, roxygen2, wrap at
   about 66 characters (existing rules, restated).

### 10.7 Chapter template (revised)

The existing template (preface, 'Chapter template') is kept, with
these changes, in order of appearance:

1. **Opening.** One concrete failure from the running cohort, or a
   payoff statement, on the first screen. No epigraph-only openings.
2. **Chapter card.** Reading time, prerequisites (chapters and
   statistical knowledge), three to five objectives phrased as
   questions the reader will be able to answer, and a section
   outline. Optional skip-ahead quiz of three items for readers who
   know the material.
3. **Where this sits on the stack.** The determinant-stack figure,
   produced by one shared function, with the layers this chapter
   captures or validates highlighted and generated alt text.
4. **Numbered sections**, each ending in a folded Check (one per
   major section, not two per chapter) and its own short exercise.
5. **Callouts**, three kinds only: Verification (how to see that it
   worked, and how to make it fail), Pitfall, and Restricted data.
6. **The cohort, continued.** The chapter's step applied to the
   running compendium, executed.
7. **The honest level.** One sentence stating which rung this
   chapter's practice reaches and what it leaves exposed; no
   recital of the whole ladder.
8. **Collaborating with an LLM.** Kept in place and patched
   (Decision D5): a restricted-data rule, premises corrected for
   coding agents, duplicated triples removed.
9. **Exercises.** At least one cumulative exercise on the cohort
   compendium, autogradable; at least one that revisits an earlier
   chapter (spacing).
10. **Cheat sheet.** One half-page table of commands and rules,
    collected later into a cheat-sheet index.
11. **Further reading.**

### 10.8 Habit list and motto

**Motto:** *Claim only the level you have verified.*

1. Commit before you compute.
2. Pin what you ran, not what is current.
3. Never commit, deposit, or paste restricted data.
4. Make every gate able to fail, and watch it fail once.
5. Compare against a recorded baseline, with a stated tolerance.
6. Rebuild from clean, on a machine that is not yours.
7. Write the honest level down.

The list and motto live in one include file shared by the
introduction and the closing chapter; each rule of thumb in a
chapter cites its habit number.

### 10.9 Running example and canonical analysis plan

**Study.** A synthetic retrospective cohort of 400 adults
(`simulate_cohort.R`, `n <- 400`) followed for incident type 2
diabetes. **Revision required:** exclude, at generation, anyone whose
baseline HbA1c meets the diagnostic threshold, so the cohort is
genuinely at risk (Finding 17).

**Canonical analysis.** Primary: Cox proportional-hazards model of
time to incident diabetes (`followup_days`, `incident_dm`) on BMI
per 5 kg/m^2, adjusted for age and sex; report the hazard ratio and
95 percent CI. Secondary: a bootstrap CI for the same estimate, with
its Monte Carlo standard error reported. The baseline for L3 is the
hazard ratio, its CI, and the cleaned-data row count, stored in a
committed baseline file and compared with tolerance `1e-8` relative
for deterministic quantities and a stated Monte Carlo tolerance for
the bootstrap.

**Planted pathologies, mapped to chapters.**

| Pathology | Taught in |
|---|---|
| Identifier columns (`mrn`, `patient_name`, `dob`) | version-control, 10 |
| Mixed date formats | 07, 08 |
| One duplicated record | 08 |
| One implausible age (400) | 08 |
| Inconsistent sex coding, applied only to true females | 08 |
| A seeded bootstrap that differs under `sample.kind = 'Rounding'` | 02, 08 |
| An undeclared package in an analysis script | 04, 09 |

**Seed policy.** The generator's seed stays as committed. Fixing line
83 to recode only true females changes only that step's draws,
because it is the last random step; the change is to be reported
and the new MD5 recorded, not re-drawn until convenient.

### 10.10 Topic additions from the coverage sweep

Breadth is the count of opened sources that include the topic, as a
lower bound: S = 30 syllabi, T = 28 textbooks and references, E = 39
emerging-topic sources.

| Topic | Breadth | Settled | Placement | Size (words) | Priority |
|---|---|---|---|---|---|
| Restricted data: de-identification, controlled-access deposit, trusted research environments, Five Safes, synthetic data for sharing | T 3, E several (NHS SDE, EHDS, NIH) | Stable | New section set in 10; Restricted-data callout in VC, 07, 09 | 2,500 | 1 |
| Funder and journal obligations: NIH DMS Policy, code-availability statements, TRIPOD+AI 18f | E several | Stable | Section in 10, with an exercise | 1,000 | 1 |
| Regulated meaning of validation; double programming; package risk assessment | T 2, persona | Stable | 'Warning about the words' box in 02; one section in 08 | 900 | 1 |
| README, data dictionary, project documentation | S 8, T 6 | Stable | Section in 03 | 900 | 1 |
| Licensing, `CITATION.cff`, Software Heritage | S 9, T 6 | Stable | Section in 10 | 900 | 1 |
| Git recovery and merge conflicts | S 6 | Stable | Section in version-control after `:614` | 1,200 | 2 |
| Debugging a failed reproduction (`git bisect`, lockfile diff, session-info diff, `tar_outdated`) | S 9 | Stable | Section in 09 | 1,200 | 2 |
| Apple Silicon, multi-architecture images, `--platform` | E several, persona | Stable | Section in 05; setup appendix | 800 | 2 |
| Pre-specified analysis plan as the oracle for the primary analysis | persona | Stable | Section in 08 | 700 | 2 |
| Monte Carlo standard error; parallel RNG streams | persona | Stable | Section in 08 | 700 | 2 |
| Project-oriented paths (`here`, no `setwd`) | S 7, T 7 | Stable | Section in 03 | 400 | 2 |
| Secrets in CI, token permissions, SHA-pinned actions | persona | Stable | Section in 09 | 600 | 2 |
| AI-use disclosure and recording model IDs | E (ICMJE, NIH) | Stable rule, volatile tools | LLM sections of 01 and 07 (D5); no tool names | 500 | 2 |
| Shell primer | S 7 | Stable | Appendix | 2,000 | 3 |
| HPC: Slurm plus Apptainer worked example, `--cleanenv` | persona | Stable | Optional section in 06 | 1,000 | 3 |

**Skipped,** with reasons recorded in the coverage reports: the EU
AI Act, SBOM and SLSA supply-chain security, uv, webR and Quarto
Live, TRIPOD-LLM, duckdb and parquet, full R package development
(pointer to *R Packages* instead), Shiny, Python, SQL.

**Length effect** [inferred estimate]. Priority 1 and 2 additions
total about 12,500 words; the shell primer and HPC section add 3,000
more. Cuts in 10.12 total about 11,000 words (intro duplication
2,700, archetype consolidation 3,000, LLM consolidation net 600,
honest-level recitals 800, ch02 numbering schemes 500, ch07 history
400, ch05 and ch10 team model moved to an optional section 3,000).
Net change for priorities 1 and 2: about +1,500 words, roughly
+2 percent. The PDF's 31 percent growth since September is a
separate question (Decision D10).

### 10.11 One-quarter core path

Adapted from the academic persona's proposal [A-I], after the cuts
in 10.12. Loads are body words; post-cut loads are estimates.

| Week | Reading | Load | Graded lab on the cohort template |
|---|---|---|---|
| 1 | Preface; intro (trimmed); 01 | 6,800 | Setup check; RNG `sample.kind` demonstration |
| 2 | 02 (cut `538-575`) | 5,000 | Place a published paper on the ladder |
| 3 | Version control | 6,800 | Repository, `.gitignore`, synthetic identifiers |
| 4 | 03 | 4,500 | Scripts to compendium; README and data dictionary |
| 5 | 04 | 5,700 | Lockfile; restore on a second machine |
| 6 | 05 | 5,500 | Digest-pinned image built in CI |
| 7 | 07; Make excerpt from pipelines | 7,300 | Sealed render with inline numbers |
| 8 | 08 | 6,100 | Repair the cohort; oracle and baseline tests |
| 9 | 09 | 6,700 | CI that compares to the baseline, shown failing |
| 10 | 10 | 4,500 | Deposit to the Zenodo sandbox; restricted-data plan |

Optional: 06 (backends and runtimes), the remainder of pipelines
(`targets`, Snakemake, Nextflow), and the shell-primer and HPC
material. Average about 5,900 words per week, still above the
persona's 5,000 target; weeks 1, 3, and 7 remain heavy.

### 10.12 Per-chapter actions

Line references are to the current sources; T-numbers refer to the
register in the scratchpad and Findings above.

- **index, preface.** Remove the duplicated plan list from the
  preface; keep motive and the zzcollab rationale. Add a
  prerequisites statement (statistics assumed: logistic and Cox
  regression, the bootstrap; R package anatomy introduced in 03).
  Confirm the author name form; the PDF metadata renders a backtick.
- **00-intro.** Delete `:163-198` and replace with two sentences
  pointing to @sec-crisis; delete or reduce `:200-498` (tool survey
  and zzcollab internals, about 2,700 words) to a one-page map; fix
  Trisovic, R 3.6.0, `stringsAsFactors`, Peng quotation, 'twelve-week
  course', and 'an image built today and next year are the same
  image' (`:302-304`).
- **01.** Fix `:391-393`, `:412-416`; replace the honest-level box
  with a one-line pointer; 'mislabelled' at `:627`.
- **02.** One definition of L3 (`:380` versus `:591-593`); realign L3
  with ACM terminology after the ACM page is checked; add the
  regulated-terminology box; fix `:48-60` (fragility is statistical),
  `:218-225` versus the Exercise 1 solution, the `.Rprofile` seed in
  the worked example (`:684-689`), the decimal-mark claim
  (`:292-293`), `@peng2009` (`:1029`); reconcile 'nine or ten'
  determinants; use the cohort in the worked example.
- **version-control.** Add recovery and merge conflicts; fix `:562`;
  fix `:98` (forward reference); temper audit-trail language
  (`:225-275`, `:272`, `:494`); complete the history-scrubbing
  procedure (`git filter-repo`, forge cache, credential rotation);
  add `.RData`, knitr cache, and `_freeze` guidance; correct the LLM
  premise at `:978-979`.
- **03.** Correct what R CMD check sees (`:203-229`, `:934-942`);
  add README and data-dictionary and `here` sections; update to six
  archetypes and `--bare`, replace `zzc analysis`; replace the
  vacuous hazard-ratio test (`:725-727`); fix the Exercise 5 test path
  (`:1028-1033`); consolidate all archetype material into one table
  here.
- **04.** Rewrite the lockfile section for the current format;
  correct the auto-fix description after zzrenvcheck is fixed; resolve
  `Suggests` and the recommended-package rule; remove the 'naive
  scanner' straw man (`:522-531`); remove or source the dplyr 1.2
  story (`:55-58`); update the renv citation.
- **05.** Rewrite the showcase Dockerfile and its exercise solution
  and test them by building (`--platform linux/amd64`); correct BLAS,
  `OMP_NUM_THREADS`, locale table (use collation instead), Nüst
  attribution, 'bit-for-bit' regulatory claim; add Apple Silicon;
  move the team model to an optional section.
- **06.** Mark optional. Fix Apptainer, rootless Docker, rix claims;
  add an `sbatch` plus Apptainer example with `--cleanenv`.
- **07.** Fix `pacman` (`:481-487`, `:1106-1109`), rocker/verse
  (`:606-609`), Simpson alt text (`:330`); trim Sweave history
  (`:235-287`) and archetypes (`:705-785`); quote Buckheit and Donoho
  verbatim with a page number.
- **pipelines.** Replace the report target with `tar_quarto()` or
  `tar_render()`; fix `:537-538`, the Exercise 3 solution
  (`:1115-1121`), skip-output text, the 'ratios are durable' claim;
  teach `.DELETE_ON_ERROR`; produce the Make excerpt for the core
  path.
- **08.** Fix test paths (`:331`, `:421`, `:464`, `:488`); replace the
  same-session reproducibility test with a baseline test across
  sessions and RNG kinds; fix the seeding pattern with `withr`; fix
  the Cox argument (`:342-350`); add Monte Carlo error, analysis plan
  as oracle, and the regulated-validation section; fix the LLM prompt
  at `:959`; replace testthat at `04:820`.
- **09.** Make every gate fail: `error_on = "warning"`,
  `error_on_fail = TRUE`, install zzrenvcheck, add the render gate,
  build the Dockerfile in CI, remove `continue-on-error`; replace the
  worked example's impossible failure; update actions versions and
  introduce r-lib/actions; hash files, not serializations; compare
  estimates with tolerance; add debugging a failed reproduction and
  secrets; remove Make targets that do not exist; reconcile L3 with
  02 and 08.
- **10.** Add restricted data, funder obligations, licensing and
  `CITATION.cff`, Software Heritage; replace the example DOI with a
  non-resolving placeholder; replace `rang` material; fix
  'nine chapters' (`:48`), 'byte-for-byte' (`:269`); tighten the FAIR
  mapping against Wilkinson et al. (2016).
- **glossary, conventions.** Regulated-sense note on Validation;
  conventions lists only the three callout kinds actually used.
- **Repository.** Rewrite `analysis/data/README.md` for the cohort;
  delete the stray conflicted-copy log and
  `07-literate-programming.html` from `analysis/report/`; fix the
  `fig-gates` palette.

### 10.13 Phases

Each phase on its own branch, closed by a clean HTML and PDF render
and the checks in Section 10.3, one commit per phase.

| Phase | Content | Depends on | Estimate |
|---|---|---|---|
| 6 (E1) | Tier 1: T1-1 to T1-11 in the book; independent re-check of each fix; the showcase Dockerfile built | zzcollab and zzrenvcheck fixes (10.17) for T1-1, T1-4 | 6 to 9 days |
| 7 (E1b) | This repository to L3: CI executes code (freeze checked, not trusted), runs tinytest so that a failure fails the build, renders PDF; `renv.lock` | none | 2 to 3 days |
| 8 (E2) | Tier 2 and 3 corrections; generator fix and baseline file with tests | 6 | 5 to 7 days |
| 9 (F) | Template: conventions page, habit include, shared stack-diagram function, instructor guide; two prototype chapters (02 and 08). **Checkpoint.** | 8 | 4 to 6 days |
| 10 (G) | Running study threaded through every chapter; course template repository with planted defects and CI autograder | 8, 9 | 5 to 8 days |
| 11 (H/K) | Conversion in batches of four chapters, with approved additions from 10.10. **Checkpoint after the first batch with a length report.** | 9, 10 | 15 to 25 days |
| 12 (I) | Restructure: intro cut, archetype consolidation, optional marking, core path in preface and instructor guide. **Checkpoint before any renumbering.** | 11 | 4 to 6 days |
| 13 (J) | Apparatus: cheat-sheet index, setup appendix (Apple Silicon, Windows, WSL2), colophon generated at render time, glossary first-use links, accessibility check | 12 | 4 to 6 days |
| 14 | Verification pass of every [EK] and [U] claim against primary sources, each marked verified, corrected, hedged, or removed with URL and date | 13 | 3 to 5 days |

Total: about 48 to 75 working days, of which Phases 6 to 8 (13 to
19 days) carry nearly all the risk reduction. If only one phase is
done, do Phase 6. Per Decision D12, Phase 7 runs after Phase 13,
not second; the table keeps its number for reference.

### 10.14 What not to do (additions)

- **Do not rewrite the chapters to describe zzcollab as it is.** The
  tool's L3 stamp and CI gate defaults are defects; fix them first
  (10.17), or teach the hand-written equivalent.
- **Do not add the infrastructure topics the syllabi show few peers
  teach** (SBOMs, SLSA, more Nix). Depth there is already beyond the
  comparison set.
- **Do not add a chapter per gap.** Every addition in 10.10 except
  restricted data fits as a section; the shell primer is an appendix.
- **Do not let a planted pathology destroy the truth it hides.**
- **Do not re-pick the generator seed after seeing the draws.**
- **Do not publish solutions for exercises used for grades**
  (Decision D6).
- **Do not name AI tools or models in the LLM sections.** The rules
  are stable; the products are not.

### 10.15 Decisions

Each decision lists options and a recommendation. Answers are
recorded here once given.

- **D1. zzcollab and zzrenvcheck defects.** (a) Fix the tools first
  and describe the fixed behavior; (b) describe the current behavior
  with warnings; (c) teach hand-written equivalents and drop the tool
  from the gating chapters. *Recommendation: (a), with (c) as the
  fallback for any fix not released before Phase 6.*
- **D2. Role of zzcollab.** (a) Concepts first, with a 'with
  zzcollab' track in boxed sections so that the course is teachable
  with renv, a Dockerfile, GitHub Actions, and tinytest alone; (b)
  keep zzcollab as the vehicle throughout. *Recommendation: (a).*
- **D3. Core path.** (a) Adopt the 10-week path in 10.11, with 06 and
  most of pipelines optional; (b) keep every chapter core.
  *Recommendation: (a).*
- **D4. Restricted data.** (a) A section set in 10 plus
  Restricted-data callouts in version-control, 07, and 09; (b) a new
  short chapter. *Recommendation: (a).*
- **D5. LLM sections.** (a) Consolidate into one appendix (about
  2,500 words: governance, agents, prompt writing, disclosure,
  nondeterminism) and keep a two-triple box per chapter; (b) keep as
  is and patch. *Recommendation: (a).*
- **D6. Published solutions (reopens Phase 1).** (a) Keep solutions
  for checks and for practice exercises; move solutions for graded,
  cohort-based exercises to the instructor guide; (b) keep all
  solutions in the book. *Recommendation: (a). Phase 1 was right for
  self-study; a course needs gradeable work.*
- **D7. The committed synthetic extract.** (a) Commit only the
  generator; gitignore the CSV and generate it in CI and tests, so
  the repository practices what the version-control chapter teaches;
  (b) keep it committed and mark it as synthetic in the data README
  and file header. *Recommendation: (a).*
- **D8. Topic additions.** Approve the Priority 1 and 2 rows of
  10.10, and decide on the Priority 3 rows. *Recommendation: approve
  Priority 1 and 2; shell primer yes; HPC optional section yes.*
- **D9. Regulated terminology.** (a) A 'warning about the words' box
  in 02 plus one section in 08; (b) rename the ladder's L3 and the
  'validation' axis. *Recommendation: (a).*
- **D10. Length.** (a) Hold net prose within about 5 percent of
  today and investigate the 31 percent page growth before Phase 11;
  (b) accept growth. *Recommendation: (a).*
- **D11. L3 and ACM.** (a) After checking the ACM page, map L3 to
  'repeatability' and reserve 'reproduced' for independent
  verification (the existing 'Independent external verification'
  section, `09:796`); (b) keep the current mapping. *Recommendation:
  (a), conditional on the check.*
- **D12. Repository L3 first.** (a) Do Phase 7 before or alongside
  Phase 6, so the book reaches the level it teaches; (b) defer.
  *Recommendation: (a).*

**Answers recorded 2026-10-11.**

| Decision | Answer | Matches recommendation |
|---|---|---|
| D1 | Fix the tools first; hand-written equivalents as fallback | Yes |
| D2 | Concepts first, 'With zzcollab' boxed track | Yes |
| D3 | Adopt the core path in 10.11 | Yes |
| D4 | Section set in 10 plus Restricted-data callouts | Yes |
| D5 | Keep the LLM sections in place and patch them | No |
| D6 | Keep all solutions in the book (Phase 1 stands) | No |
| D7 | Keep the extract committed; label it synthetic | No |
| D8 | Approve Priority 1, Priority 2, shell primer, HPC section | Yes |
| D9 | Warning box in 02 plus one section in 08 | Yes |
| D10 | Accept growth | No |
| D11 | Realign L3 with ACM after checking the page | Yes |
| D12 | Defer repository L3 until after the content work | No |

**Consequences for the plan.**

- *D5.* Template item 8 becomes: the existing section, patched with
  a one-line restricted-data rule, corrected premises for coding
  agents, and removal of the five duplicated 'full reproducibility'
  triples. AI-use disclosure and LLM nondeterminism go into the 01
  and 07 sections rather than an appendix. The LLM length saving in
  10.10 (600 words) no longer applies.
- *D6.* Graded work comes from the course template repository and
  its CI autograder (Phase 10), with instructor-written graded tasks
  whose answers are not in the book. Phase 1's rationale is
  unchanged.
- *D7.* Rewrite `analysis/data/README.md` for the cohort, add a
  synthetic-data notice to the CSV's documentation, and add a
  paragraph to the version-control chapter explaining why this
  repository commits a synthetic extract while real projects must
  not. Habit 3 is unaffected.
- *D10.* The net-length estimate in 10.10 becomes about +6,000 to
  +7,000 words after cuts (all D8 additions, no LLM saving), roughly
  +7 to 8 percent of prose. Length is still reported at each
  checkpoint so that the per-week load in 10.11 can be re-measured;
  the 31 percent page growth since September is to be explained in
  the Phase 11 length report, not capped.
- *D12.* Phase 7 moves after Phase 13. **Risk accepted by the
  author:** during Phases 6 to 13 no CI re-executes the book's code
  or runs its tests, so regressions introduced by conversion will
  surface only when Phase 7 runs. Mitigation within the existing
  rules: each phase's clean render must be done with the freeze
  cache cleared for the chapters it touches, and tinytest run
  locally with `run_test_dir()` from the repository root, where the
  tests do not exit early.

### 10.15a Implementation record

**Phase 6 (E1, Tier 1), 2026-10-11.** Book branch `phase-6-tier1`
(commit message 'Phase 6: Tier 1 correctness fixes'); zzrenvcheck
branch `fix/gate-defaults` at `19f6c2a`; zzcollab branch
`fix/l3-verification` at `80293ae`. All local; nothing pushed.
Merge order when merging: zzrenvcheck before zzcollab, because
zzcollab's `ensure-zzrenvcheck` now requires 0.9.0.

| Item | Result | Evidence |
|---|---|---|
| T1-1 L3 stamp | zzcollab test targets exit nonzero on failure; `verify --full` requires a `test-baseline*.R`; one L3 definition across 00, 02, 08, 09 and the glossary | V (lead ran the new runner on a failing test: exit 1); A-V stubbed verify runs; I grep |
| T1-2 CI gates | 03 and 09 state what R CMD check sees; both workflows use `error-on: warning`, install zzrenvcheck with `error_on_fail = TRUE`, add a render gate and an image-build verify job; each gate shown failing | A-V locally per gate; YAML parsed (structural only); CI jobs not run |
| T1-3 Dockerfile | Rewritten; built with `--platform linux/amd64`, exit 0, `jsonlite` 2.0.0 and `renv` 1.2.3 installed from the jammy snapshot; wrong renv version fails the build | A-V; I: chapter block byte-identical to the built file |
| T1-4 lockfile | 04 shows a real renv 1.2.3 record; auto-fix records the installed version (zzrenvcheck 0.9.0) | V lead snapshot; V zzrenvcheck suite 188/0 |
| T1-5 deposit | New subsection `sec-restricted-deposit` in 10; worked example and exercises say what is deposited; placeholder DOI | A-V image-contents check; I |
| T1-6 LLM data rule | Restricted-data passage in every LLM section; data-carrying prompts rewritten; coding-agent premises corrected | A-I; not separately re-read by the lead |
| T1-7 generator | Line 83 recodes only true females; MD5 `63665139...` to `4c8ca6ed60bc25ff679ac87717fd7308`; 4 new assertions | V lead regeneration matched; V tests 185/0 |
| T1-8 baseline test | Cross-session baseline test in 08 with an executed chunk showing detection of the RNG-default change | A-V; V executed in the clean render |
| T1-9 report target | `tar_render()`; `trust_timestamps` described correctly | A-V in rocker/verse:4.5.2 |
| T1-11 audit trail | Language tempered with 21 CFR 11.10(e); five-step PHI response; `.gitignore` fixed; D7 paragraph | A-V scratch repositories |
| T1-10 repository CI | Deferred by D12 | not done |

Render: freeze cleared for all 13 chapters, so every chunk
re-executed; HTML and PDF exit 0, no warnings, no unresolved
references or missing citations [V]. PDF 436 pages (398 before
Phase 6). Shared files changed by the lead: glossary (six
entries), references.bib (seven entries, URLs checked, HTTP 200),
`_quarto.yml` (fvextra line breaking in PDF code blocks, because
long digests were truncated at the margin).

Not done in Phase 6, carried to Phase 8: the renv citation
(`ushey2020` is 0.12.0); ch09 Exercise 3 and `tbl-integrity` still
hash coefficients and serializations; ch09 Exercise 4's Make
targets; the vacuous hazard-ratio test (03:725); decimal-mark table
(05); illustrative truncated digests in ch05's figure; `rang`
material and 'nine chapters' in 10; pipelines Exercise 3 solution;
'Initialise' in `tbl-audit-trail`. Known tool gap: a tinytest file
that exits early with zero assertions still counts as passing in
`run_test_dir()`; the book's `ci/run-tests.R` treats it as a
failure, the zzcollab Makefile does not.

**Phase 8 (E2, Tier 2 and 3), 2026-10-11.** Book branch
`phase-8-tier2`, built on `phase-6-tier1`; two commits: one for the
generator's baseline-exclusion fix (below), one for the chapter
corrections. All local; nothing pushed.

| Item | Result | Evidence |
|---|---|---|
| Finding 17 / T2-26, cohort baseline-prevalent cases | 400 people are screened; those meeting the HbA1c diagnostic threshold at baseline are excluded before the outcome is drawn, leaving 337 at-risk people (338 rows with the duplicate); MD5 `63665139...` to `4c8ca6ed60bc25ff679ac87717fd7308` (Phase 6) to `c9c8e19173397c2c2b6ceb073b2ba1cf` | V lead regeneration (0 rows with baseline HbA1c >= 6.5); V tests 185/0. The outcome model stays logistic, as `R/cohort.R`'s `fit_model()` expects; a true time-to-event analysis using `followup_days` is explicitly left as future work (Phase 10), not attempted, since it would require rewriting `fit_model()`, `bootstrap_ci()`, and every chapter and test built on their `glm`-shaped output |
| T2-28 'twelve-week course' | 00-intro now says the book is organized in four parts, written for a one-quarter ten-week course, with some material optional at that pace; no promise of a core-path marker that does not yet exist | I lead, hand-edited |
| Decimal-mark / locale (05) | Rewritten: R holds `LC_NUMERIC` at `C` regardless of locale, so `as.numeric()` never varies; reframed the misread as an external-tool/ingest problem; added a genuine locale effect (sort order, month names) to justify pinning `LANG`/`LC_ALL` | A-V (locale switched, confirmed); V lead re-ran independently, same result |
| fig-tag-digest illustrative digest (05) | Parenthetical added noting the truncated digests are illustrative, pointing to the showcase Dockerfile's full digest as the real one | A-I |
| Nüst citation (05) | Softened to: the paper argues for version tags/pinning, stops short of digest pins or dated snapshots, which the chapter adds itself | A-I (fetched paper); V lead independently fetched the same paper, confirmed |
| Apptainer/Docker claims (06) | 'Same content digest carries through' and 'provably the one used on the laptop' softened; `$HOME`/env leakage and `--cleanenv` noted; Windows conda/Docker claim softened | A-I / EK (labeled) |
| Simpson figure alt text (07) | Rewritten to 'nearly flat with a slight downward tilt'; a sentence added that the reversal is in sign, not magnitude | A-V; V lead independently re-ran the exact chunk: per-species slopes 0.1806/0.1293/0.1452, pooled -0.0606, matches exactly |
| rocker/verse PDF claim (07) | Softened: a base TeX Live sufficient for straightforward renders, not a full distribution; some documents need `tlmgr` installs | A-I zzcollab's own ~24-package pre-install |
| ch09 Exercise 3 / `tbl-integrity` hashing (09) | Exercise rewritten to ask why a digest is wrong for estimates; solution explains serialization is not a value comparison, points to `expect_equal(..., tolerance = ...)`; `tbl-integrity` itself was already correct (file-byte hashing) | A-V (digest changes on a tolerance-level nudge); V lead independently reran: `all.equal` true, digest differs |
| ch09 Exercise 4 Make targets (09) | `make render` replaced with `make docker-render-book`; prose now names the real render targets | A-I zzcollab Makefile; V lead grep confirmed `docker-render-book`, `check`, `check-renv` exist, no plain `render` |
| `renv::snapshot()` / DESCRIPTION (09) | Checked: no passage claims `snapshot()` updates DESCRIPTION; confirmed correct, no change needed | A-V scratch test |
| ch08 coxph/`expect_inherits` | No `coxph` reference exists in ch08; already resolved, no action needed | A-I grep; V lead grep confirmed |
| `rang` archived / wrong API (10) | Noted as archived (2026-08-22); `dockerize_rang()` replaced with the real `resolve()`/`dockerize()` API | A-I (CRAN, GitHub README); V lead independently fetched CRAN archive page and GitHub README, confirmed both |
| 'nine chapters' (10) | Reworded to 'Every earlier chapter...', avoiding a count that goes stale again | A-I (`_quarto.yml` count: 12); V lead recounted independently, confirmed 12 |
| 'byte-for-byte' (10) | Softened to match ch05: a pinned/dated rebuild reproduces the same content, not guaranteed byte-identical | A-I cross-check against 05 |
| FAIR mapping / license (10) | 'A FAIR object almost by construction' softened to 'most of the way', conditioned on an explicit license (R1.1); no new section (Phase 11 scope) | A-I |
| pipelines Exercise 3 `format = 'file'` | Split into a file target and a read target, mirroring the chapter's own correct pattern | Reported as inspected only (agent's `targets`/`igraph` build failed on host and stalled under Docker emulation); V lead ran both the original buggy and the fixed pipeline in `rocker/r-ver:4.6.0` (`--platform linux/amd64` + `libglpk40`): buggy version fails with exactly the diagnosed error, fixed version completes all 4 targets, `targets` 1.12.0 confirmed |
| skipped-target console text (pipelines) | Reworded to say current `targets` shows a skip count, not enumerated names | Reported as inspected only; V lead confirmed `targets` 1.12.0 is the version in use (matches the version this behavior change applies to) |
| 'ratios are durable' (pipelines) | Softened: repeated runs vary several-fold; ratios are illustrative, not stable | A-V (an earlier reviewer's 85/101/284 across three runs), not independently re-run this phase |
| renv citation (04, 05, 06) | `ushey2020` entry corrected in place (kept the existing key, since it is cited by that key in three chapters): `@manual`, year 2026, authors Ushey and Wickham, 'R package version 1.2.3' | V lead (`packageDescription('renv')`: 1.2.3, packaged 2026-05-16, Wickham now a listed author) |
| 'Controlled access' / 'Data-availability statement' glossary entries | Added in alphabetical position, matching the existing format | I lead, hand-written |

One process note: an agent working on 04/05/06 created a stray
`scratchpad/` directory inside the book repository itself (wrong
path; the session scratchpad is outside the repo) and wrote a
renv-citation proposal and a locale test script into it. Both were
untracked, matched the fix already applied independently by the
lead, and were deleted before committing; nothing from that
directory reached a commit.

Render: freeze cleared for the 7 touched chapters; first attempt
failed with a transient network error fetching the CSL style from
`zotero.org` (confirmed reachable on retry, unrelated to any
content change); retry succeeded, HTML and PDF exit 0, no warnings,
no unresolved references or missing citations, no literal HTML
entities outside published reference titles [V]. PDF 440 pages (436
after Phase 6). Repository test suite 185/185 after Phase 8, run
from the repository root, confirming Phase 8's chapter-only edits
did not disturb Phase 6's fixes.

Not done in Phase 8, still outstanding: 'Initialise' (British
spelling) in `version-control.qmd`'s `tbl-audit-trail`; the vacuous
hazard-ratio test at `03-research-compendium.qmd:725` (neither file
was in Phase 8's scope). Both, plus every Priority 1/2/3 addition
approved under Decision D8 (restricted data detail, licensing,
`CITATION.cff`, README/data-dictionary sections, git recovery, a
debugging guide, a shell primer, the HPC section), remain for Phase
11 (content additions) or a future correctness pass.

**Phase 9 (F, template), 2026-10-11.** Book branch `phase-9-template`,
built on `phase-8-tier2`; two commits: shared infrastructure
(`0601109`), then the two prototype chapter conversions. All local;
nothing pushed. This is the first application of the revised
template (10.7) and, per the plan's standing checkpoint rule, stops
here for the author's review before any book-wide rollout.

Shared infrastructure, built once and reused by every chapter:

| Item | Result | Evidence |
|---|---|---|
| Shared stack-diagram function | `R/stack_diagram.R`: `plot_determinant_stack(captures=, validates=, title=)` and `determinant_stack_alt()`, generating matched figure and alt text from one call | V (R CMD check clean, 0 warnings); V ch02's existing figure converted to call it, byte-faithful to the original |
| Computed fig-alt in Quarto | A hidden `{r}` `#| include: false` setup chunk (`pkgload::load_all('../..')`) followed by `#| fig-alt: !expr determinant_stack_alt(...)` in the figure chunk | V: a first attempt (`knitr::opts_current$set()`) silently produced no alt attribute at all, caught only by checking the rendered HTML, not by trusting the render log; the `!expr` pattern verified in both HTML (`<img alt="...">`) and PDF |
| Habit list and motto | `analysis/report/_habits.qmd`, included once each in 00-intro and 10-archiving-sharing via `{{< include >}}` | V: motto text appears exactly twice in the rendered PDF |
| Conventions page | Rewritten: chapter card, stack figure, folded Check, three callout kinds (Verification, Pitfall, Restricted data), honest-level one-liner, habit citation, one-quarter core path table (Decision D3) | I lead, hand-written |
| Instructor guide | `INSTRUCTOR-GUIDE.md` at the repo root, not part of the rendered book (follows the `CULTURAL-RELEVANCE-READING.md` precedent): week-by-week core path, why the book's own exercises are not fit for grading as written, known rough edges by week | I lead, hand-written |
| `@sec-conventions` cross-reference | Does not resolve: Quarto does not support `@sec-` crossrefs to an unnumbered chapter-level heading, confirmed with a fully cleared `.quarto/` cache, not a caching artifact. Replaced with a plain markdown link (`[Conventions](conventions.qmd)`) everywhere it was needed | V lead, isolated repro |
| `devtools::document()` | Run for the first time against this package's existing `Roxygen:` field; `NAMESPACE` now holds real `export()` calls and `man/` real `.Rd` files, replacing a placeholder `exportPattern` that predated any roxygen2 run | I lead |

Prototype chapter conversions, both of the 11 template items applied
in full:

| Item | ch02 (Levels of Reproducibility) | ch08 (Testing and Code Quality) |
|---|---|---|
| Opening | Payoff paragraph added (chapter did not touch the cohort) | Payoff paragraph added (chapter already touches the cohort) |
| Chapter card | 'Before you start': ~45 min, prerequisites (the book's first explicit prerequisites statement, closing a gap the academic persona's review found), 5 question-phrased objectives, outline | Same pattern, 5 objectives |
| Stack figure | Confirmed the chapter's own existing figure already satisfies the template (`captures` = all nine layers, since this chapter defines the whole stack); untouched | New figure, `validates = c('Analysis code', 'Input data')`, `captures` empty, reflecting that testing is pure validation in the book's own capture/validate distinction |
| Folded Checks | 9 total (7 new, 2 kept) | 9 total (7 new, 2 kept) |
| Callout kinds | None of the three needed; only pre-existing plain `callout-note` (vocabulary box, exempted) and the honest-level box remained | One Verification (beside the existing baseline-test table), one Pitfall (the same-session-check anti-pattern), one Restricted data (the LLM section's existing paragraph, reboxed) |
| Cohort, continued | New: `load_cohort()`/`clean_cohort()` on the real extract, states the compendium sits at L0 today (no `renv.lock`, no `Dockerfile` exist yet) | Judged already satisfied by the existing baseline-test passage; no new section added, per the brief's efficiency guidance |
| Honest level | Cut to one sentence (what the new cohort passage itself reaches) | Cut to one sentence (this chapter's own tested scope) |
| LLM section | Untouched (Decision D5) | Untouched except the restricted-data paragraph, reboxed with no substance change |
| Exercises | Added 7 (cumulative, cohort `nrow`, autogradable) and 8 (spacing, revisits Chapter 1's R 3.6.0 sampler fact) | Added 7 (cumulative, five data-validation assertions on the cohort) and 8 (spacing, revisits version control and habit 1) |
| Cheat sheet | Added, 8 rows | Added, ~11 rows |
| Further reading | Unchanged | Unchanged |

Independent verification, beyond the agents' own reports: both
chapters re-rendered standalone by the lead after the agents
finished (clean, no errors); both figures' computed alt text
checked against their `captures`/`validates` arguments in the
rendered HTML; ch02's cohort-passage row counts (338 raw, 337
cleaned) and its Exercise 8 solution's layer/rung claim (R runtime
secures at L2, not unpinned) reproduced independently; ch08's
Exercise 7 solution's five assertions and three counts all run and
confirmed true. One transient false alarm during verification: a
mid-run test-suite check showed 1 failure (08 had new exercises
without matching solutions yet); this was the ch08 agent's
work-in-progress state caught by concurrent polling, not a defect in
either agent's finished work, and resolved once both agents
finished. The repository's `test-manuscript-invariants.R` grew with
no changes needed, since it checks exercise/solution counts and
check/answer pairing generically, not specific chapter content.

Render: freeze cleared for both converted chapters; HTML and PDF
exit 0, no warnings, no unresolved references or missing citations,
no literal HTML entities [V]. PDF 456 pages (440 before Phase 9).
Repository test suite 204/204 (up from 185, all new assertions from
the two chapters' new material).

Not done in Phase 9's prototype step: the template is applied to
exactly two chapters, as scoped. Every other numbered chapter still
used the pre-revision structure at that point. 'Two numbering
schemes, and which this book uses' (ch02) was judged not redundant
with the new material and left untouched, a judgment call the
author may want to revisit.

**Phase 9 continued, book-wide rollout batch 1, 2026-10-11.** The
author approved a book-wide rollout at the prototype checkpoint.
Per the plan's standing rule (checkpoint after the first batch, with
a length report), this batch converts the remaining three chapters
of Part I, Foundations: 01-reproducibility-crisis, version-control,
03-research-compendium. Branch `phase-9-template`, same branch as
the prototypes; one commit for this batch. All local; nothing
pushed.

| Item | Result | Evidence |
|---|---|---|
| ch01 stack figure | First draft used `validates` to mean 'demonstrates an unpinned layer is volatile', which is not what the term means elsewhere in the book (confirming a previously *captured* value, per ch02's own prose and the function's contract) | Caught by the lead, not the converting agent, which had itself flagged the stretch as uncertain; fixed to an honest empty/empty call (the chapter captures and validates nothing), which exposed a real grammar bug in `determinant_stack_alt()`'s all-empty case, also fixed; re-rendered clean [V] |
| `@sec-conventions` crossref | A second instance of the same unresolved-crossref defect found in Phase 9's prototype step, this time in version-control.qmd, introduced fresh by that chapter's converting agent | V lead: grepped the whole book after fixing, confirmed zero remaining instances; replaced with the same plain-link pattern |
| ch03 vacuous test | The converting agent fixed, beyond its assigned scope (optional per the brief), the long-standing 'no hazard ratio is negative' vacuous test (Finding 14/T2-14, open since the original audit), replacing it with a baseline comparison at a stated tolerance and keeping the old bound only as a named negative example | V lead: read the passage in context, confirmed it is now used correctly as a contrast, not as the chapter's actual test |
| Cohort row counts, file-existence checks | ch03's Five Pillars check (338 raw, 337 cleaned, 1 duplicate; `.Rprofile` present, `renv.lock` and `Dockerfile` absent) and version-control's PHI-column check (`mrn`, `patient_name`, `dob` all present) | V lead, reproduced independently, both exact |
| Chapter numbering citations | ch01's agent confirmed, by rendering, that 00-intro is Chapter 1 and 01-reproducibility-crisis is Chapter 2; version-control's agent confirmed version-control itself is Chapter 4 and ch02 (sec-levels) is Chapter 3, before writing spacing-exercise cross-references | A-V both; V lead reproduced version-control's chapter-4 claim independently |

Render: freeze cleared for all three chapters; HTML and PDF exit 0,
no warnings, no unresolved references or missing citations, no
literal HTML entities [V]. Repository test suite 231/231 (up from
204).

**Length report.** PDF is now 484 pages, up from 456 before this
batch (+28 pages, +6.1%) and from 440 before Phase 9 began (+44
pages, +10.0%). Measured from the pre-Phase-6 baseline of 398 pages
(REFACTOR-PLAN Section 10.3), the book is now 484 pages, +21.6%,
which crosses the plan's 20 percent length-growth checkpoint
threshold (10.6 house rules notwithstanding, Decision D10 already
chose 'accept growth' over holding net prose within 5 percent, so
this is reported, not treated as a stop). The growth is concentrated
in the five chapters now carrying the full template (chapter card,
a new figure, up to 9 folded Checks, two new exercises each, a
cheat sheet): this is template overhead applying to every remaining
chapter, not a one-time cost, so the full-book total after all 13
chapters are converted will be materially higher than a linear
extrapolation from 5 of 13 chapters might suggest.

Not done: 7 chapters remain on the pre-revision structure
(04-dependencies, 05-containers, 06-backends-runtimes,
07-literate-programming, pipelines, 09-continuous-integration,
10-archiving-sharing). 10-archiving-sharing also holds the closing
`_habits.qmd` include and the book's final 'In conclusion' section,
which its converting agent will need to handle carefully to avoid
disturbing either.

**Phase 9 rollout batch 2, 2026-10-11.** Part II, Capturing the
Environment: 04-dependencies, 05-containers, 06-backends-runtimes.
Same branch, one commit.

| Item | Result | Evidence |
|---|---|---|
| Stack figures | ch04 `captures = c('Package versions')`; ch05 and ch06 both `captures = c('Operating system, system libraries', 'R runtime')`, the same L2 rung reached by different routes, which ch06's fig-cap states explicitly | V lead: all three alt texts reproduced exactly from the rendered HTML |
| `@sec-conventions` crossref | A third instance of the same unresolved-crossref defect, this time in 06-backends-runtimes.qmd | V lead: fixed with the same plain-link pattern; grepped the whole book afterward, zero remaining instances across all 13 chapters |
| Cohort passages | ch04: `renv::dependencies()` run for real on `R/cohort.R` and the generator, showing `tibble` as the only contributed (non-base) dependency; ch05 and ch06: `file.exists()` checks on `Dockerfile`/`renv.lock`/`default.nix`/`.devcontainer/devcontainer.json` at the repo root | V lead: reproduced the base-versus-contributed distinction (`stats`/`utils` are base, `tibble` is not) and all four file-existence checks exactly |
| ch05 Exercise 7 | Cumulative, autogradable: cohort row count (337), distinct sex codes (2), `Dockerfile` existence (false) | V lead, reproduced exactly |
| Chapter-numbering inconsistency (new finding) | ch05's converting agent found the book's own chapters disagree with each other about which chapter number names which: ch02 calls ch01 'Chapter 1' while ch01 claims that number itself; ch03 calls ch02 'Chapter 2' while version-control calls it 'Chapter 3'. Each agent derives its own chapter's number correctly from the rendered build but does not reconcile cross-chapter citations, since no single agent owns more than its own file | Not fixed; flagged for a dedicated consistency pass (candidate for Phase 12, restructure) before any further spacing-exercise cross-references are added in later batches |

Render: freeze cleared for all three chapters; HTML and PDF exit 0,
no warnings, no unresolved references or missing citations, no
literal HTML entities [V]. Repository test suite 260/260 (up from
231).

**Length report.** PDF is now 514 pages, up from 484 before this
batch (+30 pages, +6.2%). Since before Phase 6: 398 to 514 pages,
+29.1%. 8 of 13 chapters now carry the full template.

### 10.16 Limitations

- **The expert reviewers are simulated personas,** not people. Their
  judgments of adoption, course load, and what a profession expects
  are informed opinions, not evidence. Human second readers are
  needed for the regulatory, restricted-data, and statistical
  chapters before any catalog listing.
- **No Docker image was built and no CI service was run.** Findings
  14 and 13 rest on source reading, documentation, local analogs,
  and toy packages. Phase 6 must build the Dockerfile.
- **Several primary sources could not be opened:** the ACM badging
  page, some Nature, Springer, SAGE, COPE, and HHS pages,
  softwareheritage.org (certificate error), and Posit release notes.
  Claims depending on them are labeled [U] or [EK] and are scheduled
  for Phase 14.
- **Coverage breadth counts are lower bounds.** Of 30 syllabi, the
  agent re-opened 7; 23 were opened by helper agents and not
  re-checked. Asia is effectively unrepresented (no open graduate
  syllabus found). The syllabi agent launched three helper agents of
  its own, exceeding the intended concurrency; its results are
  retained with that caveat.
- **The lead reviewer did not read every chapter in full.** The
  readings were done by agents; the lead verified the Tier 1 items
  and a sample of Tier 2 items as labeled.
- **The renders reused the freeze cache** and do not show that the
  executed code runs on today's library.
- **Length estimates after cuts and additions are inferred,** not
  measured.

### 10.17 Defects outside the book

These are in the author's other repositories. They are listed here
because the book's correctness depends on them; they are not edited
by this plan.

| Repository | Location | Defect | Evidence |
|---|---|---|---|
| zzcollab | `modules/verify.sh:238-266` | L3 stamped without baseline comparison | I |
| zzcollab | `templates/Makefile:341` | `docker-test` exits 0 on test failure | V (runner), I |
| zzcollab | `docker.sh:900-904` | `get_ubuntu_codename` maps R 4.4 to noble | A-I |
| zzcollab | generated Dockerfile | `OMP_NUM_THREADS` never set, though the book says it is | A-I |
| zzcollab | CI template | tests run with `continue-on-error` | A-I |
| zzcollab | RStudio target | listens on all interfaces with a fixed printed login | A-I |
| zzrenvcheck | `R/compare.R:70` | `error_on_fail = FALSE` default makes the CI gate unable to fail | I |
| zzrenvcheck | `R/autofix.R:162-170` | auto-fix writes CRAN-current versions into `renv.lock` | I |
| zzrenvcheck | archetype handling | no archetype exemption, contrary to `04:386-395` | A-V |

Supporting reports (scratchpad, not committed): four chapter
readings, three persona reviews, learning science and model-book
comparison, LLM sections, three coverage sweeps, the structural
scan, and the working register.

## 11. Appendix: reproducing the measurements

From the repository root. Chapter list, taken from the `chapters:`
block of `analysis/report/_quarto.yml`, excluding front matter and
boilerplate:

```
00-intro 01-reproducibility-crisis 02-levels-of-reproducibility
version-control 03-research-compendium 04-dependencies 05-containers
06-backends-runtimes 07-literate-programming pipelines
08-testing-quality 09-continuous-integration 10-archiving-sharing
```

Per-chapter counts, run inside `analysis/report/`:

```bash
for f in $CH; do
  q="$f.qmd"
  words=$(wc -w < "$q")
  exer=$(awk '/^## Exercises/,/^## Further reading/' "$q" \
    | grep -cE '^[0-9]+\.')
  exec=$(grep -cE '^```\{r' "$q")
  disp=$(grep -cE '^```(r|bash|sh|yaml|json|docker|nix|makefile)$' "$q")
  chk=$(grep -ciE '^## Check your understanding' "$q")
  ans=$(grep -ciE '^## Answer' "$q")
  echo "$f $words $exer $exec $disp $chk $ans"
done
```

Section-level counts, with the boilerplate heading list derived from
`grep -h '^## ' *.qmd | sort | uniq -c | sort -rn`:

```awk
/^## / {
  if (insec) { totsec++; if (hascode) codesec++ }
  insec = 1; hascode = 0
  if ($0 ~ /^## (Learning objectives|Exercises|Further reading|Answer|Check your understanding)/) insec = 0
  next
}
/^```[a-z]/ { if (insec) hascode = 1 }
/^```\{r/   { if (insec) hascode = 1 }
END { if (insec) { totsec++; if (hascode) codesec++ }
      printf "%s %d %d\n", FILENAME, totsec, codesec }
```

Figures, counted from rendered output rather than from labels, because
`07-literate-programming.qmd` prints figure syntax as an illustration:

```bash
find analysis/report/_book -name '*.png' | grep figure-html
```

License declarations:

```bash
cat LICENSE
grep -i '^License' DESCRIPTION
grep -i '^license' CITATION.cff
grep -n -A6 -i '^## License' analysis/report/index.qmd
grep -n -i 'licensed under' analysis/report/copyright.qmd
```

Table of contents, per output format:

```bash
grep -n 'toc' analysis/report/_quarto.yml
grep -n 'tableofcontents' analysis/report/*.qmd
```

Bibliography recency:

```bash
grep -ohE 'year *= *\{?[0-9]{4}' analysis/report/references.bib \
  | grep -oE '[0-9]{4}' | sort -n | uniq -c
```

---
*Rendered on 2026-10-11 at 10:28 PDT.*<br>
*Source: ~/prj/tch/12-reproducibility/REFACTOR-PLAN.md*
