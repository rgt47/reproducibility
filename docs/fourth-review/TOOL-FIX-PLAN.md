# Plan: Fixing the zzcollab and zzrenvcheck Issues Found by the Fourth Review
*2026-11-26 11:12 PST*

Scope: the two tools the book uses as its running example,
`zzcollab` (`~/prj/sfw/07-zzcollab/zzcollab`, HEAD `eb51135`) and
`zzrenvcheck` (`~/prj/sfw/08-zzrenvcheck/zzrenvcheck`, HEAD
`0911440`). Both working trees were clean when checked. Every issue
below was re-checked on this date against the current source, and
the behavioral ones by running them; the earlier list in
`FOURTH-REVIEW-PLAN.md` and `REVIEW.md` Section 6 was compiled from
agents' reports and is superseded by this file.

Evidence labels: **V** = run on this machine today; **I** = read in
the current source (file:line given); **W** = withdrawn after
checking.

## 1. Re-check results

### Confirmed issues

| ID | Tool | Issue | Evidence |
|---|---|---|---|
| T1 | zzcollab | `make docker-build` ignores the Makefile's `PLATFORM`. The build calls `zzc rebuild`, which chooses `--platform` from `uname -m` (arm64 host: `linux/arm64`, except `verse`). The Makefile comment promises 'Override with make PLATFORM=linux/amd64'; the override reaches only the `run` targets, so a build and a later `make r` can disagree, and an amd64 image cannot be built through `make` on a Mac. | I: `templates/Makefile:47-52, 340-342`; `modules/docker.sh:1314-1323, 1413-1427` |
| T2 | zzcollab | The generated Dockerfile sets `OMP_NUM_THREADS=1` but not `OPENBLAS_NUM_THREADS`, so OpenBLAS threading is uncontrolled in images that ship it. | I: `modules/docker.sh:1218-1224` |
| T3 | zzcollab | When the base-image pull fails, `resolve_image_digest()` warns and returns an empty digest, and the generator silently writes a tag-only `FROM` line; the project then looks pinned but is not. | I: `modules/docker.sh:1071-1093, 1140-1145` |
| T4 | zzcollab | Every `check-renv` variant except `check-renv-no-fix` runs with `auto_fix = TRUE`: it rewrites `DESCRIPTION` and `renv.lock` and passes when the fix succeeds. It does fail when issues remain after the fix (correcting the earlier report, which said it could not fail), but a gate that edits files and then passes is unsuitable for CI, and the target named `check-renv` is the one users reach for. | I: `templates/Makefile:134-146`; `zzrenvcheck/R/compare.R:426-446` |
| T5 | zzcollab | `make lint` prints `lintr::lint_dir()` and exits 0 whatever it finds. | I: `templates/Makefile:156-157` |
| T6 | zzcollab | New projects are initialized with renv's `explicit` snapshot type. Under `explicit`, `renv::snapshot()` records only packages declared in `DESCRIPTION`, which contradicts zzrenvcheck's own compendium mode (packages used only in `analysis/` belong in `renv.lock` but not in `DESCRIPTION`), and a `renv::status()` CI gate misses drift. | I: `templates/.Rprofile:136-143`; V (Phase 30, report Z2): the gate missed drift under `explicit` |
| T7 | zzcollab | The auto-snapshot `.Last` hook is on by default but switched off (`ZZCOLLAB_AUTO_SNAPSHOT=false`) in `make r`, every `DOCKER_RUN` target, the cached test target, and CI; it still fires in `make docker-rstudio` and in host R sessions. Its behavior therefore depends on how R was started. | I: `templates/.Rprofile:221-245`; `templates/Makefile:84, 124, 235, 287, 386` |
| T8 | zzcollab | The deprecated `analysis` profile alias survives and collides with the `analysis` archetype; `make r`'s own error message still recommends `--profile analysis`, and its profile label maps `tidyverse` to `analysis`. | I: `modules/help.sh:35`; `templates/Makefile:211, 220` |
| T9 | zzcollab | `zzc help` says a profile command switches an existing project's profile; the code refuses and points to `zzcollab docker --profile`. | I: `modules/help.sh:32-34`; `zzcollab.sh:2233-2242` |
| T10 | zzcollab | The `CITATION.cff` template's abstract says the compendium 'Contains all data', which is false for any deposit that withholds restricted data. | I: `templates/CITATION.cff:14-16` |
| T11 | zzcollab | `verify` awards L3 when a baseline test's file name appears in the test log. A baseline file that exits early (`exit_file()`) before any comparison still appears by name, so L3 is reported with no comparison made. | V: a scratch suite with `exit_file()` as the first line of `test-baseline-x.R` printed the file name with '0 tests'; I: `modules/verify.sh:279-291` |
| T12 | zzcollab | The test targets pass a suite whose files contain no expectations ('0 tests ... All ok', exit 0), because `all(logical(0))` is `TRUE`. | V: scratch suite with one expectation-free file, exit 0; I: `templates/Makefile:312` |
| T13 | zzcollab | `verify`'s and `doctor`'s R-version coherence checks read an `ARG R_VERSION=` line that generated Dockerfiles no longer write, so the Dockerfile side of the comparison is always empty and a mismatch with `renv.lock` is never caught. | I: `modules/verify.sh:207`; `modules/doctor.sh:235`; generator writes no such ARG (`modules/docker.sh:1150-1215`) |
| T14 | zzcollab | `ensure-zzrenvcheck` installs `zzrenvcheck` from GitHub `main` with no ref, requiring only `>= 0.9.0`. | I: `templates/Makefile:131-132, 254` |
| T15 | zzcollab, zzrenvcheck | **New.** `tooling.lock` records `zzrenvcheck@v0.3.1` as the pinned tool, but the generated Dockerfile does not install `zzrenvcheck` at all (it is installed post-build, unpinned, by T14), so the lock records a version that is not what runs. The generator also declares `zzrenvcheck_tag` and `zzrenvcheck_version` and never uses them. `zzrenvcheck`'s newest tag is `v0.3.2`, while its `DESCRIPTION` says 0.10.0 with 44 untagged commits since. | I: `modules/docker.sh:922-948, 1136-1137, 1268-1270`; `git tag` in zzrenvcheck |
| T16 | zzrenvcheck | `check_packages()` returns `invisible(NULL)` without signalling failure when `DESCRIPTION` is missing, even with `error_on_fail = TRUE`, so its CI gate passes on such a project. | I: `R/compare.R:164-167`; V (Phase 30, report Z2) |
| T17 | zzrenvcheck | The reproducibility warning says 'Found N packages in DESCRIPTION but not in renv.lock' for every package missing from the lockfile, including those found only in code (Z2 saw it for `here`, not in `DESCRIPTION`). | I: `R/compare.R:347-353` |
| T18 | zzrenvcheck | The fix advice prints `q()  # Auto-snapshot on exit`, which does nothing in `make r` (T7). | I: `R/compare.R:797` |
| T19 | both | Neither repository has a `LICENSE` file, so GitHub shows no license, though both `DESCRIPTION` files declare `GPL (>= 3)`. | I: `ls` of both roots |
| T20 | zzcollab | **New, minor.** `make docker-rstudio` omits `--platform $(PLATFORM)` and `ZZCOLLAB_AUTO_SNAPSHOT=false`, unlike every other run target. | I: `templates/Makefile:283-287` |

