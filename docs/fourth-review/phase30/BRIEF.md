# Phase 30 Brief: Cuts, the zzcollab Track, and targets as Core
*2026-11-26 10:30 PST*

Repository root: `/Users/zenn/prj/tch/12-reproducibility` (branch
`phase-30-cuts-and-tracks`; do not switch branches, do not commit).
Book source: `analysis/report/`. Findings are in
`docs/fourth-review/REVIEW.md` (raw detail in
`docs/fourth-review/raw/`). Decisions: `FOURTH-REVIEW-PLAN.md`
Section 1 (D26 to D32). Read the plan's Phase 29 note first:
**REVIEW.md uses the old chapter numbers** (old Ch 8 is now
Appendix A; old Ch 9 to 14 are now Ch 8 to 13). File names did not
change.

The reader (D26): a first-year graduate student in any empirical
field, R from one course, no terminal experience before the Shell
Primer.

## The zzcollab track (D29), as now defined in `conventions.qmd`

Every step is shown first with general tools (`git`, `renv`,
`usethis`, Docker, `quarto`, plain R). A `zzcollab` shortcut for the
same step follows, in its own box:

```
::: {.callout-note icon=false}
## With zzcollab

<the framework command(s), and what they add>
:::
```

Rules: the chapter must be fully followable with every such box
removed; tool vocabulary (Five Pillars, archetypes, profiles,
progressive disclosure) is introduced in neutral words first and
attributed to `zzcollab` once; no `zzc` or `make <target>` command
appears outside a box. Check every `zzc` or `make` command against
the zzcollab source at `/Users/zenn/prj/sfw/07-zzcollab/zzcollab`
(`modules/help.sh`, `templates/Makefile`, `modules/*.sh`); earlier
phases found the book's tool commands stale or wrong (a deprecated
`zzc analysis`, an auto-fixing `make check-renv` presented as a gate,
a `PLATFORM=` override the build ignores).

## Hard rules (unchanged from Phase 28, plus two)

1. Edit only your assigned files. Shared files (`_quarto.yml`,
   `references.bib`, `glossary.qmd`, `conventions.qmd`, `index.qmd`,
   the instructor guide) are the lead's: propose changes in your
   report. You may create a new file only if your assignment says so.
2. No `quarto render` in the book directory, no `renv::restore()`,
   and no package install into the host library. You may install into
   a scratch library under the session scratchpad
   (`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/`)
   with `install.packages(..., lib = <scratch lib>)` and use it via
   `.libPaths()`; render or run scratch material there.
3. Every command you print was run by you with real output, or is
   labeled 'not run' in your report with the reason. No typed output.
   No unsourced numbers (time, cost, counts).
4. **Cuts must lose no content that other text depends on.** Before
   deleting a passage, grep the whole book for its anchors, labels,
   and the terms it defines; repoint or keep. Report word counts
   before and after (`wc -w`).
5. **Cross-references:** `@sec-` links to unnumbered pages (the Shell
   Primer `sec-shell`, the setup page `sec-setup`, Conventions) fail
   the test suite; use `[text](file.qmd#anchor)`. Links to numbered
   chapters and to Appendix A (`@sec-backends`) are fine.
6. Every check needs a nested collapsed 'Answer' callout; every
   numbered exercise exactly one collapsed solution titled
   'Exercise N'; renumber exercises and solutions together if you
   remove one.
7. Voice: academic; 'we' in exposition, 'you' only in objectives,
   exercises, solutions; sentences at most 35 words; US English; no
   em or en dashes; single quotes in prose; no contractions; no
   'Unfortunately,' or 'That is,'; prose wrapped at about 60 to 66
   characters; code at most 78.
8. A new or removed `##` section must be reflected in the chapter
   card's Outline and objectives.
9. Run the suite when done:
   `env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE Rscript -e "pkgload::load_all('/Users/zenn/prj/tch/12-reproducibility', quiet = TRUE); r <- tinytest::run_test_dir('/Users/zenn/prj/tch/12-reproducibility/inst/tinytest', verbose = 0); print(summary(r))"`
   If the reading-time test fails for your chapter, set the card to
   the value the message gives.

## Report

Write `docs/fourth-review/phase30/<letter>-report.md`: per finding,
what changed (file, line ranges), word counts before and after, what
you ran with real output, what is untested and why, proposed changes
to shared files, and the test result. Reply with the path and a
five-line summary.
