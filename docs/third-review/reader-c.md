# Reader C: Chapters 8, 9, 10 (06-backends-runtimes, 07-literate-programming, pipelines)
*2026-11-07 11:20 PST*

## Summary

1. Ch9's pacman landmine is wrong [V]. renv 1.2.3 `dependencies()` finds packages passed to `pacman::p_load(dplyr, tibble, ggplot2)`, to bare `p_load()`, and to `char =`. The second review flagged this as A-V and the plan marked it fixed (REFACTOR-PLAN:1568, 1980), but it is still in the text at 07:644-653, 1627-1645 and 1652.
2. Ch8's Apptainer advice is wrong at four sites [I, Apptainer docs]. `--cleanenv` clears environment variables only and does not isolate `$HOME` (06:851-852, 966, 995, 1360). The host home, and with it `~/.Rprofile`, `~/.Renviron` and any user library, is still mounted.
3. Ch8's artifact check now prints `renv.lock = TRUE` [V], because renv.lock has been tracked since 5a99aa9. The prose (06:759-760, 775), Exercise 7 (06:1102-1108) and the Instructor Guide key ('FALSE, FALSE, FALSE, TRUE') all contradict it. Ch10's 'L0 rung' and 'lockfile ... still absent' (pipelines:1281, 1306) have the same stale premise.
4. Ch9 still says verification 'hashes the computational outputs' (07:861-871, 908-911, 1540-1547). That contradicts habit 5, Ch12 (09-CI:1050-1056, 2219) and the book's own tolerance-based baseline test. Ch10's ratio argument is also contradicted by measurement: within one process the bootstrap-to-fit ratio ran 45, 186 and 138 [V].
5. The voice pass preserved meaning in all three files. Its costs are tics: 6 'That is,' (two misused as connectors), 2 'We note that', 3 'Unfortunately,', and 'therefore' rising from 13 to 29 uses. Pipelines has two garbled splits (283-286, 296-298). The cohort numbers are inline and correct (337, 9.5, 338/337) [V].

Report: this file. Evidence labels: [V] ran it, [I] read source or docs, [EK] expert knowledge I did not check.

---

## Part A. Meaning preservation of the voice rewrite (ee7a639 to d786c6b)

I read every word-diff hunk in all three files. In 06 and 07, most changes split a semicolon or colon into two sentences, or turn 'you/one' into 'we'. None changes a claim's scope, number, name or condition. Every flag below is about readability, not meaning.

### Counts (prose, code chunks stripped) [V]

| File | 'That is,' | 'We note that' | 'Unfortunately,' | 'therefore' (old to new) | Rhetorical questions added |
|---|---|---|---|---|---|
| 06-backends | 0 | 0 | 1 (516) | 3 to 9 | 0 |
| 07-literate | 3 (93, 445, 991) | 0 | 1 (775) | 6 to 10 | 2 (162, 1286) |
| pipelines | 3 (131, 264, 778) | 2 (508, 1173) | 1 (644) | 4 to 10 | 3 (214, 455, 624) |

These do not cluster within a file. They do recur across files: each file has exactly one new 'Unfortunately,', always placed in front of a limitation the old text stated neutrally. That pattern reads as a template. The 'therefore' insertions are mostly harmless, but several stand where no inference is being drawn, for example 06:295 and pipelines:1311.

### Flags

