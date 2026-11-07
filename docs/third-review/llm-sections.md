# Third review: the 'Collaborating with an LLM' sections
*2026-11-07 11:28 PST*

## Summary

1. Twelve sections, 36 prompt/watch-for/verification triples, about 6,975 words [V word count, `work-llm/count.sh`]. The verification steps are still the best part. The governance rule, the agent premises, and the disclosure guidance were all patched one chapter at a time, and the patches do not add up to a working policy.
2. Critical: every chapter's data rule says that institutional approval of an endpoint is enough for data held under a data use agreement. For DUA data, and NIH controlled-access data in particular, the agreement's terms govern, and an institutional approval does not override them.
3. Major: the disclosure records the book models leave out the tool name, provider, version, and dates that JAMA and Elsevier require. Nothing tells the reader to record prompts or where LLM use belongs in a compendium.
4. Major: coding agents are mentioned only as a data-exposure risk. There is no division of labor saying what an agent may run, edit, commit, push, or deposit and what stays with the analyst. Agent self-reports, tests rewritten to pass, and prompt injection are not covered.
5. Major: most prompts are vague, and none asks for a verification step. The five duplicated 'fully reproducible' triples that REFACTOR-PLAN D5 said to remove are all still present. The restricted-data rule appears twelve times, worded differently and in two formats.

Evidence labels: [V] ran it; [I] read the source or an opened web page; [EK] expert knowledge, not checked; [U] could not open.

## Sources opened

- ICMJE, 'Use of AI by authors' page (icmje.org/recommendations/browse/artificial-intelligence/ai-use-by-authors.html) [I].
- NIH NOT-OD-25-081, controlled-access genomic data and generative AI [I]; NOT-OD-25-132, AI-developed applications and the six-application cap [I]; NOT-OD-23-149, peer reviewers barred from generative AI [I].
- Elsevier, 'Generative AI policies for journals', marked 'Policy updated June 2026' [I].
- JAMA Instructions for Authors, section 'Use of AI in Publication and Research' [I].
- Springer Nature group page 'AI guidance for our researchers and communities' [I]. The nature.com editorial-policy page redirected to a login and was not read [U].
- OWASP GenAI Top 10 (2025): LLM01 Prompt Injection and LLM06 Excessive Agency [I].
- CRAN page for `rang` ('Archived on 2026-08-22') [I].
- TRIPOD-LLM (Gallifant et al., *Nature Medicine* 2025, 31:60-69): seen only in search-result snippets. The article and PubMed pages did not load [U for content].
- HHS HIPAA cloud-computing guidance returned 403 [U]. The business-associate point below is therefore [EK].

## Critical

### C1. The data rule makes institutional approval sufficient for DUA-restricted data

Locations: 01:889-893, 02:966-970, version-control:1474-1477, 03:1262-1267, 04:1210-1214, 05:1371-1375, 06:1009-1013, 07:1198-1203, pipelines:1323-1326, 08:1555-1558, 09:1699-1703, 10:1282-1284.

Every chapter forbids pasting PHI, identifiable data, or 'data under a data use agreement' into a model 'unless the endpoint is approved by the reader's institution for that data' [I]. For PHI the institutional gate is roughly right: in the US the deciding question is whether a BAA covers the service, and the institution's security office answers it [EK]. For agreement-restricted data it is wrong. The data provider's terms decide. NOT-OD-25-081 treats sharing controlled-access data with third-party generative AI tools through prompts as a breach of the Data Use Certification. It treats a model trained on the data as a Data Derivative, and it forbids distribution to anyone not named in the Data Access Request without NIH approval [I]. The notice does not carve out institution-approved tools. A student with dbGaP data and an enterprise LLM licensed by the university could follow the book's rule and still breach the DUC. Whether a vendor-hosted enterprise tool counts as a 'third party' under the DUC is uncertain [inferred], and that uncertainty is exactly why the book should send the reader to the agreement rather than to IT. 10:1286-1288 cites the notice accurately but in the narrowest form ('public generative AI tools'), which suggests a non-public tool is fine.

The governing documents also include the IRB protocol and consent, which may restrict onward processing of data even after institutional IT has approved a tool [EK].

