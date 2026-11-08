# Agent 3 report, Phase 22: Ch 5 (03-research-compendium.qmd) and Ch 7 (05-containers.qmd)
*2026-11-08*

Evidence labels: V ran it; I inspected (source or opened page); EK
expert knowledge, not checked.

## 1. Items

| Item | File and current line | Action | Evidence |
|---|---|---|---|
| A8 package skeleton, new section `{#sec-package-skeleton}` | 03:477-589 | Added. Computed chunk `skeleton-tools` (prints which of `usethis`, `devtools`, `pkgdown`, `pkgload`, `tinytest` are in `renv.lock`); `eval: false` chunk `skeleton-commands` with `create_package()`, `use_r()`, `use_cc0_license()` (the compendium's `License: CC0`, computed inline), `use_package()`, `tinytest::setup_tinytest('.')`, `use_pkgdown()`, `load_all()`, `document()`, `check()`, `pkgdown::build_site()`; prose on each; pointer to *R Packages* (2e) | V (chunks run; inline values: absent = usethis, devtools, pkgdown; present = pkgload, tinytest); I (r-pkgs.org pages); V (scratch package, below) |
| A2 README computational requirements, new subsection `{#sec-readme-requirements}` | 03:808-932 | Added after the README check-your-understanding callout. Five required items (software, randomness, runtime, hardware, output-to-code map) citing the SSDE template; a hidden chunk computes the R version from `renv.lock`, three key package versions, the `set.seed()` call and its line number in `simulate_cohort.R`, the bootstrap seed and B from `formals(bootstrap_cox_ci)`, `RNGkind()`, runtime measured by `system.time()` (about 1.9 s here), platform, and core count; an `asis` chunk prints the README excerpt; a `stopifnot()` checks that every mapped file exists | V |
| Outline bullets for the two additions | 03:80-81, 85-86 | Added | I |
| LLM: format normalized (`*Watch for*:`/`*Verification*:` to `*Watch for.*`/`*Verification.*`, first word capitalized) | 03, triples 1 to 3 | Fixed (M4) | I |
| LLM: model behavior as fact ('since that is the most common case in the model's training data'; 'the one a model is most likely to omit') | 03, triples 2 and 3 | Rephrased as 'Check whether ...' / 'check for it first' (Minor 1) | I |
| LLM: better prompt | 03, triple 1 (directory layout) | Added `*A better prompt.*` (about 65 words: file names only, raw-or-derived per file, flag unclassifiable files, list commands to check) | I |
| LLM: agent actor sentence | 03, triple 3 (unit tests) | Added: agent may run and edit tests until they pass; expected values and baseline stay with the analyst, who reviews changes under `inst/tinytest/` and `inst/baseline/`; cites `@sec-llm-delegate` | I (target exists at 01:978) |
| A9 Pilot 4 | 05:811-822, inside 'The honest level' callout | Added two sentences: FDA reviewers had to install WSL and Docker Desktop on Windows laptops, R version still decided whether packages restored, May 2026 review concluded containers may not yet give the robustness a regulatory submission needs; points to `@sec-setup` | I (FDA review PDF and R Consortium post, both opened) |
| LLM: better prompt (the M3 'Write me a Dockerfile' example) | 05, triple 1 | Added, with slots `<version>` and `<codename>` and a sentence on where to fill them from | I |
| LLM: agent self-report sentence | 05, triple 1 verification | Added: if an agent ran the two builds, read the version lists yourself; cites `@sec-llm-delegate` | I |
| LLM: model behavior as fact ('will very likely open with', 'is likely to reach first', 'tends to recommend') | 05, triples 1 to 3 | Rephrased as 'Check whether the answer ...' (Minor 1) | I |
| LLM intro: 'a confident source of subtly wrong Dockerfiles, because the most common Dockerfile on the public internet is not a reproducible one' | 05:1468-1471 | Rephrased: 'a Dockerfile it writes can look complete while lacking the pins this chapter requires'. The removed clause was an unsourced empirical claim (Minor 1); recorded as a defect removal under D18 | I |
| Duplicated 'fully reproducible' triple (M4) | neither chapter | Not applicable: M4 names 01, 02, 07, pipelines, 10 | I |
| Format drift in 05 | 05 | Already bold/italic | I |

Scratch verification of the A8 claims (V, run in the scratchpad, not in the
book): with usethis 3.2.1, devtools 2.5.2, roxygen2 8.0.0, and tinytest
1.4.3 from the system library, `create_package()` + `use_cc0_license()` +
`use_package('survival')` + `setup_tinytest()` + `document()` produced
`License: CC0`, `Imports: survival`, `Suggests: tinytest`,
`inst/tinytest/`, `tests/tinytest.R`, `LICENSE.md`, and `man/*.Rd`. The
`setup_tinytest()` behavior also matches its help page (I). `pkgdown`
2.2.0 was not exercised (structural knowledge from r-pkgs.org only).

## 2. Counts

| File | 'That is,' before / after | 'Unfortunately,' before / after |
|---|---|---|
| 03-research-compendium.qmd | 3 / 3 | 0 / 0 |
| 05-containers.qmd | 1 / 1 | 0 / 0 |

Dash grep and the `@label.` continuation grep: empty for both files (V).
No new lines over 78 characters (V, grep `.{79,}`: only pre-existing caption
and table lines).

## 3. Words added

| File | `wc -w` before / after | Notes |
|---|---|---|
| 03-research-compendium.qmd | 11,877 / about 13,250 | Prose only: A8 467 words (within 1.5 pages), A2 408 words (about 1.2 pages, slightly over the 1-page estimate; the printed excerpt adds about a third of a page); LLM edits about 120. The rest is chunk code. |
| 05-containers.qmd | 13,166 / 13,336 | A9 about 65 words (0.2 page); better prompt about 70; agent sentence about 25; Minor 1 rewording roughly neutral |

## 4. run_chapter.R summary

- 03-research-compendium.qmd: `== summary: errors 0  warnings 0` (21 inline
  expressions; new ones read: `usethis`, `devtools` and `pkgdown` /
  `pkgload` and `tinytest` / CC0 / tinytest (>= 1.4.0) / does not yet have).
  Baseline before edits was also 0 / 0.
- 05-containers.qmd: `== summary: errors 0  warnings 0` (5 inline; no new
  inline expressions). Baseline 0 / 0.

The README excerpt was printed separately (V) and reads:

```
- Software: R 4.6.1, packages as in renv.lock
  (restore with renv::restore()); key packages
  survival 3.8-6, withr 3.0.3, tinytest 1.4.3.
- Randomness: simulate_cohort.R calls
  set.seed(20260908) once, at line 19;
  bootstrap_cox_ci() sets seed 20260908 (B = 1000)
  with withr::with_seed(). Sampler kinds:
  Mersenne-Twister, Inversion, Rejection.
- Runtime: 1.9 s for the analysis and bootstrap
  (under 10 min).
- Hardware: aarch64-apple-darwin23, 8 logical cores.
```

followed by a four-row output-to-code table.

## 5. Sources opened (all 2026-11-08)

| URL | Supports |
|---|---|
| https://social-science-data-editors.github.io/template_README/ | Template authors; concept DOI 10.5281/zenodo.7293838 |
| https://social-science-data-editors.github.io/template_README/template-README.html | 'Computational requirements' subsections (Software Requirements, Controlled Randomness, Memory/Runtime/Storage), seed set once and not from a timestamp, say where the seed is set, care with parallel work and program order, runtime categories, hardware details, 'List of tables and programs' |
| https://zenodo.org/doi/10.5281/zenodo.7293838 | Title 'A template README for social science replication packages', creators, v1.1, 2022-11-05 |
| `curl -sI https://doi.org/10.5281/zenodo.7293838` | DOI resolves (302 to Zenodo) (V) |
| https://r-pkgs.org (home), /whole-game.html, /website.html, /license.html, /preface.html | *R Packages* (2e), Wickham and Bryan; the Whole Game command sequence; `load_all()` simulates build, install, attach and is recommended over `source()`; `check()` runs `R CMD check`; `use_pkgdown()` runs once, `build_site()` repeatedly; `use_cc0_license()` exists; appendix on `R CMD check`. Publisher and year are not on the site. |
| `tinytest::setup_tinytest` and `usethis` license help pages (local, `tools::Rd2txt`) | What `setup_tinytest()` creates; the license functions |
| https://r-consortium.org/posts/beyond-feasibility-learning-from-fdas-response-to-webassembly-and-container-based-submissions/ | R Consortium post, 14 May 2026; Pilot 4 history (WebAssembly Sept 2024; resubmission with containers June 2025); FDA letter received May 2026 |
| https://raw.githubusercontent.com/RConsortium/submissions-wg/main/_Documents/Summary_R_Pilot4_Submission.pdf (text extracted with `pdftotext`) | FDA CDER Office of Biostatistics 'Statistical Review and Evaluation', BLA 111111 (R pilot 4), signatures dated 2026-05-04, 'Date(s): May, 2026'; reviewers installed WSL and Docker Desktop; file submitted as 'dockerfile'; R version mismatches caused errors in `renv` restoration; conclusion that containers do not fully eliminate manual configuration and 'may not provide the level of robustness required for regulatory submissions' |

## 6. Claims resting on EK

- *R Packages* (2e) publisher O'Reilly and year 2023 (in the bib entry
  only; not on r-pkgs.org).
- `R CMD check` runs from the shell without `devtools` or `usethis`
  installed (03, A8). Standard R behavior; not run here.
- `create_package()` creating `R/`: stated by r-pkgs.org (I); my scratch run
  used `rstudio = FALSE` and `list.files()` does not show empty
  directories, so I did not observe it directly.
- `withr::with_seed()` restoring the caller's RNG state: from the roxygen
  comment in `R/cohort.R` (I), not tested.

## 7. For the lead

### Bib entries (references.bib)

```bibtex
@misc{vilhuber2022readme,
  author    = {Vilhuber, Lars and Connolly, Marie and Koren, Mikl{\'o}s
               and Llull, Joan and Morrow, Peter},
  title     = {A Template {README} for Social Science Replication
               Packages},
  version   = {v1.1},
  year      = {2022},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.7293838},
  url       = {https://social-science-data-editors.github.io/template_README/},
  urldate   = {2026-11-08}
}

@book{wickham2023,
  author    = {Wickham, Hadley and Bryan, Jennifer},
  title     = {R Packages: Organize, Test, Document, and Share Your
               Code},
  edition   = {2},
  publisher = {O'Reilly Media},
  year      = {2023},
  url       = {https://r-pkgs.org},
  urldate   = {2026-11-08}
}

@misc{fdapilot4review2026,
  author       = {{U.S. Food and Drug Administration, Center for Drug
                  Evaluation and Research, Office of Biostatistics}},
  title        = {Statistical Review and Evaluation: {R} Pilot 4
                  Submission ({BLA} 111111)},
  year         = {2026},
  month        = may,
  howpublished = {Review of the R Consortium R Submissions Working
                  Group's Pilot 4},
  url          = {https://github.com/RConsortium/submissions-wg/blob/main/_Documents/Summary_R_Pilot4_Submission.pdf},
  urldate      = {2026-11-08}
}

@misc{rconsortiumpilot4_2026,
  author  = {{R Consortium}},
  title   = {Beyond Feasibility: Learning from {FDA}'s Response to
             {WebAssembly} and Container-Based Submissions},
  year    = {2026},
  month   = may,
  day     = {14},
  url     = {https://r-consortium.org/posts/beyond-feasibility-learning-from-fdas-response-to-webassembly-and-container-based-submissions/},
  urldate = {2026-11-08}
}
```

The existing `wickham2015` (1e) stays; check that no other agent added a
different key for the 2e.

### Cheat-sheet rows (03, `sec-cheat-compendium`), optional

```
| `usethis::create_package()`, `use_r()`, `use_package()` | Write the package skin, a file in `R/`, and an `Imports` entry |
| `tinytest::setup_tinytest('.')` | Adds `inst/tinytest/`, `tests/tinytest.R`, and `tinytest` in `Suggests` |
| `devtools::load_all()`, `document()`, `check()` | The development loop: load, regenerate help and `NAMESPACE`, run `R CMD check` |
| README computational requirements | Software and versions, where each seed is set, runtime, hardware, and an output-to-code map |
```

### Mirror sentence in 08 (Chapter 11), not my file

coverage-emerging.md item 5 suggests a mirrored sentence in the
regulated-validation section of `08-testing-quality.qmd`. I did not add it;
the owning agent or the lead may cite `fdapilot4review2026` there.

### Defects found outside my files

- `inst/tinytest/test-baseline-cohort.R` skips with the message 'run
  scripts/generate-baseline.R', but no such script exists in the
  repository (I, grep over `R/`, `inst/`, `analysis/`, `tools/`,
  `Makefile`). The baseline in `inst/baseline/cohort_baseline.rds` has no
  committed generator, which is itself a gap in the output-to-code map
  the new A2 text asks for. I left the baseline producer out of the
  excerpt's table and mapped only the check.
- The repository has no root `README.md` (V; the A2 text says so via an
  inline expression, so it updates if one is added).
- `DESCRIPTION` records `License: CC0`; `usethis` documents CC0 as
  appropriate for data packages and r-pkgs.org says the same. Chapter 12
  already argues the dual license, so I only cross-referenced it.

No instructor-guide keys are made stale (no exercise changed). No new
glossary terms.

## 8. Not done

- No new exercises (not required by the brief).
- A9 quotes no sentence verbatim; it paraphrases the FDA conclusion. The
  plan said 'after Phase 25 confirms the quotation'; I opened the primary
  FDA review itself, so the paraphrase rests on that document.
- `quarto render` not run (per brief). The new keys `vilhuber2022readme`,
  `wickham2023`, `fdapilot4review2026`, `rconsortiumpilot4_2026` will be
  unresolved until the bib entries are added. `@sec-llm-delegate` exists
  at 01:978 (I); `@sec-setup` and `@sec-archiving` exist.
- The `results: asis` excerpt chunk was checked by printing its value, not
  by rendering; the lead should look at it in HTML and PDF.
- The runtime figure in the excerpt adds about 2 s to the chapter's render
  (V, 1.9 s on this machine).

## Message to the lead

Report: this file. Ch 5 gains `sec-package-skeleton` (467 words) and
`sec-readme-requirements` (408 words plus a computed README excerpt); Ch 7
gains the Pilot 4 sentences in the honest-level callout, sourced from the
FDA review PDF itself (signed 2026-05-04) and the R Consortium post of 14
May 2026. Both chapters run with errors 0, warnings 0; 'That is,' 3/3 and
1/1, 'Unfortunately,' 0/0. Please add the four bib entries. Decision
needed: whether to commit a baseline generator for
`inst/baseline/cohort_baseline.rds`, since the test points to a script
that does not exist.
