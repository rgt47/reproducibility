# Baseline test for the canonical analysis.
#
# This is the L3 verification step: it reruns the analysis from the
# raw extract, compares the result with values recorded in
# inst/baseline/cohort_baseline.rds, and fails if anything drifts
# beyond the stated tolerances. A passing run is evidence the
# analysis is reproducible; a failing run names the quantity that
# changed, which is the starting point for diagnosis.
#
# Tolerances:
#   deterministic quantities (HR, CI bounds): 1e-8 relative
#   n_rows, n_events: exact (integer)
#
# The test exits cleanly if the raw extract is absent (fresh clone
# before running the generator) or if the baseline file is absent
# (initial setup). It never silently passes on missing data.

if (!exists('run_canonical_analysis')) {
  src <- file.path('R', 'cohort.R')
  if (!file.exists(src)) src <- file.path('..', '..', 'R', 'cohort.R')
  if (file.exists(src)) source(src)
}
if (!exists('run_canonical_analysis')) {
  exit_file('cohort functions not available; skipping')
}

raw_path <- file.path('analysis', 'data', 'raw_data', 'cohort_raw.csv')
if (!file.exists(raw_path)) {
  raw_path <- file.path('..', '..', 'analysis', 'data', 'raw_data',
                        'cohort_raw.csv')
}
if (!file.exists(raw_path)) {
  exit_file('raw extract absent; run analysis/scripts/simulate_cohort.R')
}

baseline_path <- system.file('baseline', 'cohort_baseline.rds',
                             package = 'reproducibility')
if (!nzchar(baseline_path)) {
  baseline_path <- file.path('inst', 'baseline', 'cohort_baseline.rds')
}
if (!file.exists(baseline_path)) {
  exit_file('baseline file absent; run scripts/generate-baseline.R')
}

baseline <- readRDS(baseline_path)
result   <- run_canonical_analysis(raw_path)

expect_equal(result$n_rows, baseline$n_rows,
  info = 'cleaned row count matches baseline')

expect_equal(result$n_events, baseline$n_events,
  info = 'event count matches baseline')

expect_equal(result$hr, baseline$hr, tolerance = 1e-8,
  info = 'Cox BMI hazard ratio (per 5 kg/m^2) matches baseline')

expect_equal(result$lower, baseline$lower, tolerance = 1e-8,
  info = 'lower 95% CI bound matches baseline')

expect_equal(result$upper, baseline$upper, tolerance = 1e-8,
  info = 'upper 95% CI bound matches baseline')
