# Coverage review: comparable course syllabi
*2026-11-07, third review, syllabi researcher*

## Summary

1. I opened and extracted topic lists from 26 courses: 15 North American, 2 UK, 7 continental European, 1 Australian, 1 Asian. Australia/NZ and Asia gave almost nothing I could open; Auckland's outlines are behind SSO, and I found no NUS, Tokyo, KAIST or similar syllabus.
2. The book's core (git, literate programming, dependency locking, containers, pipelines, testing, CI, archiving) is covered as deeply as in any syllabus I found, and more deeply than in most. Containers appear in only 7 of 26 courses and CI in 5; the book teaches both at length.
3. The largest gap is R package tooling: 12 of 26 courses teach package development, but the book, whose compendium *is* a package, never mentions `devtools` or `usethis` (grep: 0 hits).
4. Smaller gaps that recur across syllabi: named forensic case studies of irreproducibility (3), citation management in Quarto (4), code review as a practice (5), and GitHub Issues/project management (3).
5. My ranked additions total about 9 to 11 pages. Most other syllabus topics (Python, Shiny, SQL, web data, figure design, general programming) are correctly out of scope.

## Method and evidence status

- **Search.** WebSearch, then WebFetch on each candidate page, between 2026-11-07 and the time of writing. I list only courses whose page I actually opened and from which I got a topic list.
- **Extraction caveat.** WebFetch returns a summary written by a smaller model, not raw HTML. Topic lists are therefore [I] with that caveat. The one exception is HKU EDUR7102: I downloaded the PDF and read it with `pdftotext` [I, direct].
- **What 'breadth' means.** Breadth counts the 26 courses whose extracted list names the topic. It is a lower bound, because summaries drop items. Search-result snippets I did not confirm on an opened page are not counted.
- **How book coverage was checked.** I grepped `analysis/report/*.qmd` for each term (script: `work-cov-syllabi/grep_terms.sh`, `grep_lines.sh`). A grep hit is a structural check. Wherever I cite a line as 'covered', I read the surrounding text [I].
- **Mix of course types.** Not all 26 are reproducibility courses in name. About half are graduate statistical-computing or data-science courses in biostatistics or public health that contain a reproducibility block (JHU, Harvard, Michigan, UW, Toronto, UMass, Duke, UNC). I kept them because they are the courses this book would sit beside or replace in a health-sciences department. Three are non-credit PhD-level workshops (NBIS, SISBID, r-cubed). One is in geography (McMaster), one in business (HVL), one in education (HKU). All are labeled.

### Courses I tried but could not use

- Columbia P8105: the syllabus URL I tried returned 404; catalog pages give no topics [U].
- Auckland STATS 769: course outlines redirect to SSO; the department page says 'Access restricted' [U].
- Emory SISMID 'Hitchhiker's Guide to Reproducible Research': 404 on both URLs [U].
- Karolinska 'Open Science and Reproducible Research' (2022): FORRT listing opened, but it has no topic list [U].
- JHU/Coursera 'Reproducible Research': classcentral returned 403, OCW returned DNS failure [U].
- University of Melbourne: only a non-credit Statistical Consulting Centre workshop surfaced, no handbook subject.
- NUS, HKU (other than EDUR7102), Tokyo, Kyoto, KAIST, SNU, Tsinghua, Duke Kunshan: no syllabus found in three searches.

## Course key (all accessed 2026-11-07)

