# Agent 4 report: Chapters 8, 9, 10
*2026-11-08*

Files edited: `analysis/report/06-backends-runtimes.qmd`,
`analysis/report/07-literate-programming.qmd`,
`analysis/report/pipelines.qmd`. No other file was touched. Line
numbers below are current (post-edit) and approximate.

Evidence labels: V = I ran it; I = I read the source or text;
EK = expert knowledge, not checked against a live tool here.

## 1. Items

### Chapter 8 (06-backends-runtimes.qmd)

| Item | Line | Action | Evidence |
|---|---|---|---|
| `--cleanenv` (T1-5) | 940-960, 1019-1060, cheat sheet | Already fixed (Phase 19): `--cleanenv --no-home --bind "$PWD"` + `Rscript --vanilla`; left unchanged | I (read Pitfall, Slurm script, answer, cheat sheet) |
| Stale artifact check, prose | 880-890 | Already fixed (Phase 19): inline from `backend_artifacts`; prints `renv.lock` and `devcontainer` found, L1 | V (run_chapter) |
| 'Open door' answer typed 'one existing artifact, the devcontainer' | ~905 | Fixed: now conditional, points to the computed paragraph | I |
| Ex 7 premise | 1245 | Already consistent ('four TRUE/FALSE values'); IG key already TRUE, FALSE, FALSE, TRUE | I |
| Binder overstated | 604-625, 663-672, 971-987, cheat sheet, Ex 6 | Fixed: repo2docker builds its own image; the digest pin holds only with `.binder/Dockerfile` `FROM` the digest on a Jupyter-serving (`rocker/binder`) base, plus `jupyter-rsession-proxy`; session limits; worked example now shows the one-line `.binder/Dockerfile` | EK |
| rix pin description | 458-483; Ex 3 solution 1346-1355 | Fixed: dated branch of `rstats-on-nix/nixpkgs`, usually no `sha256`; commit hash + `sha256` is the stricter pin | EK (rix not installed) |
| 'any machine, at any later time'; 'deterministic' | 225-228, 405-420, 496-502, table row, 750-752 | Fixed: 'on the same platform'; 'input-addressed builds'; added that input addressing does not imply bit-identical outputs | EK |
| 'rigour' in rendered table | 721 | Fixed: 'rigor' | I (grep empty) |
| Ex 8 `rocker/verse` digest | 1252-1254, solution 1491 | Fixed: 'any digest-pinned base line ... such as `FROM rocker/r-ver@sha256:...`' (05 has `r-ver` and `tidyverse` digests, no `verse`) | I (grep 05) |
| SIF 'deterministic' in Ex 8 solution | 1494-1500 | Fixed: clause deleted; added that SIF embeds build metadata | I; metadata claim EK |
| Rootless Docker | 132, 208-215, Ex 4 (c) | Fixed: 'standard Docker installation'; rootless mode exists but needs admin-installed prerequisites | EK |
| Five routes vs none taken | 554-565 | Fixed: 'describes ... routes'; which route the compendium has taken is deferred to the computed section | I |
| Ex 1 path vs body path | 1274 | Fixed: `analysis/run.R` | I |
| Ex 6 CI runner as axis-three tool | 1446-1468 | Fixed: Binder; CI named as separate (Ch 12) | I |
| Ex 5 'L3 is validation' | 1417 | Fixed: 'verification' (canonical rule) | I |
| Voice: opener 'we will be able to' and stilted split | 19-28 | Fixed: 'you'; reviewer's merged sentence | I |
| Voice: 'Unfortunately,' | 531 | Removed | grep |
| Voice: 'therefore' with no inference | 268, 1108 (and two of mine) | Removed | grep |

### Chapter 9 (07-literate-programming.qmd)