1. **pipelines:129-134 (minor, connector now wrong).** Before: '... though by a different mechanism: a test suite checks that the code is *correct* on some input, where a pipeline checks only ...'. After: '... a different mechanism. That is, a test suite checks ... A pipeline checks only ...'. 'That is' introduces a restatement, but this sentence is a contrast, and the split loses the 'where' that carried the contrast. Fix: restore the colon and 'where'.
2. **pipelines:283-286 (minor, garbled split).** Before: '... it too can be defeated, by a step that reads a file without declaring it ..., or that reaches for global state the tool cannot trace.' After: '... can be defeated. A step that reads a file ..., or that reaches for global state the tool cannot trace, will do so.' 'Will do so' hangs with no clear referent. Fix: restore the original.
3. **pipelines:295-298 (minor, garbled).** After: 'The overreach is the same, in exactly the way and for exactly the reasons, as treating the sealed render ... as by itself a reproducibility guarantee.' The 'same ... as' construction is broken. Fix: 'This is the same overreach, for the same reasons, as treating the sealed render of @sec-literate as a reproducibility guarantee.'
4. **07:91-94 and 07:444-448 ('That is,' as filler).** At 93, 'produced by that code. That is, they are not pasted in and left to drift' turns one clause into a fragmentary second sentence. At 445, 'but the mechanism. That is, this figure is produced when the book is built' replaces a colon that introduced an elaboration. Fix: restore 'produced by that code, not pasted in and left to drift' and the colon at 445.
5. **'Unfortunately,' at 06:516, 07:775, pipelines:644 (minor tone).** At 07:775 it adds a value judgment about rocker/verse that the old text did not make. Fix: delete all three.
6. **pipelines:25-34 (redundant roadmap).** The new paragraph is accurate, but it duplicates the Outline in the callout ten lines below. Fix: keep one of the two.
7. **06:19-29 (stilted opener).** 'The alternative named is the one, among Podman, ..., that reaches the same pinned-environment rung ... The choice is keyed to the one constraint that actually binds.' The two sentences say less than the old single sentence did. Fix: 'By the end of this chapter we will be able to take any of three situations ... and name the one alternative to Docker that fits, chosen by the constraint that actually binds.'

No added roadmap or rhetorical question misstates what a chapter does. I found no 'we' that blurs whether the actor is the analyst or a tool.

---

## Part B. Findings ranked by severity

### Major

**M1. renv does see `pacman::p_load()` arguments (07:637-653, 1318-1325, 1361-1371, 1627-1645, 1652, 1657) [V].**
I wrote a scratch `.R` file containing `pacman::p_load(dplyr, tibble, ggplot2)`, `p_load(survival, here)` and `pacman::p_load('data.table', char = c('withr'))`, and ran `renv::dependencies()` (renv 1.2.3) on it. It returned all eight packages. A scratch `.qmd` with `p_load` in a chunk returned dplyr, ggplot2, pacman and tibble. So the claim that tools 'do not parse the argument list of `p_load(a, b, c)`, so packages loaded that way go unrecorded' is false for renv. Exercise 8 would lead a student who runs the scan to the opposite of what the solution says.

The second review recorded this exact defect as A-V (REFACTOR-PLAN:1568), and Section 10.12 lists 'Fix `pacman`', but the text was not changed. The render-time install half of the argument is still valid.

A further error in the same solution [V]: it says `survival` is found 'from the `tbl-diabetic-arms`-style examples elsewhere in the book'. The scan reads one file. `survival` is found because this chapter's own `seal-inline` chunk calls `survival::diabetic` (07:541). The full set the scan returns is dplyr, ggplot2, knitr, pkgload, rmarkdown, survival and tibble.

Fix: base the landmine on the render-time install alone, and note that the zzrenvcheck gate may differ (worth testing). Rewrite Exercise 8 so the student runs `renv::dependencies()` on a `p_load` file and observes that renv finds the arguments. The teaching point then becomes: 'a scanner's coverage is an empirical question, so test it, do not assume it'.

**M2. `--cleanenv` does not isolate `$HOME` (06:851-853, 965-967, 995, 1360) [I].**
Apptainer's environment documentation describes `--cleanenv` as excluding host environment variables only. The bind-paths documentation says `$HOME` is mounted by default and is suppressed only by `--no-home`, `--contain` or `--containall`. Under `--cleanenv` alone, R inside the container still reads the bound `~/.Rprofile` and `~/.Renviron`. Since R_LIBS_USER defaults to a path under that home, a matching user library may also be picked up [EK]. That is the very leak the Pitfall describes. Because the text tells the reader the flag 'is the right default for a verified run', a reader who follows it gets a false sense of isolation, and the claim borders on critical.