### Withdrawn or narrowed after checking

| Earlier claim | Finding |
|---|---|
| 'Six archetypes against the tool's five' | **W.** Nothing in zzcollab says five; the discrepancy was only in the book, fixed in Phase 26. |
| '`make test` passes an empty suite' | **Narrowed to T12.** An empty `inst/tinytest/` makes `run_test_dir()` error, so the target exits 1 (V); a suite of expectation-free files passes. |
| '`check-renv` cannot fail' | **Narrowed to T4.** It fails when issues remain after its automatic fix. |
| '`zzc validate` cannot fail' (suspected during this check) | **W.** `error_on_fail` defaults to `!interactive()`, which is `TRUE` under `Rscript`. |

## 2. Decisions needed before implementation

| ID | Question | Options | Recommendation |
|---|---|---|---|
| TD1 | Default build platform on Apple Silicon (T1) | (a) keep native `arm64` as the default and make `PLATFORM` actually reach the build; (b) default to `linux/amd64` to match CI and the book's D15, at the cost of emulation speed and known QEMU failures | (a), plus a one-line warning on arm64 that the image differs from CI, and `make docker-build PLATFORM=linux/amd64` documented as the CI-matching build |
| TD2 | Snapshot type (T6) | (a) `implicit`, matching the book and zzrenvcheck's compendium model; (b) keep `explicit` and change zzrenvcheck's model | (a) |
| TD3 | Auto-snapshot hook (T7, T18) | (a) remove it; (b) default it off everywhere, opt in by variable; (c) on everywhere | (b): no surprise lockfile edits, and judgment 1 of the book's Ch 6 stays with the analyst |
| TD4 | The `analysis` profile alias (T8) | (a) remove now; (b) keep one more minor release with a deprecation warning, then remove | (b) |
| TD5 | zzrenvcheck release (T15) | Tag the current state as `v0.10.0` (matching `DESCRIPTION`) and pin to it, or renumber | Tag `v0.10.0`; pin everything to the tag |

