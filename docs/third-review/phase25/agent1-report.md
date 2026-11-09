# Phase 25, Agent 1: regulation, policy, standards, reporting guidelines
*2026-11-08 16:58 PST*

Scope: FDA (Part 11, 2003 scope guidance, GPSV, Pilot 4), EMA, NIH
(DMS, NOT-OD-25-081, -25-132, -23-149), HIPAA, EHDS, SATRE, Five
Safes, All of Us, dbGaP, ICMJE, OWASP, CONSORT 2025, SPIRIT 2025,
TRIPOD+AI, NHS RAP, journal table, SWHID ISO, FAIR. All sources
accessed 2026-11-08. No repository file was edited. Downloads are in
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p25/`.

The eCFR redirected to its unblock page again, so I used the official
GPO annual edition of the CFR (govinfo, revised as of 1 April 2025),
which is a primary source: `CFR-2025-title21-vol1-part11.xml` and
`CFR-2024-title45-vol2-sec164-514.xml`. Part 11's source line is
still 62 FR 13464 (1997), so later amendments are unlikely.

## 1. Claims

| id | file:line | claim | status | source | evidence |
|---|---|---|---|---|---|
| R1 | 08-testing-quality:1475-1479 | 11.10(a) quotation; applies to closed systems | verified | govinfo 21 CFR 11.10 (2025 ed.) | Text reads exactly 'accuracy, reliability, consistent intended performance, and the ability to discern invalid or altered records'; intro says 'closed systems to create, modify, maintain, or transmit' |
| R2 | version-control:849-851; glossary:35-38; version-control:501-504 | 11.10(e) wording: 'Record changes shall not obscure ...'; secure, computer-generated, time-stamped, independent | verified | same | Exact quotation matches; the trail must 'independently record the date and time of operator entries and actions' |
| R3 | version-control:1471-1473 | 11.50(a): printed name, date and time, meaning | verified | govinfo 21 CFR 11.50 | (a)(1) to (a)(3) match |
| R4 | version-control:2129-2130 | approval is not 'an electronic signature under 21 CFR 11.50(a)' | hedged | same | 11.50 sets out signature manifestations, not what an electronic signature is (11.3, subpart C) |
| R5 | references.bib `cfr21part11` | entry titled '21 CFR 11.10' and linked to 11.10, but cited for 11.50(a) and Part 11 generally | corrected (bib) | govinfo; Cornell part-11 URL returns 200 | Citation target does not contain 11.50 |
| R6 | references.bib `fdapart11scope2003` | title and date | verified | fda.gov/media/75414/download (PDF cover) | Cover: 'Guidance for Industry / Part 11, Electronic Records; Electronic Signatures — Scope and Application', August 2003; the web page gives September 2003 as issue date |
| R7 | 08-testing-quality:1492-1497 | enforcement discretion over Part 11 validation; predicate rules still apply | verified in substance; gloss hedged | same PDF, Section III.C.1 and p. 2 | 'exercise enforcement discretion regarding specific part 11 requirements for validation of computerized systems (§ 11.10(a) ...)'; predicate rules are defined as 'The underlying requirements set forth in the Act, PHS Act, and FDA regulations (other than part 11)', not as GCP and GMP |
| R8 | glossary:832-835 | GPSV definition of validation | corrected | fda.gov/media/73141/download, Section 3.1.2 | Source: 'confirmation by examination and provision of objective evidence that software specifications conform to user needs and intended uses'; book says 'software conforms' and 'documented evidence' |
| R9 | glossary:844-846 | GPSV definition of verification | verified | same | 'objective evidence that the design outputs of a particular phase ... meet all of the specified requirements for that phase' |
| R10 | references.bib `fdagpsv2002` | title, year | verified | same PDF | 'General Principles of Software Validation; Final Guidance for Industry and FDA Staff', issued 11 January 2002. The 2026 cover note says Section 6 is superseded by the Computer Software Assurance guidance (24 September 2025); the definitions in 3.1.2 are not affected |
| R11 | 08-testing-quality:1486-1490 | IQ/OQ/PQ from qualification practice, per Nicholls | verified | pharmar.org/white-paper | 'A system qualification typically includes the execution of Installation, Operational and Performance tests' |
| R12 | 08-testing-quality:1497-1502 | Part 11 'not relevant or mandatory' for statistical software; elements apply within a validated system | verified | same | Both sentences present |
| R13 | 08-testing-quality:1534-1556 | Validation Hub: R Consortium group; intended for use; four criteria; base and recommended minimal risk; tidyverse 'reasonable case'; tests for modeling functions whatever the risk | verified | same | All present; byline 'an R Consortium-funded ISC Working Group' |
| R14 | 08-testing-quality:1480-1483; 02-levels:705-706 | EMA has parallel expectations for computerized systems (uncited) | hedged (citation added) | EMA/INS/GCP/112288/2023 PDF | Final, adopted 7 March 2023; scope names 'statistical software' among sponsor systems |
| R15 | 05-containers:847-853 | Pilot 4: reviewers 'had to install WSL and Docker Desktop on Windows laptops' | hedged | FDA review PDF (RConsortium/submissions-wg) | Review lists 'Installed Windows Subsystem for Linux (WSL) and Docker Desktop' and testing 'on a Windows platform'; it says agency-issued laptops do not support Docker Desktop without a paid license and WSL 'may not be permitted' |
| R16 | 05-containers:852-856 | R version decided restore; dated May 2026; 'may not ... robustness' | verified | same; R Consortium post 14 May 2026 | 'Date(s): May, 2026', signatures 2026-05-04; 'may not provide the level of robustness required for regulatory submissions'; file submitted as 'dockerfile' |
| R17 | _llm-rule:15-21 | NOT-OD-25-081: 'third-party' tools; model as derivative not distributable without approval | hedged | grants.nih.gov NOT-OD-25-081 (raw HTML) | Notice says 'public generative AI tools (e.g., third party tools)'; models are Data Derivatives, shareable only 'with collaborators who are also Approved Users', and not retained after closeout |
| R18 | 10-archiving-sharing:1610-1612 | NIH policy 'applies to any third-party generative AI tool, not only to public ones' | corrected | same | The notice says the opposite emphasis: 'public ... (e.g., third party tools)'. It has no carve-out for licensed tools, but it does not extend itself as the book says |
| R19 | 01-reproducibility-crisis:1102-1106 | NOT-OD-25-132 and NOT-OD-23-149 | verified | grants.nih.gov, both notices | 25-132 (17 July 2025): applications 'substantially developed by AI' not original ideas; 23-149 (23 June 2023): reviewers prohibited from using generative AI for critiques; bib titles match `<title>` |
| R20 | 01-reproducibility-crisis:1057-1066 | ICMJE: no AI authorship (accuracy, integrity, originality); disclose in cover letter and section | verified | icmje.org AI use by authors | Page headed 'V.A. Use of AI by Authors'; matches bib note |
| R21 | 01-reproducibility-crisis:1037-1043 | OWASP LLM01 first; no fool-proof prevention; LLM06 least privilege and human approval | verified | genai.owasp.org LLM01, LLM06 | 'it is unclear if there are fool-proof methods of prevention'; 'require a human to approve high-impact actions' |
| R22 | 10-archiving-sharing:850-853 | DMS Policy in force 25 Jan 2023; controlled access for limited data; limits 'passed to the repository' [@nihdms2020] | corrected (citation) | NOT-OD-21-013; NIH privacy best-practices page | Policy: 'data carrying explicit limitations on subsequent use require access controls'. The pass-to-repository point is in the privacy page ('conveyed with the data ... communicate this information to repositories'), not the policy |
| R23 | 10-archiving-sharing:1019-1024 | Plan required at application; applies from 25 Jan 2023 | hedged | NOT-OD-21-013 Section IV; NOT-OD-26-120 (5 Oct 2026); NOT-OD-26-100 (29 July 2026) | True as stated for 2023; since then K awards need no Plan, and applications from 25 May 2026 use an updated Plan format |
| R24 | 10-archiving-sharing:1024-1027 | 'Other Plan(s)' field; summary and costs in budget | verified | NIH 'Writing a DMS Plan' | Both quoted on the page |
| R25 | 10-archiving-sharing:1027-1029 | program staff review 'for completeness rather than scoring it' | corrected | NOT-OD-21-013 | Policy: 'NIH Program Staff assessments of Plans merits'; peer reviewers may comment on the DMS budget but 'these comments will not impact the overall score'. 'Completeness' is not in the source |
| R26 | 10-archiving-sharing:1029-1033 | term and condition; noncompliance: special terms, 'withheld funds', termination, future funding | corrected | same | Policy lists 'additional special terms and conditions or termination of the award, and may affect future funding decisions'; withheld funds not stated |
| R27 | 10-archiving-sharing:812-823 | HIPAA: expert determination 'very small'; 18 identifiers plus no actual knowledge; limited data set needs DUA | verified | govinfo 45 CFR 164.514 (2024 ed.) | (b)(1), (b)(2)(i)(A) to (R) = 18, (b)(2)(ii), (e)(1) and (e)(4) |
| R28 | 10-archiving-sharing:906-909 | check answer: 'a determination that the risk is very small must be made by a qualified expert or by removing all eighteen' identifiers | hedged | same | Safe Harbor is not a risk determination and also needs no actual knowledge |
| R29 | 10-archiving-sharing:823-825 | NIH: legally de-identified data may still warrant controlled access | verified | NIH privacy best practices | 'regardless of whether the data meet technical and/or legal definitions of "de-identified"' |
| R30 | 10-archiving-sharing:845-849 | dbGaP public descriptions plus authorized access, security procedures, code of conduct | verified | dbgap.ncbi.nlm.nih.gov/home | Public files, Authorized Access, 'Security Procedures', 'Code of Conduct' links |
| R31 | 10-archiving-sharing:930-941 | All of Us 'solely' on the Workbench; EHDS in force 26 March 2025, permit, SPE, Article 73 non-personal download, March 2029 | verified | researchallofus.org; health.ec.europa.eu; EUR-Lex 2025/327 Art. 73(2) | Art. 73(2): users 'only able to download non-personal electronic health data'; 2029 most categories, 2031 the rest |
| R32 | 10-archiving-sharing:941-944, 960-964, 986-988, 1000-1002 | SATRE 2.0.1 dated July 2026; 3.3.04/3.3.05 mandatory; 3.3.03 recommended; 2.1.12/2.1.13 and 3.3.09 optional | verified | satre-specification.readthedocs.io | Release table: 2.0.1, 2026-07-23; importance levels match |
| R33 | 10-archiving-sharing:946-953 | Five Safes from the ONS; five definitions | verified | UKDS Five Safes page | 'originated from the ONS'; definitions match |
| R34 | 10-archiving-sharing:965-968 | All of Us 1 to 20 rule, percentages included | verified | researchallofus.org/?p=4698 | Both rules quoted on the page |
| R35 | 10-archiving-sharing:1080-1084 | SPIRIT and CONSORT 2025 each gained an 'Open science' section | verified | SPIRIT PDF (UCL Discovery); CONSORT JATS XML from journals.plos.org | Both state the new section |
| R36 | 10-archiving-sharing:1084-1089 | SPIRIT items 5 and 6 | verified | SPIRIT 2025 PDF, Table 1 | Item 6 includes 'data dictionary' and 'will be accessible' |
| R37 | 10-archiving-sharing:1089-1095 | CONSORT items 3 and 4, rested on prose; table 'not available as text' | corrected | PLOS Med JATS XML, `type=manuscript`, Table 1 | Table 1 is in the XML as text. Item 3: 'Where the trial protocol and statistical analysis plan can be accessed'. Item 4: 'Where and how the individual de-identified participant data (including data dictionary), statistical code and any other materials can be accessed'. Box 1 confirms item 3 revised, item 4 new |
| R38 | references.bib `chanspirit2025`, `hopewellconsort2025` | DOIs | verified | `curl -sI https://doi.org/...` | Both 302 to BMJ and PLOS |
| R39 | 10-archiving-sharing:1051-1059 | TRIPOD+AI 18e, 18f wording, footnote, 'Open science' | verified (via reproduction) | ORA Oxford deposit reproducing the checklist 'From: Collins GS ... BMJ 2024;385:e078378' | 18f 'Provide details of the availability of the analytical code'; footnote 'any data cleaning, feature engineering, model building, evaluation'; heading OPEN SCIENCE. PMC and BMJ returned captcha or 403 |
| R40 | 03-research-compendium:783-793 | NHS RAP baseline criteria; README quotation | verified; one gloss hedged | nhsdigital.github.io levels_of_RAP | Five baseline criteria; README quotation exact. First criterion is 'Data produced by code in an open-source language', not 'open-source code' |
| R41 | tbl-journal-code, JASA row | required at invited revision; ACS 2016, T&M 2021; ACC at submission; AER review | verified | jasa-acs.github.io/repro-guide and /pages/author-guidelines | All four on the two pages |
| R42 | tbl-journal-code, Biostatistics row | D, C, R marks; 'where ethically feasible'; no review described | verified | academic.oup.com/biostatistics General_Instructions | Page defines R as 'both data and code are available'; no AER mentioned |
| R43 | tbl-journal-code, AJE row | DAS required; sharing encouraged; editors may request statistical review | verified | academic.oup.com/aje General_Instructions | All three quoted |
| R44 | 10-archiving-sharing:687-689 | SWHID an ISO/IEC standard in 2025 | verified | Standards Council of Canada record (ccn-scc.ca/standardsdb/standards/2057061) | 'ISO/IEC 18670:2025, Information technology - SoftWare Hash IDentifier (SWHID) Specification V1.2', published 2025-04-22. iso.org returned 403 |
| R45 | 10-archiving-sharing:640-643 | FAIR R1.1 quotation | verified | GO FAIR R1.1 page (nature.com redirected to login) | '(meta)data are released with a clear and accessible data usage license' |
| R46 | references.bib `barker2022` | FAIR4RS DOI | verified | `curl -sI https://doi.org/10.1038/s41597-022-01710-x` | 302 to nature.com |
| R47 | 09-continuous-integration:1154-1157 | GitHub keeps logs and artifacts 90 days by default; adjustable | verified | GitHub Docs retention page | 90 days; 1 to 90 public, 1 to 400 private |
| R48 | preface:115-123; 08:1475; version-control:1462-1476 | scope paragraph; Validation Hub as guidance | verified (no factual claim beyond R1 to R13) | as above | |