| # | Course | Region | Level | URL opened |
|---|---|---|---|---|
| C1 | UW-Madison BMI 826, Tools for Reproducible Research (Broman, 2016) | NA | Grad | https://kbroman.org/Tools4RR/pages/schedule.html |
| C2 | UBC STAT 545, Data wrangling, exploration, analysis with R | NA | Grad | https://stat545.com/ |
| C3 | UBC DSCI 522, Data Science Workflows (MDS) | NA | Grad (professional MS) | https://ubc-mds.github.io/DSCI_522_dsci-workflows_students/ ; https://masterdatascience.ubc.ca/programs/vancouver/course-data-science-workflows-dsci-522 |
| C4 | Monash ETC5513, Collaborative and Reproducible Practices | ANZ | Grad (Master of Business Analytics) | https://rcp.numbat.space/ |
| C5 | UC Berkeley STAT 159/259 (Fall 2026) | NA | 259 grad | https://stat159.berkeley.edu/fall-2026/syllabus.html |
| C6 | Emory INFO550, Data Science Toolkit (Biostatistics) | NA | MS/PhD | https://benkeser.github.io/info550/syllabus |
| C7 | McMaster GEOG 712, Reproducible Research Workflow with GitHub and R | NA | Grad (geography) | https://www.github.com/paezha/Reproducible-Research-Workflow |
| C8 | SLU P000187, Reproducible Research in Bioinformatics and Comp. Biology | EU | PhD (third cycle) | https://www.slu.se/en/student-web/studies/courses-and-programmes/course-search/kurser/r/reproducible-research-in-bioinformatics-and-computational-biology/ |
| C9 | NBIS/SciLifeLab, Tools for Reproducible Research | EU | PhD workshop | https://training.scilifelab.se/courses/tools-for-reproducible-research |
| C10 | UNC BIOS 611, Introduction to Data Science (2019) | NA | Grad/UG | https://biodatascience.github.io/datasci611 |
| C11 | JHU 140.776, Statistical Computing | NA | ScM/PhD | https://lcolladotor.github.io/jhustatcomputing/schedule.html |
| C12 | JHU 140.777, Statistical Programming Paradigms and Workflows (2025) | NA | Grad | https://stephaniehicks.com/jhustatprogramming2025/lectures.html |
| C13 | UCL COMP0233, Research Software Engineering with Python | UK | PG | https://github-pages.ucl.ac.uk/rsd-engineeringcourse |
| C14 | Harvard BST 260, Introduction to Data Science (Fall 2025) | NA | Grad | https://datasciencelabs.github.io/2025/index.html |
| C15 | Michigan BIOSTAT 620, Introduction to Health Data Science (W26) | NA | Grad | https://dmcable.github.io/BIOSTAT620W26/syllabus.html |
| C16 | HVL MSB105, Data Science | EU | Master's (business) | https://www.hvl.no/en/studies-at-hvl/study-programmes/courses/MSB105 |
| C17 | Utrecht 202000010, Markup Languages and Reproducible Programming in Statistics | EU | MSc Methodology and Statistics | https://mlarpis.github.io/markup/overview.html |
| C18 | Glasgow, Data Skills for Reproducible Research (MSc course book v4) | UK | MSc (psychology) | https://psyteachr.github.io/reprores-v4/ |
| C19 | Duke STA 523, Programming for Statistical Science (Fall 2025) | NA | Grad | https://sta523-fa25.github.io/ |
| C20 | UW BIOST 561, Computational Skills for Biostatistics | NA | Grad | https://github.com/adw96/biostat561 |
| C21 | Toronto CHL5233H, Statistical Programming and Computation for Health Data | NA | Grad | https://www.dlsph.utoronto.ca/course/statistical-programming-and-computation-for-health-data/ |
| C22 | UZH STA472, Good Statistical Practice (HS2025) | EU | MSc Biostatistics (compulsory) | https://elearn2.mnf.uzh.ch/courses/course-v1:MNF+STA472+HS2025/about ; https://arxiv.org/html/2407.08835v1 |
| C23 | UMass BIOSTATS 632, Adv. Statistical Computing in Health Data Science (F23) | NA | Grad | https://www.fivecolleges.edu/courses/UM/2023/FALL/BIOSTATS/632/01 |
| C24 | SISBID 2017 Module 3, Reproducible Research (Baggerly, Broman) | NA | Summer institute | https://github.com/SISBID/Module3 |
| C25 | r-cubed Advanced Reproducible Research in R (Steno Aarhus / DDEA) | EU | PhD/researcher workshop | https://r-cubed-advanced.rostools.org |
| C26 | HKU EDUR7102, Statistical Computing and Data Analysis with R (2026-27) | Asia | PG (education) | https://gradsch.hku.hk/sites/default/files/content/4_current_students/coursework/course_information/cross-institutional_course_enrolment_scheme/2026_27/2026_27_Sem1/2026-27_S1_Cross%20U_Edu.pdf |

**Regional balance.** The sample leans heavily toward North America. Australia/NZ is represented only by Monash, and Asia only by a weakly matching education course at HKU (one session on Quarto reproducible reporting). I could not find a graduate reproducibility course in Asia, which may reflect the search tool (US-indexed) as much as the curriculum. The regional conclusions are therefore weak.

