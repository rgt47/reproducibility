# Phase 30, Agent Z2 Report: D29 in Chapters 6, 10 and 12
*2026-11-26 08:37 PST*

Files edited: `analysis/report/08-testing-quality.qmd` (Ch 10),
`analysis/report/10-archiving-sharing.qmd` (Ch 12),
`analysis/report/04-dependencies.qmd` (Ch 6). No other book file was
touched. No commit. Scratch material is under
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/z2/`.

## Word counts (`wc -w`)

| File | Before | After |
|---|---|---|
| 08-testing-quality.qmd | 15662 | 16309 |
| 10-archiving-sharing.qmd | 15902 | 16191 |
| 04-dependencies.qmd | 11268 | 11431 |

Reading-time cards: Ch 10 went from 65 to 75 and Ch 12 from 60 to 65,
both set to the rule's value. Ch 6 stays at 45. Most of the growth in
Ch 10 is the new code blocks, which the rule counts at 10 words a line.

## Final grep (box-aware)

`boxgrep.py` (in the scratch directory) tracks callout nesting. It
reports any backticked or `$`-prefixed `zzc` or `make <target>`, and
any bare `make <target>` line, that sits outside a `## With zzcollab`
callout. The run after the last edit returned:

```
08-testing-quality.qmd: 0 hit(s) outside With zzcollab boxes
10-archiving-sharing.qmd: 0 hit(s) outside With zzcollab boxes
04-dependencies.qmd: 0 hit(s) outside With zzcollab boxes
```

A raw grep, `grep -nE '`zzc|\$ zzc|`make [a-z]|\$ make [a-z]|zzc
verify|zzc add|zzc rebuild'`, returned 27 lines (13 of them are
backticked `zzcollab`, not commands), and I checked each by hand.
A second grep for bare target names (`check-renv`,
`check-renv-no-fix`, `docker-build`, `docker-test`, `docker-render`)
found matches only inside boxes. Box headings are now at 08:1009,
1501 and 2632; 10:464, 523, 777, 1252, 1492 and 2021; and 04:525,
792 and 1764 (line numbers shift slightly with the second-round
edits). The prose word 'make' ('to make it fail') is not a
command and is ignored.

## Second round (after the advisor review and the lead's message)

- **Snapshot type changes the gate. Verified with `dep11.sh` and
  `dep13.sh`.** On an activated scratch project that has a
  `DESCRIPTION`, plain `renv::init(bare = TRUE)` chose the `explicit`
  snapshot type. A `library(here)` added to the report then went
  unreported, and the CI line exited 0. After
  `renv::settings$snapshot.type('implicit')`, `renv::hydrate()` and a
  snapshot, the same drift made the CI line exit 1, and after a new
  snapshot it exited 0. Ch 6 now states this condition right after
  the CI line and tells the reader to confirm the type with
  `renv::settings$snapshot.type()`. This affects every compendium
  that carries a `DESCRIPTION`. The lead may want the CI chapter to
  carry the same caveat.
- **Exercise 3 prompt and solution (04).** The prompt now asks the
  reader to run `renv::status()`, repair by hand, and say what makes
  the check pass after removal. The solution's first paragraph no
  longer claims that `status()` reports the `DESCRIPTION` inclusion.
- **'Locating a drift' Check.** 'What single command' is now 'how
  would you most likely repair it', which matches the two-step answer.
- **Neutralized prose (04:650 to 662).** The passage about the
  framework not enforcing the `DESCRIPTION` inclusion is reworded,
  and the Outline now says 'the `renv` check that enforces its binding
  inclusion'.
- **Left in place (04:606 and 04:1001).** 04:606 still attributes the
  triad name to the framework, which is the one allowed attribution.
  04:1001 says the framework's configuration points R at a dated
  snapshot. Neither contains a command.
- **10, around 1236.** The 49-word 'Measured against' sentence is
  split. Its subject is now 'a compendium with a pinned container
  recipe and a lockfile', so the pinned analysis code is accurate.
- **Style check rerun.** I reran it on the real files with fence
  tracking (`style2.py`), limited to paragraphs that touch changed
  lines. Three more long sentences in 10 were split (the license
  sentence at 764, the 'Where the CI logic' sentence, and the
  `make docker-build` box), along with one wide line. What it still
  flags is the chapter-card Outline (a list written as one sentence)
  and two bold-lead paragraph openers, which it counts as one
  sentence with their header. Those are pre-existing.
