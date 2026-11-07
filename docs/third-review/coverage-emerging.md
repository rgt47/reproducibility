# Coverage review 3: emerging topics (late 2023 to November 2026)
*2026-11-07 11:38 PST*

## Summary

1. The book is current on most tooling: Nix and `rix`, devcontainers and Codespaces, SWHID, TRIPOD+AI, the NIH DMS Policy, AI-use disclosure, coding agents, and the `rang` CRAN archival (ch10 only). New tools such as `rv`, Positron, and webR are rightly absent.
2. Major gap: trusted research environments (enclaves, secure processing environments, output checking) appear nowhere in the book (0 grep hits). REFACTOR-PLAN 10.10 listed them as Priority 1, and the Phase 11 record calls the work complete, so this item was planned but never delivered.
3. Major gap: CONSORT 2025 and SPIRIT 2025 (April 2025) now make statistical-code access a numbered checklist item. They are the reporting guidelines this audience will meet most often, and the book cites only TRIPOD+AI.
4. Missing currency points from NIH and FDA: NIH NOT-OD-25-081 says putting controlled-access data into public generative AI tools breaches the data use certification; NOT-OD-24-157 requires NIST SP 800-171; and the May 2026 FDA review of R Submissions Pilot 4 found that containers 'may not yet provide the level of robustness required for regulatory submissions'.
5. Ranked additions (about 5 pages in total): TRE section; CONSORT/SPIRIT 2025 paragraph; NIH controlled-access and AI rules; LLM calls inside a pipeline; the Pilot 4 container lesson. There is also one minor correction: `04-dependencies.qmd:995` recommends `rang` without the archival note that ch10 carries.

## Method and evidence

I read the common and coverage briefs, REFACTOR-PLAN 10.4 (Findings 22, 23, 26), 10.10, and the Phase 11 record (10.17). I grepped every chapter `.qmd` for about 120 terms, using word-bounded patterns where short tokens gave false positives: `TRE`, `rig`, `ISO`, and `ICH` matched 'which', 'agreement', and similar words, so those counts were discarded and the terms re-run. All web sources below were opened on 2026-11-07 unless marked [U]. A search-result snippet that I could not open is marked [U] and is not used as the sole support for a recommendation. Labels: [V] ran it; [I] read the source; [EK] expert knowledge, unchecked; [U] could not open.

## Findings ranked by severity

### Major 1. Trusted research environments are absent, although the plan says they were added

- **Location:** `10-archiving-sharing.qmd:676-826` (the Restricted data section). Grep across all chapters for `trusted research`, `Five Safes`, `enclave`, `secure processing`, `workbench`, `airlock`, `output check`, `safe haven`, `N3C`, `All of Us`, `offline`, and `air-gap` returns zero hits [I, structural check]. REFACTOR-PLAN 10.10, row 1, lists 'trusted research environments, Five Safes' as Priority 1 for ch10, and 10.17 records Phase 11 as complete.
- **What is wrong:** The section treats restricted data only as a deposit problem: de-identify it, synthesize a stand-in, or cite dbGaP. It never covers the case that is now routine for US and European health data, where the analyst *computes inside* a governed environment. The NIH All of Us Researcher Workbench states that 'analysis will solely take place on the Researcher Workbench', with RStudio and Jupyter provided [I]. The EU EHDS Regulation entered into force on 26 March 2025, and secondary use under it is permitted only in 'secure processing environments' from March 2029 [I]. The UK SATRE specification (v2.0.1, July 2026) names output management as a core capability [I]. Inside such environments the book's L2 toolkit often fails. Docker may be unavailable, the internet is closed (so `renv::restore()` from CRAN or Posit Package Manager fails), and every exported artifact passes a human output check. A student who meets an enclave after this course has no guidance on what reproducibility means there.
- **Fix:** See Addition 1 below.

### Major 2. CONSORT 2025 and SPIRIT 2025 code-availability items are not cited

