# Phase 28 Brief: Novice On-ramps
*2026-11-25 20:10 PST*

Repository root: `/Users/zenn/prj/tch/12-reproducibility` (git branch
`phase-28-onramps`; do not switch branches, do not commit).
Book source: `analysis/report/`. Findings to implement are in
`docs/fourth-review/REVIEW.md` (read your IDs there, and the raw
reports in `docs/fourth-review/raw/` for detail). Decisions and the
record of what earlier phases did: `FOURTH-REVIEW-PLAN.md`.

The book's reader (decision D26): a first-year graduate student in
any empirical field who has used R in one course and has never opened
a terminal, used git, Docker, or YAML. Examples stay in health
research; principles must read as general.

## Hard rules

1. Edit only the files your assignment names. Shared files
   (`_quarto.yml`, `references.bib`, `glossary.qmd`, `conventions.qmd`,
   `index.qmd`, the instructor guide) are the lead's: put any proposed
   glossary entry or bib entry in your report, not in those files.
2. Do not run `quarto render` in the book directory, `quarto preview`,
   `renv::restore()`, or any package install into the host library.
   You may render a scratch document in your own temporary directory
   under the session scratchpad
   `/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/`.
3. **Every command you print must have been run by you, with its real
   output, or be labeled in your report as 'not run' with the reason.**
   Never type expected output you did not observe. Earlier phases
   found that the review's proposed fixes were sometimes wrong when
   tried (a `make PLATFORM=` override that the tool ignores; time
   costs with no source). Treat every 'Fix' in REVIEW.md as a
   proposal to check, not text to paste.
4. No unsourced numbers: no time estimates ('in an hour'), no prices,
   no usage statistics, unless you opened a source and cite it.
5. Platform steps you cannot run here (Windows, Linux, GitHub web UI):
   take them from the official documentation, cite the page in your
   report, and label them untested. No screenshots.
6. Voice: academic, measured. 'We' in exposition; 'you' only in
   learning objectives, exercises, and their solutions. Sentences at
   most 35 words, about 25 on average. US English. No em or en
   dashes. Single quotes in prose. No contractions. No 'Unfortunately,'
   or 'That is,'. Do not open with 'Consider'. Wrap prose at about 60
   to 66 characters to match the files; code lines at most 78.
7. Book mechanics:
   - Sections on unnumbered pages (the shell primer `sec-shell`, the
     setup appendix `sec-setup`, Conventions) cannot be `@sec-`
     targets for subsections; link a subsection there as
     `[text](file.qmd#anchor)`. `@sec-shell` and `@sec-setup` (the
     page-level ids) do work.
   - Every 'Check your understanding' callout needs a nested,
     collapsed 'Answer' callout (`::: {.callout-note icon=false
     collapse=true}`); every numbered exercise needs exactly one
     collapsed solution callout titled 'Exercise N'. A test enforces
     both.
   - Code that must display literally inside a Quarto chunk needs
     `echo: fenced` or a display block (` ```{.markdown} `).
   - Prefer adding to existing structure over adding new headings;
     a new `##` section needs a line in the chapter card's Outline.
8. When done, run the test suite:
   `env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE Rscript -e "pkgload::load_all('/Users/zenn/prj/tch/12-reproducibility', quiet = TRUE); r <- tinytest::run_test_dir('/Users/zenn/prj/tch/12-reproducibility/inst/tinytest', verbose = 0); print(summary(r))"`
   The reading-time test may fail for your chapter; if so, update the
   card's 'Reading time' to the value the failure message gives.

## Report

Write `docs/fourth-review/phase28/<your-letter>-report.md`: per
finding, what you changed (file and line range), what you ran with
the real output, what is labeled untested and why, proposed glossary
and bib entries, and the test result. Reply to the lead with the
report path and a five-line summary.