- **GitLab appendix (`sec-ci-other-forges`).** None of my three
  files referred to the moved Ch 11 GitLab material, so I changed
  nothing. Ch 12's own GitLab migration solution is self-contained.

## Disclosures (rule 2 and scratch hygiene)

- I ran `renv::restore()` and `renv::hydrate()` inside scratch renv
  projects under the scratchpad, never in the book repository. The
  brief's rule 2 forbids `renv::restore()` without qualification;
  these runs were scratch-only and touched no host library.
- One restore bootstrapped renv 1.3.1 from the network into the
  scratch project.
- `run_qc4.sh` briefly wrote `/tmp/zz_mean_broken.R` and then deleted
  it. All later scratch files went to the scratchpad.

## Per finding

### R11-06 / R4-006, testing chapter (08)

- **1411 to 1515.** The `make style` / `make lint` block is replaced
  by plain calls with real output from a scratch package (`qcpkg`,
  holding a carelessly typed `calculate_mean()`):
  - `LINTR_ERROR_ON_LINT=true Rscript -e 'lintr::lint_dir("R")'`:
    10 lints, exit 31.
  - `styler::style_dir("R")`, which fixes the layout.
  - A second lint run: one `object_name_linter` lint on `na.rm`, exit
    31.
  - A `.lintr` exception, after which there are no lints and the exit
    is 0.
  - The test gate `run_test_dir()` plus `tinytest::all_pass()` with
    `quit(status = 1)`: exit 0 when passing, and exit 1 with the
    division removed.

  Next comes a 'With zzcollab' box for `make style`, `make lint`,
  `zzc add code-quality`, `make test` and `make docker-test`.
- **1553.** The CI lint sentence now points back to the session.
- **999 to 1021.** The `zzc verify --full` passage is rewritten in
  neutral terms (L3 needs a rebuild, a passing suite and a baseline
  test that ran). The tool behavior moves to a box: the
  `test-baseline*.R` naming rule is labeled the tool's convention, and
  plain `zzc verify` is shown to be the coherence tier only.
- **Cheat sheet, 2622 to 2642.** The `make lint` / `make style` and
  `test-baseline*.R` rows are replaced by three plain rows, and a box
  follows the table.

### R13-10 / R4-006, archiving chapter (10)