- **Location:** `10-archiving-sharing.qmd:863-893` cites only TRIPOD+AI 18e/18f. CONSORT and SPIRIT have no relevant hits (the only matches are 'dispiriting' and 'consortium') [I, structural check].
- **What is wrong:** SPIRIT 2025, published in the BMJ in 2025 (389:e081477, accepted 31 January 2025), creates an 'Open science' section. Item 5 asks 'Where the trial protocol and statistical analysis plan can be accessed'. Item 6 asks 'Where and how the individual de-identified participant data (including data dictionary), statistical code, and any other materials will be accessible' [I: read the PDF, table 1]. CONSORT 2025 has the matching item 4 for trial reports (BMJ 2025;388:e081123). I confirmed this through a secondary guide; the BMJ page returned 403, so for CONSORT it is [I-secondary]. For biostatistics and epidemiology students, CONSORT and SPIRIT are the guidelines they will actually complete. TRIPOD+AI covers prediction models only. SPIRIT item 5 also gives ch08's 'analysis plan as oracle' (`08-testing-quality.qmd:368-380`) an external anchor: the SAP must now be accessible.
- **Fix:** See Addition 2 below.

### Major 3. Regulator experience with containers is missing from the containers argument

- **Location:** `05-containers.qmd:888-923` (The honest level); `08-testing-quality.qmd:1273-1372` (Validation in the regulated sense). No chapter mentions the R Submissions pilots' outcomes [I, structural check].
- **What is wrong:** The R Consortium's 14 May 2026 post on the FDA review letter for Pilot 4 reports that WebAssembly 'did not identify major issues' but 'does not yet remove the need to reproduce the applicant's computing environment' (renv was still needed). Containers, 'as implemented', 'do not fully eliminate the need for manual configuration' and 'may not yet provide the level of robustness required for regulatory submissions'. The barriers were Docker Desktop licensing and WSL on agency laptops [I]. This is the strongest evidence of recent years about the book's central L2 mechanism in a health-regulatory setting. The book's honest-level sections would be more honest with it.
- **Fix:** See Addition 5 below.

### Minor 4. `rang` is recommended in ch04 without the archival note

- **Location:** `04-dependencies.qmd:995-1004` and `1052-1055`, and glossary line 507, versus `10-archiving-sharing.qmd:909-915`.
- **What is wrong:** CRAN shows `rang` 'Archived on 2026-08-22 as issues were not corrected in time'. The archive's latest version is 0.3.0, dated 2023-10-08 [I: CRAN package page and archive index opened]. ch10 already says this. ch04, which is where the reader first meets the tool, calls it 'the natural instrument' with no caveat. This confirms the known-issues list's dated claim about `rang`. `groundhog` is on CRAN (3.4.0, 2026-01-10) [I]. `capsule` has no CRAN page (404) [I]. That is not an error, since the book cites it without suggesting a CRAN install, but a reader may assume one.
- **Fix:** Add a one-sentence parenthetical at ch04:1004 that mirrors ch10:909-915, and note in the glossary that `capsule` installs from GitHub.

### Minor 5. The LLM data-governance rule lacks its NIH anchor

- **Location:** `01-reproducibility-crisis.qmd:888-896`, `08-testing-quality.qmd:1557`.
- **What is wrong:** The rule ('Never paste ... data under a data use agreement ... into a model unless the endpoint is approved') is sound. However, it is stated as house policy. NIH NOT-OD-25-081 (28 March 2025) makes it a regulatory obligation: sharing controlled-access data 'with public generative AI tools ... via prompts or other user interfaces is in violation of the provision on Non-Transferability'. The notice also treats a model trained on such data as a Data Derivative that may not be retained after closeout [I]. NOT-OD-24-157 (effective 25 January 2025) requires approved users, including users of third-party cloud systems, to attest to NIST SP 800-171 [I]. NOT-OD-25-083 (effective 4 April 2025) bars institutions in named countries from NIH controlled-access repositories [I]. These notices formally cover human genomic data, and dbGaP is the book's own example at `10:752`.
- **Fix:** See Addition 3 below.

