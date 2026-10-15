#' Load the raw cohort extract
#'
#' Reads the synthetic incident-diabetes extract exactly as it sits on
#' disk, without repair. Loading and cleaning are kept separate so that
#' a validation test can inspect what actually arrived rather than what
#' the cleaning step decided to make of it.
#'
#' @param path Path to the raw CSV extract.
#' @return A data frame of the extract as read, with no coercion.
#' @export
load_cohort <- function(path) {
  utils::read.csv(path, stringsAsFactors = FALSE)
}

#' Clean the raw cohort extract
#'
#' Repairs the four defects the extract is known to carry: two date
#' formats in one column, a duplicated record, an implausible age, and
#' an inconsistently coded sex. Rows whose outcome is missing are kept
#' rather than dropped, because whether to drop them is an analytic
#' decision and not a cleaning one.
#'
#' @param x A data frame as returned by [load_cohort()].
#' @param max_age Ages above this are treated as recording errors and
#'   set to `NA`. The default of 105 comes from the enrollment
#'   criteria rather than from the observed data.
#' @return A tibble with `enroll_date` as a Date, one row per `mrn`,
#'   `sex` coded `F` or `M`, and implausible ages set to `NA`.
#' @export
clean_cohort <- function(x, max_age = 105) {
  stopifnot(is.data.frame(x), 'mrn' %in% names(x))

  # Two formats appear in one column, so parse each explicitly rather
  # than letting a guesser resolve the ambiguity differently on
  # different machines.
  iso <- as.Date(x$enroll_date, format = '%Y-%m-%d')
  dmy <- as.Date(x$enroll_date, format = '%d/%m/%Y')
  x$enroll_date <- as.Date(ifelse(is.na(iso), dmy, iso),
                           origin = '1970-01-01')

  x$sex <- ifelse(x$sex %in% c('F', 'Female'), 'F',
                  ifelse(x$sex %in% c('M', 'Male'), 'M', NA_character_))

  x$age_at_enroll <- ifelse(x$age_at_enroll > max_age, NA_integer_,
                            x$age_at_enroll)

  out <- x[!duplicated(x$mrn), , drop = FALSE]
  tibble::as_tibble(out)
}

#' Fit the primary model
#'
#' Regresses incident diabetes on HbA1c and BMI. Rows with a missing
#' outcome are dropped here, which is the analytic decision the
#' cleaning step deliberately left open.
#'
#' @param x A cleaned cohort, as returned by [clean_cohort()].
#' @return A `glm` object, which inherits from `lm`.
#' @export
fit_model <- function(x) {
  stopifnot('incident_dm' %in% names(x))
  stats::glm(incident_dm ~ hba1c + bmi,
             family = stats::binomial(),
             data = x[!is.na(x$incident_dm), , drop = FALSE])
}

#' Summarize a fitted model as a tidy table
#'
#' @param fit A model as returned by [fit_model()].
#' @return A tibble with one row per term and columns `term`,
#'   `estimate`, and `odds_ratio`.
#' @export
summarise_fit <- function(fit) {
  co <- stats::coef(summary(fit))
  tibble::tibble(
    term = rownames(co),
    estimate = unname(co[, 'Estimate']),
    odds_ratio = exp(unname(co[, 'Estimate']))
  )
}

#' Bootstrap a confidence interval for the HbA1c odds ratio
#'
#' Deterministic given a seed, which is what makes it usable as the
#' single-result form of a reproducibility check. The seed is set
#' with `withr::with_seed()`, which also restores the caller's
#' generator state on exit, so calling this function does not
#' disturb any random stream the caller was already running.
#'
#' @param x A cleaned cohort.
#' @param n Number of bootstrap replicates.
#' @param seed Seed set before resampling. Recording it is not
#'   optional: the RNG kind must also be fixed for the result to
#'   reproduce across R versions.
#' @return A named numeric vector with the `lower` and `upper` bounds
#'   of a percentile interval on the odds-ratio scale.
#' @export
bootstrap_ci <- function(x, n = 1000, seed = 20260908) {
  dat <- x[!is.na(x$incident_dm), , drop = FALSE]
  reps <- withr::with_seed(seed, {
    vapply(seq_len(n), function(i) {
      idx <- sample(nrow(dat), replace = TRUE)
      unname(stats::coef(fit_model(dat[idx, , drop = FALSE]))['hba1c'])
    }, numeric(1))
  })
  exp(stats::quantile(reps, c(0.025, 0.975), names = FALSE)) |>
    stats::setNames(c('lower', 'upper'))
}

