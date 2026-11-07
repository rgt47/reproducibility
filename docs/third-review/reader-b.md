# Reader B: Chapters 5, 6, 7 (compendium, dependencies, containers)
*2026-11-07 11:19 PST*

## Summary

1. The prose about the book's own compendium is stale, not the chunks. A fresh run prints `renv.lock` TRUE (ch5, ch7) and finds `stats`, `survival`, `tibble`, `utils`, `withr` in `R/cohort.R` (ch6). The text says no lockfile, L0, and 'tibble only'. The compendium is now at L1 (four of five pillars).
2. Ch7 claims a digest names 'one byte-identical filesystem for one platform'. The showcase digest (`73adab...`) is a multi-arch index with both amd64 and arm64 entries (verified). The claims that every team member 'pulls byte-identical bytes' therefore fail on a mixed Mac/Intel lab.
3. Ch7 says the R version 'has no entry in the lockfile' (two places). Ch6 prints the `R.Version` block. Ch6's Exercise 2 solution says the lockfile 'pins' R, while its Exercise 6 says R is 'recorded but not supplied'.
4. Ch5 defines the simulation archetype's gate as 'identical output on a second call' (849-852), then twice says that test proves nothing (1329-1331, 1584-1589). Its gate figure also marks a render gate as applying to data analysis, while the table calls it optional.
5. The voice pass (d786c6b) preserved meaning almost everywhere. Its one harmful insertion is ch7:509-510 ('Before we turn to pinning...'), which makes the misplaced Apple Silicon section contradict itself openly. 'That is,' went from 0 to 19 across the three files.

Evidence labels: [V] ran it; [I] read source or docs; [EK] expert knowledge, not checked; [U] could not open.

---

## Part A. Meaning preservation of the voice rewrite (ee7a639 to d786c6b)

I read every word-diff hunk in all three files. Most changes split sentences at colons and semicolons, turn 'you' into 'we' or 'the analyst', and add roadmaps. None of them alters a number, a name, a ranking, or the strength of a technical claim [I]. The flagged items follow, most consequential first.

**A1 (major). 05-containers.qmd:509-510.** This sentence was added:

> Before we turn to pinning, we note a complication that warrants attention.

It tells the reader that pinning has not been taught yet. The same section then says 'the showcase Dockerfile earlier in this chapter' (535-538). It also says 'the guarantee this chapter already teaches, pinning the base image by digest' (568-569) and calls the digest 'already taught' (587-588). The new transition turns a latent ordering defect into a contradiction stated in consecutive paragraphs. Fix: move the whole 'Apple Silicon and multi-architecture images' section (507-608) to after 'Making the image itself reproducible' (610-922). Then delete the inserted sentence or reword it to 'Having pinned the base, we turn to a complication'.

**A2 (minor). Roadmaps that misdescribe the chapter.**

- 05:152-163 ('We close with the profiles... and a first look at how a team shares one'). The chapter actually closes with the worked example, the cohort, and the LLM section, and the roadmap omits the Apple Silicon section. Fix: end with '...the profiles and the team model, then work one project from L1 to L2 and check this book's own compendium.'
- 03:158-166 omits three sections: the README and data dictionary, `here`, and the archetype-weight table. Add one clause covering them.
- The ch6 roadmap (148-157) is accurate.

**A3 (minor). 'That is,' used where the old text expressed cause or consequence:**

- 03:620. Before: 'still fails the first test a stranger applies to it, because the stranger has no entry point'. After: '...applies to it. That is, the stranger has no entry point.' Restore 'because'.
- 03:527. Before: 'happens to supply, so pillar two's guarantee...'. After: '...supply. That is, pillar two's...'. Restore 'so', or use 'Consequently,'.
- 05:283. Before: 'depends on, because anything the base happens to carry...'. After: '...depends on. That is, anything...'. Restore 'because'.
- 03:98. '@fig-stack-compendium marks these two layers. That is, a compendium is what first turns a scatter...'. The sentence does not restate the figure. Drop 'That is,'.

**A4 (minor). New tics.**

