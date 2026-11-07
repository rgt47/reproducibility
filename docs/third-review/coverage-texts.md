# Coverage review: textbooks, lesson sets, and professional guidance
*2026-11-07 11:37 PST*

## Summary

1. I opened 29 sources: open books, lesson sets, tool manuals, professional guidance, and journal policies (all accessed 2026-11-07). The book covers the core that nearly all of them share: version control, project paths, dependency capture, containers, pipelines, literate programming, testing, CI, licensing, and archiving.
2. One factual error turned up during the survey (major). At 03-research-compendium.qmd:620-623 and :667 the book says the NHS RAP README criterion is the *entire* baseline. The cited page lists five baseline criteria, and code peer review is one of them.
3. The largest gap for this audience is the README's computational-requirements content: software, controlled randomness, runtime, hardware, and a map from each output to the code that makes it. Replication-package standards (the Social Science Data Editors template, JASA, TIER) require it; the book's README section omits it.
4. Quarto `freeze`/`cache` gets a single clause (07-literate-programming.qmd:1469), but the book's own build uses `freeze: auto` (_quarto.yml:122). Named journal policies (JASA, Biostatistics, AJE, BMJ) are absent; only TRIPOD+AI is discussed. Code review of analysis code appears only in passing.
5. Ranked additions: (1) README computational requirements, (2) Quarto freeze and cache, (3) a table of journal policies, (4) reviewing analysis code, (5) authenticating git to GitHub. Total about 5 to 6 pages.

## Method and evidence labels

For each source I opened the current table of contents and, where a topic was in doubt, the relevant chapter page. Breadth counts cover only the sources listed in the Sources section, and they count a topic only when a chapter title, lesson title, or criterion visibly names it. They are lower bounds. Before calling a topic absent I grepped the chapter files; the scripts are in
/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/review3/work-cov-texts/.
A grep miss is a structural check: it shows a term does not appear, not that the idea is never discussed. Where I read surrounding text to confirm, I mark the claim [I].

Sources I could not open, so their content is not used as evidence: The Lancet author guidance (HTTP 403); the BMJ data-sharing page and the 2024 BMJ editorial (both 403); the RDA FAIR4RS page (redirect, then 404); the *Scientific Data* FAIR4RS article (authentication redirect); The Turing Way's Risk Assessment and Research Compendia pages (404 at the URLs I tried). For the BMJ I have only search-engine summaries. Those summaries say that analytic code sharing has been mandatory for research submitted from 1 May 2024 [U]. That claim must be checked against bmj.com before the book states it. I found no single open book titled 'Reproducible Research in R' to check, so I used Rodrigues, *Building Reproducible Analytical Pipelines with R*, and Alexander, *Telling Stories with Data*, as the nearest open R texts.

## Finding outside the coverage brief (major)

**03-research-compendium.qmd:620-623 and :667 misstate the NHS RAP baseline [I].** The text says the NHS RAP Community of Practice 'makes the README the entire baseline criterion for reproducibility'. The Answer callout then says a one-line README 'satisfies the RAP baseline criterion by itself'. The cited page (references.bib:985-991, URL `.../introduction_to_RAP/levels_of_RAP/`, opened 2026-11-07) lists five Baseline criteria:

- outputs are produced by code in an open-source language;
- the code is under version control;
- the README gives reproduction steps;
- the code has been peer reviewed;
- the code is published openly and linked to and from the publication.

The quoted clause itself is accurate. The framing around it is wrong, and the bib `note` field repeats the same narrowing. A reader would come away with a wrong view of a professional standard that many UK health analysts work under, and the error also hides the code-review criterion this report recommends adding (see addition 4). This item is not in factual-issues.md. Fix: 'Among the five baseline criteria of the NHS RAP Community of Practice is that a repository ...'. Rewrite the callout answer so it says the README sentence meets the README criterion, not the whole baseline.

## Coverage table