Fix: in all twelve places, replace the exception with a three-part condition. The model endpoint must be (a) approved by the institution for that data classification, (b) permitted by the IRB protocol, and (c) permitted by the data use agreement or provider terms. If any one is unclear, the answer is no. Change 10:1286-1288 so that NIH's notice covers 'third-party generative AI tools' and model training, not just public tools. Grading this critical rather than major rests on the consequence: NOT-OD-25-081 treats such sharing as a breach of the Data Use Certification, and the reader is the Approved User who answers for it. A reader who weighs that risk lower could grade it major.

## Major

### M1. The disclosure guidance models records that the journals would reject, and says nothing about how to record LLM use in the compendium

Locations: 01:956-982, 07:1267-1297.

What is right [I]: ICMJE bars AI authorship, requires disclosure, and puts accountability on the humans. The book says all of this.

What is wrong or missing:

- **The model records lack the required fields.** 01:968-969 offers 'a general-purpose language model, accessed October 2026'. 07:1292-1294 offers 'a general-purpose model, approximately mid-2026' and calls it 'a usable record'. JAMA requires the tool name, version and extension numbers, manufacturer, dates of use, how the tool was used, and on which parts of the manuscript [I]. Elsevier requires the tool name, the purpose, and the extent of oversight [I]. Both examples omit the name and the provider. REFACTOR-PLAN 10.14's rule 'do not name AI tools' was meant to keep product names out of the book's prose, but it has been applied to the reader's own record. Fix: show a template with slots, such as '`<tool name>`, `<version or model identifier>`, `<provider>`, used `<dates>` to `<purpose>` on `<files or sections>`; output reviewed and verified by `<author>`'. No product needs to be named for that.
- **Placement.** 07:1269-1271 says 'methods section or acknowledgments'. ICMJE also requires a statement in the cover letter. Elsevier wants a separate declaration section placed just before the references [I]. JAMA puts manuscript-preparation use in the Acknowledgment and research use in Methods [I]. Fix: 'where the target journal's instructions say', with the cover letter named.
- **Prompts.** JAMA requires, for AI used in research, 'the prompts used, their sequence, and any revisions' [I]. The book never tells the reader to keep prompts or transcripts (grep for 'transcript', 'prompt log', 'record the prompt': no hits) [I].
- **No home in the compendium.** The book's whole argument is that provenance lives in versioned files, yet nothing says where LLM provenance goes. Fix: one paragraph in 01 or 03 introducing a committed `LLM-USE.md`, or a README section, with one row per use: date, tool and identifier, purpose, affected files, prompt file path, and the verification performed. Agent-made commits should say so in the commit message or a trailer (see M2).
- **ICMJE is cited only in prose.** 01:959 and 07:1275 have no bibliography entry; `references.bib` contains `nihgenai2025` but no ICMJE item [I grep]. Add one with a urldate.
- **A false precision.** 01:980 says 'approximately version Y'. Versions are exact identifiers [EK], so the record should give the identifier the interface or API reported, not an approximation.

### M2. Agents are treated as readers of data, not as actors

Each section says, in some variant, that a coding agent 'belongs only in projects whose data it is allowed to see' (e.g. 02:974-976, 09:1706-1708). Two places go further. 01:924-939 notes that an agent can change the environment while it investigates and tells the reader to `git diff` the lockfile; this is good. version-control:1469-1473 forbids credentials that let an agent push unreviewed, which is also good. Beyond these, the brief's question of what the reader should let an agent do is not answered anywhere [I].

The missing points, each tied to a place in the book:

- **Self-report is not observation.** The book's motto is 'Claim only the level you have verified'. An agent that says 'tests pass' or 'CI is green' has asserted capture, not shown validation. 09:1728-1733 ('A CI check that has never been seen to fail…') should add that the analyst reads the run log themselves.
- **Agents edit tests and baselines to make failures go away.** 08:1610-1621 warns that a model may *recommend* changing a test to match the output. An agent will *make* that edit, and in 09 will add `continue-on-error` or loosen `error_on` to reach green. The patterns 09:1722-1725 lists become commits [inferred from how agents operate; EK]. Fix: name protected paths (`inst/tinytest/`, `inst/baseline/`, `renv.lock`, `.github/workflows/`, `analysis/data/raw_data/`). The analyst reviews every diff touching them line by line before merging.
- **Irreversible actions stay with the analyst.** Pushing to a registry, minting a DOI, depositing, rewriting history, and force-pushing all stay human. 10:1296-1311 asks for commands to push to GHCR and export a SIF. With an agent, those commands execute. version-control:1482-1502 asks for history rewriting, which an agent would carry out. OWASP LLM06 recommends least privilege and human approval for high-impact actions [I].
- **Branch and PR workflow.** The book already teaches pull requests (version-control:1241-1291), but it never connects them to agents. The natural rule: the agent works on a branch, opens a PR, and the analyst reviews and merges.
- **Prompt injection.** An agent reading a downloaded README, an issue or PR comment, a CI log, or a data file can be steered by instructions embedded in that content. OWASP LLM01 says there may be no fool-proof prevention [I]. This matters most in 09, where an agent may run with repository secrets. The book's own least-privilege section, 09:694-701, is the right place for a cross-reference.
- **The boundary has to be the filesystem.** 'Projects whose data it is allowed to see' presumes the reader can tell whether the agent will look. pipelines:1329-1330 gives the better rule: run against a synthetic extract of the same structure. The book's committed synthetic cohort makes that practical. Make it the default everywhere: run the agent in a checkout or container where the real data is not mounted. Agent-side 'ignore' settings are not a security boundary [EK].