Fix: recommend `apptainer exec --containall --bind "$PWD":/project --pwd /project ...`, or `--cleanenv --no-home`. Correct the cheat-sheet row and the check-your-understanding answer to match.

**M3. The cohort artifact check contradicts its own output (06:757-793, 1102-1108; instructor-guide:197-198) [V].**
Run from `analysis/report/` with the locked library, the chunk prints `renv.lock TRUE, Dockerfile FALSE, default.nix FALSE, devcontainer TRUE`. renv.lock has been tracked since 5a99aa9 (2026-10-15). The prose says 'no lockfile' and 'Only the devcontainer file exists'. Exercise 7 refers to 'the three missing artifacts', and the Instructor Guide key expects `FALSE, FALSE, FALSE, TRUE`.

This is the same class of defect as factual-issues item 1, here in Chapter 8. The same stale premise appears in pipelines:1281 ('the L0 rung') and 1305-1306 ('the lockfile and the container, both still absent').

Fix: decide how the book describes the compendium's rung now that the lockfile exists. Then compute the prose from `backend_artifacts` (for example, list `names(which(backend_artifacts))` inline) and regenerate the Instructor Guide key.

**M4. Ch9 contradicts the book's tolerance doctrine (07:861-871, 906-911, 1540-1547, 1659) [I].**
Ch9 says verification 'hashes the computational outputs: the derived datasets, the model objects', calls these 'deterministic', and says each 'changes its checksum exactly when a number changes'. At 908-910 it asks whether outputs 'regenerate within a stated tolerance' and then says this 'is answered by hashing the outputs'. Hashing is exact comparison, not a tolerance.

Ch12 (09-CI:1050-1056, 2019-2021, 2219), habit 5 (_habits.qmd:10) and `inst/tinytest/test-baseline-cohort.R:48-60` (`expect_equal(..., tolerance = 1e-8)`) all say the opposite. The second review recorded this for chapters 07 and 09 (REFACTOR-PLAN:1600-1604), but only 09 was fixed.

Fix: in all three places, replace 'hash' with 'compare against a recorded baseline within a stated tolerance; hashes are for files whose bytes should not change'.