Key. Cov: C covered, P partly covered, A absent. Scope: In, Out, B (borderline). Breadth: the number of my sources that name the topic. Settled: S stable, V volatile. Source codes are expanded in the Sources section.

| # | Topic | Cov (book location) | Scope | Breadth | Newness | Settled | Sources |
|---|---|---|---|---|---|---|---|
| 1 | Version control basics, history, ignore rules | C (version-control.qmd:314-693) | In | 9 | 2005+ | S | TW, HG, RAPS, NHS, DUCK, SWC, UKRN, GE, TSR |
| 2 | Authenticating git to GitHub (PAT, SSH, credential helper) | A (push shown with no authentication step, version-control.qmd:1215-1226; no PAT/SSH/gitcreds hits) | B (the audience knows basic git) | 1 named (HG ch 9-14) | PAT required since 2021 [EK] | S, but GitHub UI changes | HG |
| 3 | Code review / peer review of analysis code | P (PR as review record in the solution, version-control.qmd:1786-1806; passing mentions 08-testing-quality.qmd:1195, 10-archiving-sharing.qmd:658) | In | 4 | Long standing; RAP baseline | S | TW, NHS, DUCK, ROS |
| 4 | Code style, linting, formatting | C (08-testing-quality.qmd:1154-1234) | In | 4 | 2015+ | S | TW, DUCK, NHS, R4DS |
| 5 | File naming conventions | A (no hits for 'naming convention' in chapters) | In (minor) | 3 | Long standing | S | WTF, TW, GE |
| 6 | Project-oriented workflow, relative paths | C (03-research-compendium.qmd:677-712) | In | 5 | 2017+ | S | WTF, R4DS, SWC-R, TIER, DUCK |
| 7 | Raw data immutable; all processing scripted | C (03-research-compendium.qmd:272, :564) | In | 3 | Long standing | S | GE, TSR, TIER |
| 8 | README with reproduction steps | C (03-research-compendium.qmd:614-633) | In | 5 | Long standing | S | NHS, GE, TIER, DE, TW |
| 9 | README computational requirements: software, randomness, runtime, hardware; output-to-program map | A/P (03:626-633 asks for purpose, command, dictionary location only) | In | 4 | AEA template c. 2020 [EK]; JASA 2016/2021 | S | DE, JASA, TIER, TSR (rule 9) |
| 10 | Data dictionary / codebook | C (03-research-compendium.qmd:635-656) | In | 4 | Long standing | S | JASA, TIER, TW, GE |
| 11 | Writing functions; refactoring scripts into modules | P (pipelines.qmd:1149-1160 in service of targets) | B (programming skill) | 6 | Long standing | S | DUCK, RAPS, GE, R4DS, SWC-R, NHS |
| 12 | Configuration separated from code (`config`, YAML) | A (no `config::` or `config.yml` hits) | B | 2 | Long standing | S | DUCK, NHS |
| 13 | Run logging | A | B | 1 (NHS silver) | Long standing | S | NHS |
| 14 | Testing (unit, integration, data validation) | C (08-testing-quality.qmd:522-716) | In | 6 | Long standing | S | TW, RP, DUCK, NHS, RAPS, SWC-R |
| 15 | Test coverage, snapshot tests | A (no `covr`/`expect_snapshot` hits) | B | 2 | testthat 3e 2020 [EK] | S | RP, TW |
| 16 | Package dependency capture (renv) | C (04-dependencies.qmd) | In | 6 | renv 2019 | S | RENV, WTF, RAPS, NHS, GE, TSR |
| 17 | Dated package-repository snapshots (P3M) | C (04-dependencies.qmd:864-933) | In | 2 | 2019+ | S | WTF, RENV |
| 18 | R version install and switching (`rig`) | P (pinned through Rocker, 05-containers.qmd:444-506; no `rig`) | B | 2 | rig 2022 [EK] | V (tooling) | WTF, RENV (caveats) |
| 19 | Containers | C (05-containers.qmd) | In | 4 | Docker 2013 | S | TW, RAPS, RENV, Q-VE (indirect) |
| 20 | Binder / browser execution | C (06-backends-runtimes.qmd:572-643) | In | 1 | 2016+ | V (service) | TW |
| 21 | Build automation (Make, targets) | C (pipelines.qmd) | In | 4 | Make 1976; targets 2021 | S | TW, SWC, TGT, RAPS |
| 22 | Literate programming (Quarto) | C (07-literate-programming.qmd) | In | 5 | Quarto 2022 | S | R4DS, RAPS, TGT, SWC-R, TSWD |
| 23 | Quarto `freeze` and `cache`: what they skip, when they invalidate | P (one clause, 07:1469; book uses `freeze: auto`, _quarto.yml:122) | In | 2 | Quarto 1.0, 2022 | S | Q-CE, TGT (literate chapter, inferred) |
| 24 | Python environments alongside R (`renv::use_python`, venv) | A | Out (prior decision) | 3 | 2020+ | S | RENV, Q-VE, NHS |
| 25 | Continuous integration | C (09-continuous-integration.qmd) | In | 5 | 2019+ for R | S | TW, ROS, RAPS, NHS, DUCK |
| 26 | CI and package security (secrets, pinned actions) | C (09-continuous-integration.qmd:666-769) | In | 1 | 2021+ | V | ROS |
| 27 | Packaging the analysis | C (03-research-compendium.qmd:341-388) | In | 3 | 2018+ | S | RP, RAPS, NHS gold |
| 28 | Changelog / NEWS, versioned releases | P (`git tag` at submission, version-control.qmd:1257; no NEWS or changelog) | B | 4 | Long standing | S | NHS gold, GE 5f, RP ch 21, ROS |
| 29 | Licensing | C (10-archiving-sharing.qmd:575-660) | In | 5 | Long standing | S | TW, RP, NHS, GE, DE |
| 30 | CITATION file | C (10-archiving-sharing.qmd:575-610) | In | 1 | CFF 2021 | S | GE 3e |
| 31 | FAIR and FAIR4RS | C (10-archiving-sharing.qmd:554-574) | In | 2 | 2016 / 2022 | S | GOF, TW |
| 32 | CARE principles (Indigenous data governance) | A | B (health data) | 1 | 2019 [EK] | S | TW |
| 33 | Data management plan / NIH DMS | C (10-archiving-sharing.qmd:837-851) | In | 2 | 2023 | S | NIH, TW |
| 34 | Software management plan | A | Out | 1 | 2020s | V | TW |
| 35 | Archiving with persistent identifiers | C (10-archiving-sharing.qmd:508-610) | In | 6 | Long standing | S | TW, GE, JASA, BIOS, AJE, DE |
| 36 | Restricted data; substitute or synthetic dataset | C (10-archiving-sharing.qmd:662-826) | In | 2 | Long standing | S | JASA, DE |
| 37 | Named journal reproducibility policies (JASA ACC and reproducibility editors, Biostatistics D/C/R marks, AJE DAS, BMJ code mandate) | P (only TRIPOD+AI 18f, 10-archiving-sharing.qmd:866-893; no hits for JASA, Biostatistics, AJE, BMJ) | In | 4 | 2009 (Biostatistics, EK) to 2024 (BMJ, U) | S per journal, V in detail | JASA, BIOS, AJE, BMJ (U) |
| 38 | Independent reproducibility checking (CODECHECK, journal reviewers) | C (09-continuous-integration.qmd:1324-1390) | In | 2 | 2019+ | S | JASA, DE |
| 39 | Pre-registration | P (as test oracle, 08-testing-quality.qmd:360-453) | Out beyond that use | 1 | Long standing | S | UKRN |
| 40 | Tidy data; spreadsheet organization | A (spreadsheets appear only as an input hazard, 05-containers.qmd:951-963) | B | 5 | 2014+ | S | DC, TW, NHS, GE, R4DS |
| 41 | Debugging R code; minimal reprex | P (debugging a failed reproduction, 09-continuous-integration.qmd:1464-1604; no reprex) | B | 2 | reprex 2017 [EK] | S | WTF, TGT |
| 42 | Regulated validation; package risk assessment | C (08-testing-quality.qmd:1273-1372) | In | 1 | 2018+ | V | RVH |
| 43 | Generative AI in analysis | C (LLM sections in each chapter) | In | 1 | 2023+ | V | DUCK |
| 44 | Accessibility of outputs | A | Out | 1 | Long standing | S | NHS |
| 45 | Shell | C (shell-primer.qmd) | In | 3 | Long standing | S | SWC, HG, DC |
| 46 | Seeds and RNG streams | C (08-testing-quality.qmd:898-1084) | In | 3 | Long standing | S | TSR, DE, TGT |
| 47 | Branching and collaboration workflow (forks, PRs, trunk-based) | C (version-control.qmd:916-1031, :1193-1300) | In | 2 | Long standing | S | HG, RAPS |

