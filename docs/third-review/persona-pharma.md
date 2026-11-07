# Persona review: pharmaceutical statistical programmer
*2026-11-07 11:28 PST*

Simulated reviewer (senior statistical programmer, 21 CFR Part 11, ICH E9, CDISC, validated R). Judgments about what a regulated employer expects are informed opinion, not a survey. Chapters read in full: version-control (Ch 4), 04-dependencies (Ch 6), 07-literate-programming (Ch 9), 08-testing-quality (Ch 11), 09-continuous-integration (Ch 12).

## Summary

1. The 'discriminate' misquotation of 21 CFR 11.10(a) is confirmed (eCFR text: 'discern'). The surrounding paragraph also attributes IQ/OQ and a lifecycle 'documented evidence' definition to 11.10(a), and the regulation contains neither.
2. The R Validation Hub white paper is misreported. It does not give 'long-established tidyverse' packages trusted status, and it requires tests for statistical modelling functions whatever the risk score. The same cited paper also says Part 11 'is not relevant or mandatory' for statistical software itself, which undercuts the chapter's framing.
3. The PHI-purge procedure (history rewrite and force-push) is presented without warning that in a GxP repository it destroys audit-trail records that 11.10(e) says must not be obscured. For a regulated reader this is the one instruction that could cause professional harm.
4. Executed checks contradict three teaching claims. renv 1.2.3 does detect `pacman::p_load()` arguments. The Ch 11 Cox unit test fails (48 events vs 305 non-missing outcomes). The answer to Ch 12 Exercise 7 is two packages, not one.
5. Verdict: adopt with revisions. The capture, tolerance, and gate discipline is sound preparation, but the regulatory material is too thin and too inaccurate to be relied on as an orientation to regulated work.

## 1. Verdict

Adopt with revisions, for my setting. A graduate who absorbs the lockfile, baseline-with-tolerance, gate-must-fail, and pinned-action habits would be ahead of most new hires. But the one section aimed at regulated work (Ch 11, 'Validation in the regulated sense') misquotes the regulation, misreports its main secondary source, and is silent on ICH E9, CDISC, and predicate rules. It needs a correctness pass and a scope statement before I would hand it to a trainee.

## 2. Findings

### Critical (for a regulated setting)

**C1. History rewrite presented with no GxP caveat.** `version-control.qmd:723-773`, `:1494-1502`, `:1749-1760`, cheat sheet `:1903`. [I] The five-step response ends with `git filter-repo --sensitive-data-removal` and `git push --force --mirror`. 21 CFR 11.10(e) requires audit trails such that 'Record changes shall not obscure previously recorded information' (Cornell LII text of 11.10, opened). The chapter itself cites @cfr21part11 for audit trails at `:451-454`. In a repository that holds regulated records, a trainee who follows these steps as written would delete records that are supposed to persist, with no deviation, QA notification, or change-control record. *Fix:* add a callout to step 3. In a repository under GxP, a history rewrite is a controlled change: open a deviation or incident, get QA approval, document what was removed and why, and keep an approved record of the pre-rewrite state wherever the quality system requires one. Better still, keep regulated records out of a rewritable forge in the first place.

### Major

**M1. 11.10(a) misquoted and over-attributed.** `08-testing-quality.qmd:1285-1299`, `:1362-1369`. [I] The quotation says 'discriminate'; the regulation says 'the ability to discern invalid or altered records' (confirmed). Two further problems:

- 11.10(a) says nothing about installation or operational qualification (`:1297-1299`, `:1366`). IQ/OQ/PQ come from qualification practice. The cited white paper says 'A system qualification typically includes the execution of Installation, Operational and Performance tests', and it lists PQ, which the book omits.
- The answer at `:1362-1365` presents the general FDA definition of validation ('documented evidence that the system ... reliably does what it purports to do') as what '11.10(a) asks for'.

*Fix:* correct the word. Attribute IQ/OQ/PQ to qualification practice (cite @nicholls2020 Section 5), and drop the claim that 11.10(a) 'demands' them.