## Candidate topic table

Coverage column: file:line in `analysis/report/`. Breadth is out of 26. 'Newness' is when the topic entered common teaching practice [EK unless stated]. Settledness is stable or volatile, meaning likely to change within a year.

| Topic | Book coverage | Scope | Breadth (sources) | Newness | Settled | Notes |
|---|---|---|---|---|---|---|
| Git/GitHub basics, collaboration | Covered, version-control.qmd:377, :1193 | In | 23 (all except C18, C19, C26) | c. 2012 | Stable | Universal. |
| Git recovery, undoing, branches | Covered, version-control.qmd:916, :1032 | In | 4 (C3, C4, C13, C24) | c. 2014 | Stable | |
| `git stash` | Absent (grep 0) | In | 1 (C4) | Old | Stable | Too narrow to add on its own. |
| `git bisect`, history forensics | Covered, 09-continuous-integration.qmd:1464 | In | 1 (C13) | Old | Stable | The book goes further than most courses. |
| Large files in git (LFS, size limits) | Partly: .gitignore 'large data', version-control.qmd:297 | In | 1 (C4) | c. 2016 | Stable | One paragraph would do. |
| GitHub Issues, milestones, project management | Absent (grep 'issue tracker' 0) | In | 3 (C4, C10 agile, C13) | c. 2015 | Stable | Small addition. |
| Literate programming, R Markdown/Quarto | Covered, 07-literate-programming.qmd:336, :437 | In | 21 | Rmd 2014; Quarto 2022 | Stable | |
| Citation management (BibTeX, CSL, Zotero) in documents | Partly: `bibliography:` line only, 07-literate-programming.qmd:1052; software citation in 10-archiving-sharing.qmd:575 | In | 4 (C4, C7, C11, C16) | Old | Stable | Health manuscripts need journal CSL styles. |
| LaTeX / PDF toolchain | Covered, 07-literate-programming.qmd:739 | In | 5 (C1, C5, C7, C16, C22) | Old | Stable | |
| Project organization, paths (`here`) | Covered, 03-research-compendium.qmd:546, :677 | In | 8 (C1, C3, C6, C7, C8, C9, C10, C26) | c. 2015 | Stable | |
| README, data documentation | Covered, 03-research-compendium.qmd:614 | In | 3 (C6, C7, C9) | Old | Stable | |
| Research compendium concept | Covered, 03-research-compendium.qmd:280 | In | 2 (C5, C17) | 2007/2018 | Stable | Few courses name it explicitly. |
| Shell / command line | Covered (appendix), shell-primer.qmd:15 | In | 8 (C1, C5, C6, C8, C10, C12, C14, C20) | Old | Stable | |
| Dependency/environment locking (renv, conda) | Covered, 04-dependencies.qmd:269; 06-backends-runtimes.qmd:499 | In | 6 (C3, C6, C7, C9, C17 per Utrecht materials, C25) | renv 2019 | Stable | |
| Containers (Docker, Apptainer) | Covered, 05-containers.qmd; 06-backends-runtimes.qmd:304 | In | 7 (C3, C4, C6, C8, C9, C10, C22) | c. 2017 | Stable | The book's depth well exceeds the syllabi's. |
| Make | Covered, pipelines.qmd:549 | In | 7 (C1, C2, C3, C6, C10, C19, C24) | Old | Stable | |
| `targets` / workflow managers (Snakemake, Nextflow) | Covered, pipelines.qmd:685, :1053 | In | 4 (C4, C8, C9, C25) | 2021 | Stable | |
| R package development tooling (`devtools`, `usethis`, roxygen2, pkgdown) | Partly: package as container, 03-research-compendium.qmd:341; roxygen mentioned 03:784; `devtools`/`usethis` 0 hits; pkgdown only in a code comment, version-control.qmd:819 | In/borderline | **12** (C1, C2, C5, C7, C8, C12, C17, C19, C20, C21, C23, C24) | c. 2015 | Stable | Most frequent topic the book lacks. |
| Unit testing | Covered, 08-testing-quality.qmd:454, :530 | In | 7 (C1, C3, C12, C13, C19, C22, C23) | c. 2014 | Stable | The book uses tinytest; most courses use testthat (C19) or pytest (C13). |
| Data validation | Covered, 08-testing-quality.qmd:601 | In | 1 (C3) | c. 2018 | Stable | The book leads here. |
| Continuous integration | Covered, 09-continuous-integration.qmd | In | 5 (C5, C8, C13, C22, C25) | c. 2018 | Actions syntax volatile | |
| Interactive debugging, error handling | Partly: generic debugging explicitly out of scope, 09-continuous-integration.qmd:1472; `browser()` only as a lint target, 08:1235 | Borderline | 5 (C1, C11, C13, C22, C23) | Old | Stable | A pointer is enough; the scope decision is defensible. |
| Code style, linting | Covered, 08-testing-quality.qmd:1154 | In | 3 (C1 'clear code', C13, C22) | c. 2017 | Stable | |
| Code review as a practice | Partly: one sentence, 08-testing-quality.qmd:1195; pointer, 10-archiving-sharing.qmd:658 | In | 5 (C5, C7, C22, C24, C25: peer or team review) | c. 2018 in research | Stable | Many courses assess through peer review. |
| Simulation studies, Monte Carlo error | Covered, 08-testing-quality.qmd:898; archetype 03:821 | In | 5 (C1, C20, C21, C22, C26) | Old | Stable | |
| Parallel computing, HPC, job scripts | Covered: RNG streams 08:898, Slurm example 06-backends-runtimes.qmd:904 | In | 6 (C1, C8, C12, C19, C20, C22) | Old | Stable | |
| Caching long computations | Covered, 07-literate-programming.qmd (caching), pipelines.qmd | In | 1 (C1) | Old | Stable | |
| Cloud compute (AWS, hosted IDEs) | Partly: Codespaces/Binder, 06-backends-runtimes.qmd:572 | Borderline | 1 (C6) | c. 2018 | Volatile | Leave as is. |
| Licensing, copyright | Covered, 10-archiving-sharing.qmd:575 | In | 3 (C1, C13, C17) | Old | Stable | |
| Human subjects, HIPAA, PHI | Covered, version-control.qmd:648, :693; 10-archiving-sharing.qmd:676 | In | 1 (C1) | Old | Stable | The book is far ahead of the syllabi here. |
| FAIR, data management plans | Covered: FAIR 10-archiving-sharing.qmd:554; NIH DMS 10:837 | In | 2 (C7, C8) | 2016 | Stable | |
| Archiving, DOIs, publishing artifacts | Covered, 10-archiving-sharing.qmd:508 | In | 2 (C5, C17) | c. 2016 | Stable | |
| Named case studies of computational irreproducibility (e.g. Duke genomics) | Absent: evidence in 01:300 rests on surveys (cites baker2016, begley2012, ioannidis2005, opensciencecollaboration2015, trisovic2022, saju2025); grep for Baggerly, Potti, 'train wreck', Reinhart: 0 | In | 3 (C5, C24 'Train Wreck' and Vitamin D, C4 capstone) | 2009 onward | Stable | Fits a health audience well. |
| Reproduction vs replication, philosophy | Covered, 02-levels-of-reproducibility.qmd:536; 01:388 | In | 2 (C5, C24) | | Stable | |
| Research ethics, QRPs, p-hacking | Partly: pre-specified analysis plan, 08-testing-quality.qmd:360; QRP grep 0 | Out (methods) / borderline | 3 (C5, C10, C22) | c. 2011 | Stable | The preface's scope statement excludes it; keep it out. |
| Websites, blogs, slides, portfolios from the compendium | Partly: blog archetype 03-research-compendium.qmd:855; no `quarto publish`, GitHub Pages, or revealjs (grep 0) | Borderline | 7 (C4, C8, C12, C17, C21, C22, C25) | c. 2020 | Quarto publish fairly stable | Mostly a communication topic. |
| Figure/table design, scientific communication | Absent as a topic | Out | 4 (C2, C5, C16, C22) | | Stable | Belongs in a communication text. |
| LLM coding assistants | Covered, 'Collaborating with an LLM' in each chapter | In | 2 (C12 Copilot, C19 LLMs & R) | 2023 | **Volatile** | The book is ahead of the syllabi; keep tool names out (D5). |
| Python / Jupyter interoperability | Partly: Jupyter engine 07:380; Snakemake | Out (book is R) | 7 (C1, C3, C6, C9, C10, C11, C13) | | Stable | |
| Writing functions, functional programming | Implicit | Out (programming) | 6 (C2, C3, C11, C12, C20, C26) | | Stable | A prerequisite, not content. |
| Shiny, dashboards | Absent | Out | 5 (C2, C10, C12, C14, C19) | | Stable | Already skipped in 10.10; agree. |
| Databases, SQL, duckdb | Absent | Out | 3 (C12, C15, C19) | | duckdb volatile | Already skipped; agree. |
| Web scraping, APIs | Absent | Out | 3 (C2, C15, C19) | | | |

