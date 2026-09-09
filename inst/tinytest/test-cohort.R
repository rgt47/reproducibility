# Tests for the running-example analysis, arranged in the four kinds
# the testing chapter distinguishes: unit, integration, data
# validation, and reproducibility.

# Under test_package() the namespace is loaded and these are already
# available; under run_test_dir() on the source tree they are not, so
# source them if absent rather than failing obscurely.
if (!exists('load_cohort')) {
  src <- file.path('R', 'cohort.R')
  if (!file.exists(src)) src <- file.path('..', '..', 'R', 'cohort.R')
  if (file.exists(src)) source(src)
}
if (!exists('load_cohort')) {
  exit_file('cohort functions not available; skipping')
}

raw_path <- file.path('analysis', 'data', 'raw_data', 'cohort_raw.csv')
if (!file.exists(raw_path)) {
  raw_path <- file.path('..', '..', 'analysis', 'data', 'raw_data',
                        'cohort_raw.csv')
}
if (!file.exists(raw_path)) {
  exit_file('raw extract not present; run analysis/scripts/simulate_cohort.R')
}

raw <- load_cohort(raw_path)
cohort <- clean_cohort(raw)

# --- unit tests: oracles computed by hand, not by the function ------

# Two date formats in one column must both parse to the same day.
tiny <- data.frame(
  mrn = c('a', 'b'), enroll_date = c('2020-03-04', '04/03/2020'),
  sex = c('F', 'Female'), age_at_enroll = c(50L, 400L),
  incident_dm = c(1, 0), hba1c = c(6, 6), bmi = c(30, 30),
  stringsAsFactors = FALSE
)
tc <- clean_cohort(tiny)
expect_equal(tc$enroll_date[1], tc$enroll_date[2],
             info = 'ISO and day-first dates parse to the same day')
expect_equal(as.character(tc$enroll_date[1]), '2020-03-04',
             info = 'the parsed day is the one written, not a swap')
expect_equal(tc$sex, c('F', 'F'),
             info = "'Female' and 'F' collapse to one code")
expect_true(is.na(tc$age_at_enroll[2]),
            info = 'an age above the enrollment maximum becomes NA')
expect_equal(tc$age_at_enroll[1], 50L,
             info = 'a plausible age is left alone')

# --- integration test: the pipeline end to end ---------------------

fit <- fit_model(cohort)
tidy <- summarise_fit(fit)
expect_inherits(fit, 'lm',
                info = 'a glm inherits from lm')
expect_true(all(c('term', 'estimate', 'odds_ratio') %in% names(tidy)),
            info = 'the tidy summary carries the expected columns')
expect_equal(nrow(tidy), 3L,
             info = 'intercept plus two predictors')
expect_equal(tidy$odds_ratio, exp(tidy$estimate),
             info = 'the odds ratio is the exponentiated estimate')

# --- data validation: constraints from the protocol, not the data ---

expect_true(all(c('mrn', 'age_at_enroll', 'sex', 'incident_dm')
                %in% names(raw)),
            info = 'the extract carries the expected columns')
expect_equal(sum(duplicated(cohort$mrn)), 0L,
             info = 'cleaning leaves one row per record number')
expect_true(all(cohort$sex %in% c('F', 'M')),
            info = 'sex takes only the two coded levels after cleaning')
expect_true(all(cohort$age_at_enroll >= 18 & cohort$age_at_enroll <= 105,
                na.rm = TRUE),
            info = 'ages lie within the enrollment criteria')
expect_true(mean(is.na(cohort$incident_dm)) < 0.15,
            info = 'outcome missingness stays under fifteen percent')
expect_true(all(!is.na(cohort$enroll_date)),
            info = 'every enrollment date parsed')

# The raw extract is expected to be dirty. These assert the defects
# are still there, so that a future change to the generator that
# quietly cleans them does not leave the validation tests vacuous.
expect_true(sum(duplicated(raw$mrn)) > 0,
            info = 'the raw extract still carries its duplicate')
expect_true(any(raw$age_at_enroll > 105),
            info = 'the raw extract still carries an implausible age')
expect_true(length(unique(raw$sex)) > 2,
            info = 'the raw extract still carries inconsistent sex coding')

# --- reproducibility: the same seed gives the same answer ----------

expect_equal(bootstrap_ci(cohort, n = 50), bootstrap_ci(cohort, n = 50),
             info = 'a seeded bootstrap is deterministic')
expect_true(unname(bootstrap_ci(cohort, n = 50)['lower']) <
            unname(bootstrap_ci(cohort, n = 50)['upper']),
            info = 'the interval is ordered')
expect_equal(run_primary_analysis(raw_path)$estimate,
             run_primary_analysis(raw_path)$estimate,
             info = 'the primary analysis is deterministic')
