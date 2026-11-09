# Agent 2 report: Chapter 4 (version-control) and Chapter 5 (03)
*2026-11-08*

Files edited: `analysis/report/version-control.qmd` (VC) and
`analysis/report/03-research-compendium.qmd` (03). No other
file was changed. Line numbers are current working-tree lines,
approximate after edits; items were located by quoted text.

Evidence labels: V ran it; I inspected; EK expert knowledge, not
checked.

## 1. Items

### Chapter 4, version-control.qmd

| Item | Where (now) | Action | Evidence |
|---|---|---|---|
| Committed-CSV statements (857-867, 1357, 1587) | 891-930, 1505-1512, Ex 7 | already fixed (Phase 19): prose says the CSV is not committed; state computed inline; honest-level callout and Ex 7 rewritten | V: run_chapter inline values `present`, `in`, 3 columns, 2 commits; grep finds no 'committed on purpose' |
| Forward reference to Ch 5 (196-199) | 198-201 | fixed: 'The next chapter, @sec-compendium, makes the compendium...' | I |
| Archetypes used before Ch 5 defines them (775) | 805-811 | fixed: one-sentence gloss of the data-analysis and R-package archetypes, flagged as developed in @sec-compendium | I |
| Default branch | 300-304, 398-407, 1077-1079, worked example 1534, cheat sheet | fixed: vocabulary says git still names the first branch `master` unless told otherwise; `git init` -> `git init -b main` in the model section, worked example, and cheat sheet; a sentence explains why the later `git push -u origin main` needs it; 'main is merely the branch git creates by default' corrected | V: scratch `git init` with `GIT_CONFIG_GLOBAL=/dev/null` on git 2.56.0 gives `master`; `git init -b main` gives `main` (script `a2_gitinit.sh`) |
| FINAL counts (159-161) | 160-163 | fixed: 'The drawer of copies collapses back into one analysis.R, and each copy becomes an entry in a history' | I |
| Ex 3 solution contradicts listings | Ex 3 solution | fixed: rewritten from the two sample listings (common: .Rhistory, .RData, .DS_Store; analysis-only and package-only sets as computed); notes that .Renviron, *.pem, .Rproj.user/ belong in a package file too; removed renv/library/ and inst/doc/, which neither sample contains | V: `a2_ex3.R` computes the set differences from the qmd listings |
| Ex 5 solution: fork 'establishes' no write access; `git checkout -b` | Ex 5 solution | fixed: fork 'lets a contributor without write access propose a change', parenthetical on shared-repository alternative; `git fetch` and `git switch -c` on separate lines | I |
| Ex 5 'per DSMB request' (Pharma minor) | Ex 5 code | fixed: commit message 'per SAP amendment 2'; one sentence that the analysis change is approved through the sponsor's SAP process, not the PR | EK (Pharma persona) |
| Ex 7 solution 'Verification' pointer | Ex 7 solution | already fixed (Phase 19): points to the cohort checks | I |
| Ex 8 solution never names the rung | Ex 8 solution | fixed: '**The rung is L2, unchanged by the deletion.**'; added that an L3 claim must be re-shown because CI runs attached to the old commits are gone (L3 by verification only) | I |
| Habit 1 cited twice (cheat sheet) | cheat sheet `git status` row | fixed: habit 3 ('Never commit ... restricted data') | I: `_habits.qmd` |
| Worked example vs `tbl-audit-trail` | worked example `git add` | fixed: `git add .gitignore DESCRIPTION`, matching 2 files in the first row and the separate cleaning-script commit | I |
| PR as regulated approval (M5, 11.50(a)) | remote section paragraph; Ex 5 solution | fixed: added that a forge approval is review evidence, not by itself a signature with the printed name, date and time, and meaning that 21 CFR 11.50(a) requires; whether it counts depends on the validated configuration and SOPs. 'In a regulated multi-site analysis' softened to 'In a multi-site analysis' | EK for the 11.50(a) elements (matches Pharma persona's quoted text; I did not open the CFR) |
| 'Dominant model' fork-and-PR (Reader A, EK) | same paragraph | fixed: both models presented, shared-repository with protected `main` named as usual for private trial repositories | EK |
| 'r.thomas' handle | `tbl-audit-trail` chunk | fixed: 'analyst.a' and 'analyst.b' (both handles neutral; 'a.okafor' replaced too so the pair is consistent) | V: chunk runs; grep finds 'r.thomas' only in `_book/` and `_freeze/` outputs |
| 'U.S. regulations for electronic records' broader than Part 11 (Pharma minor) | 459-461 | fixed: 'the audit trail that FDA's regulations require of electronic records in the studies they cover' | I |
| Objectives person (Finding 36, A5) | 20-28 | fixed: 'you will be able to' throughout | I |
| Roadmap and Outline omit 'Undoing things, and merge conflicts' | 30-38, Outline | fixed: added to both | I |
| Two rhetorical questions inside judgment 3 (240-242) | 242-245 | fixed: one declarative sentence | I |
| 'Unfortunately,' x2 (423, 1591) | 432, 1617 | fixed: both removed; 'the reader headed for regulated work' -> 'anyone headed for regulated work' | I |
| LLM triple mixes 'the analyst's own' and 'yours' (A, 1510-1523) | LLM .gitignore triple | fixed: 'your own project', 'your directory' | I |
| Solutions switch to 'the reader' | Solutions intro, Ex 1, Ex 6 | fixed: 'you' | I |
| Overlong and garbled line wraps in edited paragraphs | several | fixed | I |
| 'That is,' uses | 203, 1186 | kept: both restatements | I |

### Chapter 5, 03-research-compendium.qmd

| Item | Where (now) | Action | Evidence |
|---|---|---|---|
| Stale pillars and L0 (1206-1251, Ex 7, 8) | cohort section, check box, Ex 7, Ex 8 | already fixed (Phase 19): computed inline | V: run_chapter prints 4 pillars, L1, lockfile TRUE, Dockerfile FALSE |
| Simulation gate 'second call' contradicts itself (849-852 vs LLM section and Ex 5) | archetype 4 paragraph | fixed: gate is now 'a baseline test that compares the seeded output with a value recorded in an earlier session and committed (@sec-testing)', with one sentence saying why a second call is not such a test | I |
| `fig-gates` render cell (952) | fig-gates chunk, fig-alt, fig-cap | fixed: 'Data analysis' dropped from `renders`, so the figure matches the table ('Optional') and body; fig-alt updated to 'active for scholarly manuscript and blog'; one sentence in fig-cap says optional render gates are left unmarked. No other change to the figure code | V: chunk runs, no warnings |
| `here` path explanation (697-701) | here section | fixed: the two strings name one file by different routes from `analysis/report/`; 'two directories deeper ... different starting working directory' removed | V: grep shows `../data/` in Chs 2, 3, 5 and `../../analysis/data/` in 08 |
| Two 'strongest case' rows (1037, 1040) | `tbl-archetype-weight` | fixed: data analysis 'Strong case for `targets`...'; simulation 'Strongest case of the five' | I |
| `R CMD check` claim needs qualifier (370-372) | R-package section | fixed: claim qualified 'As `rcmdcheck::rcmdcheck()` and `devtools::check()` run it'; parenthetical that plain `R CMD check dir/` skips the build but parses R code only in the package's own directories, so `analysis/` scripts go unparsed either way | EK (Reader B; not run) |
| NHS RAP baseline reduced to its README criterion (620-623, 667) | README section and its Answer | fixed: README is 'one of the criteria of its baseline level, alongside open-source code, version control, peer review of the code, and open publication'; Answer says the sentence satisfies the README criterion, other criteria separate. **[I] via coverage-texts.md, which opened the page 2026-11-07; I did not reopen it. Phase 25 should confirm the five-item list.** The bib `note` still narrows it (see For the lead) | I (secondhand) |
| Ladder: R-package row 'L2 via R CMD check and tests in a clean rebuild' (Finding 41) | `tbl-archetype-weight` | fixed: 'L1 and L2 as for any archetype, since `R CMD check` is a gate, not a rung; L3 via a baseline on function output after a clean rebuild' | I against canonical rules |
| Ladder: pillar 3 says `.Rprofile` fixes the RNG kind (Finding 41) | Five Pillars item 3 | fixed: `.Rprofile` can override the kind, but the override is secured only by an explicit `RNGkind()` call in the analysis code, and the seed belongs there (@sec-levels, @sec-testing) | I against canonical rules and Ch 3's default-versus-override table |
| Objectives 'we shall be able' | 20-27 | fixed: 'you will be able' | I |
| Roadmap omits README, `here`, archetype-weight table (Reader B A2) | 158-169 | fixed: one clause added; 'We begin' removed there | I |
| 'We begin' three times in 100 lines | 92, 159, 191 | fixed: kept 92; 159 and 191 rewritten ('Three judgments at the center of this chapter are the analyst's alone.') | I |
| 'To illustrate, consider' opens Orientation | 117 | fixed: 'Consider' | I |
| 'That is,' misuses | 98 (dropped), 286 (colon), 527 ('Consequently,'), 620 ('because'), 727 (colon), 761 ('For example,') | fixed | I |
| 'We note that' tics | 428, 455, 505 | fixed: removed or rephrased | I |
| 'Those' without antecedent (92-102) | stack section | fixed: 'above the packages and the system' | I |
| 'The chapters placed so far ... composite student' (1186) | cohort section | fixed: 'The examples so far have all described a hypothetical student's compendium.' | I |
| 'The reader should read both' | after archetype section | fixed: 'Both are best read across the rows' | I |
| Ex 4 solution 'No directory needs reorganizing' vs files moving to `vignettes/` | Ex 4 solution | fixed: no new structure invented; files move between existing directories | I |
| Solutions 'the reader's own'; Ex 1 'A reader who finds' | Solutions intro, Ex 1 | fixed: 'you' | I |
| Overlong lines from the voice pass | several | fixed | I |
| 'The honest level' callout redundant (537-544) | | declined: D18 forbids cuts other than defects | |

## 2. Counts

| File | 'That is,' before | after | 'Unfortunately,' before | after |
|---|---|---|---|---|
| version-control.qmd | 2 | 2 | 2 | 0 |
| 03-research-compendium.qmd | 8 (plus one split across lines at 285-286) | 3 | 0 | 0 |

The three remaining in 03 (Answer at 180, the render-many line,
Ex 3 solution) are restatements.

## 3. run_chapter.R summary lines

- version-control.qmd: `== summary: errors 0  warnings 0` (5
  inline expressions, unchanged values; baseline was also 0/0).
- 03-research-compendium.qmd: `== summary: errors 0  warnings 0`
  (16 inline expressions, unchanged values; baseline 0/0).

Also run: em/en-dash grep empty for both files; example-list lint
grep empty for both files; `git diff --stat` shows only these two
of my files changed by me (other files in the stat belong to the
other agents).

## 4. For the lead

- **references.bib, `nhsrap2024` note** (line 1008) still says
  'Baseline criterion: repository includes a README.md ...'.
  Suggested replacement:
  `note = {One of the baseline criteria: repository includes a README.md (or equivalent) detailing reproduction steps}`.
- **Instructor guide:** no key is made stale. `sec-ig-vc` covers
  only Ex 7 (unchanged values 338, three columns). `sec-ig-ch03`
  covers Ex 7 and 8, whose values are unchanged (4 pillars, L1).
  Ex 3 and Ex 5 of Chapter 4 have no guide keys.
- **No new bib entry.** The 11.50(a) sentence cites the existing
  `@cfr21part11`.
- **Cross-chapter:** VC now teaches `git init -b main`. Chapter 13
  or the setup appendix, if they show a bare `git init` followed by
  `git push -u origin main`, have the same defect (not checked).
  The planned git preflight (Phase 22) may want
  `git config --global init.defaultBranch main` instead.

## 5. Not done, or uncertain

- NHS RAP five-criteria list: taken from coverage-texts.md; not
  re-verified against the live page. Mark [I, secondhand] for
  Phase 25.
- 21 CFR 11.50(a) elements: stated from the Pharma persona's
  quotation and my own knowledge; I did not open the regulation.
- The plain `R CMD check dir/` behavior in the new parenthetical
  is EK; I did not run it on a toy package.
- 'git as of version 2.56 names it master' is verified only for
  the local git 2.56.0.
- Ex 8 (Ch 4) and the Ch 5 check-box answer keep the conditional
  'four of five pillars with the lockfile present and the
  Dockerfile absent is L1'. It is phrased as a conditional and
  stays true as a statement, but the 'four of five' figure would
  read oddly if a Dockerfile were added; the inline values around
  it are computed. Left as is.
- `tbl-archetypes` and `fig-gates` still label the simulation
  gate 'seed determinism'; the body now defines that gate as a
  baseline test. Labels left unchanged (figure code otherwise
  untouched per instruction).
- The 'Before you start' Outline and roadmap duplication (Reader
  A) left in place (Phase 23).
- Chapter 5 closing paragraph (Reader B) not added (new content).
- Ch 4 cheat-sheet link to a 'When git refuses' table (model-book
  M5) and git setup (M2) not done: Phase 22.
- Pharma's blinding caution and PR wording elsewhere in the book
  were not checked.