## Findings

### Major

**M1. R package tooling is absent although the compendium is a package.** Evidence: 03-research-compendium.qmd:341-388 [I]; grep for `devtools` and `usethis` gives 0 hits; `pkgdown` appears only in a code comment at version-control.qmd:819 [structural]; 12 of 26 courses teach package development [I].

- **What is wrong.** Chapter 5 (03-research-compendium.qmd) argues the R package is 'the most consequential design decision' and builds on `R CMD check`, roxygen2 (03:784, 03:1154) and tests in `tests/`. It never shows the student how to create or maintain that skeleton: `usethis::create_package()`, `use_test()`, `devtools::document()`, `devtools::check()`, `load_all()`.
- **Why it matters.** A health-sciences MS student who knows R but not packages will meet `DESCRIPTION`, `NAMESPACE` and roxygen tags with no procedure. The 10.10 decision to give only a pointer to *R Packages* is defensible for full package development. It underestimates the minimum the compendium itself requires, and peer courses (C7, C17, C21, C23) treat that minimum as core.
- **Fix.** Add a 4 to 5 page appendix, 'The package skeleton in practice'. Cover `usethis` creation, the `DESCRIPTION` Imports/Suggests split as it relates to the triad (04-dependencies.qmd:530), roxygen2 to `NAMESPACE`, `load_all()` during development, and `check()`. Point to *R Packages* for everything else. Reference it from 03:341.

