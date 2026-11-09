# Phase 24, Agent 5 report: the instructor guide (D14)
*2026-11-08 16:16 PST*

Evidence labels: V ran it and observed; I inspected source; EK
expert knowledge, not checked. Nothing is committed.

## 1. Items

| Item | File | Action | Evidence |
|---|---|---|---|
| Move guide out of book | `git mv analysis/report/instructor-guide.qmd analysis/instructor-guide/instructor-guide.qmd` | done (staged as a rename by `git mv`; status `AM`) | V |
| Own project | `analysis/instructor-guide/_quarto.yml`: `type: default`, `output-dir: _output`, renders only `instructor-guide.qmd` to HTML (embed-resources) and PDF | done | V |
| Ignore outputs | `analysis/instructor-guide/.gitignore` (`/_output/`, `/.quarto/`, stray html/pdf/tex/_files; Quarto itself added `**/*.quarto_ipynb`) | done; `git status --ignored` shows `_output/` and `.quarto/` as `!!` | V |
| Setup chunk | `setup` sets `root.dir` to the repo root via `normalizePath('../..')`, runs `pkgload::load_all(repo_root, quiet = TRUE)`, stops with a clear message if the gitignored extract is missing | done | V |
| Typed `#>` lines | all removed; every key block is now an executed `{r}` or `{bash}` chunk | `grep -c '#>' instructor-guide.qmd` = 0 | V |
| Bash keys | Ch4 `git check-ignore -v` + `git log`, Ch13 two `git check-ignore --no-index -v`: executed `{bash}` chunks (run in under a second from root) | done | V |
| Chapter render-time values | recomputed with the chapter's code, cited by file and chunk in a comment: Ch3 `repo_state` (unlabeled), Ch4 `old_copy_has_identifiers` chunk (unlabeled), Ch5 `pillars` (unlabeled), Ch6 `tbl-cohort-deps`, Ch7 `cohort-lockfile-r`, Ch8 artifact check, Ch12 `ci-ex7-key`, Ch13 `cohort-deposit-checks` | done | V |
| Typed dates | 'as of 2026-11-07' (four places) and the header timestamp removed; YAML `date: today`, plus an inline commit hash and clean/dirty flag in the opening | done | V |
| Ch10 `_targets.R` fragment | kept display-only (`{.r}`), with the rubric saying it is not executed: `targets` is not installed in the locked library | display-only | V (requireNamespace FALSE) |
| Week table, On grading, Known rough edges, What is not here | moved from `INSTRUCTOR-GUIDE.md` into the .qmd under '# Teaching the course' | done | V |
| Cumulative quizzes (learning-science 2(d)) | new section `sec-ig-quizzes`; the list of chapters carrying a 'from earlier chapters' check is computed by grepping the chapter files at render | done; rendered 'Ch 2 ... Ch 13 (all of them)' | V |
| Opening paragraph (task 4) | now names Exercise 7 keys for Chs 2 to 13, the Ch 11 Exercise 9 note, and the course material | done | V |
| `INSTRUCTOR-GUIDE.md` | replaced with a pointer; title line kept, new timestamp from `date` | done | V |

### Key corrections forced by the computed values (task 2)

1. **Ch6 key was stale.** `unique(deps$Package)` now returns six
   packages, `parallel stats survival tibble utils withr`, not five:
   `R/cohort.R` gained `parallel::` in Phase 21
   (`replicate_streams()`). The base list is `parallel, stats,
   utils`, not `stats, utils`. Contributed count is still 3. The
   common-error line 'listing `stats` and `utils`' became 'listing
   base packages'. [V]
2. **Ch10 common error was wrong.** 'a pipeline pins no determinant,
   so the compendium stays at L0' now reads 'stays at the rung its
   capture artifacts set, `r rung`' (L1 on this render). The
   lockfile is present, so L0 contradicted Ch3, Ch5 and the
   pipelines chapter's own `cohort-rung` chunk. [V]
