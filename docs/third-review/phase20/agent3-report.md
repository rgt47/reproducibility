# Agent 3 report: Phase 20, Chapters 6 and 7
*2026-11-08*

Files: `analysis/report/04-dependencies.qmd` (Ch 6),
`analysis/report/05-containers.qmd` (Ch 7). Line numbers are
current (post-edit) lines. Evidence labels: V ran it, I inspected,
EK expert knowledge not checked.

## 1. Items

### Chapter 6 (04-dependencies.qmd)

| Item | Line | Action | Evidence |
|---|---|---|---|
| Stale lockfile prose (cohort section) | 1158-1215 | already fixed (Phase 19): inline R over `tbl-cohort-deps`; run prints 5 found, 3 contributed, lockfile TRUE, 0 unpinned, 'at least L1' | V (run_chapter) |
| Exercise 7 counting rule (`survival`) | 1341-1351, 1192-1200 | already fixed (Phase 19): rule stated in body and exercise; key in instructor guide agrees (3: `survival`, `tibble`, `withr`) | V, I |
| `sample()` in `stats` | 1228-1231 | fixed: `rnorm()` in `stats`, `sample()` in `base` | V: `environmentName(environment(sample))` is `base` |
| 'pins the R version' and `@tbl-lockdiff` (Ex 2 solution) | 1442-1446 | fixed: the `R` block records the version, does not install or enforce it; `@tbl-lockdiff` clause dropped | I |
| Restore and R mismatch (check answer) | 994-999 | fixed: records, neither installs nor enforces; renv prints a one-line notice on a minor-version mismatch at load | V: read `renv:::renv_load_r` in renv 1.2.3 (compares major.minor, prints 'Using R %s (lockfile was generated with R %s)') |
| packrat survey pointer | 1666-1668 | fixed: points to glossary entry `gloss-renv-and-packrat` | V: grep shows no packrat survey outside Ch 6, glossary, index |
| `renv/.gitignore` contents (Ex 8 solution) | 1619-1625 | fixed: `library/ local/ cellar/ lock/ python/ sandbox/ staging/`; `local/` described as local package sources; `activate.R` and `settings.json` placed in `renv/` | V: ran `renv:::renv_infrastructure_write_gitignore()` in a temp project, renv 1.2.3 defaults |
| 'refuse to use these' (Ex 8 solution) | 1636-1639 | fixed: 'would likely treat them as already installed, and a package with compiled code would then fail when it loads' | EK |
| `testthat` (Finding 33) | 1266 | fixed: `tinytest` | I |
| Unpinned gate tool | 704-716 | fixed: `remotes::install_github('rgt47/zzrenvcheck@6f53235668cb4048c1ae793d64b10d6505bf69a2')`, stated as 0.10.0 | V: `gh api` HEAD sha 6f53235 (2026-10-17), DESCRIPTION at HEAD is 0.10.0; no 0.10.0 tag exists (tags stop at v0.3.2) |
| 'Four of the six pins moved' typed | 1117-1119 | fixed: inline `sum(lock_diff$changed != '')` of `nrow(lock_diff)` (4 of 6) | V |
| Binaries objective / first statement (item 19) | 63-65, 877-880 | fixed: qualified to served platforms, Linux needs codename URL | I |
| 'Unfortunately,' (reader A4) | 120 | fixed: removed | V grep |
| 'That is,' before an elaboration | 1016 | fixed: 'In effect,' | V grep |
| Person in opening objective paragraph | 27-34 | fixed: 'we shall be able to' to 'you will be able to' | I |
| Ladder: 'exposed at L2 and below' | 978-979 | fixed: 'every layer beneath the packages remains exposed' | I |
| Ladder: Ex 6 solution implies L2 carries numerical libraries | 1563-1576 | fixed: L2 fixes OS, R runtime, system libraries; no rung guarantees BLAS; thread count and CPU vary | I |
| Duplicated Pitfall (420-434), archetype passage rewrite | 405-434, 576-600 | declined: duplication cuts are Phase 23 (D18) | n/a |

### Chapter 7 (05-containers.qmd)