## 2. Replacement blocks

### R4 version-control.qmd
OLD:
```
trial, the approval is review evidence rather than, by
itself, an electronic signature under 21 CFR 11.50(a);
whether it serves as one depends on the sponsor's
```
NEW:
```
trial, the approval is review evidence rather than, by
itself, a signed record carrying the printed name, the
date and time, and the meaning that 21 CFR 11.50(a)
requires; whether it serves as one depends on the sponsor's
```

### R7 08-testing-quality.qmd
OLD:
```
exercise enforcement discretion over the Part 11
validation requirement, while the predicate rules, the
underlying good clinical and manufacturing practice
regulations, still apply [@fdapart11scope2003]. The R
```
NEW:
```
exercise enforcement discretion over the Part 11
validation requirement, while the predicate rules, the
underlying requirements of the Act and of FDA's other
regulations, still apply, their own validation
requirements included [@fdapart11scope2003]. The R
```

### R8 glossary.qmd
OLD:
```
*Regulated sense:* in FDA software guidance, validation means
confirming that software conforms to user needs and its intended
use, with documented evidence [@fdagpsv2002]. That is a broader
```
NEW:
```
*Regulated sense:* in FDA software guidance, validation is
confirmation, by examination and objective evidence, that
software specifications conform to user needs and intended uses
[@fdagpsv2002]. That is a broader
```