| Item | Line | Action | Evidence |
|---|---|---|---|
| pacman: 'invisible to renv' (body) | 637-660 | Fixed: landmine now rests on the render-time install and on `pacman` itself as a silent dependency; states renv 1.2.3 does see `p_load()` arguments; other scanners must be tested | V: `renv::dependencies()` (1.2.3) on a one-line `pacman::p_load(dplyr, tibble, ggplot2)` file returned dplyr, ggplot2, pacman, tibble |
| pacman: 'installs `pacman` itself if absent' (Ex 3 solution) | 1464-1469 | Fixed: absent `pacman` stops the render ('there is no package called 'pacman''); present `pacman` silently installs; summary of loud/quiet landmines recounted (2 loud, 2 quiet, pacman either) | V: `pacman::p_load(dplyr)` with pacman absent errors with that message |
| pacman: Ex 8 and solution | 1376-1384, 1647-1705 | Fixed: Ex 8 is now an observation exercise (scan the chapter, then scan a one-line `p_load` file). Solution has an executed chunk `ex8-scan` and inline prose; the old wrong 'survival from tbl-diabetic-arms' list is gone | V: run_chapter, chapter scan = dplyr, ggplot2, knitr, pkgload, renv, rmarkdown, survival, tibble; pacman file = dplyr, ggplot2, pacman, tibble |
| pacman: cheat sheet | 1709 | Fixed: 'every scanner recognizes; prefer it to `p_load()`, which installs at render time' | I |
| Verification as hashing | objective 64; body 870-890; answer 925-931; Ex 5 + solution 1349-1352, 1545-1572; cheat sheet 1714 | Fixed: compare recomputed outputs with a recorded baseline within a stated tolerance (habit 5); hashes only for files whose bytes should not change; aligned with Ch 12 at 09:1050-1062 | I |
| Honest-level callout said 'no higher than L0' | 898-906 | Fixed (Finding 41): seal adds no rung; the rung is set by the lockfile and environment, computed in Chs 6 and 7; no typed rung | I |
| 400-eye target | 588-594 | Fixed: stated as a hypothetical protocol constant | I |
| Habit number on inline expression ('habit 2') | cheat sheet 1710 | Fixed: tag removed (no habit fits) | I (_habits.qmd) |
| 'single most cited sentence' | 1727-1731 | Fixed: 'the sentence this book takes as its keystone' | I |
| Disclosure record lacks model and version | 1303-1308 | Fixed: example now names placeholders for model name and version, interface, and date | I |
| TeX Live size | 774-776 | Fixed: 'a full TeX Live installation occupies several gigabytes' | EK |
| Ex 1 solution `cohort$age` | 1399 | Fixed: `age_at_enroll, na.rm = TRUE` | V: knitr renders the `inline_expr` literal correctly; column confirmed in CSV header |
| Double negative in day-one answer | 1035-1037 | Fixed per reader C | I |
| Voice: 'That is,' at 93 and 445 | | Fixed (reader C flag 4); 991 kept (a restatement) | grep |
| Voice: 'Unfortunately,' at 775 | | Removed | grep |
| 'therefore' | 1295 (+2 of mine) | Removed | grep |

### Chapter 10 (pipelines.qmd)

| Item | Line | Action | Evidence |
|---|---|---|---|
| Ratio 'is what survives' | 504-535; check 542-566; caption 462 | Fixed: prose now reports the bootstrap's absolute time, its share (floor of percent) of the total, and the largest other step, all inline; says the bootstrap-to-fit ratio is unstable and only the ordering held; check question and answer rewritten; caption's 'two expensive steps' corrected to one | V: 8 runs in one process gave ratios 36, 130, 132, 261, 263, 266, 139, 276 and shares 97.3 to 99.6 percent; run_chapter shows 'took 284 ms, at least 97 percent, none of the other three took more than 7 ms' |
| Undefined file target | 1311-1330; answer 1346-1352 | Fixed: three-target fragment (`raw_file` with `format = 'file'`, `raw`, `cleaned`); explains why a lone `raw` target tracks only the path string; answer says `tar_outdated()` reports all three | EK (targets not installed) |
| Stale L0 | 1336-1340, 1360 | Already fixed (Phase 19): inline `cohort_rung` = L1, `cohort_state` | V |
| Ex 4 unsatisfiable | 1477-1483 | Fixed: edit a helper sourced from a file the Makefile does not list | I |
| Ex 8 solution credits a baseline test in the worked example | 1773-1778 | Fixed: credits Ch 12; says the worked example has no baseline test | I |
| Clean CI runner 'rebuilds exactly what is stale' | 975-982, 1222-1224 | Fixed: clean runner has no `_targets/` store, so it rebuilds the whole graph (the clean-rebuild test); selective rebuild needs a restored store | EK |
| Make error wording | Pitfall 574-591; LLM watch-for | Fixed: exact message with the 8-space hint, the bare message with 4 spaces, and the colon case that raises no error | V: GNU Make 3.81 on a copy of the four-rule Makefile: 8 spaces before `Rscript make_figures.R` gives `Makefile:5: *** missing separator (did you mean TAB instead of 8 spaces?).  Stop.`; 4 spaces gives the bare message; 8 spaces before the `rmarkdown::render` line parses with no syntax error |
| `Targets` capitalized | 707 | Fixed: 'The package reads' | I |
| Ex 3 solution path and `make_figures()` | 1608-1616 | Fixed: `data/raw_data.csv`, `clean_data(raw)`, `make_figures(model, cleaned)` | I |
| Ex 7 'two-target' fragment | 1520 | Fixed: 'three-target' (matches the `raw_file`/`raw` split it asks for) | I |
| Habit 5 on pipeline currency | cheat sheet 1812 | Fixed: tag removed | I (_habits.qmd) |
| Voice: garbled splits 283-286, 295-298; 'That is,' at 131 and 778; 'We note that' at 508 and 1173; 'Unfortunately,' at 644; opener 'we will be able to' | | Fixed per reader C flags 1-3 and 5; 'That is,' at 264 kept (a restatement) | grep |