**M2. Part 11's scope is misframed.** `08-testing-quality.qmd:1285-1289`, `:1350-1352`. [I] The exercise has 'a regulator' ask whether a compendium 'is validated under 21 CFR 11.10(a)'. Three sources cut against that framing:

- 11.10 governs 'closed systems' that create, modify, maintain, or transmit electronic records (intro paragraph, opened).
- FDA's 2003 *Part 11 Scope and Application* guidance says the agency will 'exercise enforcement discretion regarding specific part 11 requirements for validation', with predicate-rule requirements still applying, and recommends 'a justified and documented risk assessment' (fda.gov, opened).
- The book's own source, @nicholls2020, states: 'In conclusion, 21 CFR Part 11 is not relevant or mandatory in the context of statistical analysis software itself', and adds that 'When using R as part of a validated system, elements of 21 CFR Part 11 do apply.'

*Fix:* restate the exercise around what an inspector actually asks: is the statistical computing environment in a documented, validated or qualified state under the sponsor's SOPs and the GCP or predicate-rule requirements? Cite the 2003 guidance and the white paper's Section 3.

**M3. R Validation Hub treatment misreported.** `08-testing-quality.qmd:1334-1337`. [I] Factual-issues item 43 is confirmed. The white paper gives trusted status to base and recommended packages, on the basis of the R Foundation's development practice. For the tidyverse it says only that 'there is a reasonable case to consider the tidyverse team a trusted resource'; trusted status is earned, and the organization sets the threshold. 'No further work' is also wrong: 'Tests should be written for all statistical modelling functions within an Intended for Use Statistical Package ... regardless of the risk assessment.' Remediation is 'tests, linked to user requirements', and the book never introduces the user-requirements concept. *Fix:* rewrite the sentence along those lines and add one sentence on user requirements and traceability.

**M4. Regulated vocabulary collides beyond 'validation'.** `08-testing-quality.qmd:1279-1280`, `09-continuous-integration.qmd:265-270`, `:1027-1036`, `glossary.qmd:774-782`. [I] There are four parts to this:

- Ch 11 says the regulated sense is 'narrower', while the Ch 2 box (`02-levels-of-reproducibility.qmd:613`) says 'larger'.
- The book's 'Validation' (rebuild and rerun) and 'Verification' (compare with a baseline) do not match FDA usage. In FDA software guidance, verification checks outputs against the specified requirements, and validation confirms fitness for user needs and intended use [EK].
- A tool that writes a `verified` stamp into a state record (`zzc verify`) looks to a regulated reader like a validation-status record with no signer, no meaning of signature, and no QA review.
- REFACTOR-PLAN 10.12 scheduled a regulated-sense note for the glossary, and it is absent (`glossary.qmd:774-776` unchanged). Finding 20 also named 'audit trail' and 'verification', and only 'validation' received a box.

*Fix:* make Ch 11 say 'broader'. Add regulated-sense notes to the glossary entries for Validation, Verification, and Audit trail. In Ch 12, say that the L3 stamp is not a validation record.

**M5. A pull request is presented as a regulated review gate.** `version-control.qmd:1244-1252`, `:1294-1297`, `:1801-1808`. [I] 21 CFR 11.50(a) requires a signed record to show the printed name, the date and time, and 'the meaning (such as review, approval, responsibility, or authorship)' of each signature (opened). A GitHub approval does not meet that standard by default, and the forge is a third-party system that would itself need supplier assessment. *Fix:* qualify: 'useful review evidence; whether it counts as a controlled approval depends on the organization's validated configuration and SOPs.'

**M6. The Cox unit test is wrong and would fail.** `08-testing-quality.qmd:1664-1666`, `:1673-1675`. [V] I ran `fit_cox(clean_cohort(...))` with the locked library and got `fit$nevent` = 48 against `sum(!is.na(incident_dm))` = 305. Factual-issues item 3 is confirmed. In a book about oracles, the stated contract is itself wrong. *Fix:* use `sum(cohort$incident_dm == 1, na.rm = TRUE)` (48), and add this listing to `inst/tinytest/`, so that the book's shown tests are actually executed.

