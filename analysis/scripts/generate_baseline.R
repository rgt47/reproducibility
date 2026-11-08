# Record the baseline for inst/tinytest/test-baseline-cohort.R.
#
# Run once from the project root, after simulate_cohort.R, then
# commit inst/baseline/cohort_baseline.rds in its own commit,
# after the code that produced it. Regenerate it only when the
# generator, the seed, or the model changes on purpose: a baseline
# rewritten to make a failing test pass is no longer a baseline.

pkgload::load_all('.', quiet = TRUE)

result <- run_canonical_analysis(
  file.path('analysis', 'data', 'raw_data', 'cohort_raw.csv')
)
dir.create(file.path('inst', 'baseline'), recursive = TRUE,
           showWarnings = FALSE)
saveRDS(result, file.path('inst', 'baseline', 'cohort_baseline.rds'))