## 2. Counts

| File | 'That is,' before | after | 'Unfortunately,' before | after |
|---|---|---|---|---|
| 06-backends-runtimes.qmd | 0 | 0 | 1 | 0 |
| 07-literate-programming.qmd | 3 | 1 | 1 | 0 |
| pipelines.qmd | 3 | 1 | 1 | 0 |

Em/en dash grep: empty for all three. Example-list lint grep: empty
for all three. 'We note that': 0 in pipelines (was 2).

## 3. run_chapter.R summary lines

- 06-backends-runtimes.qmd: `errors 0  warnings 0` (baseline the same).
- pipelines.qmd: `errors 0  warnings 0` (baseline the same).
- 07-literate-programming.qmd: `errors 1  warnings 0`. The one error
  is the pre-existing inline `knitr::inline_expr(...)` in the Exercise
  1 solution, which can be evaluated only inside a knitting process;
  the baseline had the same error. I confirmed separately that
  `knitr::knit()` renders it to the literal
  `` `r round(mean(cohort$age_at_enroll, na.rm = TRUE), 1)` `` [V].
  All other inline values read correctly in their sentences.

## 4. For the lead

- **Instructor guide, Chapter 10 key** (`instructor-guide.qmd`, about
  line 283-285): the rubric says a second `tar_make()` 'should report
  both targets as already up to date'. The key's fragment has three
  targets. Suggested text: 'should report all three targets
  (`raw_file`, `raw`, `cleaned`) as already up to date, confirmed by
  `tar_outdated()` returning an empty character vector.' [I; the
  `tar_outdated()` behavior is EK.]
- **Instructor guide, Chapter 8 key**: already `TRUE, FALSE, FALSE,
  TRUE`, matching the chunk today [V]. It carries a typed date
  ('as of 2026-11-07'); no change needed from my edits.
- **New executed chunk in Ch 9** (`ex8-scan`) calls
  `renv::dependencies()` at render time. renv 1.2.3 is in
  `renv.lock` [I]. It writes one temp file and scans the chapter
  `.qmd`; with `progress = FALSE` it should print nothing, but please
  check the rendered Exercise 8 box for stray console output and that
  the chunk does not slow the render noticeably. Not rendered by me.
- No bib entry needed.

## 5. Not done, or uncertain

- Not rendered (per the brief). The new code blocks (`dockerfile` in
  Ch 8, the `r` fragment in Ch 10) and the Ch 9 solution chunk are
  checked only by run_chapter and by reading.
- rix, Binder/repo2docker, targets, and Apptainer were not run (none
  installed). The rix fork and missing-`sha256` description, the
  Binder `rocker/binder` and `jupyter-rsession-proxy` requirements,
  the SIF build-metadata sentence, the `tar_outdated()` three-target
  answer, the clean-runner store point, and the rootless-Docker
  sentence are EK. Phase 25 should confirm the rix and Binder claims
  in particular.
- Make wording verified on GNU Make 3.81 only; RSE reported the same
  hint for 4.3.
- The pacman scan was verified for renv 1.2.3 only; the body says so.
  I did not test the zzrenvcheck gate on `p_load()` (its source has
  no `p_load` handling by grep, which suggests it may miss them, but
  I did not run it), so the text says only that other scanners must
  be tested.
- Deferred by the brief: the roadmap/Outline duplication at
  pipelines:17-34 (Phase 23), reading times (Phase 23), the Quarto
  freeze section (A6) and LLM-in-pipeline (A4) (Phase 22).
- Not in the Tier 2 rows and left alone: Podman short names and
  SELinux `:Z`, unprivileged Apptainer's dependence on user
  namespaces, the 'capture-versus-validation' wording in the
  prerequisites of Chs 8 to 10 (it matches the shared stack figure's
  'validates' category in `R/`, so changing it is a book-wide
  decision), forward pointers at the ends of Chs 8 and 9, and most
  'therefore' uses in pipelines.qmd.
- Person in solutions: I fixed the solutions I rewrote; I did not
  sweep every solution in the three files for 'we'.