### Minor

**m1. No named forensic case.** Evidence: 01-reproducibility-crisis.qmd:300-390 [I]; 3 of 26 courses (C4, C5, C24) [I].

- **What is wrong.** The chapter makes its case with aggregate surveys and replication projects. The courses that teach reproducibility to biomedical audiences (SISBID C24, taught by Baggerly) open with a concrete forensic reconstruction. The canonical example is the Duke genomic-signature trials analyzed by Baggerly and Coombes (Annals of Applied Statistics, 2009) [EK; I did not reopen the paper].
- **Why it matters.** A case in which off-by-one row shifts and mislabeled samples reached patients in clinical trials is the most persuasive motivation available for this audience. It also illustrates a point the book makes at 01:660: a reproducible analysis can still be wrong, and reproducibility is what allowed the error to be found.
- **Fix.** Add a 1.5 page boxed case in 01, beside 01:660. Verify the citation before adding it.

**m2. Citation management in literate documents is thin.** Evidence: 07-literate-programming.qmd:1052 [I]; 4 of 26 courses [I].

- **What is wrong.** The only treatment is a `bibliography:` line in a YAML header. There is no `csl:` for journal styles, no mention of reference managers (Zotero with Better BibTeX), and nothing on keeping `references.bib` under version control as part of the sealed render.
- **Fix.** Add a 1 page subsection in 07 after the header discussion (about 07:1055). Cover `bibliography`, `csl`, a pinned CSL file committed to the repository (a render-determinism point), and an exported `.bib` under git.

**m3. Code review as a practice is absent.** Evidence: 08-testing-quality.qmd:1195, 10-archiving-sharing.qmd:658 [I]; 5 of 26 courses use peer or team review of code [I].

- **What is wrong.** The book mentions code review only to say that `styler` keeps formatting out of it.
- **Why it matters.** Several peer courses (C5, C7, C22, C24) assess students through reviewing a colleague's repository. The book's own exercises could use that design, and its pull-request material (version-control.qmd:1241) is the natural place for it.
- **Fix.** Add a 1.5 page section in 08 or version-control.qmd. Give a review checklist built on the book's own gates: clone, restore, render, compare to the baseline, read the README and data dictionary. Add one paired exercise.

**m4. Issues and milestones are absent.** Evidence: version-control.qmd:1193 [I]; grep 'issue tracker' 0 [structural]; 3 of 26 courses [I].

