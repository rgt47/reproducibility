# Reviewer H: web verification, currency, and case bank
*2026-11-25 18:15 PST*

## Summary

- The numbers quoted in Chapters 1 and 2 are now correct. Phase 25 fixed the OSC, Saju, and Peng wording, and I found no new numerical error.
- Three caveats are missing: Begley and Ellis's selection and non-disclosure, Baker's self-selected sample, and Trisovic's post-cleaning rate.
- The chapters promise health-science evidence, but none of the four cited studies re-executed health-science analyses.
- Absent: Brodeur et al. and SCORE (both *Nature*, 2026), Errington et al. (2021), and the OSTP public-access memo with its NIH implementation and reported 2026 repeal.
- Part I names no real-world case of a code error with consequences.
- Tooling claims check out on the web: `checkout@v7` and `r-lib/actions@v2` on Node 24, Docker Desktop terms, and the Apptainer history. R 4.6.2 is now out.
- The case bank offers 25 cases across 12 disciplines.

## Strengths

- Every quoted figure in Chapters 1 and 2 matches its source as currently worded. That includes the hedged OSC wording (39 judged successful, 36 percent significant) and Saju's script-versus-project distinction, which I confirmed against arXiv HTML.
- R release years are correct: R 3.6.0 in 2019 (CRAN tarball 2019-04-26) and R 4.0.0 in 2020 (2020-04-24).
- The NIH DMS paragraph is current. NOT-OD-26-100 and NOT-OD-26-120 are cited correctly; I checked both against the raw notice text.
- The CI examples use action majors that run on Node 24, so they survived GitHub's September 2026 removal of Node 20.
- `icmje2026ai` matches the ICMJE Recommendations as updated January 2026.

## Findings