### R14a 08-testing-quality.qmd
OLD:
```
altered records' [@cfr21part11]. The same standard is
reflected in parallel form in European Medicines Agency
expectations for computerized systems in the same
regulatory setting. This is validation of the system
```
NEW:
```
altered records' [@cfr21part11]. The European Medicines
Agency sets parallel expectations for computerized
systems in clinical trials, and names statistical
software among them [@ema2023computerised]. This is
validation of the system
```

### R14b 02-levels-of-reproducibility.qmd
OLD:
```
11.10(a) [@cfr21part11]. European regulators expect
something comparable of a sponsor's analysis tools. A
```
NEW:
```
11.10(a) [@cfr21part11]. European regulators expect
something comparable of a sponsor's analysis tools
[@ema2023computerised]. A
```

### R15 05-containers.qmd
OLD:
```
submitted to the FDA with a Dockerfile, the agency's
statistical reviewers had to install WSL and Docker
Desktop on Windows laptops, and found that the R version
still decided whether the packages restored
```
NEW:
```
submitted to the FDA with a Dockerfile, the agency's
statistical reviewers installed WSL and Docker Desktop on
Windows. They noted that agency-issued laptops may not
permit WSL or an unlicensed Docker Desktop, and found
that the R version still decided whether the packages
restored
```

