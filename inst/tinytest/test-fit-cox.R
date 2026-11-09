# Unit tests for fit_cox(), the canonical Cox model.
#
# The contract: the model uses the complete cases on every variable
# it reads, and its event count is the number of events among those
# cases. The oracle is computed from the data directly, not from the
# fit, so a change to the exclusion rule is caught.

if (!exists('fit_cox')) {
  src <- file.path('R', 'cohort.R')
  if (!file.exists(src)) src <- file.path('..', '..', 'R', 'cohort.R')
  if (file.exists(src)) source(src)
}
if (!exists('fit_cox') || !requireNamespace('survival', quietly = TRUE)) {
  exit_file('fit_cox or survival not available; skipping')
}

raw_path <- file.path('analysis', 'data', 'raw_data', 'cohort_raw.csv')
if (!file.exists(raw_path)) {
  raw_path <- file.path('..', '..', 'analysis', 'data', 'raw_data',
                        'cohort_raw.csv')
}
if (!file.exists(raw_path)) {
  raw_path <- system.file('testdata', 'cohort_raw.csv',
                          package = 'reproducibility')
}
if (!nzchar(raw_path) || !file.exists(raw_path)) {
  exit_file('raw extract not present; run analysis/scripts/simulate_cohort.R')
}

cohort <- clean_cohort(load_cohort(raw_path))
model_vars <- c('followup_days', 'incident_dm', 'bmi', 'age_at_enroll',
                'sex')
complete <- stats::complete.cases(cohort[, model_vars])

fit <- fit_cox(cohort)
expect_equal(fit$n, sum(complete),
             info = 'the model uses the complete cases on its variables')
expect_equal(fit$nevent, sum(cohort$incident_dm[complete] == 1),
             info = 'the event count is the events among complete cases')
expect_true(fit$nevent < sum(!is.na(cohort$incident_dm)),
            info = 'events are fewer than non-missing outcomes')

# Removing the age of one event row must drop exactly one event.
event_row <- which(complete & cohort$incident_dm == 1)[1]
less <- cohort
less$age_at_enroll[event_row] <- NA
fit_less <- fit_cox(less)
expect_equal(fit_less$nevent, fit$nevent - 1,
             info = 'a missing covariate on an event row removes one event')
expect_equal(fit_less$n, fit$n - 1L,
             info = 'and one row from the model')