**Decided 2026-11-26** (AskUserQuestion): TD1 native arm64 by
default, with the `PLATFORM` override made to reach the build and a
warning that the image differs from CI; TD2 implicit snapshot type
for new projects; TD3 auto-snapshot off by default, opt in with
`ZZCOLLAB_AUTO_SNAPSHOT=true`; TD4 keep the `analysis` alias one more
release with a deprecation warning, then remove it; TD5 tag
`zzrenvcheck` `v0.10.0` and pin every install and `tooling.lock` to
it. Every recommendation in the table above was accepted.

## 3. Phases

Each phase on its own branch in the tool's repository, with tests
added before the fix where a test can show the bug, the full shell
suite (`tests/shell/run_all_tests.sh`) and the R suite
(`tests/tinytest.R`) green, and no push or merge without the
author's approval.

### Phase T-A: gates that pass when they should fail (zzcollab and zzrenvcheck)

1. **T16** (zzrenvcheck): when `DESCRIPTION` is missing, set
   `result$status <- 'fail'` and signal through
   `signal_validation_failure()` when `error_on_fail`; keep a clear
   message. Test: a tinytest case with a temp directory lacking
   `DESCRIPTION` expects `error = 'zzrenvcheck_validation_failure'`.
2. **T12** (zzcollab template and own Makefile): change
   `TINYTEST_RUN` to fail when no expectation ran:
   `r <- tinytest::run_test_dir('inst/tinytest'); print(r); if (length(r) == 0 || !all(as.logical(r))) quit(status = 1)`.
   Test: shell test with an expectation-free file expects exit 1.
3. **T11** (verify): require evidence that each baseline file ran
   at least one expectation. Parse the tinytest summary line for the
   file ('N tests', N > 0, and no '[Exited at' marker) instead of
   grepping the name. Test: the early-exit fixture above must yield
   L2, not L3.
4. **T5**: `lint` target sets `LINTR_ERROR_ON_LINT=true` (or checks
   `length(lints) > 0` and quits 1); keep a `lint-report` target for
   the non-failing listing. Test: a lint-dirty fixture exits nonzero.
