# Instructor Guide
*2026-10-11 13:47 PDT*

## What this is

Faculty-facing material for teaching from *Reproducible
Research for the Health Sciences* in a required course. It
is not part of the published book: it is not listed in
`_quarto.yml`'s `chapters:` block, so it does not render
into the HTML or PDF and carries no obligation to the
book's reading level or tone. Decision D6 of
`REFACTOR-PLAN.md` kept every exercise's solution printed
in the book itself, so this guide does not hold answers the
book withholds; its job is course design, not secrecy.

## The one-quarter core path

The book's Conventions page marks each chapter Core or
Optional for a ten-week quarter; this table repeats it with
a week number, following the proposal in
`REFACTOR-PLAN.md` section 10.11.

| Week | Chapter | Graded lab, on the cohort compendium |
|---|---|---|
| 1 | Preface, Introduction, The Reproducibility Crisis | Setup check; the `sample.kind` demonstration (Exercise 3) |
| 2 | Levels of Reproducibility | Place a published paper on the ladder (Exercise 2), graded against a rubric, not a single answer |
| 3 | Version Control with Git and GitHub | A course repository with `.gitignore` written before the synthetic extract is added |
| 4 | The Research Compendium | Convert a scatter of scripts into a compendium; add a README and data dictionary |
| 5 | Pinning Packages with renv | A lockfile, then a restore on a second machine |
| 6 | Pinning the Environment with Docker | A digest-pinned image, built in CI |
| 7 | Literate Programming; the Make section of Automating the Analysis | A sealed render with every number computed inline |
| 8 | Testing and Code Quality | Repair the cohort generator's planted defect; write an oracle test and a baseline test |
| 9 | Continuous Integration and Verification | A CI workflow that compares to a committed baseline, demonstrated failing once on purpose |
| 10 | Collaboration, Archiving, and Stewardship | Deposit to the Zenodo sandbox; write a restricted-data plan for a hypothetical patient-level extract |

Backends and Runtimes (Nix, Podman, Apptainer) and the
`targets`/Snakemake/Nextflow material in Automating the
Analysis are optional at this pace; a two-quarter offering
can restore them in a second term.

## On grading

Most of the book's 72 exercises are retrieval practice or
short arguments, and their printed solutions serve that
purpose well: a student checks their own reasoning against
a worked answer. They were not designed to be collected for
a grade, and collecting them as written has two problems.
First, about a third ask the student to work from their own
paper, analysis, or data, which cannot be graded
consistently and, for an extract that might carry patient
information, is itself a data-governance risk the book
argues against. Second, every solution is printed, so a
submitted answer cannot be distinguished from a copied one.

The ten weekly labs above are designed instead: each works
the shared cohort compendium, each has a checkable output
(a restored lockfile, a CI run that is red and then green, a
rendered document with a specific inline number), and none
depends on a student's own data. `REFACTOR-PLAN.md` phase 10
(G, running study) plans a template repository, built from
the same compendium with its planted defects, distributed
through GitHub Classroom or GitLab, and autograded by CI;
until that repository exists, the labs above can be run by
hand against the same checklist.

The autograder depends on two fixes already made to the
`zzcollab` and `zzrenvcheck` tools in Phase 6: `make
docker-test` now exits nonzero when a test fails, and `zzc
verify --full` now requires a baseline test before it
stamps a compendium L3. A course built on an unpatched
install of either tool will accept a failing submission as
passing.

## Known rough edges, by week

- **Week 1.** The chapter assumes the reader already knows
  what `set.seed()` does; a five-minute board explanation of
  R's random-number generator before Exercise 3 saves
  confusion the chapter does not have room to add.
- **Week 2.** Exercise 2 (placing a published paper on the
  ladder) has no single correct answer; grade it on whether
  the student's reasoning cites a specific determinant from
  the determinant stack in Levels of Reproducibility, not on
  which rung they name.
- **Weeks 5 to 6.** Both labs need Docker. Apple Silicon and
  Windows students will need `--platform linux/amd64`
  (covered in the text) and, on Windows, WSL2; budget a
  studio hour before week 5 for environment setup, since
  this is where a course on this schedule is most often
  lost.
- **Week 10.** The restricted-data plan exercise is new
  (Phase 6); there is no worked exemplar yet. A reasonable
  rubric: does the plan name a specific de-identification or
  controlled-access route, and does it say what happens if
  the data cannot be shared at all, rather than assuming it
  always can be.

## What is not here

This guide does not hold: alternate exercises, exam
questions, slide decks, or a second set of solutions. It
also does not resolve the open content gaps the coverage
sweep found (`REFACTOR-PLAN.md` section 10.10): licensing,
`CITATION.cff`, a shell primer, and the HPC section are
still Phase 11 work, and this guide's week-by-week table
will need revision once they land.