3. **Ch10 rubric, small addition.** The exercise asks for
   `tar_outdated()` both after the first `tar_make()` and after a
   second; the old rubric covered only the second. Both are empty.
   [EK, `targets` not run]
4. **Ch3, Ch5, Ch7, Ch8 rung statements** ('L1', 'missing pillar
   Dockerfile', 'R 4.6.1', `rocker/r-ver:4.6.1`, 'TRUE, FALSE, FALSE,
   TRUE', devcontainer image `rocker/verse:4.4.0`) are now inline and
   agree with the typed values on this render. No contradiction. [V]
5. **Ch7 thread variables** are now read from the chapter's showcase
   `docker` block (first block with a digest-pinned `FROM` and an
   `ENV` line), so the key follows the chapter. Note: another agent
   inserted a new `docker` block earlier in `05-containers.qmd`
   during my run; the first version of my extractor picked it up and
   failed its `stopifnot`, which is why the selector is by content.
   [V]
6. **Ch11** four `expect_true()` assertions now execute; 4 of 4 pass;
   a `stopifnot(nrow(raw) - nrow(cohort) == n_dup)` guards the claim
   that only duplicates are removed. Wording 'removes one duplicate'
   generalized to 'removes duplicates'. [V]
7. **Ch13** the guide's invented filename stays `my_extract.csv`
   (the chapter uses `registry_extract_2027.csv`); both resolve to
   `.gitignore:40:analysis/data/raw_data/*`. [V]
8. **Opening paragraph** now also states that the generator does not
   call `RNGkind()` (computed by grep), so a session overriding the
   sampler is a fourth source of a mismatched key. [V]

All other values were unchanged on this render: 338/337/1, classes
'character'/'factor', 9.5 percent, 4 of 5 pillars, `length(missing)`
0 then 'sandwich', oldest fixture commit `0bec92e` holds
`patient_name` and `dob`. [V]

### Week table changes (task 3), against `conventions.qmd` and `_quarto.yml`

The week-to-chapter mapping already agreed with the core path; the
changes are titles, numbering and lab descriptions.

1. Chapter titles set to the current H1s; chapter numbers added
   (Ch 1 to Ch 13 in `_quarto.yml` order). 'Literate Programming'
   became 'Literate Programming and the Rendered Report';
   'Automating the Analysis' became 'Automating the Analysis: Make
   and targets'; 'Introduction' became 'Introduction:
   reproducibility as a computational problem'. A hidden chunk
   (`ig-weeks-check`) fails the render if any title in the table
   stops matching a book H1. [V]
2. Week 1 lab: 'the `sample.kind` demonstration (Exercise 3)' became
   'the RNG-kind comparison (Exercise 3)'; Ch2 Exercise 3 compares
   RNG kinds on a bootstrap draw. [I]
3. Week 8 lab: 'Repair the cohort generator's planted defect' was
   inaccurate (the defects are in the extract, plural, and are
   repaired by `clean_cohort()`, not in the generator). Now
   'Data-validation tests for the extract's planted defects
   (Exercise 7); an oracle test and a baseline test'. [I]
4. Week 10 lab: 'write a restricted-data plan' became 'rewrite the
   data-availability statement for a registry extract held under a
   data-use agreement (Exercise 4)', which is what Ch13 Exercise 4
   asks. [I]
5. A 'Key' column links each week to its Exercise 7 key.

### Other corrections in the moved material

- 'the book's 72 exercises' was stale: now computed, 99 in Chs 2
  to 13 on this render. [V]
- 'about a third ask the student to work from their own paper'
  became 'several' (not computed; I did not count). [I]
- 'every solution is printed' became 'every solution other than
  Exercise 7's is printed' (D14 makes the old sentence false). [I]
- Rough edge, week 10: 'the restricted-data plan exercise is new
  (Phase 6); there is no worked exemplar yet' was stale. Ch13
  Exercise 4's solution now gives the registry-case statement. [I]
- What is not here: 'licensing, `CITATION.cff`, a shell primer, and
  the HPC section are still Phase 11 work' was stale; coverage is
  now computed (Ch13 heading 'Licensing, CITATION.cff, and Software
  Heritage'; `shell-primer.qmd`; Ch8 'An HPC worked example'). The
  sentence placing them in the week table (week 10, optional Ch 8,
  week 1) is typed. [V for coverage, I for placement]
- The quiz section originally opened 'Every check in the book tests
  the section just read'; changed to 'Most checks' since the
  cumulative checks now exist.

## 2. Counts

`That is,` 1 to 0 (the Ch2 rubric's 'That is,' was not a
restatement; removed). `Unfortunately,` 0 to 0. Em/en dashes: 0.
No contractions (grep). Words: guide and old `INSTRUCTOR-GUIDE.md`
together were 2738; now 4820 (.qmd) + 101 (.md), about 2180 words
added, most of it R code in the key chunks.

## 3. Verification

- `quarto render analysis/instructor-guide` with the locked-library
  prefix: HTML and PDF written to
  `analysis/instructor-guide/_output/`; no R warnings, no LaTeX
  errors (14-page PDF). [V]
- `pdftotext` of the PDF: no literal HTML entities, no '??' or
  'Section ?'; each inline value read in its sentence (I read the
  whole text). The source has no typed `#>`. [V]
- `grep -rl 'sec-ig-' analysis/report --include='*.qmd'`: empty. [V]
- No file outside the guide references the old path except
  `THIRD-REVIEW-PLAN.md` (history) and the stale `_freeze/` and
  `_book/` caches (below). [V]
- Full suite (`run_tests.R`, locked prefix): **438 passed, 0
  failed** (invariants 364, reading times 12). This ran while other
  agents were editing chapters, so it is a snapshot. [V]

## 4. For the lead

- **Stale caches.** `analysis/report/_book/instructor-guide.html`
  (untracked, dated 15:41) survives from the last book render, and
  24 `_freeze/*/execute-results/*.json` files still contain the old
  'instructor-guide.qmd' link text. All the chapters are modified,
  so `freeze: auto` should re-execute them; but delete
  `_book/instructor-guide.html` (or render into a clean `_book`)
  before any deploy, or the keys stay publicly reachable.
- **`.Rbuildignore`** does not list `INSTRUCTOR-GUIDE.md` (it was
  not listed before either), so `R CMD build` ships the pointer
  file. Suggested line: `^INSTRUCTOR-GUIDE\.md$`.
- **Rendering** needs the locked-library prefix on this host, as
  the book does; the pointer file gives the bare command.
- **Week 6 lab** says 'A digest-pinned image, built in CI', but CI
  is taught in week 9. I left it; consider 'built locally with
  `--platform linux/amd64`, its digest recorded'.
- No instructor-guide key needed a change in a chapter file.

## 5. Not done, or uncertain

- `targets` is not in the locked library, so the Ch10
  `tar_outdated()` claim is not executed (labeled in the rubric).
- The 'Phase 6' zzcollab/zzrenvcheck fixes in 'On grading': I
  confirmed by reading `modules/verify.sh` that `zzc verify --full`
  withholds L3 without a `test-baseline*.R`; I did not check `make
  docker-test` exit status or `zzrenvcheck`. [I partial, EK rest]
- The 'Known rough edges' week 1 claim (the chapter assumes
  `set.seed()` knowledge) and the weeks 5 to 6 Docker advice were
  kept unverified.
- Spacing and interleaving citations in the quiz section (Cepeda et
  al. 2006; Brunmair and Richter 2019) are taken from
  `learning-science.md`, written as plain text (the guide has no
  bibliography). [EK]
- The cumulative-check list is computed at render, so it will be
  right whenever the lead renders, whatever the other agents finish.

## Message to the lead

Guide moved to `analysis/instructor-guide/` as its own default
project; all keys computed; renders clean to HTML and PDF; the book
has no `sec-ig-` reference; tests 438/438. Two key corrections (Ch6
now six referenced packages with `parallel`; Ch10 'stays at L0' was
wrong). Before deploying, delete the stale
`_book/instructor-guide.html`.
