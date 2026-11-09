# Instructor Guide
*2026-11-08 16:14 PST*

The instructor guide has moved to
`analysis/instructor-guide/instructor-guide.qmd`. It is a
separate Quarto project, outside the book, and is
distributed to course instructors rather than published
with the book (Decision D14 of `THIRD-REVIEW-PLAN.md`). It
holds the Exercise 7 keys, computed from executed code, the
week-by-week core path, the cumulative-quiz schedule, the
notes on grading, and the known rough edges that this file
used to hold.

Render it from the repository root with

```bash
quarto render analysis/instructor-guide
```

which writes HTML and PDF to
`analysis/instructor-guide/_output/` (git-ignored). The
cohort extract must exist first; generate it with
`Rscript analysis/scripts/simulate_cohort.R`.