### R17 _llm-rule.qmd
OLD:
```
under which a data provider released the data. NIH, for
example, treats sharing controlled-access data with
third-party generative AI tools through prompts as a breach
of the data use certification, and a model trained on such
data as a derivative that may not be distributed without
approval [@nihgenai2025].
```
NEW:
```
under which a data provider released the data. NIH, for
example, treats sharing controlled-access data through
prompts with public generative AI tools, which it glosses as
third-party tools, as a breach of the data use certification.
It treats a model trained on such data as a data derivative,
to be shared only with other approved users and not kept
after the project closes [@nihgenai2025].
```

### R18 10-archiving-sharing.qmd
OLD:
```
include row-level logs and small-count tables, and the
NIH policy cited above applies to any third-party
generative AI tool, not only to public ones. A prompt about
```
NEW:
```
include row-level logs and small-count tables. The NIH
notice cited above names public generative AI tools, which
it glosses as third-party tools, and makes no exception for
a tool an institution has licensed. A prompt about
```

### R22 10-archiving-sharing.qmd
OLD:
```
January 2023. It expects controlled access for data with
explicit limits on later use, and asks that those limits
be passed to the repository that holds the data
[@nihdms2020].
```
NEW:
```
January 2023. It requires access controls for data with
explicit limits on later use [@nihdms2020]. NIH's privacy
guidance adds that those limits should travel with the
data and be communicated to the repository
[@nihprivacy2026].
```