**M5. Ch10's 'the ratio is what survives' is contradicted by the caption and by measurement (pipelines:513-520, 535-545 vs 462) [V].**
I ran the `tbl-pipeline-steps` code three times in one R process. The ratio `round(t_boot / max(t_fit, 1))` came out 45, 186 and 138, with the model fit at 2-7 ms (near the timer's resolution). The caption correctly calls ratios illustrative. The body ('The ratio ... is what survives') and the answer ('far more stable ... the figure worth trusting') still assert the claim the second review asked to remove. This confirms factual-issues item 49 (first half). The ratio is unstable because a 2 ms denominator is noise.

Fix: report the bootstrap's absolute cost and its share of the total. Say only that the bootstrap dominates, which held in every run, and drop 'what survives' and 'worth trusting'.

**M6. The cohort pipeline answer relies on a file target that is not defined (pipelines:1275-1277, 1299-1302) [I].**
`tar_target(raw, load_cohort(cohort_path))` has no `format = 'file'` target. `targets` would track the value of the global string `cohort_path`, not the CSV's contents [EK]. So the answer's 'because the file-tracked target hashes the corrected CSV's new contents' does not follow from the fragment shown. This confirms factual-issues item 6. Exercise 7 (1449-1450) correctly asks for the `raw_file`/`raw` split, so only the prose fragment and the answer need fixing.

Fix: show the three-target fragment, `tar_target(raw_file, cohort_path, format = 'file')` followed by `raw` and then `cleaned`, and say `tar_outdated()` reports all three.

**M7. Binder does not run 'the same pinned image the compendium ships' (06:636-638, 864-869, 592-593) [EK].**
mybinder.org builds an image from repository configuration files with repo2docker. It does not pull a registry digest. The worked example's claim holds only if `.binder/Dockerfile` is `FROM ghcr.io/lab/cohort-env@sha256:...` and that image meets Binder's requirements (a Jupyter server, plus jupyter-rsession-proxy for RStudio). As written, a reader will expect a `.binder/` directory of `install.R`/`runtime.txt` to reproduce the digest-pinned environment, which it does not.

Fix: add the two-line `.binder/Dockerfile` and a sentence on the Jupyter requirement and session resource limits.

**M8. The rix/Nix description is still wrong where the plan recorded a defect (06:453-454, 1203-1207) [EK, corroborated by REFACTOR-PLAN:1576 A-I].**
Current `rix` pins a dated branch of the `rstats-on-nix/nixpkgs` fork, not a NixOS/nixpkgs commit, and the generated `fetchTarball` usually has no `sha256`. The Exercise 3 solution ('a full git commit hash of the `nixpkgs` repository, accompanied by a `sha256`') describes a different file from the one the exercise produces. Separately, 'on any machine, at any later time' (06:404-405) and 'deterministic, reproducible environments ... by construction' (06:220-224, 484-487) overstate what Nix guarantees. Input addressing fixes store paths, not bit-identical outputs, and platform still matters. I could not verify the `rix` part: `rix` is not installed on the host or in the locked library.

Fix: describe the dated-fork pin, soften 'any machine' to 'the same platform', and say 'input-addressed builds' rather than 'deterministic'.

### Minor

- **06:688** 'maximum rigour' (British) is still in the rendered table [I]; factual-issues item 22 confirmed. Change to 'rigor'.
- **06:1110-1117** Exercise 8 asks for 'a `FROM rocker/verse@sha256:...` line from that chapter's Dockerfile'. 05-containers has digest-pinned `rocker/r-ver` (755) and `rocker/tidyverse` (641, 1580), but no verse [I]. Factual-issues item 21 confirmed. Change to `rocker/r-ver`, or say 'any digest-pinned base'.
- **06:1342-1348** The solution still says 'the conversion itself was deterministic', which contradicts the body's careful parenthetical (06:324-327) and the plan's correction at 2787 [I]. Factual-issues item 52 confirmed. Delete the clause.
- **06:539-548** 'This chapter's own practice reaches L2 ... by as many as five routes' contradicts 06:791-793 (the rung is unchanged and nothing has been built). Fix: 'This chapter offers five routes to L2; its own compendium has taken none'.
- **06:208-211, 132** These imply Docker cannot run rootless. Rootless Docker exists, though it needs administrator-installed prerequisites [EK]. The plan recorded this at 1576 [A-I], and it remains.
- **06:1131 vs 282** The solution runs `analysis/scripts/run.R` and the body runs `analysis/run.R`. Neither exists in this repository. Use one illustrative path.
- **06:1298-1302** The Exercise 6 solution makes a CI runner the blog's remote-execution route. CI is not one of the chapter's axis-three tools, and the body (06:608-616) says Binder.
- **07:593-594** 'the trial's total enrollment target of 400 eyes' is presented as a fact about the Diabetic Retinopathy Study. `survival::diabetic` is a 197-patient (394-eye) sample, and I found no source for a 400-eye target [V for counts; source U]. Use a clearly hypothetical constant ('a protocol's stated target').
- **07:1455-1458** '`p_load()` installs `pacman` itself if absent' is false. `pacman::p_load(dplyr)` with pacman absent errors with 'there is no package called 'pacman'' [V]. Factual-issues item 12 confirmed.
- **07:1672-1673** 'the single most cited sentence in this literature' has no support [I]. Factual-issues item 42 confirmed.
- **07:1292-1295** The 'usable record' example ('a general-purpose model, approximately mid-2026') omits the model and version that 07:1276-1279 has just said to record.
- **07:765-766** A full TeX Live install is several gigabytes, not 'on the order of a gigabyte' [EK].
- **07:1653; pipelines:1737** The habit numbers are wrong. Inline expressions are tagged habit 2 ('Pin what you ran'), and pipeline currency is tagged habit 5 (baseline with tolerance) [I, _habits.qmd].
- **pipelines:707** `` `Targets` `` is capitalized in inline code [I]; factual-issues item 49 confirmed.
- **pipelines:1717-1720** The Exercise 8 solution credits 'this chapter's worked example' with triggering a baseline test in CI. The worked example has no baseline test [I]; factual-issues item 49 confirmed.
- **pipelines:1423-1429** Exercise 4 asks for an edit to a function body that 'leaves every file's modification time as `targets` sees it'. Editing `R/*.R` changes that file's mtime, so the instruction is unsatisfiable as written. The solution quietly reframes it as an undeclared helper file. Fix: 'edit a helper sourced by the script but not listed as a prerequisite'.
- **pipelines:1542, 1548 vs 724, 730** The Exercise 3 solution uses `'data/raw_data/cohort.csv'` and `make_figures(model)`, while the body uses `'data/raw_data.csv'` and `make_figures(model, cleaned)`. Align them.
- Factual-issues items 26, 27 and 47 ('ch10') are in 10-archiving-sharing.qmd (436, 1554, 1609), not pipelines.qmd. They are outside my scope, and none appears in pipelines.