#' Run the primary analysis end to end
#'
#' The driver the testing chapter checks against a recorded baseline.
#'
#' @param path Path to the raw extract.
#' @return A list with the fitted model, its tidy summary, and the
#'   HbA1c odds ratio as `estimate`.
#' @export
run_primary_analysis <- function(
    path = file.path('analysis', 'data', 'raw_data', 'cohort_raw.csv')) {
  cohort <- path |> load_cohort() |> clean_cohort()
  fit <- fit_model(cohort)
  tidy <- summarise_fit(fit)
  list(
    fit = fit,
    summary = tidy,
    estimate = tidy$odds_ratio[tidy$term == 'hba1c']
  )
}

#' Fit the canonical Cox proportional-hazards model
#'
#' Primary analysis: time to incident diabetes on BMI per 5 kg/m^2,
#' adjusted for age and sex. Rows with a missing outcome or a missing
#' covariate are dropped; the cohort's `incident_dm` missingness is a
#' planted pathology that `clean_cohort()` deliberately leaves in
#' place.
#'
#' @param x A cleaned cohort, as returned by [clean_cohort()].
#' @return A `coxph` object.
#' @export
fit_cox <- function(x) {
  stopifnot(
    'followup_days' %in% names(x),
    'incident_dm' %in% names(x),
    'bmi' %in% names(x),
    'age_at_enroll' %in% names(x),
    'sex' %in% names(x)
  )
  dat <- x[!is.na(x$incident_dm) &
             !is.na(x$age_at_enroll) &
             !is.na(x$sex), , drop = FALSE]
  survival::coxph(
    survival::Surv(followup_days, incident_dm) ~
      I(bmi / 5) + age_at_enroll + sex,
    data = dat
  )
}

#' Extract the canonical result summary from a Cox fit
#'
#' @param fit A `coxph` object as returned by [fit_cox()].
#' @return A list with `hr` (hazard ratio for BMI per 5 kg/m^2),
#'   `lower` and `upper` (95 percent confidence limits), and
#'   `n_events` (number of observed events).
#' @export
summarise_cox <- function(fit) {
  ci <- summary(fit)$conf.int['I(bmi/5)', , drop = FALSE]
  list(
    hr    = unname(ci[, 'exp(coef)']),
    lower = unname(ci[, 'lower .95']),
    upper = unname(ci[, 'upper .95']),
    n_events = fit$nevent
  )
}

#' Bootstrap a confidence interval for the Cox BMI hazard ratio
#'
#' Resamples the analysis dataset (complete cases only) and refits the
#' Cox model on each resample. The seed is set with
#' `withr::with_seed()` so the caller's RNG state is restored on
#' exit.
#'
#' @param x A cleaned cohort.
#' @param n Number of bootstrap replicates.
#' @param seed Seed for the resampler. Must be recorded alongside the
#'   result; changing it changes the interval.
#' @return A named numeric vector with `lower` and `upper` bounds of
#'   a percentile interval on the hazard-ratio scale.
#' @export
bootstrap_cox_ci <- function(x, n = 1000, seed = 20260908) {
  dat <- x[!is.na(x$incident_dm) &
             !is.na(x$age_at_enroll) &
             !is.na(x$sex), , drop = FALSE]
  reps <- withr::with_seed(seed, {
    vapply(seq_len(n), function(i) {
      idx <- sample(nrow(dat), replace = TRUE)
      fit_i <- survival::coxph(
        survival::Surv(followup_days, incident_dm) ~
          I(bmi / 5) + age_at_enroll + sex,
        data = dat[idx, , drop = FALSE]
      )
      unname(exp(stats::coef(fit_i)['I(bmi/5)']))
    }, numeric(1))
  })
  stats::quantile(reps, c(0.025, 0.975), names = FALSE) |>
    stats::setNames(c('lower', 'upper'))
}

#' Run the canonical analysis end to end
#'
#' Loads the raw extract, cleans it, fits the Cox model, and returns
#' the result list. This is the function a baseline test calls; its
#' output is compared with the committed baseline file.
#'
#' @param path Path to the raw extract.
#' @return A list with `n_rows` (cleaned row count), `hr`, `lower`,
#'   `upper` (from [summarise_cox()]), and `n_events`.
#' @export
run_canonical_analysis <- function(
    path = file.path('analysis', 'data', 'raw_data', 'cohort_raw.csv')) {
  cohort <- path |> load_cohort() |> clean_cohort()
  fit <- fit_cox(cohort)
  res <- summarise_cox(fit)
  c(list(n_rows = nrow(cohort)), res)
}