### Minor 6. Other small currency points

- **Large-scale reproduction evidence.** The Institute for Replication's working paper, published in *Nature* 652:151-156 (2026), found that over 85 percent of claims in 110 economics and political-science papers were computationally reproducible. These were journals with mandatory data and code policies [I: IDEAS/RePEc abstract]. The citation is absent from `01-reproducibility-crisis.qmd:300-387`. It is the largest recent re-execution study and is directly on the book's thesis, although it is outside health. Add one sentence.
- **Institutional code checks.** Institutional CODECHECKs began in August 2025 at TU Delft and at Amsterdam UMC, a medical center. The register has 132 certificates as of September 2026 [I]. `09-continuous-integration.qmd:1334-1345` describes CODECHECK only as a peer-review scheme. A pre-submission check offered by the analyst's own institution is the form a health-sciences student is most likely to meet. Add one sentence.

## Candidate-topic table

Breadth counts the distinct issuing bodies among the sources I opened (lower bound). 'Newness' is the date the item entered practice.

| Topic | Book status | Scope | Breadth | Newness | Settledness | Sources (opened 2026-11-07) |
|---|---|---|---|---|---|---|
| Trusted research environments: computing in an enclave, output checking, offline package mirrors | Absent (0 hits; see Major 1) | In scope | 3 (NIH All of Us, EU EHDS, UK SATRE) | 2023-2026; EHDS 2025 | Stable concept; specs versioned | researchallofus.org/data-tools/workbench/ ; health.ec.europa.eu/ehealth-digital-health-and-care/european-health-data-space-regulation-ehds_en ; satre-specification.readthedocs.io/en/stable/ |
| CONSORT 2025 / SPIRIT 2025 open-science items (code, SAP, data dictionary) | Absent | In scope | 2 (SPIRIT, CONSORT groups) | April 2025 | Stable (ten-year revision cycle) | discovery.ucl.ac.uk/10207932/1/SPIRIT%202025%20BMJ.pdf ; casrai.org/guides/consort-statement-rct-reporting-guideline (secondary) |
| TRIPOD+AI code item 18f | Covered `10:863-893` | In scope | 1 | 2024 | Stable | (already in book) |
| TRIPOD-LLM | Absent; skipped by 10.10 | Borderline | 1 | Jan 2025 | Called a 'living' guideline [U] | Nature/PubMed/Utrecht pages refused (403 or redirect) [U] |
| NIH controlled-access data and generative AI (NOT-OD-25-081) | Partly: general rule `01:888-896` without NIH anchor | In scope | 1 (NIH) | Mar 2025 | Stable; NIH promises further guidance | grants.nih.gov/grants/guide/notice-files/NOT-OD-25-081.html |
| NIST SP 800-171 for controlled-access data (NOT-OD-24-157); countries-of-concern bar (NOT-OD-25-083) | Absent (`10:752` names dbGaP's 'own security procedures') | In scope (one paragraph) | 1 (NIH) | Jan and Apr 2025 | Stable | grants.nih.gov/grants/guide/notice-files/NOT-OD-24-157.html ; grants.nih.gov/grants/guide/notice-files/NOT-OD-25-083.html |
| NIH DMS Policy | Covered `10:837-851` | In scope | 1 | 2023 | Stable | (already in book) |
| NIH 2024 Public Access Policy (zero embargo, 1 July 2025) | Absent | Out of scope (concerns manuscripts, not code) | 1 | Jul 2025 | Stable | grants.nih.gov/grants/guide/notice-files/NOT-OD-25-101.html |
| AI-use disclosure (ICMJE) | Covered `01:955-983`, ch07 | In scope | 1 | 2023-2024 | Stable rule | icmje.org/recommendations/browse/artificial-intelligence/ai-use-by-authors.html (book's account is consistent: cover letter plus manuscript section, no AI authorship) |
| LLM calls inside an analysis pipeline (e.g. extraction from free text with `ellmer`): caching responses, recording model and parameters | Absent (0 hits for `ellmer`, `temperature`, `API call`, `model snapshot`) | In scope | 1 (ellmer); TRIPOD-LLM [U] | 2025 | Principle stable, tools volatile | ellmer.tidyverse.org |
| Agent instruction files (AGENTS.md-type) as compendium artifacts | Absent | Borderline | 0 opened | 2025 | Volatile | none opened; [EK] |
| FDA draft guidance on AI for regulatory decision-making (credibility framework) | Absent | Out of scope (concerns models used as evidence) | 1 (FDA) | Jan 2025, still draft | Draft | fda.gov/.../considerations-use-artificial-intelligence-support-regulatory-decision-making-drug-and-biological |
| R Submissions Pilot 4: FDA response on containers and WebAssembly | Absent | In scope (one paragraph) | 1 (R Consortium/FDA) | Letter May 2026 | Settled as a finding | r-consortium.org/posts/beyond-feasibility-learning-from-fdas-response-to-webassembly-and-container-based-submissions/ |
| ICH E6(R3) GCP: data governance, computerized systems | Absent | Borderline (ch08 regulated-validation box) | [U] | Step 4 Jan 2025 [U] | Stable [U] | ich.org page returned only a title [U] |
| EU AI Act research exemption, Art. 2(6) | Absent; skipped by 10.10 | Out of scope | search only [U] | 2024 | Guidance pending [U] | not opened; I agree with the 10.10 skip |
| SWHID as ISO/IEC 18670:2025 | Covered `10:610-625` | In scope | search only | Apr 2025 [U] | Stable | iso.org and scc-ccn.ca returned 403. Search results consistently give April 2025 [U], so the book's claim is plausible but unconfirmed by me |
| SBOMs (CISA minimum elements, draft 2025) | Absent; skipped by 10.10 | Out of scope for one quarter | 1 (CISA) | 2025 draft | Volatile | cisa.gov/sbom |
| Build provenance attestations (GitHub `attest`, `gh attestation verify`) | Absent (`09:666-769` covers SHA-pinned actions) | Borderline | 1 (GitHub) | 2024 | Moderately stable | docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/... |
| Differential privacy (NIST SP 800-226, Mar 2025) | Absent | Out of scope (a disclosure-control methods topic); pointer at most | 1 (NIST) | Mar 2025 | Stable | csrc.nist.gov/pubs/sp/800/226/final |
| Synthetic data for sharing | Covered `10:736-748` (includes the disclosure caveat for model-fitted synthesis) | In scope | n/a | n/a | Stable | (already in book) |
| `rang` archived on CRAN | Covered `10:909-915`; missing at `04:995` | In scope | 1 (CRAN) | Aug 2026 | Settled fact | cran.r-project.org/package=rang ; cran.r-project.org/src/contrib/Archive/rang/ |
| `groundhog`, `capsule` | Covered `04:1006-1035` | In scope | 1 | n/a | groundhog 3.4.0 on CRAN; capsule not on CRAN | cran.r-project.org/package=groundhog ; cran.r-project.org/package=capsule (404) |
| `rv` (Rust R package manager) | Absent | Borderline | 1 (A2-ai) | 2025 | Volatile (381 GitHub stars) | github.com/A2-ai/rv |
| Positron IDE | Absent | Out of scope (IDE choice) | 1 (Posit) | 2025 | Stable product | positron.posit.co |
| webR / WebAssembly | Absent; skipped by 10.10 | Borderline | 2 (webR docs, Pilot 4) | 2023-2024 | API 'subject to change' | docs.r-wasm.org/webr/latest/ |
| Quarto Manuscripts (MECA bundle, embedded notebook cells) | Absent from ch07 | Borderline (fits the manuscript archetype) | 1 (Quarto) | Quarto 1.4, 2024 | Stable | quarto.org/docs/manuscripts/ |
| Nix/`rix`, devcontainers/Codespaces | Covered `06:399-498`, `06:597-601` | In scope | n/a | n/a | n/a | (already in book) |
| CODECHECK; institutional code checks | Covered `09:1324-1390`; institutional form absent | In scope | 1 | 2025 | Growing | codecheck.org.uk |
| Journal data editors, DCAS | Absent | Borderline (economics practice; no health analog found) | 2 (AEA, DCAS) | DCAS Dec 2022 | Stable | aeadataeditor.github.io/aea-de-guidance/ ; datacodestandard.org |
| Large-scale reproduction study (I4R, *Nature* 2026) | Absent | In scope (ch01 evidence) | 1 | 2026 | Settled | ideas.repec.org/p/zbw/i4rdps/287.html |
| Pre-registration and SAP | Partly `08:368-380` | In scope | 1 (SPIRIT item 5) | n/a | Stable | as above |

## Ranked additions

1. **Working inside a trusted research environment.** New section in ch10 after the Restricted data deposit routes (about `10:826`), with a forward pointer from ch06's 'Axis three: remote execution'. The section should cover:
   - why Docker and open-network restores often fail inside an enclave;
   - what replaces them: an institution-provided R and package mirror, a lockfile restored against that mirror, the code carried in and out through the output-checking process, and the environment version recorded from the enclave's own release notes;
   - which ladder rung is honestly reachable, and the fact that the published code may only ever be re-run by another approved user.

   Use All of Us as the US example and EHDS/SATRE as the European frame. **About 2 pages.** This delivers the unfinished 10.10 row.
2. **CONSORT 2025 and SPIRIT 2025.** Add a paragraph to ch10 'Funder and journal obligations' (`10:863`), placed before TRIPOD+AI, quoting SPIRIT item 6 and CONSORT item 4. Add one cross-reference sentence in ch08's analysis-plan section on SPIRIT item 5 (the SAP must be accessible). Extend ch10 Exercise 9 (`10:1424`) to CONSORT. **About 0.5 page.**
3. **NIH controlled-access rules for AI and computing.** Add one paragraph in ch10 Restricted data at the dbGaP passage (`10:750-762`) covering NOT-OD-25-081, the NIST SP 800-171 attestation (including cloud), and NOT-OD-25-083. Add a one-clause citation of NOT-OD-25-081 to the governance rule at `01:888-896`. **About 0.4 page.** These notices are dated, so the cited notice numbers should be easy to update.
4. **LLM calls inside the analysis.** Add a short subsection in pipelines.qmd (fitting `targets` caching) or in the ch07 LLM section. Its point is that when a model call produces analysis data, such as coded free-text fields, its responses are raw data. They should be cached and committed or deposited, with model identifier, date, and parameters recorded, and the pipeline should read the cache rather than re-query. Add a pointer to TRIPOD-LLM once its text is verified. Name no product beyond an R client in a footnote, per house rule 10.14. **About 1 page.** I rank this fourth because adoption among health analysts is plausible but I did not measure it [EK].
5. **What a regulator found when it ran the containers.** Add one paragraph in ch05's honest-level section, mirrored by a sentence in ch08's regulated-validation section, summarizing the Pilot 4 FDA response. The point to draw: an image pins the environment, but a reviewer still needs it to run on their own locked-down machine, which links to the setup appendix's 'Locked-down institutional laptops'. **About 0.3 page.**

I decided against adding SBOMs, build attestations, the EU AI Act, the FDA AI draft guidance, `rv`, Positron, webR as a topic, differential privacy, and the NIH Public Access Policy. For each, breadth for this audience is low, the topic is still changing, or it concerns models or manuscripts rather than reproducible R analyses. I agree with the 10.10 skips except TRIPOD-LLM, which I would revisit only through Addition 4.

## Scope disclosure

- I did not open the primary CONSORT 2025 text (BMJ returned 403), ICH E6(R3), the EU AI Act, TRIPOD-LLM, or the ISO page for ISO/IEC 18670.
- I did not survey syllabi or textbooks (the other two researchers do).
- Breadth counts are lower bounds from a single session. No book code was run; every 'absent' classification is a grep result (a structural check), with lines read where cited.
