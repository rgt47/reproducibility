# Refactoring Plan: *Reproducible Research for the Health Sciences*
*2026-09-07 18:38 PDT*

## 0. Status

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
- **Epistemic status by finding.** Findings 1, 3, 4, 5, 6, 8, and 9
  rest on counts that were verified by running commands and reading
  their output, with the figure count cross-checked against the
  rendered output directory rather than against labels. Finding 2's
  count of 54 is verified; its claim about which blocks are
  convertible is inferred from inspecting two chapters. Finding 7 is
  verified. Finding 10 is inspected, not tested.

## 9. Appendix: reproducing the measurements

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
*Rendered on 2026-09-08 at 18:32 PDT.*<br>
*Source: ~/prj/tch/12-reproducibility/REFACTOR-PLAN.md*
