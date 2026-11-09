# Phase 25, Agent 4: quotations and claims about the literature
*2026-11-08 16:58 PST*

Scope: the 13 epigraphs, every attributed inline quotation found by a
paragraph-level scan of `analysis/report/*.qmd` (script:
`scratchpad/p25/a4/quotes.py`), and the literature and history claims
in the evidence sections of Chapters 1 and 2 and their echoes. All
sources were opened on 2026-11-08. Downloaded copies are under
`scratchpad/p25/a4/dl/`. No repository file was edited.

Evidence key: V = I opened the original and compared the words;
V-r = compared against a reprint or author copy, not the publisher
page; P = partly verified.

## 1. Claims table

| id | file:line | claim | status | source | evidence |
|---|---|---|---|---|---|
| E1 | 00-intro:7-14 | Buckheit and Donoho epigraph, 'paraphrasing Jon Claerbout', 1995 | verified (V-r) | web.stanford.edu/dept/statistics/cgi-bin/donoho/wp-content/uploads/2018/08/wavelab.pdf | Both sentences are word for word. The original introduces them as 'we can distill Claerbout's insight into a slogan', so 'paraphrasing' is fair. Not abridged. |
| E2 | 01-crisis:7-12 | Baker 2016, 'More than 70% ... their own experiments.' | verified (V) | nature.com/polopoly_fs/1.19970!/menu/main/topColumns/topLeftColumn/pdf/533452a.pdf | This is the article's opening sentence, verbatim. The print headline is 'Is there a reproducibility crisis?'; the bib uses the online title, which is also correct (Crossref). |
| E3 | 02-levels:7-12 | Peng 2011 epigraph | verified (V) | Europe PMC abstract, DOI 10.1126/science.1213847; NCBI efetch PMC3383002 | The abstract's second sentence, verbatim. |
| E4 | 03-compendium:7-14 | Marwick, Boettiger, Mullen 2018 epigraph | **corrected** | faculty.washington.edu/bmarwick/PDFs/Marwick-Boettiger-Mullen-2018-TAS-research-compendia.pdf (publisher PDF) | The original reads 'organising'; the book has 'organizing'. The sentence opens Section 1. Not abridged. |
| E5 | 04-deps:7-13 | Sandve et al., Rule 3 sentence | verified (V) | journals.plos.org XML, 10.1371/journal.pcbi.1003285 | This is the first sentence under 'Rule 3: Archive the Exact Versions of All External Programs Used', verbatim. |
| E6 | 05-containers:7-14 | Boettiger 2015 epigraph, 'straight forward' | verified (V) | Crossref abstract for 10.1145/2723872.2723882; arXiv:1410.0846v1 | Verbatim in both versions, including the two-word 'straight forward'. Do not 'fix' it. |
| E7 | 06-backends:7-13 | Kurtzer, Sochat, Bauer 2017 epigraph | verified (V) | PLOS XML, 10.1371/journal.pone.0177459 | Abstract sentence, verbatim. |
| E8 | 07-literate:7-14 | Knuth 1984 epigraph | verified (V-r) | literateprogramming.com/knuthweb.pdf | Verbatim, including the capital 'Instead' after the colon. Year and journal match Crossref. |
| E9 | 08-testing:7-11 | Dijkstra, *Notes on Structured Programming* (1972) | verified (V) | cs.utexas.edu/~EWD/transcriptions/EWD02xx/EWD249/EWD249.html; 1972 book chapter, informatik.uni-bremen.de/.../EWD-notes-structured.pdf | Verbatim in both, preceded by 'Corollary of the first part of this section:'. The 1972 date is the book; EWD249 circulated in 1969 to 1970. No bib entry exists (optional entry below). |
| E10 | 09-ci:7-11 | Sandve Rule 10 title | verified (V) | PLOS XML | 'Rule 10: Provide Public Access to Scripts, Runs, and Results'. |
| E11 | 10-archiving:7-12 | Wilkinson et al. 2016 epigraph | verified (V) | nature.com/articles/sdata201618 | Abstract sentence, verbatim. |
| E12 | pipelines:7-11 | Sandve Rule 2 title | verified (V) | PLOS XML | 'Rule 2: Avoid Manual Data Manipulation Steps'. |
| E13 | version-control:7-14 | Ram 2013 epigraph | verified (V) | scfbm.biomedcentral.com/articles/10.1186/1751-0473-8-7 | Abstract sentence, verbatim. |
| Q1 | 00-intro:85-88 | Peng inline quotation | verified (V) | as E3 | Now matches the epigraph. Persona-ms item resolved. |
| Q2 | 03-compendium:788 | NHS RAP baseline README criterion | verified (V) | nhsdigital.github.io/rap-community-of-practice/introduction_to_RAP/levels_of_RAP/ | Verbatim. |
| Q3 | 03-compendium:848-851 | Template README sections 'Computational requirements', 'List of tables and programs' | verified (V) | raw template-README.md, social-science-data-editors/template_README | Both are `##` headings in the template. |
| Q4 | 05-containers:941; setup:50 | Docker, 'can be much slower than native builds, especially for compute-heavy tasks' | verified (V) | docs.docker.com/build/building/multi-platform/ | Verbatim in the current page note. |
| Q5 | 08-testing:1475-1480 | 21 CFR 11.10(a) quotation | verified (V) | ecfr.gov renderer, title 21 part 11 section 11.10 | 'discern' is now correct (the Phase 19-24 fix holds). |
| Q6 | version-control:850 | 21 CFR 11.10(e) | verified (V) | as Q5 | Verbatim. |
| Q7 | 09-ci:735-737 | GitHub, 'should never be stored as plaintext in workflow files' | **corrected** (citation) | docs.github.com/en/actions/reference/security/secure-use (the `githubhardening` URL redirects here); github/docs `content/actions/reference/security/secure-use.md` | The wording is verbatim. It sits on the hardening (secure-use) page, not the secrets page: the `githubsecrets` URL now redirects to `.../use-secrets`, which does not contain it. |
| Q8 | 10-archiving:642 | FAIR R1.1, 'a clear and accessible data usage license' | verified (V) | as E11 | Verbatim. |
| Q9 | pipelines:247 | 'avoid manual data manipulation steps' | verified (V) | as E12 | Rule 2 title in lower case, acceptable. |
| L1 | 01-crisis:442-444; 466; 1446-1449 | The NAS report 'add[s] a third, *robustness*' | **corrected** | nationalacademies.org/read/25303/chapter/3 and /chapter/6; book.the-turing-way.org/reproducible-research/overview/overview-definitions | NAS defines reproducibility, replicability and *generalizability*. 'Robust' occurs only in passing (rigor; the NSF report title). The 'robust' definition (same data, different analysis) is the Turing Way's. Resolves reader-a [U]. |
| L2 | 00-intro:98-100; 01-crisis:339-342 | OSC 'could replicate only 39 of 100' | hedged | Europe PMC abstract, 10.1126/science.aac4716 | 39% were 'subjectively rated to have replicated'. Only 36% of replications reached significance. A biostatistics reader will ask which criterion. |
| L3 | 00-intro:101; 01-crisis:342-346 | Begley and Ellis, 6 of 53 | verified (V) | nature.com/articles/483531a | 'scientific findings were confirmed in only 6 (11%) cases'. |
| L4 | 01-crisis:353-359 | Baker: over 1,500 surveyed, majority see a crisis, over 70% failed | verified (V) | as E2 | 1,576 surveyed; 52% 'significant crisis', 38% 'slight'. |
| L5 | 00-intro:107-110; 01-crisis:369-374 | Trisovic: over 9,000 R files, Harvard Dataverse, about one in four ran | verified (V) | nature.com/articles/s41597-022-01143-6 | 9,078 R files in 2,109 packages. 74% failed initially (56% after cleaning). Outputs were not compared. |
| L6 | 01-crisis:608-611 | Churn plus missing files and paths, 'tested years after the original deposit' | hedged | as L5 | Library, version, file and path errors are all reported (reader-a #41 verified). Deposits span 2010 to July 2020 and were re-run in 2020, so 'years after' holds for many deposits but not all. |
| L7 | 00-intro:110-114; 01-crisis:374-380; 00-intro:134,146 | Saju: 'about a quarter of the projects ran to completion'; about 99% lacked dependency files | **corrected** | arxiv.org/abs/2505.21590 and arxiv.org/html/2505.21590 | 25.87% of 460 *scripts* succeeded, after an automated pipeline rebuilt their environments. Only 40 of 249 *projects* (16.06%) ran in full. The 98.8% figure (261 of 264) is correct. |
| L8 | 01-crisis:512-516 | Claerbout, early 1990s, every figure regenerable 'by a single command' [@claerbout1992] | hedged | as E1 (Section 3.1) | Buckheit and Donoho date the project to 1990 and describe CD-ROM *books* whose figures can be burned and rebuilt. I could not open claerbout1992 (SEG returns 403), so 'single command' and 'papers' are unchecked. |
| L9 | 01-crisis:528-531 | Peng: reproducibility 'is a minimum standard' when replication is 'impractical' | hedged | as E3 | Peng: 'has the potential to serve as'; 'not possible' (abstract) and 'not feasible' (body). This is a paraphrase without quotation marks, but it drops the modal. |
| L10 | 08-testing:2531-2535 | Peng: why reproducibility 'is a minimum scientific standard' | hedged | as E3 | Same modal as L9. Reader-d m12 and persona-ms #44 concern a sentence no longer present at 2148. |
| L11 | 00-intro:81-84; 01-crisis:524-528 | Peng spectrum: published, code, code and data, linked and executable, full replication | partly verified (P) | NCBI efetch PMC3383002 (body text); figure labels only through a search snippet of an OCR copy | The body confirms a spectrum between 'full replication' and 'no replication'. The figure labels ('Publication only', 'Publication + Code', 'Code and data', 'Linked and executable code and data', 'Full replication') come from the snippet only. No quotation marks are used, so no change. |
| L12 | 09-ci:1473-1475; 09-ci:2584-2587 | Sandve's ten rules 'place independent re-execution' (and 'automated checking') among the recommendations | **corrected** | as E5 (all ten rule titles read) | No rule recommends independent re-execution or automated checking. Rule 2 (automate), Rule 10 (public access) and others make re-execution possible. |
| L13 | 08-testing:2518-2522 | Sandve rules 'situate readable code' | hedged | as E5 | No rule concerns code readability. Recorded results (Rules 1, 5, 7) are covered. |
| L14 | 10-archiving:1187-1191 | Stodden: 'mere existence of a policy is a weak predictor' | hedged | Europe PMC abstract, 10.1073/pnas.1708290115 | The study sampled 204 *Science* papers under one policy. It obtained artifacts for 44% and reproduced 26%, calling the policy 'an improvement over no policy, but currently insufficient'. It is not a predictor analysis. |
| L15 | 03-compendium:340-358 | Marwick et al.: R package as compendium, top-level `analysis/`, rrtools; Nust et al. reading guide | verified (V), with spelling fix | as E4 | The paper places scripts and reports in `analysis/` and introduces rrtools. The text spells the name 'Nust'; it is Nüst (bib and 05-containers:503). |
| L16 | 01-crisis:350-353 | Ioannidis: power, flexibility, bias, 'most ... are false' | verified (V) | Europe PMC abstract, 10.1371/journal.pmed.0020124 | Consistent with the abstract. |
| L17 | 01-crisis:430-434 | Goodman et al.: the same words carry opposite meanings across fields | unverified (abstract only) | Europe PMC abstract, 10.1126/scitranslmed.aaf5027 | The abstract says only 'nonstandard and unsettled'. Full text is paywalled. |
| L18 | 00-intro:74-77 and elsewhere | Leek and Peng: reproducible can be wrong; 'floor not ceiling' | P | NCBI efetch PMC4330755 (front matter only) | Title confirmed. 'Floor' is the book's phrase, unquoted, and the body text was not available. |
| B1 | references.bib:234-242 | `buckheit1995` typed `@article`, journal 'Wavelets and Statistics' | corrected (bib) | Crossref: type book-chapter, Lecture Notes in Statistics, Springer New York | The entry renders as a journal article with volume 103. |
| B2 | references.bib, all quoted entries | Titles against Crossref | verified (V) | api.crossref.org for 13 DOIs | All titles match. No quoted-source title contains British spelling. 'Generalisable' appears only in the Turing Way page, which is not quoted. |
| X1 | all chapters | Duke/Potti, I4R, other replication counts | not present | grep for Potti, Baggerly, I4R, 'Institute for Replication', Reinhart, Herndon, Pimentel | No mentions found; nothing to verify. |

## 2. Replacement blocks

### E4 03-research-compendium.qmd
OLD:
```
can be a suitable template for organizing files into a
```
NEW:
```
can be a suitable template for organising files into a
```
(The CLAUDE.md rule keeps British spelling inside verbatim quotations.)

### Q7 09-continuous-integration.qmd
OLD:
```
workflow files' [@githubsecrets]. A workflow instead
```
NEW:
```
workflow files' [@githubhardening]. A workflow instead
```
(`githubhardening` exists at references.bib:1076. Its URL redirects to
'Secure use reference', which holds the sentence under 'Mask sensitive
data'.)

### L1a 01-reproducibility-crisis.qmd
OLD:
```
of a scientific finding. To these two the report and
the wider literature add a third, *robustness*,
```
NEW:
```
of a scientific finding. To these two the wider
literature, notably the Turing Way [@turingway2022],
adds a third, *robustness*,
```

### L1b 01-reproducibility-crisis.qmd (fig-cap, line 466)
OLD:
```
The grid presentation follows the Turing Way [@turingway2022]; the definitions are those of the National Academies [@nas2019] adopted above.'
```
NEW:
```
The grid and the robustness cell follow the Turing Way [@turingway2022]; the definitions of reproducibility and replicability are those of the National Academies [@nas2019] adopted above.'
```

### L1c 01-reproducibility-crisis.qmd
OLD:
```
  [@nas2019] is the authoritative source for the
  reproducibility, replicability, and robustness
  distinctions, and repays reading in full for the
```
NEW:
```
  [@nas2019] is the authoritative source for the
  distinction between reproducibility and replicability,
  and repays reading in full for the
```

### L2a 00-intro.qmd
OLD:
```
grim. In psychology, the Open Science Collaboration could
replicate only 39 of 100 studies it re-ran
[@opensciencecollaboration2015].
```
NEW:
```
grim. In psychology, the Open Science Collaboration's
teams judged only 39 of 100 replications successful
[@opensciencecollaboration2015].
```

### L2b 01-reproducibility-crisis.qmd
OLD:
```
re-ran one hundred published studies and could
replicate the original finding in only thirty-nine of
them [@opensciencecollaboration2015].
```
NEW:
```
re-ran one hundred published studies. Its teams judged
the original finding replicated in only thirty-nine of
them, and only thirty-six percent of the replications
reached statistical significance
[@opensciencecollaboration2015].
```

### L6 01-reproducibility-crisis.qmd
OLD:
```
deposited R scripts did not run when tested years after
the original deposit [@trisovic2022].
```
NEW:
```
deposited R scripts did not run when re-executed, often
years after the original deposit [@trisovic2022].
```

### L7a 00-intro.qmd
OLD:
```
Framework, found that only about a quarter ran to
completion. They also found that the vast majority carried
no description of their dependencies at all.
```
NEW:
```
Framework, found that only about a quarter of the R
scripts ran without error, even after an automated
pipeline rebuilt their environments. They also found that
nearly every project carried no description of its
dependencies at all.
```

### L7b 01-reproducibility-crisis.qmd
OLD:
```
the Open Science Framework. They found that only about a
quarter of the projects ran to completion, and that
the great majority, close to ninety-nine percent,
carried no formal description of their dependencies at
all [@saju2025].
```
NEW:
```
the Open Science Framework. Only about a quarter of the
R scripts ran without error, even in environments the
authors rebuilt, and only one project in six ran in
full. Close to ninety-nine percent of the projects
carried no formal description of their dependencies at
all [@saju2025].
```

### L7c 00-intro.qmd (optional; 25.87 rounds to 26)
OLD:
```
  rate = c(39, 11, 26, 25),
```
NEW:
```
  rate = c(39, 11, 26, 26),
```
If adopted, also change 'Saju and colleagues at about 25 percent' in the
fig-alt at line 134 to 'about 26 percent'.

### L8 01-reproducibility-crisis.qmd
OLD:
```
early 1990s they built their published papers so
that every figure could be regenerated from the
archived code and data by a single command
[@claerbout1992]. Their standard was demanding. The
```
NEW:
```
early 1990s they built their books and reports so
that every figure could be rebuilt from the archived
code and data [@claerbout1992; @buckheit1995]. Their
standard was demanding. The
```

### L9 01-reproducibility-crisis.qmd
OLD:
```
replicable. He argued that reproducibility is a minimum
standard for judging a scientific claim when full
independent replication is impractical [@peng2011;
```
NEW:
```
replicable. He argued that reproducibility can serve as a
minimum standard for judging a scientific claim when full
independent replication is not possible [@peng2011;
```

### L10 08-testing-quality.qmd
OLD:
```
clearest short statement of why reproducibility is a
minimum scientific standard when full independent
```
NEW:
```
clearest short statement of why reproducibility can serve
as a minimum scientific standard when full independent
```

### L12a 09-continuous-integration.qmd
OLD:
```
deposition and checking [@stodden2018]. The ten-rules
literature, for its part, places independent re-execution
among its recommendations [@sandve2013].
```
NEW:
```
deposition and checking [@stodden2018]. The ten rules,
for their part, ask for automated steps and public access
to scripts, runs, and results, which is what makes
independent re-execution possible [@sandve2013].
```

### L12b 09-continuous-integration.qmd
OLD:
```
rules of Sandve and colleagues [@sandve2013] place
automated checking and independent re-execution among their
recommendations. They also connect the mechanics of CI to
```
NEW:
```
rules of Sandve and colleagues [@sandve2013] ask for
automated steps and public access to scripts, runs, and
results, the preconditions of independent re-execution.
They also connect the mechanics of CI to
```

### L13 08-testing-quality.qmd
OLD:
```
compact, rule-by-rule form, and situate readable code
and recorded results within a general reproducibility
discipline.
```
NEW:
```
compact, rule-by-rule form, and situate version control
and recorded results within a general reproducibility
discipline.
```

### L14 10-archiving-sharing.qmd
OLD:
```
colleagues examined the effectiveness of journal
reproducibility policies. They found that the mere
existence of a policy is a weak predictor of an actually
reproducible artifact [@stodden2018]. A gap between the
```
NEW:
```
colleagues tested a journal policy requiring code and
data on request. They obtained artifacts for 44 percent
of 204 articles and reproduced the findings of 26 percent
[@stodden2018]. A gap between the
```

### L15 03-research-compendium.qmd
OLD:
```
package. Nust, Boettiger, and Marwick later wrote a
```
NEW:
```
package. Nüst, Boettiger, and Marwick later wrote a
```

## 3. For the lead (BibTeX)

B1, a replacement for `buckheit1995` (key unchanged). DOI checked:
`curl -sI https://doi.org/10.1007/978-1-4612-2544-7_5` returns 302 to
link.springer.com. Crossref gives type book-chapter, Springer New
York, ISBN 9780387945644. It lists no editors, so I give none.

```
@incollection{buckheit1995,
  title     = {WaveLab and Reproducible Research},
  author    = {Buckheit, Jonathan B and Donoho, David L},
  booktitle = {Wavelets and Statistics},
  series    = {Lecture Notes in Statistics},
  volume    = {103},
  publisher = {Springer},
  address   = {New York},
  year      = {1995},
  pages     = {55--81},
  doi       = {10.1007/978-1-4612-2544-7_5}
}
```

This entry is optional. The Dijkstra epigraph is the only one with no
bib entry. The book chapter I opened is headed 'I. Notes on Structured
Programming, Edsger W. Dijkstra'. The book details below are standard
and are not taken from that scan. There is no DOI.

```
@incollection{dijkstra1972,
  title     = {Notes on Structured Programming},
  author    = {Dijkstra, Edsger W.},
  booktitle = {Structured Programming},
  editor    = {Dahl, O.-J. and Dijkstra, E. W. and Hoare, C. A. R.},
  publisher = {Academic Press},
  address   = {London},
  year      = {1972}
}
```

The `stodden2018` note field reads '50-89% of studies fail
replication'. That is wrong (the paper reports 26% reproduced). It does
not render in `_book` (grep found no match). Delete it anyway.

## 4. Not verified, and why

- Claerbout and Karrenbach 1992 (L8): library.seg.org returns 403, so
  'single command' rests on Buckheit and Donoho's secondary account.
- Peng 2011 figure labels (L11): PMC and science.org were blocked, and
  the figure text exists only as an image. The labels come from a
  search-engine snippet of an OCR copy.
- Leek and Peng 2015 body (L18): NCBI efetch returned front matter
  only, and PNAS returned 403.
- Goodman et al. 2016 'opposite meanings' (L17): paywalled; I read the
  abstract only.
- Knuth (E8) and Buckheit and Donoho (E1) were compared against an
  author-hosted reprint, not the publisher PDF. Both match Crossref
  metadata.
- I did not check the reader-b rrtools lockfile claim; it concerns a
  tool, not a quotation.

## Message to the lead

All 13 epigraphs and 9 inline quotations were checked against
originals. Twelve epigraphs are verbatim and unabridged. The Marwick
epigraph must read 'organising', as published (E4). The GitHub
plaintext quotation is accurate, but it belongs to `githubhardening`,
not `githubsecrets` (Q7).

The literature claims had four real errors:

- the NAS report does not define robustness; the Turing Way does (L1);
- Saju's quarter counts scripts, not projects, and only 16 percent of
  projects ran in full (L7);
- Sandve's rules never recommend independent re-execution (L12);
- Stodden reports 26 percent reproduced, not a predictor analysis
  (L14).

The hedges on OSC (39 subjective, 36 significant), Peng's 'can serve
as', and Claerbout's 'single command' are minor but cheap to make.
Duke/Potti and I4R do not appear in the book.