### Health-science evidence promised, non-health evidence supplied
- Location: 01-reproducibility-crisis.qmd:52
- Quote: 'Can you summarize the empirical evidence that a large fraction of published health-sciences research cannot be regenerated'
- Severity: major
- Viewpoint: referee
- Evidence: verified (https://arxiv.org/html/2505.21590: the projects are 'R projects in the social sciences and psychology'); inspected (00-intro.qmd:42-44 makes the same claim)
- Prior: new
- Problem: The re-execution evidence comes from two studies. Saju is social science and psychology. Trisovic is Harvard Dataverse replication datasets; I did not verify its field mix, though it is not health-specific. The replication evidence is psychology and preclinical oncology. Neither chapter cites a re-execution study of health-science or clinical analyses.
- Why it matters: A biostatistics referee or a skeptical clinical mentor will notice that the headline claim about their field rests on other fields' data.
- Fix: Add Naudet et al. 2018 (doi:10.1136/bmj.k400; abstract read at PMC5809812). Of 37 RCTs in *The BMJ* and *PLOS Medicine*, data were available for 17, and '14 of the 17 ... were fully reproduced on all their primary outcomes'. Alternatively, reword both sites to 'published research, including in the health sciences'.

### No named real-world case of a computational error in Part I
- Location: 01-reproducibility-crisis.qmd:126
- Quote: 'Consider a situation that every quantitative health scientist eventually meets.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected (grep of all chapters for Potti, Baggerly, Reinhart, Herndon, Ziemann, Aboumatar, Eklund, Chang, Foote: no hits; also `docs/third-review/coverage-syllabi.md`:101)
- Prior: Reopens D18 (A10, the Duke case, was declined)
- Problem: Part I opens with a hypothetical auditor, and its evidence is aggregate rates only. No study is named that was retracted, reversed, or stopped because of a code or data-handling error.
- Why it matters: Aggregate rates do not answer the mentor's 'my results have always been fine'; a named case with consequences does. This is the new argument: A10 was weighed only against length, never against the persuasion goal this review puts first.
- Fix: Add one paragraph of about 150 words after 01:392 ('The tooling in this book addresses the second failure.'). This is an addition, not a swap, so it does not collide with the next two findings. Use the 2019 JAMA retraction and republication of Aboumatar et al., where a programming error in the analysis reversed a reported benefit into harm (doi:10.1001/jama.2019.14503). Add one non-clinical case, Reinhart and Rogoff (doi:10.1093/cje/bet075), with the caveat given in the case bank. Both citations are verified; the details rest on search summaries and should be checked against the papers before printing.

### Begley and Ellis cited without their selection and disclosure caveats
- Location: 01-reproducibility-crisis.qmd:345
- Quote: 'Begley and Ellis, working from within industry, reported that only six of fifty-three landmark findings could be reproduced'
- Severity: major
- Viewpoint: referee
- Evidence: verified (page text of nature.com/articles/483531a: papers 'were deliberately selected that described something completely new'; the text names none of the 53 papers; a Clarification was published 2 May 2012); verified (Errington et al. abstract via api.elifesciences.org/articles/71601). The later report that Amgen never identified the papers is unverified; I saw it only in search summaries.
- Prior: new (Phase 25 L3 verified the number, not the caveats)
- Problem: The figure comes from a Comment that deliberately sampled novel findings and does not name the studies, so no one can check it. The open successor goes uncited: the Reproducibility Project: Cancer Biology. It repeated '50 experiments from 23 papers', found replication effects '85% smaller', and reports a combined 'success rate was 46% (51/112)'.
- Why it matters: A referee will notice that a book about checkable claims leans on an uncheckable one.
- Fix: Add: 'the authors chose deliberately novel findings and did not name the studies'. Cite Errington et al. 2021 (doi:10.7554/eLife.71601) beside Begley and Ellis in the text, in `fig-failure-rates` (00-intro.qmd:143-157), and in Further reading.

### The 2026 mass-reproduction and SCORE results are absent
- Location: 01-reproducibility-crisis.qmd:365
- Quote: 'But a growing body of work isolates the specifically computational failures.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (Brodeur et al., *Nature* 2026, doi:10.1038/s41586-026-10251-x, article PDF opened: 'more than 85% of published claims were computationally reproducible'; Tyner et al., *Nature* 2026, doi:10.1038/s41586-025-10078-y, abstract via Europe PMC: replication for '151 of 274 claims (55.1%' and 49.3 percent of 164 papers)
- Prior: fix for THIRD-REVIEW-PLAN Section 7 incomplete (it advised 'the I4R 2026 reproduction study (one citation in Ch 2)'; `coverage-emerging.md`:88; grep finds no citation)
- Problem: The 'growing body of work' stops at 2025. Brodeur et al. reproduced 110 economics and political science papers from journals with mandatory data and code policies, 'most (but not all)' with a data editor. The authors call their sample 'highly selective' and 'an optimistic upper bound'.
- Why it matters: Brodeur is the strongest evidence for the mentor that the practices pay off, since enforced deposit yields reproducible papers. Omitting both 2026 studies dates the chapter for a referee.
- Fix: Add two or three sentences after the Saju paragraph (after 01:383): 'Where journals enforce code deposit, most claims re-execute (Brodeur et al.).' Cite SCORE beside OSC as the current replication benchmark.

### OSTP 2022 memo and NIH 2024 Public Access Policy absent
- Location: 10-archiving-sharing.qmd:1025
- Quote: 'The NIH Data Management and Sharing Policy applies to proposals due on or after 25 January 2023.'
- Severity: major
- Viewpoint: student
- Evidence: verified (memo PDF text, bidenwhitehouse.archives.gov/wp-content/uploads/2022/08/08-2022-OSTP-Public-Access-Memo.pdf: agencies to update policies 'no later than December 31st, 2025'; NOT-OD-25-101 raw text: 2024 NIH Public Access Policy effective 1 July 2025; aip.org/fyi, 20 May 2026: 'OSTP is now apparently in the process of repealing the Nelson memo')
- Prior: considered and declined in `docs/third-review/coverage-emerging.md`:66 and :104 as 'concerns manuscripts, not code'; not a recorded decision. New argument: the memo covers 'supporting data', not only manuscripts, and this review's audience includes students funded by NSF, DOE, and others.
- Problem: The policy section covers data management only. It omits the zero-embargo rule now binding on NIH-funded manuscripts, the government-wide deadline, and the 2026 uncertainty over repeal.
- Why it matters: Funded students are bound by public-access rules now, and those rules govern where the paper and its supporting data go.
- Fix: Add a short paragraph citing the memo, NOT-OD-25-101, and the AIP report. The 2022 OSTP memo directed agencies to require embargo-free access to publications and supporting data by 31 December 2025. NIH implemented it from 1 July 2025. In 2026 OSTP was reported to be repealing the memo, so readers should check their agency's current policy.

### Baker survey quoted without its self-selection caveat
- Location: 01-reproducibility-crisis.qmd:355
- Quote: 'When Baker later surveyed more than fifteen hundred researchers for Nature, a majority agreed that science was facing a reproducibility crisis.'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (article PDF via nature.com polopoly_fs 533452a.pdf: the survey 'probably selected for respondents who are more receptive to and aware of concerns about reproducibility')
- Prior: new
- Problem: The source states its own self-selection caveat; the book omits it here and in the epigraph framing.
- Why it matters: A methods-literate mentor will discount an opt-in survey once they know it is one.
- Fix: Add: 'in an online survey that, by the article's own account, probably attracted respondents already concerned about the issue'.

### Trisovic quoted without the post-cleaning rate
- Location: 01-reproducibility-crisis.qmd:374
- Quote: 'Roughly one in four executed without error, before any question of whether the output matched the published result'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (Europe PMC abstract for doi:10.1038/s41597-022-01143-6: '74% of R files failed to complete without error in the initial execution', and 56 percent still failed after automatic code cleaning)
- Prior: new (Phase 25 L5 recorded the 56 percent but proposed no text)
- Problem: Automatic code cleaning raised success from about 26 to 44 percent, which supports this book's point that many failures are mechanical.
- Why it matters: It backs 'more avoidable' (00-intro.qmd:104-105) with evidence instead of assertion.
- Fix: Add: 'and automatic code cleaning still left more than half failing'. Alternatively: 'automatic cleaning raised success to about 44 percent, a sign of how many failures are mechanical'.

### `saju2025` cites a preprint that has a published version
- Location: references.bib:442
- Quote: 'journal = {arXiv preprint arXiv:2505.21590},'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (`curl -sI https://doi.org/10.36190/2025.49` returns 302 to workshop-proceedings.icwsm.org/abstract.php?id=2025_49; that page gives the same title, four authors, R2CASS 2025 at ICWSM, 5 June 2025)
- Prior: new
- Problem: The entry gives 'Saju, Lorraine and others' and an arXiv journal field. The paper appeared in the ICWSM 2025 workshop proceedings, by Saju, Holtdirk, Mangroliya, and Bleier.
- Why it matters: Citing the proceedings version is standard practice and signals peer review.
- Fix: Make it `@inproceedings` with all four authors, booktitle 'Workshop Proceedings of the 19th International AAAI Conference on Web and Social Media', and doi 10.36190/2025.49, keeping the arXiv URL in `note`.

### NIH DMS update cited for one date, transition rules omitted
- Location: 10-archiving-sharing.qmd:1030
- Quote: 'Applications submitted on or after 25 May 2026 use an updated Plan format [@nihnot26100]'
- Severity: minor
- Viewpoint: student
- Evidence: verified (raw text of grants.nih.gov/grants/guide/notice-files/NOT-OD-26-100.html, released 29 July 2026)
- Prior: new (Phase 25 R23 verified the sentence as written)
- Problem: The notice also has three provisions the book omits. All active awards move to the new format by the FY2027 RPPR. Prior approval for Plan changes is retired. From 1 October 2026, changes are reported in the RPPR. The format itself is defined in NOT-OD-26-046.
- Why it matters: Students usually join existing awards, so the transition and the RPPR reporting are what they will meet.
- Fix: Add: 'Existing awards move to the same format at their next progress report, where changes to an approved Plan are now reported instead of approved in advance [@nihnot26100].'

### R 4.6.2 and `rocker/verse:4.6.2` now exist
- Location: 09-continuous-integration.qmd:921
- Quote: 'The image tag above names R 4.6.1, and this'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (cran.r-project.org/banner.shtml: R 4.6.2, 2026-10-29; Docker Hub tags API for rocker/verse: `4.6.2` updated 2026-11-16)
- Prior: new
- Problem: Tying the tag to the lockfile is defensible. But 09:518-519 frames the versions as 'current when this chapter was revised in November 2026', and by then R 4.6.2 was current.
- Why it matters: A reader may take 4.6.1 to be the newest R.
- Fix: Keep 4.6.1 and add 'the R version in the lockfile, not the newest release'.

### Node 20 retirement not mentioned as an aging mechanism
- Location: 09-continuous-integration.qmd:518
- Quote: 'setup and the check, at the major versions current when'
- Severity: minor
- Viewpoint: student
- Evidence: verified (raw.githubusercontent.com/actions/checkout/v7/action.yml and r-lib/actions/v2/setup-r/action.yml: `using: "node24"`; github.blog/changelog/2026-09-24-node-20-is-no-longer-available-in-github-actions: Node 20 retired, runners use Node 24, opt-out removed)
- Prior: new (D21 updated the pins; `persona-rse.md`:120 raised the retirement as EK, now verified)
- Problem: The book's pins are correct but do not explain why pins age. A student copying a workflow from an older tutorial will meet action majors built for Node 20.
- Why it matters: It is a current instance of the book's own thesis: the environment changed beneath unchanged code.
- Fix: Add: 'GitHub retired the Node 20 runtime for actions in September 2026, so workflows pinned to older action majors must be updated; this is why the versions above carry a date.' Whether old tags fail or only warn is unverified.

### Apptainer described as if the Singularity name ended
- Location: 06-backends-runtimes.qmd:345
- Quote: 'Apptainer, known until its move to the Linux Foundation as'
- Severity: minor
- Viewpoint: student
- Evidence: verified at search-summary level only (SingularityCE release announcements, groups.google.com/g/singularity-ce, 4.5.0 June 2026); apptainer.org footer 'a Series of LF Projects LLC' (fetched)
- Prior: new (Phase 25 A2-47 verified the rename only)
- Problem: Sylabs continues a separate fork under the name SingularityCE, and cluster documentation often still says 'singularity'.
- Why it matters: A novice on a cluster may not connect the `singularity` command with the book's Apptainer.
- Fix: Append: 'A separate fork, SingularityCE, continues under the old name.' Check any compatibility statement against both projects' documentation before adding it.

### Journal-policy table covers health journals only
- Location: 10-archiving-sharing.qmd:1115
- Quote: '@tbl-journal-code summarizes three that biostatistics and'
- Severity: minor
- Viewpoint: student
- Evidence: verified (journals.plos.org/ploscompbiol/s/code-availability: authors must share 'all author-generated code directly related to their study's findings', for submissions from 30 March 2021; aeadataeditor.github.io/aea-de-guidance: replication package, 'verification checks' after submission)
- Prior: new (the three existing rows were verified by Phase 25 R41 to R43)
- Problem: For a cross-disciplinary audience, the table omits the two best-known mandatory code policies outside health.
- Why it matters: An economics or computational biology student may conclude that the obligation is a health-science peculiarity.
- Fix: Add rows for *PLOS Computational Biology* (code required since 2021) and the AEA journals (replication package checked by the Data Editor). Change 'three' to 'five'.

### 'Most widely followed in the health sciences' is unsupported
- Location: 01-reproducibility-crisis.qmd:433
- Quote: 'Academies, whose 2019 consensus report offers the'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected; unverified (no source cited, none found)
- Prior: new
- Problem: The sentence (01:433-434) makes a comparative empirical claim without a source. It also sits uneasily with 02:676-679, which says biomedical usages often swap the terms.
- Why it matters: It contradicts the book's own warning in the next chapter.
- Fix: Replace it with 'a widely cited settlement that this book adopts'.

### Phase 25 unverified items remain unverified
- Location: 01-reproducibility-crisis.qmd:429
- Quote: 'found that the same words carry opposite meanings in'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (Goodman 2016 paywalled; NCBI efetch of PMC4330755, Leek and Peng, returned front matter only; Europe PMC fullTextXML empty; acm.org badging page returned 403 to WebFetch and curl)
- Prior: new attempt on Phase 25 L17, L18, and the ACM claims at 02:657-676
- Problem: Several claims still rest on text no reviewer has opened: Goodman's 'opposite meanings', Leek and Peng's body text, and the ACM pre-2020 and v1.1 badge definitions.
- Why it matters: These sentences carry the vocabulary argument of Chapters 1 and 2.
- Fix: Someone with library access should open Goodman et al. 2016 and the ACM badging page. Until then, use 'conflicting meanings', which the abstract's 'nonstandard and unsettled' supports.

## Currency table (Task 2)

| Item | Book claim | file:line | Current fact (2026-11-25) | Source | Status |
|---|---|---|---|---|---|
| NIH DMS Policy | From 25 Jan 2023; updated format from 25 May 2026; no Plan for K awards | 10-archiving-sharing.qmd:1025-1033 | Correct. NOT-OD-26-100 also moves active awards to the new format by the FY2027 RPPR, and from 1 Oct 2026 changes are reported in the RPPR | NOT-OD-26-100, NOT-OD-26-120 (raw HTML) | verified; minor omission |
| NIH Public Access | absent | none | 2024 policy effective 1 July 2025 for manuscripts accepted on or after that date | NOT-OD-25-101 (raw HTML) | verified; gap |
| OSTP 2022 memo | absent | none | Policies due by 31 Dec 2025; repeal reported in progress (May 2026) | memo PDF text; aip.org/fyi (20 May 2026) | verified; repeal status rests on a news report |
| JASA, *Biostatistics*, AJE | table read 8 Nov 2026 | 10-archiving-sharing.qmd:1120-1125 | not re-fetched | Phase 25 R41 to R43 | relied on prior |
| PLOS CB, AEA | absent | none | PLOS CB code mandatory from 30 Mar 2021; AEA verification checks | journals.plos.org; aeadataeditor.github.io | verified; gap |
| `actions/checkout` | `@v7` | 09-continuous-integration.qmd:520, 545, 798, 1037, 1694 | v7.0.1 is the latest v7; `node24` | github.com/actions/checkout/releases; v7 action.yml | verified |
| `actions/upload-artifact` | not in chapters | none | v7 (v7.0.2 latest); repository workflow uses v7 | github.com/actions/upload-artifact/releases | verified |
| `r-lib/actions` | `@v2` | 09-continuous-integration.qmd:548-573, 1625-1698 | v2 is the current major (v2.14.0, 2026-09-21); no v3 seen; setup-r `node24` | github.com/r-lib/actions/releases; setup-r action.yml | verified |
| Node 20 | absent | none | Retired; runners use Node 24, no opt-out | github.blog changelog 2026-09-24 | verified; gap |
| R version | R 4.6.1 | 09-continuous-integration.qmd:617, 800, 921 | R 4.6.2 released 2026-10-29 | CRAN banner and src/base/R-4 | verified |
| Rocker | `rocker/verse:4.6.1` | 09-continuous-integration.qmd:800, 883 | `4.6.2` tag updated 2026-11-16 | Docker Hub tags API | verified |
| renv | 1.2.3 used; lockfile v2 since 1.1.0 | 04-dependencies.qmd:361, 443 | CRAN 1.3.1 (2026-10-06). 1.3.0 behavior changes (version constraints, `RemoteSha`) per the NEWS page read through a summarizing tool | CRAN; renv NEWS | version verified; NEWS unverified |
| pak | no version claim | none | 0.11.2 (2026-11-07) | CRAN | verified |
| Quarto | no chapter version claim | none | v1.11.9 latest release (30 Oct; year not shown, inferred 2026) | GitHub releases/latest | verified version |
| Docker Desktop | not free for larger organizations; education exception | 06-backends-runtimes.qmd:330-337 | Free under 250 employees and USD 10 million; also personal use, education, and non-commercial OSS. Paid for larger organizations and 'Government entities' | docs.docker.com/subscription/desktop-license | verified (agrees with Phase 25 A2-48) |
| Apptainer | Singularity until the LF move | 06-backends-runtimes.qmd:345 | LF Projects series; SingularityCE fork continues. Latest Apptainer version not confirmed on the project's own page | apptainer.org; search summaries | partly verified |

## Case bank

Status key. 'Citation verified; abstract read' means the DOI resolves,
the Crossref title matches, and I read the abstract or article text.
'Citation verified; details unverified' means the DOI resolves, but
the details come only from search-engine summaries; check them against
the paper before printing. 'In book' records prior use.

| # | Case | Discipline | One-line summary | Lesson | Primary citation | Status | In book |
|---|---|---|---|---|---|---|---|
| 1 | Reinhart and Rogoff | Economics | A re-analysis found that a spreadsheet range omitted several countries. Average growth above 90 percent debt was reported as 2.2 percent rather than -0.1 percent. Selective exclusions and weighting mattered more than the cell error. | Sharing the working file let outsiders find the error | Herndon, Ash, Pollin, *Camb. J. Econ.* 38(2), 2014; doi:10.1093/cje/bet075 (Crossref issued 2013) | Citation verified; details unverified | No |
| 2 | Duke genomic signatures (Potti) | Clinical genomics | Forensic re-analysis reported scrambled rows and wrong labels. Trials using the signatures were stopped and papers retracted. | Unreproducible analyses reached patients | Baggerly and Coombes, *Ann. Appl. Stat.* 3(4), 2009; doi:10.1214/09-AOAS291 | Citation verified; details unverified | No (A10 declined, D18) |
| 3 | JAMA COPD trial | Clinical medicine | A programming error in the analysis reversed a reported benefit into harm; retracted and republished in 2019. | A script error changed a clinical conclusion | Bauchner and Golub, *JAMA* 2019, doi:10.1001/jama.2019.14503; corrected article doi:10.1001/jama.2019.11982 | Citation verified; details unverified | No |
| 4 | Gene names converted to dates | Computational biology | About one-fifth of genomics papers with Excel gene lists had conversion errors (2016); 30.9 percent by 2021. | A silent software default corrupts published data | Ziemann et al., *Genome Biol.* 2016, doi:10.1186/s13059-016-1044-7; Abeysooriya et al., *PLOS Comput. Biol.* 2021, doi:10.1371/journal.pcbi.1008984 | Citation verified; abstract read | No |
| 5 | Willoughby-Hoye NMR scripts | Chemistry | Calculated shifts 'depended on the operating system' when using published Python scripts, a flaw that 'could lead to incorrect conclusions'. | The OS is a determinant, outside health | Bhandari Neupane et al., *Org. Lett.* 2019; doi:10.1021/acs.orglett.9b03216 | Citation verified; abstract read (mechanism unverified) | No |
| 6 | Chang structure retractions | Structural biology | An error in a homemade analysis program led to five retractions, three in *Science*. | Unreviewed custom code is a single point of failure | Miller, *Science* 314:1856, 2006; doi:10.1126/science.314.5807.1856 | Citation verified; details unverified | No |
| 7 | FreeSurfer version and platform | Neuroimaging | Volumes differed by 8.8 percent on average between FreeSurfer v5.0.0 and earlier versions, and by about half that between workstations and OS versions. | Version and platform are part of the result | Gronenschild et al., *PLOS ONE* 2012, doi:10.1371/journal.pone.0038234; see also Glatard et al. 2015, doi:10.3389/fninf.2015.00012 | Citation verified; abstract read (Glatard: details unverified) | No |
| 8 | Cluster failure in fMRI | Neuroimaging statistics | Three million null analyses found parametric cluster inference invalid at nominal 5 percent familywise error. | Defaults in widely used software need empirical checks. Caveat: '70%' is a familywise rate, and Cox et al. judged the AFNI bug minor (search summary) | Eklund, Nichols, Knutsson, *PNAS* 2016; doi:10.1073/pnas.1602413113 | Citation verified; abstract read | No |
| 9 | NARPS, 70 teams | Neuroimaging | Seventy teams analyzed one dataset; 'no two teams chose identical workflows', and results varied sizeably. | Robustness: shared workflows expose analytic variation | Botvinik-Nezer et al., *Nature* 582, 2020; doi:10.1038/s41586-020-2314-9 | Citation verified; abstract read | No |
| 10 | Many analysts, one data set | Psychology | Twenty-nine teams estimated one effect; odds ratios ranged from 0.89 to 2.93. | The analysis is a choice that code makes inspectable | Silberzahn et al., *AMPPS* 1(3), 2018; doi:10.1177/2515245917747646 | Citation verified; details unverified | No |
| 11 | Economics and social-science replications | Economics, social science | Eleven of 18 economics experiments replicated, at 66 percent of the original effect (2016). Thirteen of 21 *Nature* and *Science* experiments replicated, at about 50 percent (2018). | Replication failure is not unique to psychology or medicine | Camerer et al., *Science* 351, 2016, doi:10.1126/science.aaf0918; *Nat. Hum. Behav.* 2, 2018, doi:10.1038/s41562-018-0399-z | Citation verified; abstracts read | No |
| 12 | Abortion and crime | Economics | Foote and Goetz reported omitted state-year interactions in the code. The correction reduced the estimates; the original authors dispute how much it matters. | Code must implement the stated model | Foote and Goetz, *QJE* 123(1), 2008; doi:10.1162/qjec.2008.123.1.407 | Citation verified; details unverified | No |
| 13 | I4R mass reproduction (positive) | Economics, political science | More than 85 percent of claims in 110 papers from journals with mandatory code policies were computationally reproducible; the sample is 'highly selective'. | Enforced deposit works | Brodeur et al., *Nature* 652, 2026; doi:10.1038/s41586-026-10251-x | Citation verified; abstract read | No (third review advised it) |
| 14 | SCORE replication | Social and behavioral sciences | 55.1 percent of 274 claims, and 49.3 percent of 164 papers, replicated. | Current benchmark beside OSC 2015 | Tyner et al., *Nature* 2026; doi:10.1038/s41586-025-10078-y | Citation verified; abstract read | No |
| 15 | Reproducibility Project: Cancer Biology | Preclinical biomedicine | Fifty experiments from 23 papers; effects 85 percent smaller; 46 percent success overall. | The open successor to Begley and Ellis | Errington et al., *eLife* 10:e71601, 2021; doi:10.7554/eLife.71601 | Citation verified; abstract read | No |
| 16 | Shared RCT data re-analyzed | Clinical trials | Data were available for 17 of 37 RCTs, and 14 of those 17 were fully reproduced. | Health-specific re-execution evidence; policies alone yield under half the data | Naudet et al., *BMJ* 360:k400, 2018; doi:10.1136/bmj.k400 | Citation verified; abstract read | No |
| 17 | Open data at *Cognition* | Psychology | Reusable data rose after a mandatory policy, but many reproductions needed author help. | Availability is not reproducibility | Hardwicke et al., *R. Soc. Open Sci.* 5:180448, 2018; doi:10.1098/rsos.180448 | Citation verified; details unverified | No |
| 18 | Code availability in ecology | Ecology | 'only 27% of eligible articles were accompanied by code', versus 79 percent with data, under code-sharing policies. | Policy without enforcement leaves code unshared | Culina et al., *PLOS Biol.* 18:e3000763, 2020; doi:10.1371/journal.pbio.3000763 | Citation verified; abstract read | No |
| 19 | Ocean acidification and fish | Ecology | A transparent replication found 'negligible effects' where earlier papers reported large ones. | Open data and methods let a field correct itself | Clark et al., *Nature* 577, 2020; doi:10.1038/s41586-019-1903-y | Citation verified; abstract read | No |
| 20 | Leakage in ML-based science | Machine learning, many fields | Leakage was reported in 17 fields, affecting 294 papers. | A teachable error class for students using ML | Kapoor and Narayanan, *Patterns* 4:100804, 2023; doi:10.1016/j.patter.2023.100804 | Citation verified; details unverified | No |
| 21 | CODECHECK of CovidSim (positive) | Epidemiological modeling | An independent check reproduced the Report 9 tables, with small variations. | Runnable code let a contested policy model be verified quickly | Eglen, CODECHECK certificate 2020-010; doi:10.5281/zenodo.3865491 | Citation verified (DOI resolves); details unverified | Scheme in ch09; case no |
| 22 | Ten Years Reproducibility Challenge | Computational science | Researchers tried to re-run their own decade-old code, with mixed success. | Your future self is your compendium's first reader | Perkel, *Nature* 584:656, 2020; doi:10.1038/d41586-020-02462-7 | Citation verified; details unverified (sources disagree on counts) | No |
| 23 | Tuberculosis drugome | Computational biology | Reproducing one method 'took several months of effort'; novices could reproduce only a few steps. | Unrecorded workflows cost months | Garijo et al., *PLOS ONE* 8:e80278, 2013; doi:10.1371/journal.pone.0080278 | Citation verified; abstract read | No |
| 24 | LIGO GW150914 open data (positive) | Physics | GWOSC provides public access to gravitational-wave data, with tutorials and software. | Open data as standard practice in a large collaboration | Abbott et al., *Phys. Rev. Lett.* 116:061102, 2016, doi:10.1103/PhysRevLett.116.061102; gwosc.org/about | Citation verified; GWOSC page read (release history unverified) | No |
| 25 | England's lost COVID-19 cases | Public health informatics | In October 2020, 15,841 positive cases were left out of daily totals after a spreadsheet-based process hit a limit. | Manual, format-bound steps fail silently | Press reports of the PHE statement, e.g. theregister.com/2020/10/05/excel_england_coronavirus_contact_error/ | Unverified (PHE statement not opened; mechanism disputed) | No |

Disciplines covered: economics (1, 11, 12, 13), clinical medicine
(3, 16), clinical genomics (2), computational biology (4, 23),
chemistry (5), structural biology (6), neuroimaging (7, 8, 9),
psychology and social science (10, 11, 14, 17), ecology (18, 19),
machine learning (20), epidemiology and public health (21, 25), and
physics (24). Positive cases: 13, 19, 21, and 24, with 16 and 17
mixed.

Omitted:

- Collberg and Proebsting 2016 (doi:10.1145/2812803) and Archmiller et al. 2020 (doi:10.1002/jwmg.21855). Both DOIs resolve, but I could not confirm the rates.
- A recalled DOI for the I4R paper (10.1038/s41586-025-08578-3), which returned 404.

## Scope disclosure

Read in full:

- `01-reproducibility-crisis.qmd` (1,488 lines)
- `00-intro.qmd` (332 lines)
- `THIRD-REVIEW-PLAN.md` (991 lines)
- `docs/third-review/factual-issues.md` (178 lines)
- Phase 25 `BRIEF.md` and `agent4-report.md`
- `docs/fourth-review-prompt.md`
- The fourth-review `BRIEF.md`

Read in part:

- `02-levels-of-reproducibility.qmd`: lines 560 to 720 and a citation grep; the chapter has no other named cases.
- `10-archiving-sharing.qmd`: lines 1015 to 1135.
- `09-continuous-integration.qmd`: lines 510 to 580, 790 to 805, and 915 to 925.
- `06-backends-runtimes.qmd`: lines 320 to 350.
- Phase 25 `agent1-report.md` and `agent2-report.md`: grep and the relevant rows.
- Phase 25 `agent3-report.md`: headings only.
- `REFACTOR-PLAN.md` and `docs/third-review/*.md`: grepped for this scope's topics. The hits are cited in the findings.

How sources were checked:

- Opened directly, with raw text: NIH notices (curl), the OSTP memo (pdftotext), Baker's PDF, Begley and Ellis's page, Brodeur's PDF, the eLife API abstract, PMC (Naudet), Europe PMC abstracts, arXiv, the action.yml files, and the CRAN, Docker Hub, and GitHub release pages.
- A summarizing fetch tool misreported NOT-OD-26-100 before I read the raw text, so I relied on it only for non-critical details.

Not verified:

- Goodman 2016, the body of Leek and Peng, and the ACM badging page.
- Trisovic's field mix.
- Whether pre-Node-24 action tags fail or only warn.
- The latest Apptainer version on its own page.
- The PHE statement.
- The case-bank details marked unverified.

No code was executed apart from curl, pdftotext, and short Python text extraction. No render was run.
