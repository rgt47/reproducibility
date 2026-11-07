# Suspected factual and consistency issues
*2026-11-06 20:09 PST*

These items were flagged by the agents during the humanizer and voice
passes. None has been fixed. Line numbers are approximate and refer to
the state before the voice pass, so locate each by its quoted text.
Evidence status is given for each: 'checked' means an agent ran a
command or compared files; 'read' means it follows from reading the
text; 'recall' means it rests on an agent's memory of an external
source and has not been verified.

## Tier 1: likely errors a reader or reviewer would notice

1. ch03 (about 1175, Exercise 8 at 1626) and ch04 (1127, 1155): the
   text says the repository has no `renv.lock` and places the
   compendium at L0 on that basis. `renv.lock` exists and is tracked
   (checked with `git ls-files`). The frozen chunk output still shows
   `packages_renv_lock FALSE`; a fresh render will contradict the
   prose. Possibly intentional if the chapter describes an earlier
   state; otherwise stale.
2. ch09 Exercise 7 (about 1806-1815): the locked package set omits
   `withr` and `survival`, which the chapter's own demonstration
   (about 1586) includes. The stated `missing` length and the 'one
   package name' result do not follow (read). Same class of defect
   as commit 6ec2f42.
3. ch08 Cox unit test (about 657-660): `expect_equal(fit$nevent,
   sum(!is.na(cohort$incident_dm)))` compares events with all
   non-missing outcomes, zeros included. No test in `inst/tinytest/`
   exercises it (checked by grep).
4. ch02 Exercise 8 solution (about 1305): the runtime is said to sit
   above 'the analysis code below it'; the chapter's own stack puts
   the analysis code above the runtime (read).
5. ch02 Exercise 5 solution (about 1219-1223): 'the two conventions
   actually agree, so the request is not simply a misreading' appears
   logically inverted (read).
6. pipelines check-your-understanding (about 1262) and Exercise 7
   (about 1409): the answer relies on a file-tracked target that the
   pipeline as shown does not define (`tar_target(raw,
   load_cohort(cohort_path))` has no `format = 'file'`) (read).
7. ch05 Apple Silicon section (about 527-586): refers to the showcase
   Dockerfile 'earlier in this chapter, built on `rocker/tidyverse`';
   that Dockerfile comes later and uses `rocker/r-ver:4.4.0`, which
   the same section says has an arm64 build. Digest pinning is said to
   be 'already taught' but comes in the next section. Looks like a
   moved section (read).
8. (Withdrawn after checking: hard-coded chapter numbers match the
   rendered order in `_quarto.yml`, where file prefixes do not; e.g.
   version-control is Chapter 4 and 03-research-compendium Chapter 5.)
9. `utils` listed as recorded in `renv.lock`: ch02 cohort answer
   (about 936) and instructor-guide (68). The ch06 rubric
   (instructor-guide 147-148) correctly says base packages are
   excluded (read; renv behavior from recall).

## Tier 2: probable errors, lower visibility

10. ch04 (about 1174): '`rnorm()` and `sample()` live in the `stats`
    package'; `sample()` is in base (recall, high confidence).
11. ch07 (about 636-645, Exercise 8 at 1614-1632): says renv cannot
    see packages loaded by `pacman::p_load()`. An agent recalls that
    renv's dependency scanner handles `p_load`. If so, the landmine
    argument and the solution are wrong (recall, unverified; worth
    running `renv::dependencies()` on a test file).
12. ch07 (about 1441): `p_load()` 'installs `pacman` itself if absent'
    cannot happen; the call fails first if pacman is missing (read).
13. ch00 (about 185-189): the R 4.0.0 `stringsAsFactors` change
    'altered the behavior of every model that treated those columns as
    categorical'. Overstated; ch01 (573-578) states it correctly.
14. ch00 (about 175): R 3.6.0 changed 'the default random-number
    algorithm'; only the `sample()` method changed. ch01 is correct.
15. ch01 (about 605-608) vs (537-541): simulations are 'more exposed
    to the RNG change than any manuscript', yet `rnorm()`-based
    simulations were unaffected.