**M7. The `pacman::p_load()` landmine argument is false.** `07-literate-programming.qmd:644-653`, `:1627-1645`, cheat sheet `:1652`. [V] `renv::dependencies()` (renv 1.2.3) on a file containing `pacman::p_load(dplyr, tibble, ggplot2)` and bare `p_load(sandwich)` returned dplyr, ggplot2, pacman, sandwich, and tibble. Factual-issues item 11 is confirmed. REFACTOR-PLAN 10.4 already recorded this and 10.12 scheduled 'Fix pacman', but the text is unchanged. The render-time install objection still stands. *Fix:* drop the 'invisible to renv' claim and rewrite the Exercise 8 solution. Item 12 is also confirmed [I]: `:1455-1458` says p_load 'installs pacman itself if absent', but a `pacman::` call fails when the namespace is absent.

**M8. Ch 12 Exercise 7's answer is wrong.** `09-continuous-integration.qmd:1836-1848`. [V] `R/cohort.R` uses stats, survival, tibble, utils, and withr. Against the exercise's locked set, `missing` is `c('survival', 'withr')`, which has length 2, and adding sandwich gives three names, not 'one package name'. Factual-issues item 2 is confirmed. *Fix:* use the locked set from `:1619`.

**M9. A raw-bytes claim contradicts the demo.** `09-continuous-integration.qmd:1995-1997` vs `:1132-1143`. [I] The solution says `tbl-integrity` 'targets the raw data bytes on disk'. The chunk actually digests an in-memory tibble, which `digest()` serializes, and that is the very mechanism the same solution warns against. REFACTOR-PLAN 10.15a (`:2224`) records `tbl-integrity` as 'already correct (file-byte hashing)', which is inaccurate. *Fix:* write the frame to CSV and digest with `file = TRUE`, or use `tools::md5sum` or a SHA-256 of the file.

**M10. The gate tool is unpinned in the chapter that teaches pinning.** `09-continuous-integration.qmd:518-524`, `:815-817`, `04-dependencies.qmd:700-702`. [I] `remotes::install_github('rgt47/zzrenvcheck')` installs whatever HEAD happens to be, and `renv::install(c('rcmdcheck', ...))` is unpinned too. The admission at `:727-742` covers action tags but not these. In validated work, the tool that produces evidence is itself a controlled, versioned item. *Fix:* `remotes::install_github('rgt47/zzrenvcheck@<sha>')`, and pin the other gate tools in the lockfile or by version.

**M11. Data-integrity and level statements contradict each other.** `09-continuous-integration.qmd:1067-1073` says the gates reach L3 and that 'CI establishes nothing at all about the data's own integrity', while `:1025-1026` says `zzc verify` checks raw-data checksums. `:1229` rates Docker without renv as L2, while `07-literate-programming.qmd:1512` says 'L2 presupposes L1'. [I] Factual-issues items 25 and 46 are confirmed. *Fix:* attribute L3 to the verify job, not the gates. Say CI can check data integrity when the manifest step runs. Rate the Docker-only row as 'L2 environment, L1 not met' or explain the exception.

**M12. Ch 6 still says the repository has no lockfile.** `04-dependencies.qmd:1141`, `:1169-1175`. [V] `git ls-files` lists `renv.lock` as tracked. Factual-issues item 1 is confirmed for this chapter. *Fix:* update the prose to describe the lockfile that exists.

### Minor