- 'We begin' appears three times in 100 lines of ch5: 92 ('We begin by placing'), 159 ('We begin with the three judgments'), and 191 ('We begin with three judgments'). The last two announce the same section twice. Change 191 to 'Three judgments at the center of this chapter are the analyst's alone.'
- 04:120 adds 'Unfortunately, the number in the published table...'. This is editorial and adds nothing. Drop it.

**A5 (minor). Actor ambiguity.**

- 05:1745 replaces 'the lockfile you think it did' with 'the lockfile the analyst believes it did'. The scenario is about a *collaborator*, so 'the analyst' now points at the wrong person. Use 'the collaborator'.
- 05:1164-1166: 'But how does a team share one? A team needs every member to share the same environment...'. The second sentence restates the question. Cut it to 'A team needs one shared environment, and this introduces a wrinkle...'.

**Counts (current text; all were zero at ee7a639 except one 'We now' in ch7)** [V, grep over the joined text]:

| File | 'That is,' | 'We note that' | 'Unfortunately,' | Rhetorical questions added |
|---|---|---|---|---|
| 03 (ch5) | 10 | 3 | 0 | 3 (369, 834, 1047) |
| 04 (ch6) | 4 | 0 | 1 | 2 (543, 938) |
| 05 (ch7) | 5 | 1 | 0 | 2 (926, 1164) |

No paragraph contains two 'That is,'. The ch5 occurrences are spread across the chapter, roughly one per 870 prose words. Three of ch7's five fall in its first 520 lines. That is density rather than clustering, but at ten per chapter the phrase starts to be noticeable. The rhetorical questions are well placed: each opens a section that answers it.

---

## Part B. Reader review

### B0. The renv.lock question: what is stale, and what a fresh run prints

`renv.lock` was committed in 5a99aa9 (2026-10-15, 'Phase 7'). The lockfile records R 4.6.1 and 59 packages, including `tibble`, `survival`, and `withr` [V]. `R/cohort.R` gained `survival::coxph()` in 8ed5596 (2026-10-15, 'Phase 10'). It had already gained `withr::with_seed()` in 0bec92e (2026-10-11) [I, git log and grep].

I ran each chapter's cohort chunk from `analysis/report/` with the locked library [V]:

- ch5 chunk (03:1191-1204): `environment_dockerfile FALSE`, `packages_renv_lock TRUE`, `session_rprofile TRUE`, `source_code_r_cohort TRUE`, `data_raw_csv TRUE`. `nrow(raw)` = 338, `nrow(cohort)` = 337, and the pillar sum is 4.
- ch6 chunk (04:1152-1158), with `renv` 1.2.3: rows `stats`, `survival`, `tibble`, `utils`, `withr`, all from `cohort.R`. `simulate_cohort.R` contributes no rows.
- ch7 chunk (05:1316-1321): `Dockerfile FALSE`, `renv.lock TRUE`. Ch7 Exercise 7 gives 337 rows and 2 sex codes (`F`, `M`).

The frozen output **committed at HEAD** is stale in all three chapters [V, `git show HEAD:.../_freeze/...`]:

- ch5 shows `packages_renv_lock FALSE`.
- ch6 shows `stats/tibble/utils/withr`. It is missing `survival`, and it already contradicted the prose about `withr`.
- ch7 shows `renv.lock FALSE`.

The working-tree freeze, which the concurrent render is regenerating, now matches my fresh run. So the chunks are correct, and the next render will print output that contradicts the prose directly beneath it. The phrase 'at the time this chapter is being written' (03:1211-1212) cannot rescue the prose, because the chunk executes at render time.

The stale passages:

- **03:1206-1226, 03:1228-1251, Exercise 7 (03:1371-1380) and Exercise 8 with its solution (03:1382-1387, 1656-1672).** These say 'Two do not', 'no `renv.lock`', and L0, and that three pillars are present. Truth: four pillars, L1. The 'not partway between rungs' teaching point still works if restated: 'four of five pillars is L1, not 80% of the way to L2'.
- **04:1141-1146, 04:1161-1175.** These say 'has no `renv.lock` yet', that `tibble` is the one contributed package, 'L0', and 'the step this book's own repository has not yet taken'. All four are wrong now. The new rows also expose a conceptual gap. `survival` is a *recommended* package, and 04:568-569 says recommended packages are 'excluded from the code set'. Yet `renv` lists it in the scan and pins it in `renv.lock` (line 1857) [V]. The prose must say how to count `survival`, or Exercise 7 ('number of distinct contributed (non-base) packages') has two defensible answers: 2 (`tibble`, `withr`) or 3.
- **05:1323-1331.** This says 'Neither file exists' and 'once @sec-dependencies' lockfile is committed'. It also gives an adaptation recipe that becomes wrong once one looks at the real lockfile; see F3 below.
- **Outside my files, but forced by the above.** The instructor-guide autogradable values are stale:
  - ch5: `sum(pillars)` = 1 (instructor-guide.qmd:119); fresh value 2.
  - ch6: `c("stats","tibble","utils")`, 'tibble only' (139-149).
  - ch7: `file.exists` values. Check these too.
  - 02-levels-of-reproducibility.qmd:921-950 makes the same L0 claim and says 'Chapter 6 adds exactly that artifact'.

Fix (ranked fix 1): generate these sentences from the chunk with inline R, for example `` `r sum(pillars)` `` and `` `r if (pillars['packages_renv_lock']) 'L1' else 'L0'` ``, so they cannot drift again. That follows the brief's rule that numbers in prose should be computed. Then rewrite the ch6 cohort section as 'the lockfile this chapter describes now exists; here is what it pins for the cohort'. That arguably makes a better narrative: the book shows its own compendium climbing the ladder.

### B1. Chapter 5, 03-research-compendium.qmd

**Reading time.** About 8,750 prose words plus 1,950 in solutions, so about 44 minutes plus code. The stated 50 minutes is fair [V, word count].

**Opening (20-27, 115-156).** Effective. The 'scatter, not an object' student is concrete and familiar to an MS student. The L0 placement is stated early.

**Closing.** There is no consolidating paragraph. The chapter ends on exercises, the cheat sheet, and further reading, which points forward to ch6 and ch7 (1708-1710). The cheat sheet does the consolidation. A three-sentence close after 'The cohort, continued' would help: archetype from deliverable, `R CMD check` as floor not ceiling, the compendium at L1 awaiting L2.

**Prose difficulty.** Generally moderate. The hardest passages:

- 92-102 ('In the sense of pinning a package version or a system library, this chapter captures nothing on that stack. What it captures are the two layers that sit above those...'). 'Those' has no clear antecedent.
- 368-386, the `.Rbuildignore` argument. It is correct but compresses tarball, build, and check into four sentences.
- 1186 ('The chapters placed so far have all described a composite student's compendium'). This reads as a garble. Suggest 'The examples so far have all described a hypothetical student's compendium.'

**Findings, by severity.**

- **Major. 03:849-852 vs 03:1329-1331 and 03:1584-1589 [I].** The body gives the simulation archetype's emphasized gate as 'a test that the seeded simulation returns identical output on a second call'. The LLM section says 'A second call in the same session agrees with the first even when the generator has changed, so it does not test this'. Exercise 5's solution says the same at more length. A student who writes the body's gate has written the test the chapter later calls worthless. Fix: change 849-852 to 'a baseline test that compares the seeded output with a value recorded in an earlier session and committed (@sec-testing)'.
- **Major. 03:952 (fig-gates code) vs 03:904, 765, 1037 [I].** The figure's `renders` vector includes 'Data analysis', so the figure and its alt text show the render gate as applying to data analysis. The table says 'Optional', the body says 'A render gate is optional here', and the weight table says 'only if a report exists'. Fix: drop 'Data analysis' from `renders`, or add a third 'optional' status.
- **Minor. 03:697-701 [I].** This is factual-issues item 17, confirmed. From `analysis/report/`, `'../../analysis/data/raw_data/...'` and `'../data/raw_data/...'` resolve to the same file. Ch11 itself uses both forms (08-testing-quality.qmd:568 and 808). The paths do not 'assume a different starting working directory', and the longer one is not 'two directories deeper'. Fix: 'reaches the same file by a longer route; nothing but the author's care keeps the two forms in agreement'.
- **Minor. 03:1037, 1040 [I].** This is factual-issues item 18, confirmed. Data analysis is the 'Most valuable case for `targets`' and simulation the 'Strongest case'. Pick one.
- **Minor. 03:1531-1535 [I].** The Exercise 4 solution says 'No directory needs reorganizing' and then '`analysis/`... empties or becomes `vignettes/`'. Moving files into `vignettes/` is a reorganization. Say 'the scaffold's directories already exist; files move from `analysis/` into `vignettes/`, but no new structure is invented'.
- **Minor. 03:370-372 [EK].** '`R CMD check` does not check the directory it is pointed at. It checks the package tarball that `R CMD build` makes'. This is true of `rcmdcheck` and `devtools::check()`. Plain `R CMD check dir/` checks the directory without building. The conclusion (`analysis/` is never parsed) holds either way, because check parses only `R/`. Qualify the claim to 'as `rcmdcheck` and `devtools::check()` run it'.
- **Minor. 03:537-544 'The honest level' callout.** It says nothing that the preceding paragraph did not. Cut it or merge it.

**Pedagogy.** The check-your-understanding questions are answerable from the text. Exercises 1-6 are good, and Exercise 6, the steel-man exercise, is excellent. Exercises 7 and 8 and their solutions are wrong as of the current repository (B0).

**Callouts.** Fourteen collapsible checks in about 9,000 words is dense but tolerable. The Pitfall (403-418) and Verification (388-401) callouts are well used.

**Running example.** It is consistent with `R/cohort.R`: 338 raw rows, 337 cleaned, one duplicate [V]. Only the pillar state is stale.

### B2. Chapter 6, 04-dependencies.qmd

**Reading time.** About 8,000 prose words, so about 40 minutes plus code and JSON. The stated 50 minutes is fair.

**Opening (27-34, 103-146).** Strong. The doctoral student with drifting `dplyr` motivates the chapter directly. The roadmap is complete.

**Closing.** Same pattern as ch5: no consolidating paragraph, and the further reading points forward to ch7 (1636-1641). That is acceptable.

**Prose difficulty.** The hardest passage is 573-597, the archetype qualification. It uses 'strict `DESCRIPTION` inclusion' three times and states the same conclusion twice (583-586 and 592-597). Suggested rewrite:

> For an R package the strict chain holds: everything the code calls belongs in `DESCRIPTION`. A compendium's `DESCRIPTION` declares only what `R/` uses, so a package used only by an analysis script may legitimately appear in `renv.lock` and nowhere else. The gate a compendium must pass is therefore the single inclusion $\mathrm{Code} \subseteq \mathrm{renv.lock}$: nothing used goes unpinned.

The other two hard passages are 652-673 (the repair semantics) and 405-418 (the hash history).

**Findings, by severity.**

- **Major. 04:1141-1175 and Exercise 7.** Stale; see B0. The fresh table has five rows.
- **Major. 04:1188 [V].** This is factual-issues item 10, confirmed. '`rnorm()` and `sample()` live in the `stats` package'. `environmentName(environment(sample))` returns `"base"`. Fix: '`rnorm()` lives in `stats` and `sample()` in `base`; both are base-R packages'.
- **Major. 04:1410-1413 vs 04:1528-1531 [I].** This is factual-issues item 50, confirmed. The Exercise 2 solution says the untouched `R` block 'is the point of @tbl-lockdiff... the lockfile pins the R version separately'. @tbl-lockdiff (1076-1096) contains no R-version content, and Exercise 6 correctly says the R version is 'recorded in the lockfile but not supplied by it'. Fix: 'the `R` block at the top is untouched; it records the R version but does not supply it (Exercise 6)', and drop the @tbl-lockdiff clause.
- **Minor. 04:1616-1618 Further reading [V].** '`packrat`... is set out compactly in the survey portions of @sec-intro'. `packrat` appears only in 04, glossary.qmd, and index.qmd (grep), so there is no such survey. Drop the sentence or point to the glossary.
- **Minor. 04:976-979 [I].** 'restoring does not enforce or warn on a mismatch by itself'. In renv 1.2.3, `renv_load_r()` prints 'Using R %s (lockfile was generated with R %s)' whenever an activated project loads under a different R minor version (source read from the locked namespace). `restore()` itself does not warn, but the reader will see a notice at startup. Add: 'renv prints a one-line notice when the project loads, but does nothing to supply the recorded R'.
- **Minor. 04:1570-1573 [V].** The Exercise 8 solution lists `renv/.gitignore` as `library/`, `sandbox/`, `staging/`, `local/`. Running `renv_infrastructure_write_gitignore()` writes `library/ local/ cellar/ lock/ python/ sandbox/ staging/`. Calling `local/` 'its own cache' is inaccurate; it holds local package sources. The sentence also places `activate.R` and `settings.json` 'at the project root'; they sit in `renv/`.
- **Minor. 04:1587-1588 [EK].** This is factual-issues item 50, part 3, and I could not settle it. 'renv::restore() would either refuse to use these or use them incorrectly'. `restore()` compares recorded versions with installed DESCRIPTION versions. A same-version foreign binary would likely be treated as installed and fail at `library()`. 'Refuse' is probably wrong; say 'would treat them as installed and fail when they load'.
- **Minor. 04:63-64 and 04:873-876 [I].** This is factual-issues item 19. The platform qualifier now exists at 894-900, so the item is mostly fixed. The objective ('so that a restore draws fixed, pre-compiled binaries') and the first statement still lack 'on macOS and Windows; on Linux only from the codename URL'.
- **Minor. 04:1098.** 'Four of the six pins moved' is typed. It is correct (`sum(version_a != version_b)` = 4 [V]) but should be inline R.
- **Minor, duplication.** The Pitfall (420-434) repeats the paragraph before it (405-418) almost line for line. Keep one. 'The limits of renv' (934-961) also overlaps ch7's 'What the lockfile leaves standing' (05:294-328), down to the GDAL and `libxml2` examples. Keep the ch6 version short and forward-pointing.

**Verified tool claims.** The `zzrenvcheck` 0.10.0 claims check out [I, source]: the `error_on_fail = !interactive()` default (R/compare.R:107), `compendium = "auto"` (R/compare.R:99), and the CRAN fallback with a warning when a package is not installed (R/autofix.R:219-263).

**Callouts and pedagogy.** These are sound apart from Exercises 2 and 7. The 'snapshot writes, restore reads' mnemonic (525-526) is the chapter's best device.

### B3. Chapter 7, 05-containers.qmd

**Reading time.** About 9,750 prose words plus 1,860 in solutions, so about 49 minutes plus code. The stated 40 minutes is too low; say 55 [V, word count].

**Opening (20-27, 118-163).** Good. The GDAL failure and the R-version drift map cleanly onto the two layers captured.

**Closing.** The worked example (1270-1282) does consolidate: what L2 gained, and that L3 is ch12. That is the best closing of the three chapters.

**Prose difficulty.**

- 557-575, the emulation versus digest argument. It is also wrong in part; see F1.
- 934-1006, the locale passage. It is long but well staged.
- 1015-1040, the thread passage. It is clear.

**Findings, by severity.**

- **F1. Major. 05:570-575, 254-256, 600-602, 1182-1185, 1199-1212 [V].** The text says 'A digest names one specific, byte-identical filesystem for one specific platform' and 'The same digest always denotes byte-identical bytes'. `docker buildx imagetools inspect rocker/r-ver:4.4.0` shows otherwise. Its digest, `sha256:73adab...`, is exactly the one on the showcase `FROM` line (755). It is an OCI *image index* with `linux/amd64` and `linux/arm64` manifests. The ch7 Exercise 2 digest for tidyverse (`3e7203...`) is also an index; it has one amd64 entry and an attestation. The chapter's own 513-514 says 'one tag, or even one digest, points... at a small table'.

  An Apple Silicon student who builds the showcase Dockerfile *without* `--platform` therefore gets native arm64 bytes under the same digest. A labmate on Intel gets amd64 bytes. The claims that a pinned team image means 'every member pulls byte-identical bytes' and 'Works on my machine therefore cannot arise' (1183-1185) fail for a mixed lab.

  Fix: 'An index digest fixes one set of per-platform images; a digest together with a fixed `--platform` fixes one filesystem. Pin both, or pin the platform-specific manifest digest.' Add `--platform linux/amd64` to the team-model claim.
- **F2. Major. 05:507-608 ordering [I].** This is factual-issues item 7, confirmed. 'The showcase Dockerfile earlier in this chapter, built on `rocker/tidyverse`' (535-538) is wrong on both counts. The showcase comes later (752-782), and it is built on `rocker/r-ver:4.4.0`, which the same section verifies has an arm64 entry. 'Already teaches' digest pinning (568-569, 587-588) points forward. 'The next section exists to pin' (567-568) BLAS and vector-instruction differences, but those are treated two sections later. The check question at 580-588 says the showcase build is slow because no native arm64 `rocker/tidyverse` exists, so it describes a different Dockerfile. Fix: move the section after 922, retarget 535-538 and 580-606 to the Exercise 2 tidyverse recipe, and see A1.
- **F3. Major. 05:347-349 and 05:1799-1800 [I].** The text says of R itself that 'its version is recorded nowhere in the lockfile' and 'none of them has an entry in the lockfile'. The lockfile records `"R": {"Version": ...}`, as ch6:337-338 shows and as this repository's `renv.lock` does (4.6.1) [V]. Fix: 'its version is recorded in the lockfile's `R` block, but the lockfile cannot install it'.
- **F4. Major. 05:1333-1341 [V].** The recipe for this compendium says to pin `rocker/r-ver` or `rocker/tidyverse` 'by digest rather than by the tag `4.4.0` alone', with '`jammy` for the current `rocker/r-ver:4.4.0`'. The compendium's actual `renv.lock` records R 4.6.1. `rocker/r-ver:4.6.1` exists, and its image config sets `CRAN=https://p3m.dev/cran/__linux__/noble/...` [V]. Following the bullets literally gives a 4.4.0 image restoring a 4.6.1 lockfile, which is the exact mismatch the chapter warns about. Fix: 'a `rocker/r-ver` tag matching the lockfile's recorded R (4.6.1 here, on `noble`)'. Better still, compute it from the lockfile in the chunk.
- **Major. 05:1323-1331.** Stale; see B0.
- **Minor. 05:1712-1714 [I].** This is factual-issues item 20, confirmed. 'Setting `OMP_NUM_THREADS=1` removes the variability', while the body (1023-1036) requires `OPENBLAS_NUM_THREADS=1` as well for the OpenBLAS the image carries. The Exercise 5 prompt (1482) repeats the single variable.
- **Minor. 05:1503-1505 [I].** Exercise 7 asks for 'the one line this chapter's showcase Dockerfile would need to add to pin the thread count'. The showcase already sets both variables (767-768), so the premise is false. Ask instead: 'name the line in the showcase Dockerfile that pins the thread count, and say why both variables appear'.
- **Minor. 05:1129 [V, grep].** 'the random-number discipline of @sec-dependencies'. Ch6 contains no RNG content; the seeding discipline is in @sec-compendium (03:834-853).
- **Minor. 05:1224 vs 05:1615 [I].** This is factual-issues item 51. The worked example picks minimal for data analysis and Exercise 3 picks tidyverse. Both are defended conditionally (1111-1114), so this is tension rather than error; Exercise 3 should say 'tidyverse or minimal; see the worked example'. The second half of item 51 ('single changed line' vs 'at most a single system-installation line') I would call refuted: 1096-1097 is an upper bound and 1267-1268 is a case within it.
- **Minor. 05:342-343.** `` `install.\npackages()` `` is broken across a line inside backticks and renders as 'install. packages()'.
- **Minor. 05:1345-1346 [EK].** 'the cohort's own model fit uses a bootstrap whose last digits the thread count can move'. `bootstrap_ci()` refits `glm` on 337 rows serially. `glm`'s QR uses LINPACK and level-1 BLAS, where OpenBLAS threading is unlikely to engage at this size. The claim is plausible in principle but not demonstrated. Soften it to 'could'.
- **Minor. 05:1857-1859 [EK, unverified].** '`rrtools` first combined a lockfile and a Dockerfile'. My recollection is that rrtools' Dockerfile installed from `DESCRIPTION` against a dated MRAN snapshot rather than restoring an renv lockfile. Check before keeping 'lockfile'.
- **Minor, style.** The parenthetical evidence tags in body prose ('(verified)', '(Inspected: ...)', at 529, 532, 623-625, 997, 1000, 1848) read as review artifacts. Move them to a footnote or a single 'How we checked' callout.

**Pedagogy.** The checks and Exercises 1-4 and 6 are answerable and agree with the body. The Exercise 2 digest is real and current [V]. Exercise 4's code is correct as written [I].

**Running example.** 337 rows and 2 sex codes are confirmed [V]. The file-existence prose is stale.

### B4. Cross-chapter

- **Out of sequence.** Only the ch7 Apple Silicon section (F2).
- **Duplication.** The lockfile-limits passage appears in both ch6 and ch7. The 'Restricted data' callouts repeat intentionally and are fine.
- **Inconsistent tense.** The opening objectives say 'we shall' in ch5 and ch6 and 'we will' in ch7. This is trivial.

### Memorability

Devices that work:

- 'If I deleted this file, could the code regenerate it?' (03:1433)
- render-none / render-one / render-many (03:874-876)
- 'snapshot writes the lockfile and restore reads it' (04:525)
- 'the lockfile answers which packages, the container answers on what' (05:1806)
- the tag-versus-digest timeline figure

Devices that would help:

1. A three-row 'three pins' table in ch7: digest → base, snapshot → download source, lockfile → versions, each with what breaks without it. It would replace the prose recap at 731-736 and 847-859.
2. A computed 'ladder ledger' line in each chapter's cohort section, for example 'Pillars present: 4/5; rung: L1', so the book visibly climbs its own ladder.

### Three concrete fixes, ranked

1. **Compute, do not type, the compendium's state.** Affected: 03:1206-1251, 1371-1387, 1656-1672; 04:1141-1175, 1312-1318; 05:1323-1341, 1496-1505; instructor-guide.qmd:105-182; 02:914-950. Use inline R from the existing chunks. Restate the placement as L1. Decide whether `survival` counts as contributed. Make the ch7 base image follow the lockfile's R version (4.6.1, `noble`).
2. **Repair the ch7 digest argument and section order.** Affected: 05:254-256, 507-608, 1182-1185. State that index digests are per platform, pair the digest with `--platform`, move the Apple Silicon section after the pinning section, and remove the 509-510 transition.
3. **Remove the internal contradictions about what a lockfile records and what a seeding gate is.** Affected: 05:347-349 and 1799-1800 ('no entry in the lockfile'); 04:1410-1413 ('pins the R version', @tbl-lockdiff); 03:849-852 (the second-call gate) against 03:1329-1331 and 1584-1589; and the 03 fig-gates render cell for data analysis.

### Scope disclosure

- I did not build any Docker image. The Docker claims rest on `docker buildx imagetools inspect` registry queries only.
- I did not run `R CMD check` on a toy package for the `.Rbuildignore` claim (03:391-400), nor `renv::restore()` for the version-mismatch claims.
- I did not render any chapter. The figures were judged from their code and alt text.
- I did not check `zzcollab` templates for the generated Dockerfile's labels or digest pinning (05:1237-1249), or for the `.Rprofile` exit-hook claim (04:482-490).
- The dated facts cited in the chapters (`renv` 1.2.3 on 2026-10-11, `dplyr` 1.2.1, the PPM dates) were not checked against external sources.

Scratch files: /private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/review3/work-reader-b/