### R23, R25, R26 10-archiving-sharing.qmd
OLD:
```
not drafted after data collection is underway
[@nihdms2020]. The Plan goes in the 'Other Plan(s)'
attachment of the research plan; only a brief summary
and the associated costs go in the budget and its
justification [@nihdmswriting]. NIH
program staff review the Plan for completeness rather
than scoring it. However, once an award is made, the
approved Plan becomes a term and condition of that award.
Noncompliance can bring added special terms, withheld
funds, or termination, and can affect future funding
decisions [@nihdms2020]. For the analyst, the choice
```
NEW:
```
not drafted after data collection is underway
[@nihdms2020]. Applications submitted on or after 25 May
2026 use an updated Plan format [@nihnot26100], and
career development (K) awards no longer need a Plan
[@nihnot26120]. The Plan goes in the 'Other Plan(s)'
attachment of the research plan; only a brief summary
and the associated costs go in the budget and its
justification [@nihdmswriting]. NIH program staff
assess the Plan. Peer reviewers may comment on its
budget, but those comments do not affect the overall
score. Once an award is made, the approved Plan becomes
a term and condition of that award. Noncompliance can
bring added special terms and conditions or termination
of the award, and can affect future funding decisions
[@nihdms2020]. For the analyst, the choice
```

### R28 10-archiving-sharing.qmd
OLD:
```
a person. A determination that the risk is very small
must be made by a qualified expert or by removing all
eighteen HIPAA identifiers, not by the analyst's own
judgment. Absent that determination in writing from the
```
NEW:
```
a person. De-identification needs either a qualified
expert's documented determination that the risk is very
small, or removal of all eighteen HIPAA identifiers with
no actual knowledge that the rest could identify anyone.
The analyst's own judgment is neither. Absent that
determination in writing from the
```

### R37 10-archiving-sharing.qmd
OLD:
```
protocol, can be accessed. Its new item 4 asks where
and how the de-identified participant data, the statistical
code, and other materials can be accessed. (The CONSORT
wording here follows the statement's own description of
these items; its checklist table was not available to us as
text.) Two consequences follow. The protocol promises, under
```
NEW:
```
protocol, can be accessed. Its new item 4 asks where
and how the individual de-identified participant data, with
their data dictionary, the statistical code, and any other
materials can be accessed. Two consequences follow. The
protocol promises, under
```

### R40 03-research-compendium.qmd
OLD:
```
of its baseline level, alongside open-source code, version
control, peer review of the code, and open publication.
```
NEW:
```
of its baseline level, alongside code in an open-source
language, version control, peer review of the code, and
open publication.
```

## 3. For the lead

Replace `cfr21part11` (key unchanged), so that the 11.50(a) and Part 11
citations point at a source that contains them:

```bibtex
@misc{cfr21part11,
  title        = {21 {CFR} Part 11: Electronic Records; Electronic
                  Signatures},
  note         = {Code of Federal Regulations, Title 21, Part 11,
                  revised as of 1 April 2025},
  url          = {https://www.govinfo.gov/app/details/CFR-2025-title21-vol1/CFR-2025-title21-vol1-part11},
  urldate      = {2026-11-08}
}
```

(The govinfo details URL returns 200. Cornell's
`https://www.law.cornell.edu/cfr/text/21/part-11` also returns 200, if
the lead prefers it.) `fdapart11scope2003` needs no change: its
title and 'August 2003' note match the PDF cover.

New entries (no DOIs exist for these):

```bibtex
@misc{ema2023computerised,
  author       = {{European Medicines Agency, GCP Inspectors Working
                  Group}},
  title        = {Guideline on Computerised Systems and Electronic
                  Data in Clinical Trials},
  year         = {2023},
  note         = {EMA/INS/GCP/112288/2023, 9 March 2023},
  url          = {https://www.ema.europa.eu/en/documents/regulatory-procedural-guideline/guideline-computerised-systems-electronic-data-clinical-trials_en.pdf},
  urldate      = {2026-11-08}
}

@misc{nihnot26100,
  author       = {{National Institutes of Health}},
  title        = {Implementation Update: {NIH} Data Management and
                  Sharing Plan Requirements},
  year         = {2026},
  note         = {Notice NOT-OD-26-100, released 29 July 2026},
  url          = {https://grants.nih.gov/grants/guide/notice-files/NOT-OD-26-100.html},
  urldate      = {2026-11-08}
}

@misc{nihnot26120,
  author       = {{National Institutes of Health}},
  title        = {Accelerated Implementation of Data Management and
                  Sharing Plan Changes for {NIH} Career Development
                  ({K}) Awards},
  year         = {2026},
  note         = {Notice NOT-OD-26-120, released 5 October 2026},
  url          = {https://grants.nih.gov/grants/guide/notice-files/NOT-OD-26-120.html},
  urldate      = {2026-11-08}
}
```

Both NOT-OD-26 titles match the `<title>` elements of the notice
pages (checked by grep on the downloaded HTML).

Optional, verified: Ch 13:687-689 could name the standard, 'as ISO/IEC
18670:2025'. The `swhiso2025` source (OpenChain news) is secondary;
the Standards Council of Canada record is the closer source if a
citation to the standard itself is wanted.

## 4. Not verified, and why

- eCFR would not open (302 to an unblock page). The GPO annual edition
  was used instead; it is current to 1 April 2025, not to today.
- TRIPOD+AI wording rests on a third-party deposit that reproduces the
  BMJ checklist and names it as the source; PMC showed a captcha and
  BMJ returned 403.
- SWHID: iso.org returned 403; the date rests on the Standards
  Council of Canada database.
- FAIR R1.1 rests on the GO FAIR page; nature.com redirected to login.
- Several fetches went through a summarizing tool. Where a claim turns
  on exact words (NOT-OD-25-081, -25-132, -23-149, -26-100, -26-120,
  NOT-OD-21-013, Part 11, 164.514, GPSV, the 2003 guidance, SPIRIT,
  CONSORT, the Pilot 4 review, EHDS Art. 73), I read the raw text.
  The journal pages, SATRE, UKDS, All of Us, OWASP, ICMJE, NHS RAP, and
  GitHub retention rest on the summarizing tool's quotations.
- The `nhsrap2024` year (2024) could not be checked: the page shows no
  date.
- Not in the book, so not checked: ICH E9 and E6(R3), NOT-OD-24-157,
  TRIPOD-LLM, the FDA Statistical Software Clarifying Statement.

## Message to the lead

Report at this path. Of 48 claims, 33 verified; corrections in 7
(R5 bib, R8, R18, R22, R25, R26, R37), hedges in 8 (R4, R7, R14,
R15, R17, R23, R28, R40). Points that need a decision: (1) Ch 13:1611
reverses NOT-OD-25-081, which names *public* tools 'e.g., third party
tools'. (2) The CONSORT checklist is available as text in the PLOS JATS
XML, so the 'not available to us' parenthesis can go. (3) NIH changed
the DMS Plan in 2026: an updated format from 25 May 2026, and K awards
exempted on 5 October 2026. (4) `cfr21part11` points at 11.10 only but
is cited for 11.50(a). (5) The 2003 guidance title in the bib matches
the PDF cover. Three new bib entries; none has a DOI.