5. **T4**: rename for intent: `check-renv` becomes the failing,
   non-editing gate (today's `check-renv-no-fix`), and the editing
   variants become `fix-renv`, `fix-renv-no-strict`, `fix-renv-slim`;
   keep the old names one release as aliases that print a notice.
   Update the CI templates and `snapshot` target accordingly.
6. **T13**: read the R version from the `FROM` line
   (`rocker/<image>:<version>[@digest]`) in `verify.sh` and
   `doctor.sh`. Test: a Dockerfile whose tag disagrees with
   `renv.lock` makes coherence fail.

### Phase T-B: what is built, and what is recorded

7. **T1** (after TD1): pass `PLATFORM` from the Makefile to
   `zzc rebuild` (environment variable or flag), honor it in
   `build_docker_image()` and `_build_platform()` (the cache key),
   and keep the auto-detected default. Test: with
   `PLATFORM=linux/amd64` on an arm64 host, the build arguments
   contain `--platform linux/amd64` and the cache key matches.
8. **T2**: add `OPENBLAS_NUM_THREADS=1` (and `MKL_NUM_THREADS=1`) to
   the generated `ENV` block. Test: grep the generated Dockerfile.
9. **T3**: when the digest cannot be resolved, stop with an error
   unless `--allow-unpinned` (or a config key) is given; record the
   unpinned state in `tooling.lock` (`base_image_digest: null` is
   already written) and surface it in `zzc status` and `verify`.
10. **T15, T14, TD5**: tag `zzrenvcheck` `v0.10.0`; set the default
    `ZZRENVCHECK_TAG` to that tag; make `ensure-zzrenvcheck` install
    `rgt47/zzrenvcheck@<tag>` and check `packageVersion()` equals it;
    make `tooling.lock` record what is actually installed (or install
    it in the image so the lock is true); delete the unused
    `zzrenvcheck_tag` variables in the Dockerfile generator.
11. **T20**: add `--platform $(PLATFORM)` and the snapshot variable
    to `docker-rstudio`.

### Phase T-C: defaults, messages, and documentation

12. **T6** (after TD2): `snapshot.type = 'implicit'` in
    `renv_init_quiet()`; note in NEWS that existing projects keep
    their setting and show `renv::settings$snapshot.type('implicit')`.
13. **T7, T18** (after TD3): default the hook off (opt in with
    `ZZCOLLAB_AUTO_SNAPSHOT=true`), remove the now-redundant
    variables from the Makefile, and change zzrenvcheck's advice to
    'run `renv::snapshot()`, then review the lockfile diff'.
14. **T17** (zzrenvcheck): split the warning into 'declared in
    DESCRIPTION but not locked' and 'used in code but not locked'.
15. **T8, T9** (after TD4): deprecation warning for `analysis`;
    correct `help.sh` to 'create a new project; switch an existing
    one with `zzcollab docker --profile <name>`'; fix the `make r`
    message and profile label to use `tidyverse`.
16. **T10**: template abstract becomes neutral ('The code and
    computational environment needed to reproduce the analysis; see
    the data availability statement for the data'), with a comment
    telling the author to edit it.
17. **T19**: add the GPL-3 `LICENSE` text to both repositories
    (`usethis::use_gpl3_license()` writes `LICENSE.md` consistent
    with `DESCRIPTION`).

### Phase T-D: release, and the book catches up

18. Tag a zzcollab release and the zzrenvcheck `v0.10.0` (or next)
    release; update each NEWS file.
19. In the book, revise the 'With zzcollab' boxes that describe the
    old behavior: Ch 6 (auto-snapshot hook, `check-renv` naming),
    Ch 7 (native arm64 and the missing `OPENBLAS_NUM_THREADS`, the
    unpinned-`FROM` fallback), Ch 10 (`make lint`), Ch 11 (gates and
    `verify`'s baseline rule), and the Ch 12 CI shim. Record the
    tool version each box describes.
20. Close the corresponding entries in `FOURTH-REVIEW-PLAN.md`.

## 4. Order and size

T-A first: it fixes the gates that can report success falsely (T16,
T12, T11, T5, T4, T13), each a small, test-first change. T-B next,
after TD1 and TD5. T-C after TD2 to TD4. T-D only after both tools
are released, so the book never describes unreleased behavior.
Estimated changes: about 15 files in zzcollab, 2 in zzrenvcheck,
6 book chapters; no estimate of hours is offered.

## 5. Not verified

- T1 and T3 were established by reading the source; no `zzc` build
  was run in this check (an earlier phase ran none either).
- T6's effect on `renv::snapshot()` under compendium mode is
  inferred from renv's documented `explicit` behavior and the Phase
  30 run; no zzcollab-initialized project was snapshotted today.
- Whether existing user projects depend on the old `check-renv`
  auto-fix behavior is unknown; the alias period in step 5 hedges it.

## 6. Implementation record

### Phase T-A (2026-11-26 16:07 PST): done, not pushed

Branches: `zzrenvcheck` `fix/missing-description-gate` (1 commit,
`cb0afc0`); `zzcollab` `fix/false-pass-gates` (5 commits, `71aaa04`
to `89a339e`). Nothing pushed or merged.

| Item | Change | Evidence |
|---|---|---|
| T16 | Missing `DESCRIPTION` returns `status = 'fail'` and signals `zzrenvcheck_validation_failure` under `error_on_fail` | V: 2 new tinytest checks failed before the fix; suite 213/213 after |
| T12 | `TINYTEST_RUN` (both Makefiles) and the GitHub and GitLab test steps exit 1 when no expectation ran | V: expectation-free fixture exits 1, passing exits 0, failing exits 1 |
| T12a (new) | GitLab test steps were non-blocking (`\|\| echo "... (non-blocking)"`); suffix removed, own commit | I: present since the GitLab template was added, with no stated reason |
| T11 | Baseline credited only when its final tinytest log line shows at least one test and no `[Exited at` | V: log fixtures for early exit, late exit, rewritten lines, ANSI codes |
| T13 | R version read from the `FROM` tag; `ARG R_VERSION` kept as fallback; `doctor` likewise | V: see below |
| T5 | `make lint` exits 1 on any lint; `make lint-report` keeps the listing | V: dirty `R/`, dirty `analysis/`, and clean fixtures |
| T4 | `check-renv*` edit nothing and fail with a `make fix-renv` hint; `fix-renv*` repair; `check-renv-no-fix` deprecated alias; `make r` post-session hook uses `fix-renv`; 7 docs corrected | V: dry-run tests on both Makefiles; live fixture: `check-renv` nonzero with files unchanged, `fix-renv` added the package to both files |

**T13 was worse than reported.** Under `zzcollab.sh`'s
`set -euo pipefail`, the failed `grep` for `ARG R_VERSION` ended an
assignment with status 1, so `zzc verify` aborted mid-check (exit 1)
on any project with a `renv.lock` and a generated Dockerfile. Two
existing capture-matrix tests (`test_matrix_L2_renv_backend`,
`test_matrix_renv_toggle_roundtrip`) failed on the base for this
reason and pass after the fix. The first version of the new helper had
the same latent bug; the test suite could not see it because
`run_test_suite` runs each test inside a `||` list, which disables
`set -e`. A test now runs the helper in a fresh `set -e` shell.

**Test evidence.** New `tests/shell/test-gates.sh` (9 tests): all six
tests present at the T11/T13 commit fail on the base commit `eb51135`
and pass on the branch. Full shell suite: base 192 passed, 17 failed;
branch 203 passed, 15 failed. Every branch failure also fails on the
base (pre-existing, not addressed: 11 in `test-capture-matrix`
(toggle, blog archetype, init wizard, apptainer wiring), 1 in
`test-docker` (yaml install), 1 in `test-docs` (removed profile named
in docs), 2 in `test-scaffold-build-run` (scaffold exits nonzero)).
The zzcollab R package tests were not run; no R code changed.

**Not done in T-A.** `snapshot` and the host post-session hook still
call `check_packages(auto_fix = TRUE)` inline, by design (both are
repair steps). Several vignettes say `check-renv` runs 'in the
container'; it runs on the host when R is present (pre-existing, left
alone). The Makefile's `R_VERSION` variable (line 14) is dead code.
`zzvim-R` depends only on the `/tmp/zzvim-r-hook-ran` marker, not on
target names, so the rename does not affect it.

#### Review follow-ups (same day)

A second review of T-A found five gaps; four are fixed on the same
branch (`39bea57`, `d3e0b99`, `051465b`), one is open.

- `doctor.sh` (also `set -euo pipefail`) aborted its state back-fill
  when a `grep | cut` read found nothing. Fixed; a strict-shell test
  aborts on the old file and passes on the new (V).
- `check-renv-no-strict` and `check-renv-slim` named `fix-renv` as
  the repair, which would add the very packages they exclude. Each now
  names its matching variant (V, dry-run test).
- `c()` on two `lints` objects drops the class, so `make lint`'s
  listing printed as a bare list. Each directory is printed on its own
  (V: old expression prints `[[1]]`, new does not).
- `toggle.sh` claimed the validate settings apply to `make
  check-renv`; the Makefiles never read them. Wording corrected (I).
- **Open: T16 and bare compendia.** `zzc init --bare` omits
  `DESCRIPTION` by design (I: `modules/project.sh:657-662`). With T16,
  `check_packages()` fails on such a project, so `check-renv` and
  `fix-renv` fail, `make r`'s post-session hook prints 'Package
  validation failed' after every session, and `verify`'s advisory
  dependency step warns. Before T16 all of these passed silently. The
  `zzrenvcheck` branch is therefore held unmerged pending a decision.

Test count: `tests/shell/test-gates.sh` 11 of 11 pass.

**Still unverified.** The no-host-R (container) paths of `check-renv`
and `fix-renv`; the cached `test-container` recipe with the new
expression; the R code embedded in the edited CI YAML (both files
parse as YAML; the R was not run); the 15 pre-existing shell-suite
failures, including both `test-scaffold-build-run` tests, so no
end-to-end scaffold run backs the claim that new projects pass the
empty-suite rule (that claim rests on reading `create_test_infrastructure`,
which writes one unconditional expectation). The T13 abort in
`cmd_verify` is inferred from two capture-matrix tests changing from
fail to pass plus the same mechanism reproduced on the helper; `zzc
verify` itself was not traced.

#### T16 and bare compendia: decided 2026-11-27 (option 1)

zzrenvcheck keeps failing a project without `DESCRIPTION`; zzcollab
skips. Commit `0af98e5` on `fix/false-pass-gates`: the `check-renv*`,
`fix-renv*`, `snapshot` (check step), and `reset-lock` targets, `make
r`'s post-session hook, `zzc validate`, and `zzc verify` report
'No DESCRIPTION (bare compendium): dependency check skipped' with exit
0; `ensure-zzrenvcheck` installs nothing for a bare project; the hook
still writes the zzvim-R marker. Also fixed in passing: `verify` ran
zzrenvcheck in the caller's directory, not the verified one.

Evidence (V): three new tests (every target with R made unreachable;
the hook; a scaffolded `--bare` project under `verify` and `validate`)
fail on the previous commit and pass; `test-gates.sh` 14 of 14; full
suite 208 passed, 15 failed, the same 15 as the base. T16 is no
longer held.

Not changed: zzvim-R, on an abnormal exit (`:qa!`) without the marker,
runs zzrenvcheck itself in the background (`plugin/zzvim-R.vim:2662`);
for a bare project that run now logs a failure to
`/tmp/zzvim-r-renvcheck.log`. Harmless, outside zzcollab, not edited.

### Phase T-B (2026-11-27 10:50 PST): done; zzrenvcheck released

**TD5 revised (author, 2026-11-27).** `DESCRIPTION` became 0.10.0 at
`354a30a`; `main` later added the `skip_image_pkgs`/`image` arguments
(used by zzcollab's `check-renv-slim`, `fix-renv-slim`, and post-session
hook), the cleanup-gate change, and T16. Tagging that work `v0.10.0`
would mislabel it, and tagging `354a30a` would break those zzcollab
targets, so the author chose a `v0.11.0` release and approved merging,
tagging, and pushing.

**zzrenvcheck 0.11.0 (pushed).** T16 merged into `main` (`410e8af`);
release commit `5d22bf3` (version bump; NEWS gains the unrecorded
`skip_image_pkgs` feature and a breaking-changes note); annotated tag
`v0.11.0`. Tests 213/213; `R CMD check --as-cran`: 0 errors, 0
warnings, 1 note (new submission). The first `git push origin main
v0.11.0` reported a ref-lock error for `main` although the remote
`main` did advance to `5d22bf3`, and the tag was not created; a second
push of the tag alone succeeded (V: `git ls-remote --tags`). Local
branch `fix/missing-description-gate` deleted.

**zzcollab `fix/build-provenance`** (stacked on `fix/false-pass-gates`;
not pushed): `7a1df5e`, `70c281f`, `fbd5535`, `4f33cdb`.

| Item | Change | Evidence |
|---|---|---|
| T1 | An explicit `PLATFORM` reaches `zzc rebuild` as `ZZCOLLAB_PLATFORM`, honored by the build and its cache key; the auto default is not passed; arm64 for verse is refused; a native arm64 build warns that CI builds amd64 | V: `docker`/`uname` stubbed, build arguments recorded; Makefile dry-runs |
| T1a (new) | The run targets' `PLATFORM` default was `linux/arm64` on arm64 hosts even for a verse image, which is always amd64; it now follows the Dockerfile base | V: dry-run on this arm64 Mac |
| T2 | `OPENBLAS_NUM_THREADS=1` and `MKL_NUM_THREADS=1` join `OMP_NUM_THREADS=1` | V: generated Dockerfile |
| T3 | An unresolved digest stops generation (nothing written); global `--allow-unpinned` writes a tag-only `FROM` with a warning; `verify` warns on any tag-only `FROM`; README, vignette, help, cheatsheet updated | V: failed pull stubbed; verify fixtures |
| T3a (new) | `verify` aborted under `set -e` on a malformed `renv.lock` before reporting it | V: fixture |
| T15 | Default tag `v0.11.0`; the Makefile reads the tag from `tooling.lock` and installs exactly that release (host and post-session paths); `tooling.lock` states the tool is not in the image; unused generator variables and a comment naming a nonexistent target removed | V: dry-runs; live install of the Makefile's expression from GitHub into a temporary library gave 0.11.0 |
| T20 | `docker-rstudio` passes `--platform`; the snapshot variable is left to T-C (TD3) | V: dry-run |

Each new test fails on the commit before its fix. Full shell suite:
219 passed, 15 failed (the same 15 as the base).

**Not verified.** No real image was built: T1 rests on stubbed build
arguments, not on `docker build` producing an amd64 image on this Mac;
T2's effect on numerical results is not measured. Commands that
regenerate the Dockerfile in passing (`zzc renv`, `zzc update`) keep
the old Dockerfile and warn when the digest cannot be resolved; that is
from reading `zzcollab.sh:865, 1439, 2674`, not from a test. The
zzcollab repository's own `tooling.lock` (not a generated project's)
still records `v0.3.1`; it was left alone.