- **'Framework's vignette' (403 to 410, 463 to 475, 495 to 499, 522
  to 533).** The vignette exists and is public:
  `gh api repos/rgt47/zzcollab` returns `public`, and the local HEAD
  `eb51135` equals remote `main`. The local blob `b1255e7` matches the
  public file. The prose is now neutral. Two boxes cite it with a
  commit-pinned URL:
  <https://github.com/rgt47/zzcollab/blob/eb5113562cd0c84561d743ba06db637e1f02512f/vignettes/reusable-team-images.Rmd>.
  - The second box quotes the vignette verbatim ('If the team image is
    not available, building from the Dockerfile produces an identical
    environment.') and applies the chapter's qualification to it.
  - I removed the '15 to 20 minutes to seconds' timing. The vignette
    gives no measurement for it, and it is inconsistent with itself
    (it says '~30 seconds', '~1-3 minutes' and '~5 minutes' for the
    same step).
- **'System review' (1233 to 1260).** No such document exists. A grep
  for 'system review', 'bus factor' and 'scaffolding tool' across
  `/Users/zenn/prj/sfw/07-zzcollab` and the book repository found only
  REVIEW.md and the raw review notes. I removed the quotation:
  - The prose is now a neutral statement about container-plus-lockfile
    tools.
  - A box gives the authors' own assessment. The single-maintainer
    point is sourced to `gh api repos/rgt47/zzcollab/contributors`,
    run 2026-11-26, which returned `rgt47 396` and
    `dependabot[bot] 5`.
- **'Pillar one/two' (403, 433).** Neutralized to 'the computational
  environment' and 'the package layer'.
- **CITATION.cff (764, box 776 to 788).** 'Generated by zzcollab' is
  removed from the prose. The box clause 'which is where this book's
  file came from' is inherited from the old text and was not checked
  against the repository history. The box states what the template
  (`templates/CITATION.cff`, installed by `modules/project.sh:389`)
  writes: an empty `orcid` and an abstract claiming 'Contains all
  data, code, and computational environment needed to reproduce the
  analyses'. The box flags that abstract for restricted deposits.
- **Worked example (1440, box 1489 to 1500).** `make docker-build` is
  now `docker build -t cohort-env:latest .`. The box describes what
  the target adds: it runs `check-binaries` and then `zzc rebuild`,
  which tags the image with the project name (`modules/docker.sh:1526`).
- **LLM verification (1747).** 'zzc verify or its equivalent' becomes
  a neutral rebuild-plus-baseline condition.
- **'Where the CI logic should live' (about 2008 to 2030, in the
  solution callout that precedes the Exercise 4 solution; the lead
  relayed agent X's report on the same paragraph).** The CI entry
  points are now
  neutral. The `make check`, `make check-renv-no-fix` and
  `make docker-render` targets moved into a nested 'With zzcollab'
  box. All three exist in `templates/Makefile:137, 300, 402`.

### R6-03, dependencies chapter (04)

- **717 to 828, the triad check.** `renv::status()` is now taught
  first, with real output from an activated scratch renv project
  (`depproj`), followed by a verified CI line. The `zzrenvcheck`
  material moved into a box (780 to 827), as described under
  'Verified' below.
- **833 to 897, scanning and the straw man.** The 'code-only scanner'
  sentence and the 'naive check' sentence are rewritten:
  - `renv::dependencies()` parses `.qmd` and `.Rmd`. The `.qmd`
    case is verified: `status()` flagged `here`, which was loaded
    only in `analysis/report.qmd`. The `.Rmd` case is inspected from
    the renv documentation, not run.
  - The risk now named is a home-made check that reads only `.R`
    files.
  - The `zzrenvcheck` scanning details are boxed (855 to 870).
  - The Check is retitled 'where a report's packages hide' and asks
    whether `renv::status()` catches the package. Its Answer is
    rewritten to match.
- **Honest level, triad-across-archetypes, the 'locating a drift'
  Answer, and the Exercise 3 solution.** `check-renv` and
  `make check-renv` are replaced by `renv::status()`, by
  `usethis::use_package()` plus `renv::snapshot()`, and by the
  observed recorded-but-unused behavior.
- **Objective 3** now reads 'keeps the code and the lockfile in
  agreement'. Outline and `##` sections are unchanged.
- **Cheat sheet (1745 to 1763).** The `zzrenvcheck` rows are replaced
  by `renv::status()` and the CI line, and a box follows the table.

### R6-04, the auto-snapshot hook (04:525 to 549)

The paragraph is moved into a box that states the following.

- The hook is in `templates/.Rprofile:218-245`. It runs only in the
  container with renv mode on, is skipped when `CI` is set, and needs
  `renv/activate.R` to be present.
- It calls `renv::snapshot()` at every normal exit. I verified that
  `.Last` runs under `Rscript`.
- It is disabled with `ZZCOLLAB_AUTO_SNAPSHOT=false`, a name confirmed
  at `.Rprofile:223`, and `ZZCOLLAB_AUTO_RESTORE=false` stops the
  restore step. Because the variable is read at exit, setting it with
  `Sys.setenv()` during the session also works.
- `make r` sets both variables to false (`Makefile:235-236`) and runs
  the repairing check after the session instead.
- The trade-off is stated against judgment 1.
- The explicit snapshot type that `renv_init_quiet()` sets
  (`.Rprofile:139`) is recorded as a tool behavior.

## What I ran (real output)

### Testing chapter scratch package

Scripts `final_qc2.sh` and `final_qc3.sh`, log `final_qc.log`.

- **Lint exit codes, verified.** With `LINTR_ERROR_ON_LINT=true` the
  exit was 31 before styling, 31 after styling, and 0 after `.lintr`.
  Without the variable the exit was 0 even with 10 lints.
- **Test exit codes, verified.** A bare `run_test_dir()` with 2
  failures exited 0. The `all_pass()` form exited 0 when passing and
  1 when failing.

### Dependencies chapter scratch project

Scripts `dep5.sh`, `dep7.sh`, `dep8.sh`, `dep9.sh` and `dep10.sh`.
The project was activated: it has a `.Rprofile`, and `.libPaths()`
showed the project library.

- **`renv::status()` and the CI line, verified.**
  - With `here` added to the `.qmd`, `status()` printed the table and
    exited 0, and the CI line exited 1.
  - After a snapshot the CI line exited 0.
  - With `here` recorded but unused, the CI line exited 1.
  - With the library moved aside the CI line exited 1, and after
    `renv::restore()` it exited 0.
- **`zzrenvcheck`, verified.**
  - With a minimal DESCRIPTION, the call printed 'Validation failed.'
    and exited 1.
  - Without a DESCRIPTION it printed 'DESCRIPTION file not found' and
    exited 0 despite `error_on_fail = TRUE`.
- **`usethis::use_package('survival')`, verified.** It wrote
  `survival` to Imports.
- **`?renv::snapshot`, inspected.** It states that 'explicit' uses the
  packages recorded in DESCRIPTION.

The earlier runs `dep2.sh` to `dep4.sh` and `dep6.sh` were made on a
project that was not activated, or one confounded by that. I drew no
book claim from them.

## Untested or not run

- **Archiving worked-example session.** `docker build -t
  cohort-env:latest .` and the rest of that session were not run. The
  chapter already labels the session a static illustration (registry
  and Zenodo placeholders).
- **'With zzcollab' boxes.** None of the box commands was run: `make
  style`, `make lint`, `make test`, `make docker-test`, `make
  docker-build`, `zzc verify --full`, `zzc add code-quality`, `make
  check-renv`, `make check-renv-no-fix`, `make check` and `make
  docker-render`. Running them needs a zzcollab project and image. I
  inspected their behavior from `templates/Makefile`,
  `modules/verify.sh`, `modules/help.sh` and `modules/docker.sh`.
- **`make lint` exit status (inferred).** The claim that it 'reports
  without failing' is inferred. `DOCKER_RUN` does not pass
  `LINTR_ERROR_ON_LINT`, and the plain call without it exited 0.
- **The auto-snapshot hook (inspected).** I did not run it in a
  container.
- **`R CMD check` (not verified this phase).** The claim that it
  reports a package called in code but not declared is
  well-established R behavior.
- **Rendering.** No render was done, per the brief.

## Tool issues found (for the zzcollab and zzrenvcheck maintainers)

1. `zzrenvcheck` 0.10.0 exits 0 when `DESCRIPTION` is missing, even
   with `error_on_fail = TRUE`. A CI gate on such a project cannot
   fail. This is stated in the Ch 6 box.
2. `zzrenvcheck` reported `here` as 'in DESCRIPTION but not in
   renv.lock' when `here` was not in DESCRIPTION. The message wording
   is wrong.
3. The `zzrenvcheck` fix advice says `q()  # Auto-snapshot on exit`,
   but `make r` disables the auto-snapshot.
4. The `zzcollab` CITATION.cff template's abstract claims the
   compendium 'Contains all data ...'. That is false for any
   restricted-data deposit.
5. The vignette's setup times are unmeasured and inconsistent with
   one another.

## Proposed changes to shared files (lead)

- **`references.bib`.** Add an entry for the vignette, keyed
  `thomas2026zzcollabteamimages`, type `@misc`, title 'Reusable Team
  Images: Build Once, Use Everywhere', URL as above (commit `eb51135`),
  note 'zzcollab vignette'. The boxes then cite it with `@key` instead
  of the bare URL.
- **`glossary.qmd`.** The `zzrenvcheck::check_packages()` entry (905)
  should say that the tool-neutral check is `renv::status()`. Any
  'test-baseline' glossary entry should be marked '(zzcollab term)'.
- **Other chapters, not mine.** `02-levels-of-reproducibility.qmd:758`
  still says 'The framework's teaching materials include a vignette
  that ...', which may need the same citation treatment.
  `09-continuous-integration.qmd:660-671` and
  `03-research-compendium.qmd:1573-1580` carry `make check-renv*`
  commands that, if outside boxes, fall under the same rule. The CI
  chapter could also adopt the verified
  `renv::status()$synchronized` line.
- **Other neutral-wording candidates.** 'Archetype' remains as
  chapter vocabulary in Ch 12 (the `## Across the archetypes`
  section). It is outside this brief and I left it as is.

## Test suite

Final run, after the second round:

```
  test-baseline-cohort.R             5     0      5
  test-cohort.R                     25     0     25
  test-compare-baseline.R           20     0     20
  test-fit-cox.R                     5     0      5
  test-manuscript-invariants.R     382     0    382
  test-reading-times.R              12     0     12
  test-replicate-streams.R           7     0      7
  Total                            456     0    456
```

An earlier run failed only on the Ch 10 reading time (card 65, rule
75). I fixed it by setting the card to 75.
