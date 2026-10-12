# Data: the synthetic incident-diabetes cohort
*2026-10-11 11:22 PDT*

This directory holds the running example used throughout the
book: a **synthetic** retrospective cohort of adults followed for
incident type 2 diabetes. No row describes a real person. The
file exists so that the book can teach data governance and data
validation on a concrete extract without exposing anybody.

## Provenance

- **File:** `raw_data/cohort_raw.csv`
- **Generator:** `analysis/scripts/simulate_cohort.R`, with
  `set.seed(20260908)` and `n <- 400`.
- **Regenerate:** from the repository root, run
  `Rscript analysis/scripts/simulate_cohort.R`. The script uses
  base R only and overwrites the CSV.
- **Size:** 338 rows (337 simulated records plus one planted
  duplicate) and 10 columns. 400 people are screened and those
  already meeting the diabetes diagnostic threshold at baseline
  are excluded, so the cohort is genuinely at risk; see 'Baseline
  exclusion' below.
- **Checksum:** MD5 `c9c8e19173397c2c2b6ceb073b2ba1cf`, from
  R 4.6.1 with the default generators (Mersenne-Twister,
  Inversion, Rejection). Compare `md5sum raw_data/cohort_raw.csv`
  (`md5` on macOS) after regeneration. A mismatch means the
  generator, the seed, or the random-number defaults have
  changed.

The file is committed deliberately (plan decision D7): a
committed generator with a fixed seed has no external
dependency, no link rot, and no access control, so any reader
can rebuild the extract and check it against the committed copy.

## Columns

| Column | Type in CSV | Meaning |
|---|---|---|
| `mrn` | character | Fake medical record number, `MRN-` plus six digits |
| `patient_name` | character | Fake name drawn from invented given and family name lists |
| `dob` | date (ISO) | Fake date of birth, 1940 to 2000 |
| `sex` | character | `F` or `M`, with a planted inconsistency (see below) |
| `hba1c` | numeric | Baseline HbA1c, percent |
| `bmi` | numeric | Baseline body mass index, kg/m^2 |
| `enroll_date` | character | Enrollment date, 2019 to 2021, in two formats (see below) |
| `age_at_enroll` | integer | Completed years from `dob` to `enroll_date` |
| `incident_dm` | integer | 1 if incident diabetes was observed, 0 if not, `NA` if missing |
| `followup_days` | integer | Days of follow-up, drawn from 180 to 1460 |

The outcome is simulated from a logistic model in which risk
rises with HbA1c and BMI; the coefficients are in the generator.
`followup_days` is drawn independently of the outcome, so it
documents how long each person was observed without driving
whether they developed diabetes; a time-to-event analysis that
uses `followup_days` as an exposure time, rather than the
logistic model the book currently fits, is tracked as future
work (plan Finding 17 and Phase 10).

## Baseline exclusion

400 people are initially simulated; anyone whose baseline HbA1c
meets the diabetes diagnostic threshold (6.5 percent or higher)
is excluded before the outcome is drawn, leaving 337 people
genuinely at risk of incident disease. An earlier version of this
generator skipped this step, which left 63 of 401 rows already
diabetic at baseline; that defect is fixed as of 2026-10-11 and
no longer appears in the committed extract.

## Planted pathologies

The extract is dirty on purpose, so that the data-validation
tests in `inst/tinytest/test-cohort.R` have something to catch.
Each defect is introduced by a numbered step in the generator:

1. **Missing outcomes.** 32 values of `incident_dm` are `NA`.
2. **Mixed date formats.** About one fifth of `enroll_date`
   values are written day first (`%d/%m/%Y`); the rest are ISO
   (`%Y-%m-%d`). The column is stored as character, as a CSV
   export would be.
3. **One duplicated record.** Row 7 is appended again as the
   last row, with the same `mrn`. In the current draw, step 5
   happens to recode row 7, so the two copies differ only in how
   `sex` is written (`Female` and `F`), as a re-export might.
4. **One implausible age.** Row 13 has `age_at_enroll` of 400.
5. **Inconsistent sex coding.** 18 rows read `Female` instead of
   `F`. The recoding is applied only to rows whose true value is
   `F`, so that `clean_cohort()` in `R/cohort.R` recovers the
   true sex for every row; the test file checks this by replaying
   the generator up to step 5 and comparing.

`clean_cohort()` repairs defects 2 to 5 and leaves missing
outcomes in place, because dropping them is an analytic decision.

## Why the identifier columns exist

`mrn`, `patient_name`, and `dob` have the shape of protected
health information but are invented: record numbers are random
six-digit integers and names are random pairings from short
invented lists. They exist so that the version-control and
archiving chapters can show a file that, were it real, must
never enter a repository's history, a deposit, or a prompt to a
language model, and can do so without exposing anyone. No public
dataset contains protected information, so this lesson requires
an invented one.

## Real projects must not do this

In a real project the raw extract does **not** belong in the
repository. Raw data that carries identifiers, or that is
governed by a data use agreement, stays in the access-controlled
location the agreement names. The repository holds the code that
reads it, a `.gitignore` entry for `raw_data/`, a data dictionary,
and, where useful, a synthetic stand-in such as this one. Once a
file has been committed and pushed, deleting it does not remove
it from the history; treat that as a data incident.

## Test fixture mirror

`inst/testdata/cohort_raw.csv` is a byte-identical copy of
this extract. It exists because `analysis/` is excluded from
the built package (`.Rbuildignore`), so a test that only
looks there finds nothing once the package is installed and
silently reports zero assertions, which can be mistaken for
a passing check. `inst/tinytest/test-cohort.R` falls back to
this mirror as its last resort, so the data-validation tests
still run under `R CMD check` and `tinytest::test_package()`;
the two assertions that replay the generator's own code to
recover ground truth still require the source tree and skip
cleanly when only the mirror is available.

## Derived data

`derived_data/` is empty in this repository. Cleaning happens in
memory through `load_cohort()` and `clean_cohort()`; nothing
derived from the extract is written to disk.