16. ch02: layer count inconsistent ('nine layers', 'nine or ten
    layers', 'four of the ten determinants').
17. ch03 `here` section: the ch08 path `'../../analysis/data/...'` is
    said to assume a different working directory; from
    `analysis/report/` both paths reach the same file (checked against
    ch08 lines 568, 753, 808).
18. ch03 archetype table (about 1006/1009): two rows each called the
    strongest or most valuable case for `targets`.
19. ch04 (about 860-888): dated snapshot URL said to return binaries,
    then said to deliver source on Linux; needs a platform qualifier.
20. ch05 Exercise 5 solution (about 1703): `OMP_NUM_THREADS=1` alone
    'removes the variability'; the body also requires
    `OPENBLAS_NUM_THREADS=1`.
21. ch06 Exercise 8 (about 1100): asks for 'a `FROM
    rocker/verse@sha256:...` line from that chapter's Dockerfile'; no
    ch05 Dockerfile uses a digest-pinned verse image.
22. ch06 comparison table (code chunk, about 680): 'maximum rigour'
    is British spelling inside a string that renders in the table.
23. ch08 (about 860): `test-baseline-cohort.R` 'reports five passes'
    while the listing shows three assertions without saying it is
    abridged (the real file has five).
24. ch08 (about 1254 vs 1940): 'removing a validation feature leaves
    the level unchanged' conflicts with Exercise 4's solution (L3 to
    L2 on removing the baseline test).
25. ch09 (about 1047): callout says the chapter's gates reach L3; the
    verification job does, not the gates. Same callout says CI says
    nothing about data integrity, while `zzc verify` checks raw-data
    checksums.
26. ch10 Exercise 3 solution (about 1524) cites `make render`; ch09
    (2040-2046) states there is no plain `make render` target.
27. ch10 Exercise 4 solution (about 1580): accepts output hashes as L3
    evidence, contrary to ch09's argument for tolerance-based
    baselines.
28. version-control (about 147-150): 'the five `FINAL` files ... the
    four snapshots' does not match the seven files listed earlier.
29. version-control Exercise 7 solution: points to the 'Verification'
    section for the cohort check, which is in a later untitled
    paragraph.
30. instructor-guide (260-262): 'both targets' where the fragment
    defines three; (285-287, 311): listed values not computed by the
    code shown.

## Tier 3: minor or debatable

31. setup-appendix (35-36, row 146): omitting `--platform` with an
    amd64-only image said to fail; Docker Desktop on Apple Silicon
    usually pulls and emulates with a warning (recall).
32. setup-appendix (93): CRLF shebang usually yields 'bad interpreter
    ... ^M', not `exec format error` (recall).
33. setup-appendix (148): '/mnt/c or on Windows' own filesystem' names
    one place twice; (5) 'three machines' introduces four topics.
34. colophon (10-13): every computed figure 'generated at build time',
    though `_freeze` replays frozen chunks.
35. cheat-sheet-index: chapter titles differ from conventions.qmd;
    link text lacks a space after the colon ('Chapter 2:The ...').
36. glossary (258): 'the only commit with two parents' ignores octopus
    merges.
37. credits (20): 'the sequence house style' looks like a typo.
38. shell-primer (6-7), setup-appendix (9-12, 103): '2026 syllabi
    comparison' and '2026 expert review' are uncited.
39. ch01 check-your-understanding (about 806): asks for a 'single
    word'; the answer 'RNG kind' is two.
40. ch02 CI answer (509-521): 'toward L3' sits uneasily with 'L2
    confirmed, not L3' (438-441).
41. ch01 (560-564): Trisovic et al. failures attributed to package
    churn alone; the paper also reports missing files and path errors
    (recall).
42. ch07 (1659-1661) 'the single most cited sentence in this
    literature' and cheat-sheet-index (21) 'single most referenced
    table': unsupported superlatives.
43. ch08 (1319-1322): R Validation Hub low-risk treatment said to
    cover long-established tidyverse packages; the white paper may
    limit it to base and recommended packages (recall).
44. ch08 (2131-2135): Peng 2011 paraphrased as 'confirming a result'
    is the minimum; Peng's minimum is reproducibility (recall).
45. ch09: Outline omits two sections; 'as the first section
    established' points to the wrong section; 'five moves' in the
    debugging section vs four diagnostics described.
46. ch09 (1208): Docker without renv rated L2, in tension with the
    cumulative ladder (644-645).
47. ch10 (424): Dockerfile drift called 'regression to L0' though the
    lockfile would keep L1; (1201) cross-reference points at the
    restricted-data section instead of the worked example.
48. version-control: cheat sheet assigns 'habit 1' twice; Exercise 8
    solution never names a single rung; Exercise 5 solution overstates
    what a fork establishes; Exercise 3 solution lists patterns absent
    from the sample `.gitignore` files.
49. pipelines: table caption calls ratios illustrative while the prose
    calls the ratio the figure worth trusting; Exercise 8 solution
    credits the worked example with a baseline test it lacks;
    `` `Targets` `` capitalized in inline code (about 688).
50. ch04: 'lockfile pins the R version' (Exercise 2) vs 'recorded but
    not supplied' (Exercise 6); `renv::restore()` refusing a
    foreign-platform library (1572) unverified; '@tbl-lockdiff'
    reference to R-version content the table lacks (1396).
51. ch05: worked example picks the minimal profile for data analysis
    while Exercise 3's solution picks tidyverse; 'single changed line'
    vs 'at most a single system-installation line'.
52. ch06 Exercise 8 solution (1334): SIF conversion called
    deterministic; SIF builds can embed timestamps (recall).
53. conventions (149-154): 'not a compromise' next to 'what it gives
    up is friction'.

Dated claims no agent could verify: `rang` archived on CRAN
2026-08-22; git 2.55.0; R 4.6.1; SWHID adopted as an ISO/IEC standard
in 2025.