---

## Part B. Per-file reader review

### Chapter 8, 06-backends-runtimes.qmd

- **Reading time.** About 8,400 words in all, including solutions [V word count], plus 150 code lines. That is roughly 40-45 minutes, against the stated 35. Adjust to 40.
- **Opening.** The three personas (a cluster job, a lab without a Docker Desktop license, a reviewer who installs nothing) motivate the chapter well for this audience. The first paragraph is stilted (Part A, flag 7).
- **Closing.** Further reading ends by pointing back to @sec-containers and @sec-levels. Nothing consolidates the chapter or points forward to Chapter 9. A two-sentence 'constraint, axis, tool' recap would serve.
- **Hardest passages.** (a) 06:316-327, with the SIF hash parenthetical. (b) 06:481-497, a long trade-off paragraph. (c) 06:1219-1227. Suggested rewrite for (a): 'Build the SIF from the digest-pinned Docker image, never from a separate recipe. The SIF's own checksum will differ from the Docker digest because the file format differs; what stays pinned is the input.'
- **Pedagogy.** The check-your-understanding boxes are well targeted. Exercise 7 and its key are stale (M3), Exercise 8 points at a Dockerfile that does not exist, and the Exercise 3 solution describes the wrong file (M8).
- **Callouts.** Used appropriately. The Pitfall is the most valuable callout in the chapter, but its advice is wrong (M2). The honest-level callout overclaims.
- **Running example.** The artifact check uses the real repository, which is good practice, but the prose around it is typed rather than computed and is now false (M3).
- **Memorability.** 'Three axes: runner, environment model, location' works. A one-row-per-constraint mapping table ('no admin rights, Apptainer, axis 1') would fix it better than `tbl-backends`, which is organized by tool.

### Chapter 9, 07-literate-programming.qmd

- **Reading time.** About 11,000 words in all, plus 107 code lines, roughly 55-60 minutes. The stated 60 is right.
- **Opening.** The orientation's drifted-confidence-interval story is the best motivating vignette in my three chapters. The 'three aims' paragraph above it is serviceable.
- **Closing.** Further reading only, with no forward pointer to Chapter 10, although Chapter 10's prerequisites rely on this one. Add one sentence: 'once computation leaves the document, a pipeline decides what to re-run'.
- **Hardest passages.** (a) 07:1016-1025: 'What would be lost is the absence of a phase in which copying could occur' is a double negative. Rewrite: 'What is lost is a guarantee: starting on day one leaves no period in which numbers are copied, so the habit never forms.' (b) 07:163-174, the 'almost orthogonal' paragraph. (c) 07:1421-1438, where seal and seed are contrasted.
- **Pedagogy.** Exercise 8 cannot be answered as the solution expects (M1). The Exercise 3 solution depends on the false pacman claims. Exercise 7's values match the Instructor Guide: 337 and 9.5 [V].
- **Callouts.** Well used. The 'Verification' tip at 573-586 is a good active-learning device.
- **Running example.** The cohort chunk reproduces 337 records and 9.5 percent missing [V], with both values inline. `seal-inline` gives 197 eyes, 54 events and 27.4 percent [V]. `fig-simpson` gives a pooled slope of -0.061 against within-species slopes of 0.13-0.18 [V], which matches 'nearly flat with a slight downward tilt'. The Exercise 1 solution uses `cohort$age`, but the cohort column is `age_at_enroll`.
- **Content.** The PDF-hashing material duplicates Ch12 (09-CI:1040-1062), and the two disagree (M4). Keep one treatment, preferably Ch12's, and cross-reference it from Ch9.
- **Memorability.** 'The seal and the pins are different virtues' and 'advertisement versus scholarship' both work. 'Landmines' works, provided the list is correct.