- `04-dependencies.qmd:1188`: 'rnorm() and sample() live in the stats package'. [V] `sample` is in base and `rnorm` is in stats (item 10, confirmed).
- `04-dependencies.qmd:1410-1413` ('the lockfile pins the R version separately') vs `:1530` ('recorded ... but not supplied'). [I] Item 50 is confirmed; the '@tbl-lockdiff' reference to R-version content is also confirmed, since the table has no R row. Whether `restore()` 'refuses' a foreign-platform library (`:1587-1588`): could not tell [U].
- `04-dependencies.qmd:872-876`, `:63-64`: binaries are promised without qualification, and the Linux qualifier comes only at `:895-900`. Item 19 is partly resolved.
- `08-testing-quality.qmd:762-768` vs `:870`: the listing has three assertions; the real file has five, and I observed 'All ok, 5 results' [V]. Item 23 is confirmed. Mark the listing as abridged.
- `08-testing-quality.qmd:1267-1269` vs `:1962`: item 24 is confirmed.
- `08-testing-quality.qmd:1290-1292`: the EMA claim is uncited. Cite the EMA guideline on computerised systems and electronic data in clinical trials [EK: 2023]; the same applies to the Ch 2 box.
- `08-testing-quality.qmd:2148-2152`: Peng (2011) offers reproducibility as a minimum standard 'when full independent replication ... is not possible' [EK]. 'Confirming a result' blurs that with replication. Item 44 is confirmed on recall.
- `08-testing-quality.qmd:1738` uses `md5sum`, while Ch 12 standardizes on SHA-256.
- `07-literate-programming.qmd:1671-1673`: 'single most cited sentence' is unsupported (item 42, confirmed).
- `version-control.qmd:159-161`: 'five FINAL files ... four snapshots' does not match the seven files at `:136-142` (item 28, confirmed).
- `version-control.qmd:1849-1854`: the 'Verification' callout at `:829-843` concerns `.gitignore`, and the chapter never prints `nrow(raw)` (item 29, confirmed).
- `version-control.qmd`: item 48 is confirmed on all four counts. 'Habit 1' appears at `:1895` and `:1906`. The Exercise 8 solution names no single rung. `:1791-1793` claims a fork 'establishes that the contributor did not hold write access', which it does not. The Exercise 3 solution lists `renv/library/`, `inst/doc/`, and `.Rproj.user/` (package file), none of which appear in the samples at `:792-827`.
- `version-control.qmd:451`: 'U.S. regulations for electronic records' is broader than Part 11, which covers FDA-regulated records.
- `version-control.qmd:1784`: 'per DSMB request'. In a blinded trial, DSMB recommendations go to the sponsor, and analysis changes go through an SAP amendment, not a site's fork [EK].
- `09-continuous-integration.qmd`: item 45 is confirmed. The Outline (`:75-86`) omits 'Secrets, tokens, and pinned actions' and 'Debugging a failed reproduction'. 'As the first section established' (`:1279`) points to the three-gates section. 'Five moves' (`:1565`) does not match the diagnostics described.

## 3. Gaps (and whether in scope)

The preface's 'What this book does not cover' (`preface.qmd:101-113`) says nothing about regulated work. Add one paragraph saying the book is not a computer-system-validation manual, and point to the sources below. Within that scope, I would expect a short treatment of the following:

- **ICH E9 Section 5.8**, 'Integrity of data and computer software validity': software must be reliable, with documentation of testing [EK; corroborated only by secondary sources]. **ICH E9(R1) estimands** belong naturally in 'The analysis plan as an oracle' (`08:360-425`). In scope, as one paragraph.
- **FDA Statistical Software Clarifying Statement** (no specific software required; software must be documented). The white paper quotes this point [I]. It answers the 'must we use SAS?' question every trainee asks. In scope, as one sentence.
- **QC by independent programming in practice**: risk-based choice between independent programming and code review, comparison of outputs (for example `diffdf` or `arsenal::comparedf`), the program-log review ('clean log': no unexpected WARNING or NOTE), and TFL footers with program path, run time, and data cut. In scope; extend the double-programming paragraph.
- **CDISC SDTM/ADaM traceability and define.xml**: out of scope beyond one sentence, but name them.
- **Validated environment patterns**: a frozen, qualified R stack; a curated internal package repository; `riskmetric` and the riskassessment application; the 'Intended for Use' restriction (the white paper requires that 'users do not directly load the Package Imports'). Partly in scope for Ch 6.
- **Evidence retention**: CI logs and artifacts expire on hosted forges [EK: GitHub's default is 90 days]. Regulated evidence must be retained as long as the records it supports. In scope for Ch 12, as two sentences.
- **Blinding and access control in git**: dummy randomization, restricted branches, and who may see unblinded outputs. Out of scope, but a single caution belongs in Ch 4.
- **ALCOA+ and data integrity** vocabulary: in scope, as a glossary entry.

## 4. Cuts for one quarter

- Ch 12 'Proving the framework itself: the capture test matrix' (`09:1205-1266`): framework internals that students do not act on.
- Ch 12: keep one CI dialect in the body and move GitLab to a sidebar (`09:770-897`).
- Ch 6 'From packrat to renv' and the three alternatives (`04:269-295`, `985-1062`): compress to a paragraph.
- Ch 9: the Sweave-to-Quarto lineage (`07:336-411`) and the write-as-you-go check (`07:1004-1027`).
- Ch 4: the worked example (`version-control.qmd:1365-1460`) largely re-narrates `tbl-audit-trail`.

## 5. Strengths to keep

- The lockfile's 'protection ... is exactly nil' against altered bytes (`04:405-434`): correct, and rarely taught.
- Git tamper-evidence with an explicit backdating demonstration and the Part 11 audit-trail contrast (`version-control.qmd:423-457`).
- Ordering of the PHI response (report, rotate, then rewrite).
- `error-on: warning`, 'a step allowed to fail is a report, not a gate', and SHA-pinned actions.
- Baseline tests with a stated tolerance, plus `ci/run-tests.R`, which refuses to pass when no baseline ran.
- The insistence that an oracle be independent of the code under test, and the contrast between double programming and baseline tests (`08:1301-1319`). This matches how independent QC is justified in industry.

## 6. Factual-issues items in these chapters

| Item | Status | Evidence |
|---|---|---|
| 1 (lockfile absent) | Confirmed for 04-dependencies `:1141`, `:1169-1175` | [V] `git ls-files renv.lock` |
| 2 (Ch 12 Ex 7) | Confirmed | [V] missing = survival, withr |
| 3 (Cox nevent) | Confirmed | [V] 48 vs 305 |
| 10 (`sample()` in stats) | Confirmed | [V] environment is base |
| 11 (renv misses p_load) | Confirmed: the book's claim is false | [V] renv 1.2.3 detects the arguments |
| 12 (pacman self-install) | Confirmed | [I] |
| 19 (binaries qualifier) | Partly resolved | [I] `:895-900` |
| 23 (five passes) | Confirmed: listing is abridged | [V] 5 results |
| 24 (validation feature and level) | Confirmed | [I] |
| 25 (L3 callout, data integrity) | Confirmed | [I] |
| 28 (FINAL count) | Confirmed | [I] |
| 29 (Ex 7 pointer) | Confirmed | [I] |
| 42 (superlative) | Confirmed | [I] |
| 43 (Validation Hub low risk) | Confirmed | [I] white paper opened |
| 44 (Peng 2011) | Confirmed on recall | [EK] |
| 45 (Ch 12 outline etc.) | Confirmed | [I] |
| 46 (Docker-only L2) | Confirmed | [I] |
| 48 (version-control set) | Confirmed, all four | [I] |
| 50 (Ch 6 inconsistencies) | Confirmed except the `restore()` refusal | [I]; refusal [U] |

Sources opened: Cornell LII text of 21 CFR 11.10 and 11.50 (the eCFR URL redirected to an unblock page); FDA, *Part 11 Scope and Application* (2003); Nicholls, Bargo and Sims, R Validation Hub white paper (2020), pharmar.org. ICH E9 Section 5.8 wording was seen only in secondary sources. Executed checks are in `work-persona-pharma/checks.R`, run with the locked library.
