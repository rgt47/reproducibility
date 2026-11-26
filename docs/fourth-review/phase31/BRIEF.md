# Phase 31 Brief: Currency and the Remaining Findings
*2026-11-26 13:10 PST*

Repository root: `/Users/zenn/prj/tch/12-reproducibility` (branch
`phase-31-currency-minor`; do not switch branches, do not commit).
Book source: `analysis/report/`.

Read, in this order:

1. `FOURTH-REVIEW-PLAN.md` in full. Its implementation record lists
   every finding already done in Phases 26 to 30; do not redo them.
   **`REVIEW.md` uses the old chapter numbers**: old Ch 8 is now
   Appendix A (`06-backends-runtimes.qmd`); old Ch 9 to 14 are now
   Ch 8 to 13. File names did not change. Appendix B,
   `ci-other-forges.qmd`, is new.
2. `docs/fourth-review/REVIEW.md`, for your findings (IDs given in
   your assignment), and the matching raw report in
   `docs/fourth-review/raw/` for detail.
3. `docs/fourth-review/phase30/BRIEF.md`: its hard rules, the
   'With zzcollab' box rule, the voice rules, and the report format
   all apply here unchanged, with these additions.

## Additional rules for Phase 31

- **Currency claims need a source opened today** (2026-11-26): a
  version, a release, a default, a policy. Cite the URL in your
  report; a claim you could not open is left out of the book or
  hedged as unverified in the report, never asserted.
- **Inline R:** never write a prose code span that begins with `r`
  and a space (`` `r <- x` ``); Quarto executes it. Grep your files
  for `` `r `` before you finish and confirm every hit is meant to
  run.
- **Finish by rendering a scratch copy** of each file you changed to
  HTML (copy the `.qmd`, `references.bib`, and any included files it
  needs into a scratch directory, and run `quarto render` there, with
  `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`). Report the result. An
  unresolved cross-reference to another chapter is expected there;
  an R error is not.
- A finding the review marked 'Fix' that turns out wrong when you
  check it: do not apply it; say why in your report.
- Prefer small, local edits. Do not restructure sections or move
  material between files; Phase 29 settled the structure.

## Report

`docs/fourth-review/phase31/<letter>-report.md`, as in Phase 30, with
one table row per finding ID: done, partly done, not done (reason).
Reply with the path and a five-line summary.