## Comment on selected rows

**Row 9, README computational requirements.** The template README of the Social Science Data Editors has a 'Computational requirements' section. Its subsections are 'Software Requirements', 'Controlled Randomness', and 'Memory, Runtime, Storage Requirements' (split into Summary and Details), and the template also has a 'List of tables and programs' [I]. JASA requires a workflow that reproduces 'data preparation and cleaning, analyses, figures, and tables', backed by an ACC form [I]. TIER 4.0 requires a Read Me and a master script, and states that 'Sufficiency' means a user can reproduce the results without contacting the author [I]. At 03-research-compendium.qmd:626-633 the book's README needs only a purpose, a reproduction command, and a pointer to the data dictionary. A health student sending a replication package to a journal would also need expected runtime, the hardware it was last run on, and the seed policy. These are cheap to add, and the book already measures most of them: wall-clock time (02-levels-of-reproducibility.qmd and 05-containers.qmd, 'wall-clock' hits), the platform (05-containers.qmd:507), and seeds (08-testing-quality.qmd:898). The book never says to write them down in one place.

**Row 23, Quarto freeze and cache.** The Quarto documentation explains that `freeze` keeps a global project render from re-running a document, that frozen results live in `_freeze/`, and that `_freeze/` should be committed [I]. It also says cache invalidation is triggered by changes in chunk source code [I]. That means a change to data or packages does not invalidate the cache, which is the property that matters here. The book's 'sealed render' argument (07-literate-programming.qmd:437-573) depends on every number being regenerated. Yet the book itself renders with `freeze: auto` (_quarto.yml:122), and the git status at this session's start shows dozens of modified `_freeze/` files. A reader who copies the book's own setup gets a render that can report stale numbers under a fresh timestamp. This is the most in-scope, least covered item I found.