| Item | Line | Action | Evidence |
|---|---|---|---|
| Finding 30: 'Before we turn to pinning' transition | n/a | already fixed (Phase 19): absent | V: grep 'Before we turn' empty |
| Finding 30: 'byte-identical', 'one specific platform', 'pulls byte-identical', 'built on rocker/tidyverse' | n/a | already fixed (Phase 19): absent; section now after pinning; team model passes `--platform linux/amd64` (1225-1232) | V: grep empty; I |
| Finding 30: 'already taught' in the check question | 934 | already correct after the move (pinning precedes it) | I |
| Finding 30: roadmap and outline omit the Apple Silicon section | 85-86, 160-165 | fixed: outline bullet added; roadmap now ends with profiles, team model, worked example, own compendium (reader A2) | I |
| 'no entry in the lockfile' | 352-357, 1902-1905 | fixed: version recorded in the lockfile's `R` block, which cannot install it | I; V lockfile has `R.Version` 4.6.1 (inline `lock_r`) |
| 'pins the packages but not the R version' | 320-323 | fixed: added that the `R` block records but cannot install | I |
| Base image vs lockfile R | 1420-1436 | already fixed (Phase 19): `rocker/r-ver:4.6.1` computed from lockfile | V (run_chapter) |
| `OMP_NUM_THREADS` alone (Ex 5 solution, Ex 5 prompt, simulation bullet) | 1812-1817, 1569-1570, 1171-1174 | fixed: both `OMP_NUM_THREADS` and `OPENBLAS_NUM_THREADS` | I |
| Ex 7 premise (showcase already sets both variables) | 1585-1595 | fixed: asks to name the instruction that pins the thread count and say why it sets two variables | I |
| RNG cross-reference to `@sec-dependencies` | 1173 | fixed: 'seeding discipline of @sec-compendium' | V: grep; seeding passage in 03:834-853 |
| 'install. packages()' line break | 349-350 | fixed | I |
| `docker inspect` for digests (Ex 1 solution, cheat sheet) | 1611-1630, 1931-1932 | fixed: `docker buildx imagetools inspect` (registry, index digest plus per-platform manifests); `docker pull --platform linux/amd64` then `docker image inspect --format '{{index .RepoDigests 0}}'` labeled as the digest the local copy was pulled under | V: `imagetools inspect rocker/r-ver:4.4.0` prints index digest `73adab...` and amd64/arm64 manifests; `docker image inspect` RepoDigests of local `rocker/r-ver:4.6.0` equals `imagetools` `.Manifest.Digest` (`6f05a1...`) |
| Cohort bootstrap claim (EK, reader and RSE) | 1439-1442 | fixed: softened to 'could', names `bootstrap_ci()` | I: `R/cohort.R` defines `bootstrap_ci()`; effect not tested |
| Ladder: BLAS not guaranteed by any rung | 1075-1079 | fixed: one sentence added in the thread passage | I |
| 'That is,' (A3 at 286; list at 367; restatement at 774; objective at 22) | 22, 288, 372, 779 | fixed: 'because', colon, colon, rewrite | V grep |
| 'We note that' | 103 | fixed | I |
| Rhetorical question restated (reader A5) | 1208-1210 | fixed | I |
| Actor 'the analyst' in Ex 6 solution (A5) | 1848-1849 | fixed: 'the collaborator' | I |
| Person in objective paragraph and solutions | 20, 1605-1606, 1837 | fixed: 'you' | I |
| `rrtools` 'first combined a lockfile and a Dockerfile' (1960 area) | Further reading | not done: reader EK doubt; I did not check rrtools history | n/a |
| Evidence tags in body prose ('(verified)', '(Inspected: ...)') | several | declined: style, not a defect in scope | n/a |
| Reading time 40 minutes | 40 | declined: Phase 23 | n/a |

## 2. Counts

| File | 'That is,' before | after | 'Unfortunately,' before | after |
|---|---|---|---|---|
| 04-dependencies.qmd | 4 | 3 | 1 | 0 |
| 05-containers.qmd | 5 | 1 | 0 | 0 |

Dash grep and example-list grep are empty for both files.

## 3. run_chapter.R summaries

- `04-dependencies.qmd`: `== summary: errors 0  warnings 0` (9
  inline expressions; new ones print 4 and 6).
- `05-containers.qmd`: `== summary: errors 0  warnings 0` (5 inline
  expressions, unchanged values: 'Only `renv.lock` exists', L1,
  `4.6.1`, `rocker/r-ver:4.6.1`).

Baselines before editing were also errors 0 warnings 0.

## 4. For the lead

- **Instructor guide, Ch 7 key (`#sec-ig-ch05`).** The Ex 7 premise
  changed. The 'Common errors' line 'not identifying the
  thread-count `ENV` line as the missing Dockerfile addition' is now
  wrong. Suggested replacement: 'naming only `OMP_NUM_THREADS`; the
  showcase `ENV` instruction sets `OPENBLAS_NUM_THREADS=1` as well,
  because the Rocker image links R against OpenBLAS, which reads its
  own variable.' The rubric sentence ('The `ENV` line needed ... is
  `OMP_NUM_THREADS=1` together with `OPENBLAS_NUM_THREADS=1`') can
  stay, reworded to 'The `ENV` instruction that pins the thread
  count sets ...'. The autogradable values (337, 2, FALSE) are
  unchanged. Its '(as of 2026-11-07)' is typed; consider computing.
- **Instructor guide, Ch 6 key (`#sec-ig-ch04`).** Still correct
  (5 referenced, 3 contributed); no change.
- **Other chapters (not mine).** `09-continuous-integration.qmd`
  (Pharma M10, near 518-524 and 815-817) installs `zzrenvcheck`
  unpinned; the same commit pin
  (`rgt47/zzrenvcheck@6f53235668cb4048c1ae793d64b10d6505bf69a2`,
  0.10.0) would keep Chs 6 and 12 consistent. The `zzrenvcheck`
  repository has no tag for 0.10.0; tagging `v0.10.0` at that
  commit would allow a readable `@v0.10.0` pin.
- No shared-file or bib changes needed.

## 5. Not done

- The `rrtools` claim in Ch 7 Further reading was not checked
  (reader EK doubt that rrtools restored an renv lockfile).
- The Ex 8 'treat them as installed' wording is EK; I did not
  commit a foreign-platform library and run `restore()`.
- No Docker image was built or pulled; the digest commands were
  checked by `imagetools inspect` and by `image inspect` on an
  already-local `rocker/r-ver:4.6.0`, not on `4.4.0`.
- The bootstrap-thread effect remains untested; the text now says
  'could'.
- No `quarto render`; the brief reserves it for the lead.