Fix: one roughly 250-word 'What to delegate' paragraph in 01, cross-referenced from the others. Agents may scaffold, edit code on a branch, run the tests, and propose PRs. The analyst owns raw data, test expectations and baselines, lockfile decisions, model specification, level claims, merges, pushes, and deposits.

### M3. Most prompts are under-specified, and the book never shows a better one

By my classification, which is a judgment call, about 15 of the 36 prompts give no inputs or constraints: 01:900, 01:917, 02:1004, 02:1019, version-control:1504, 03:1296, 03:1313, 05:1383, 05:1410, 05:1431, 07:1233, 07:1250, pipelines:1354, 08:1610, 09:1755 [I]. Only 07:1210-1215 (the `knitr` chunk) and 08:1588-1594 (the data dictionary) are fully specified. None of the 36 asks the model to say how its answer could be checked. Each 'Watch for' then lists failures that the vague prompt invited. For example, 05:1383 'Write me a Dockerfile' predictably yields `:latest`. The reader learns to verify but never learns to ask. 02:980-983 asks for a level 'on the L0 to L3 ladder', which is the book's own scale, without supplying its definitions, so the model cannot apply it.

Fix: add a fourth element, '*A better prompt*', to at least one triple per chapter, specifying inputs, constraints, output, and verification. For 05: 'Write a Dockerfile for an R 4.4.1 analysis restored from the attached `renv.lock`. Pin the base image by digest; point the installer at a dated Package Manager snapshot for `<codename>`; set `LANG`, `LC_ALL`, `TZ`; install nothing at run time. List the commands I should run to confirm the two builds install identical versions.' Keep the vague prompt as the cautionary contrast. Word cost: about 60 words per chapter.

### M4. Repetition and inconsistent policy

- **The five 'fully reproducible' triples are still there:** 01:941-954, 02:1004-1017, 07:1250-1265, pipelines:1381-1394, 10:1313-1333 [I]. REFACTOR-PLAN 10.15 says the D5 patch included 'removal of the five duplicated "full reproducibility" triples', but its 10.15a record shows the section was left untouched apart from the reboxed data paragraph [I]. This item is therefore not fixed. Keep 01 (the general case) and 10 (data availability, which is distinct). Replace 02, 07, and pipelines with chapter-specific prompts, for example in 07 'Find hidden state in this document'.
- **One rule, twelve wordings, two formats.** The restricted-data rule is a `callout-important` box in 03, 04, 05, 07, and 08, and inline prose in 01, 02, version-control, 06, pipelines, 09, and 10 [I]. The wording shifts too: 'allowed to see', 'permitted to see', 'cleared to see'. 07:1198-1200 first states the rule for PHI alone, then extends it. 06:1007-1009 says the commands 'carry no data', then warns about host paths. The chapter-specific additions are valuable: listings in 02, host paths in 06, CI logs in 09, small-count tables in 10. The base rule should be a single Quarto include, like `_habits.qmd` (for example `_llm-rule.qmd`), carrying the C1 wording, followed by one chapter-specific sentence. That gives one policy, fixes C1 in one place, and saves about 600 words [inferred from about 80 to 110 words times 12].
- **Disclosure is duplicated.** 01:956-982 and 07:1267-1297 make the same argument (ICMJE, no authorship, record the model, nondeterminism) in about 580 words between them. Keep the full version in 01, cut 07 to two sentences, and point back.
- **Format drift.** 03 uses '*Watch for*:' with a colon. 06 uses bold titles and bullet lists. All other chapters use '**Prompt.** / *Watch for.* / *Verification.*' [I].