**Row 37, journal policies.** The book teaches the code-availability statement through TRIPOD+AI 18f only (10-archiving-sharing.qmd:866-893). Four policies are directly relevant to biostatistics and epidemiology students:

- JASA has required code, data, and a workflow at revision since 2016 for Applications and Case Studies and since 2021 for Theory and Methods. It uses an ACC form, and reproducibility editors review the materials [I].
- *Biostatistics* marks papers D, C, or R for available data, code, or both [I].
- AJE makes a data-availability statement mandatory and strongly encourages code sharing [I].
- The BMJ is reported to mandate code sharing [U].

A short table showing which venue requires what would convert an abstract obligation into a checklist. Details change, so the table should carry an access date.

**Row 3, code review.** The NHS RAP baseline (the source the book already cites), The Turing Way's 'Code Reviewing Process' chapter, the Duck Book's 'Peer review' chapter, and rOpenSci's peer-review section all treat review of analysis code as a core practice [I]. The book's pull-request solution (version-control.qmd:1786-1806) records who checked a change, but nowhere does the book say what a reviewer should check. For a book whose thesis is that a reproducible analysis can still be wrong (01-reproducibility-crisis.qmd:660), this omission matters.

**Row 2, authentication.** *Happy Git* gives six chapters (9 to 14) to connecting git, GitHub, and RStudio, including 'Personal access token for HTTPS' and 'Set up keys for SSH' [I]. The book's first `git push` (version-control.qmd:1223) assumes authentication already works. Students who 'know basic git' have often used only a GUI or a lab-managed machine, so the first push fails for them [EK]. This is a setup problem, not a concept, and it belongs in the setup appendix.

