# Generate the synthetic incident-diabetes cohort used as this book's
# running example for the governance lessons: what must never be
# committed, and what a data-validation test is for.
#
# The cohort is synthetic on purpose, and the choice is a
# demonstration rather than a compromise. A committed generator with a
# fixed seed is more reproducible than a downloaded extract: it has no
# external dependency, no link rot, and no access control. It is also
# the only way to show a reader a file carrying identifiers and
# explain why it must stay out of the history, without exposing
# anybody.
#
# The defects below are deliberate. The data-validation chapter needs
# something to catch, and real data would have to be broken on purpose
# in any case.
#
# Run with: Rscript analysis/scripts/simulate_cohort.R

set.seed(20260908)

n <- 400

# A fake identifier scheme that looks like a medical record number,
# and names drawn from a small invented list. Neither corresponds to
# any person.
surnames <- c('Achebe', 'Bianchi', 'Chen', 'Diallo', 'Eriksson',
              'Farah', 'Gupta', 'Haddad', 'Ibarra', 'Jensen',
              'Kowalski', 'Lam', 'Mwangi', 'Nakamura', 'Okonkwo',
              'Petrov', 'Quintero', 'Rahman', 'Silva', 'Tran')
givens <- c('Amara', 'Bo', 'Camila', 'Dev', 'Elif', 'Farid',
            'Grace', 'Hiroshi', 'Imani', 'Jonas', 'Keiko', 'Luis',
            'Mira', 'Noor', 'Omar', 'Priya', 'Rosa', 'Sami',
            'Tomas', 'Yusuf')

cohort <- data.frame(
  mrn = sprintf('MRN-%06d', sample(100000:999999, n)),
  patient_name = paste(sample(givens, n, replace = TRUE),
                       sample(surnames, n, replace = TRUE)),
  # Births spanning 1940 to 2000, so that everyone is an adult at
  # enrollment. The study's eligibility criterion is age 18 and over,
  # and the extract should satisfy it except where a defect is
  # introduced on purpose below.
  dob = as.Date('1940-01-01') +
    sample(0:22000, n, replace = TRUE),
  sex = sample(c('F', 'M'), n, replace = TRUE),
  hba1c = round(rnorm(n, mean = 5.8, sd = 0.7), 1),
  bmi = round(rnorm(n, mean = 28.5, sd = 5.2), 1),
  stringsAsFactors = FALSE
)

cohort$enroll_date <- as.Date('2019-01-01') +
  sample(0:900, n, replace = TRUE)
cohort$age_at_enroll <- as.integer(
  floor(as.numeric(cohort$enroll_date - cohort$dob) / 365.25)
)

# Incident diabetes, with risk rising in HbA1c and BMI.
lp <- -8.5 + 0.9 * cohort$hba1c + 0.06 * cohort$bmi
cohort$incident_dm <- rbinom(n, 1, plogis(lp))
cohort$followup_days <- sample(180:1460, n, replace = TRUE)

# --- deliberate defects, so the validation tests have work to do ---

# 1. Missing outcomes, as a real extract would carry.
cohort$incident_dm[sample(n, 32)] <- NA

# 2. Two date formats in one column, the failure the containers
#    chapter describes. Stored as character, as a CSV would be.
fmt <- sample(c(TRUE, FALSE), n, replace = TRUE, prob = c(0.8, 0.2))
cohort$enroll_date <- ifelse(
  fmt,
  format(cohort$enroll_date, '%Y-%m-%d'),
  format(cohort$enroll_date, '%d/%m/%Y')
)

# 3. One duplicated record, as a bad join or a re-export produces.
cohort <- rbind(cohort, cohort[7, ])

# 4. One implausible age, the kind a range check exists to catch.
cohort$age_at_enroll[13] <- 400L

# 5. Inconsistent coding of one categorical, from a merged export.
cohort$sex[sample(nrow(cohort), 18)] <- 'Female'

out_dir <- file.path('analysis', 'data', 'raw_data')
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
out <- file.path(out_dir, 'cohort_raw.csv')
write.csv(cohort, out, row.names = FALSE)

cat('wrote', out, 'with', nrow(cohort), 'rows and',
    ncol(cohort), 'columns\n')