- **Fix.** Add half a page in the remote section on issues as the audit trail for analysis decisions, linked from commit messages (`Fixes #12`). Optionally add one paragraph on large files and why data stay out of git, extending version-control.qmd:297.

**m5. Publishing a compendium as a website is mentioned but not shown.** Evidence: 03-research-compendium.qmd:855-870 [I]; grep for `quarto publish` and GitHub Pages 0 [structural]; 7 of 26 courses [I].

- **What is wrong.** The blog archetype claims that 'the full five-pillar reproducibility stack applies to web-published teaching content without any change to the workflow' (03:867-870), but no chapter shows the publish step.
- **Status.** Borderline. It is a communication skill, and breadth varies in kind (C4 presentations, C17 portfolios, C25 Netlify). I rank it sixth and do not include it in the five.

### Places where the book exceeds the syllabi (no action needed)

These areas are stated briefly because they matter for the length decision.

- Restricted data and PHI: 1 of 26 courses (C1, one lecture), versus several sections in the book.
- Containers: 7 of 26 courses.
- CI: 5 of 26 courses.
- Data validation: 1 of 26 courses.
- Regulated validation and Monte Carlo error: no course covers them.
- History forensics with `git bisect`: 1 of 26 courses.
- Determinism detail (RNG kind, locale): no course covers it.

This is consistent with the book's stated focus. It also means the book is heavier than any single comparable course. Plan 10.11 already records weekly loads above target, so every addition below should be offset or placed in an appendix.

## Agreement and disagreement with REFACTOR-PLAN 10.10

**Agree.** I agree with 10.10's syllabus-derived items: README and data dictionary, licensing, git recovery, debugging a failed reproduction, `here`, and the shell primer. All are now present (03:614, 10:575, version-control.qmd:1032, 09:1464, 03:677, shell-primer.qmd) [I]. My shell-primer breadth (8 of 26) is close to 10.10's S 7 of 30.

**Agree.** I agree with skipping Shiny, SQL, Python and duckdb.

**Partly disagree.** I partly disagree with skipping 'full R package development (pointer to *R Packages* instead)'. Full development should stay out. But package tooling is the single most frequent topic in my sample that the book lacks (12 of 26), and the book's architecture depends on it (M1).

**Not in 10.10.** Case study, citation management, code review, and issues do not appear in 10.10's table. These are new.

## Ranked additions

| Rank | Addition | Placement | Size |
|---|---|---|---|
| 1 | Package skeleton in practice: `usethis`, roxygen2 to `NAMESPACE`, `load_all`, `check`, `DESCRIPTION` Imports vs Suggests (M1) | New appendix, referenced from 03-research-compendium.qmd:341 and 04-dependencies.qmd:530 | 4 to 5 pp |
| 2 | Forensic case: Duke genomic signatures (Baggerly and Coombes 2009), framed as 'reproducible yet wrong, and found because reproducible' (m1) | Boxed case in 01, beside 01:660 | 1.5 pp |
| 3 | Code review of a compendium: checklist built on the book's gates, plus one paired exercise (m3) | Section in 08 after 'Code quality as a validation feature' (08:1154), or in version-control.qmd after 1241 | 1.5 pp |
| 4 | Citation management in Quarto: `bibliography`, committed `csl`, `.bib` under git, Zotero/Better BibTeX export (m2) | Subsection in 07 near 07:1055 | 1 p |
| 5 | Issues and milestones as the decision log; one paragraph on large files (m4) | version-control.qmd remote section (1193) and :297 | 0.5 to 1 p |

Total: about 9 to 11 pages. Ranks 2 to 5 fit inside existing chapters. Rank 1 belongs in an appendix so it does not add to the weekly load. To offset the length, I would trim the 'honest level' recitals that 10.12 already flagged.

## What was not done

- I did not open the full weekly schedules for C5 (Berkeley), C15 (Michigan) or C17 (Utrecht beyond week titles). Their topic counts may be undercounts.
- C17's renv and compendium content comes from a search snippet plus its week title 'Reproducible Research'. It is counted, but it is the weakest entry.
- I did not verify the Baggerly and Coombes citation details by opening the paper [EK].
- Book coverage relies on grep plus reading the cited lines. I did not read whole chapters.
- I examined no non-English syllabi, which probably explains part of the Asian and European gap.