**Rows 11, 12, 13, 28, 40.** These rows (functions, configuration, logging, changelogs, tidy data) appear widely in general analyst guidance (NHS RAP silver and gold, the Duck Book, *Good enough practices*) but are programming or data-management skills more than computational-reproducibility mechanisms. In one quarter I would not add sections for them. A sentence each in the relevant places would do: functions in pipelines.qmd:1149, changelogs next to `git tag` at version-control.qmd:1257, tidy data in the data-dictionary section.

**Agreement with REFACTOR-PLAN 10.10.** The current book reflects every 10.10 Priority 1 and 2 row that I checked (restricted data, funder obligations, regulated validation, README, licensing, recovery, debugging, Apple Silicon, analysis-plan oracle, Monte Carlo error, `here`, CI secrets, AI disclosure, shell primer, HPC) [I by grep and heading]. I agree with 10.10's skip list, including Python and full package development. I disagree on one point: 10.10 rated the README row as done in 900 words. Measured against replication-package standards, which 10.10 did not consult, that section is still incomplete (row 9). 10.10 also did not raise freeze/cache, named journal policies, or code review.

## Five recommended additions, ranked

1. **README computational requirements and an output-to-code map.** Placement: extend 'The README and the data dictionary', 03-research-compendium.qmd:614. Add a required list (software and versions with a pointer to the lockfile and image digest; seed policy; expected runtime and hardware last used; a table mapping each manuscript table and figure to its target or script), and add the same items to the worked-example README. Size: 1 page. Sources: DE, JASA, TIER.
2. **Quarto `freeze` and `cache`, and how they break the seal.** Placement: a new subsection after 'The landmines that break the seal', 07-literate-programming.qmd:611. Cover what each option skips, the fact that cache invalidation keys on chunk source and not on data or packages, committing `_freeze/`, and a rule: the deposit render runs with freeze off, or after deleting `_freeze/`. Say plainly that the book itself uses `freeze: auto` and why. Size: 1 to 1.5 pages. Source: Q-CE.
3. **A table of journal reproducibility requirements.** Placement: inside 'Funder and journal obligations', 10-archiving-sharing.qmd:853, before TRIPOD+AI. Columns: journal, what is required or encouraged, since when, review of materials (yes/no). Rows: JASA, *Biostatistics*, AJE, and BMJ once its policy page has been checked. Add an exercise that has students locate their target journal's policy. Size: 1 page. Sources: JASA, BIOS, AJE.
4. **Reviewing analysis code.** Placement: a section in 08-testing-quality.qmd after 'Code quality as a validation feature' (:1154), cross-referenced from the pull-request material in version-control.qmd:1193. Content: what a reviewer checks that tests and linters cannot (does the code implement the analysis plan, are exclusions and derived variables right, can the reviewer rerun it from the README), a short checklist, and the NHS baseline criterion. Size: 1.5 pages. Sources: NHS, TW, DUCK, ROS.
5. **Authenticating git to GitHub.** Placement: a new section in setup-appendix.qmd, linked from version-control.qmd:1215. Content: an HTTPS personal access token through a credential helper, or an SSH key; how to test the connection; and where tokens must never go (linking the existing credential guidance at version-control.qmd:683). Name no tool version beyond what is needed. Size: 0.5 to 1 page. Source: HG.

The five together add roughly 5 to 6 pages [inferred estimate]. Additions 1 and 3 are reference material and could share a page with the existing cheat sheets.

## Scope disclosure