### M5. Using an LLM inside the analysis is not addressed

Every section treats the model as a helper to the analyst. In health-sciences work by late 2026, a pipeline that calls a model, for example to code free-text clinical notes or to extract variables, is common [EK]. This is a determinant-stack problem in exactly the book's terms: an unpinned remote dependency with nondeterministic output, a provider that can retire it, and (for notes) data-governance consequences. The nondeterminism paragraph in 07:1286-1297 is aimed only at disclosure. It never draws the reproducibility conclusion: cache model outputs as versioned derived data; record the model identifier and parameters; version the prompts as code; treat a re-query as a new measurement, not a re-execution. JAMA requires prompts and Methods reporting for AI used in research [I]. TRIPOD-LLM exists for such studies [U content]. REFACTOR-PLAN 10.10 skipped TRIPOD-LLM, which is defensible as a guideline, but the reproducibility point belongs in 02 (determinant stack) or pipelines. Fix: about 200 words in pipelines:1313 or 02, plus one exercise.

## Minor

1. **Model behavior asserted as fact.** Examples: 'Models frequently conflate' (01:904), 'will very likely open with `FROM rocker/tidyverse:latest`' (05:1385-1386), 'will frequently produce the naive two-step form' (09:1719-1720), 'tends to derive the expected values by running the function' (08:1571-1573). These are untested empirical claims [I: no source cited]. They will date as models change, and a reader whose model does better may conclude the verification is unnecessary. Rephrase as 'Check for…', which also keeps the advice current.
2. **testthat in a tinytest book.** 04:1237 asks why the lockfile 'includes `roxygen2` and `testthat`'. Finding 22 flagged this (as 04:820), and it is still there [I]. The book's test infrastructure is tinytest. The repository lockfile does contain testthat, but only as other packages' dependency (`renv.lock`:200 and others), with `tinytest` at :1995 [I]. Change to `tinytest`.
3. **10:1335-1348 `rang`.** `rang` is archived on CRAN [I, CRAN page], and the chapter discloses this at 10:909-914. The triple does not. Also, when a lockfile survives the versions are already known. The recovery route is to install the recorded versions from the CRAN archive or a dated snapshot, and the 'recorded run date' (10:1345-1346) matters only for picking the snapshot. Add a short caveat and correct the verification.
4. **Synthetic stand-ins.** Every section recommends 'a small synthetic example' but none says how to make one. A reader may perturb real rows, which can leak information [EK]. Add: generate synthetic rows from the data dictionary (as 08:1588-1594 does), never by editing real records.
5. **Funder context.** NOT-OD-25-132 (AI-developed applications, effective 2025-09-25) and NOT-OD-23-149 (reviewers may not use generative AI) are not mentioned [I]. One sentence in the 01 disclosure paragraph would cover the reader as a future applicant and reviewer.
6. **Inconsistent example dates.** 01:968-969 'accessed October 2026' and 07:1293-1294 'approximately mid-2026' differ, and both will look dated within a year. Use the slot template from M1 instead of dates.
7. **Style.** 09:1722 writes `error_on = "error"` with double quotes, while the book's code elsewhere uses single quotes [I].

## Strengths (brief)

The verification steps are executable and well chosen [I]. Examples: 'seen to fail' in 09:1729-1733; touching declared and undeclared inputs in pipelines:1348-1352; comparing installed contents rather than image digests in 05:1397-1407; breach-first ordering in version-control:1494-1502. No product or model names appear [I grep: no hits for common product names], so the prose will not date on that front. 01:924-939 correctly treats an agent's environment changes as something to inspect in the diff.

## Known-issue list

None of the 53 items in `factual-issues.md` falls inside an LLM section [I, by location]. Item 12 (`p_load()` installing `pacman`, ch07 about 1441) and the `rang` dated claim are nearby. The `rang` archival date of 2026-08-22 is **confirmed** [I, CRAN page]. The others are outside this brief.

## Scope disclosure

- I read the twelve sections in full. I did not read the rest of each chapter except to check cross-references.
- The prompt classification in M3 is my judgment, not a coded rubric.
- I did not run any model to test the 'Watch for' predictions.
- Nature's editorial-policy page, HHS cloud guidance, and the TRIPOD-LLM article could not be opened.
- UC San Diego's specific AI data-classification rules could not be confirmed from an official page, so I make no institution-specific claim.