### Chapter 10, pipelines.qmd

- **Reading time.** About 11,200 words in all, plus 174 code lines, roughly 60 minutes against the stated 55. Because only the Make section is core, the core-path reading time should also be stated.
- **Opening.** Clear. The roadmap paragraph duplicates the Outline (Part A, flag 6).
- **Closing.** Further reading only.
- **Hardest passages.** (a) pipelines:295-298 (Part A, flag 3). (b) 776-790, the `trust_timestamps` paragraph. It is dense but accurate, though 'That is, it compares' reads as filler. (c) 1174-1180, the linear-schematic caveat. That caveat would be better placed in the figure caption than in the worked example.
- **Pedagogy.** The Make check-your-understanding boxes are correct. Exercise 4 cannot be done as written, the Exercise 8 solution cites something absent, and the cohort answer depends on an undefined file target (M6).
- **Callouts.** The tab Pitfall and the 'Verification' tip are good.
- **Running example.** `tbl-cohort-pipeline` rows are 338 and 337 [V]. The timings vary run to run, as the caption says. The surrounding prose has the stale-rung problem (M3).
- **Memorability.** 'A pipeline validates currency, not correctness' (pipelines:131-134) is the chapter's best line. It should go in the cheat sheet as a rule of thumb.

---

## Known-issue list, items in my files

| Item | Status | Evidence |
|---|---|---|
| 6 (pipelines file target) | Confirmed | pipelines:1276, 1299-1302 [I] |
| 11 (pacman invisible to renv) | Confirmed wrong claim; still unfixed despite the plan | renv 1.2.3 scan [V] |
| 12 (p_load installs pacman) | Confirmed false | ran `pacman::p_load` with pacman absent [V] |
| 21 (rocker/verse digest) | Confirmed | grep 05-containers [I] |
| 22 ('rigour') | Confirmed | 06:688 [I] |
| 42 (superlative) | Confirmed | 07:1672 [I] |
| 49 (ratios; Ex8; `Targets`) | All three confirmed | pipelines:462 vs 517/545 [V]; 1717-1720; 707 [I] |
| 52 (SIF deterministic) | Confirmed in the solution | 06:1347 [I] |
| 26, 27, 47 | Not in my files (10-archiving) | grep [I] |

## Three fixes, ranked

1. **07:637-653, 1455-1458, 1361-1371, 1627-1645, 1652, 1657.** Rewrite the pacman landmine around the render-time install only, and turn Exercise 8 into an observation exercise (M1).
2. **06:846-853, 959-969, 990-1000, 1360.** Replace `--cleanenv` with `--containall` (plus `--bind`) or `--cleanenv --no-home`, and correct what each flag isolates (M2).
3. **06:759-793, 1102-1108, instructor-guide:197-198, pipelines:1281, 1306, and 07:861-911, 1540-1547.** Compute the artifact prose from the chunk, restate the compendium's rung now that renv.lock exists, and replace output hashing with a tolerance-based baseline (M3, M4).

## Scope disclosure

- Not run: Podman, Apptainer, Nix/rix, Binder, Make, or `targets`. None of them is installed in the locked library or on the host, and no Docker image was built. The claims about the Apptainer flags rest on the official documentation [I]; the claims about Binder, rix and rootless Docker are [EK].
- The word counts include solutions and cheat sheets, so body-only reading times are lower than the totals above.
- My cohort runs used the host's R 4.6 base library together with the locked library. tibble resolved from the base library rather than locklib.