- I read tables of contents and the specific pages named, not whole books. A topic may be treated inside a chapter whose title does not name it, so breadth counts are lower bounds.
- 'Covered' rests on grep plus reading the cited lines. I did not judge the depth or correctness of covered sections, except the NHS passage above.
- Dates marked [EK] (PAT requirement, rig, testthat 3e, CARE, *Biostatistics* 2009, AEA template) were not checked.
- I did not open the BMJ or Lancet policies, the FAIR4RS article, or the JASA reproducibility checklist itself.

## Sources (all accessed 2026-11-07)

- TW: The Turing Way, Guide for Reproducible Research, https://book.the-turing-way.org/reproducible-research/reproducible-research ; subpages /renv, /code-quality, /reviewing, /rdm, /testing, /code-documentation
- HG: Bryan, Happy Git and GitHub for the useR, https://happygitwithr.com/
- RP: Wickham and Bryan, R Packages (2e), https://r-pkgs.org/
- R4DS: Wickham, Cetinkaya-Rundel, Grolemund, R for Data Science (2e), https://r4ds.hadley.nz/
- WTF: What They Forgot to Teach You About R, https://rstats.wtf/ ; /reproducible-environments
- ROS: rOpenSci Packages: Development, Maintenance, and Peer Review, https://devguide.ropensci.org/ ; statistical software guide https://stats-devguide.ropensci.org/
- SWC: Software Carpentry lessons, https://software-carpentry.org/lessons/ ; SWC-R: R for Reproducible Scientific Analysis, https://swcarpentry.github.io/r-novice-gapminder/
- DC: Data Carpentry lessons, https://datacarpentry.org/lessons/
- RENV: renv, Introduction to renv, https://rstudio.github.io/renv/articles/renv.html
- TGT: The targets R package user manual, https://books.ropensci.org/targets/
- Q-CE: Quarto, Managing Execution, https://quarto.org/docs/projects/code-execution.html ; Q-VE: Quarto, Virtual Environments, https://quarto.org/docs/projects/virtual-environments.html
- NHS: NHS RAP Community of Practice, https://nhsdigital.github.io/rap-community-of-practice/ ; Levels of RAP, https://nhsdigital.github.io/rap-community-of-practice/introduction_to_RAP/levels_of_RAP/
- UKRN: UK Reproducibility Network primers, https://www.ukrn.org/primers/
- GOF: GO FAIR Foundation, FAIR Principles, https://www.gofair.foundation/fair-principles/
- DUCK: UK Government Analysis Function, Quality assurance of code for analysis and research, https://best-practice-and-impact.github.io/qa-of-code-guidance/intro.html
- RAPS: Rodrigues, Building Reproducible Analytical Pipelines with R, https://raps-with-r.dev/
- TSWD: Alexander, Telling Stories with Data, https://tellingstorieswithdata.com/
- GE: Wilson et al. 2017, Good enough practices in scientific computing, https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510
- TSR: Sandve et al. 2013, Ten Simple Rules for Reproducible Computational Research, https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285
- DE: Social Science Data Editors, template README, https://social-science-data-editors.github.io/template_README/template-README.html
- TIER: Project TIER, TIER Protocol 4.0, https://www.projecttier.org/tier-protocol/protocol-4-0/
- RVH: R Validation Hub, https://www.pharmar.org/
- JASA: JASA Reproducibility Guide, https://jasa-acs.github.io/repro-guide/ ; author guidelines, https://jasa-acs.github.io/repro-guide/pages/author-guidelines
- BIOS: Biostatistics, General Instructions, https://academic.oup.com/biostatistics/pages/General_Instructions
- AJE: American Journal of Epidemiology, General Instructions, https://academic.oup.com/aje/pages/General_Instructions
- NIH: NIH DMS Policy overview, https://grants.nih.gov/policy-and-compliance/policy-topics/sharing-policies/dms/policy-overview
- BMJ (U, search results only): https://www.bmj.com/content/384/bmj.q324.full ; https://www.bmj.com/about-bmj/resources-authors/article-types/data-sharing
