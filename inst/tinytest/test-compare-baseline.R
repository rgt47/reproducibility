# Tests for compare_to_baseline(), the two-tier baseline check: a
# seed-exact tier at a numerical tolerance, then, for a Monte Carlo
# quantity only, a tier that accepts a difference of at most k MCSE.

if (!exists('compare_to_baseline')) {
  src <- file.path('R', 'cohort.R')
  if (!file.exists(src)) src <- file.path('..', '..', 'R', 'cohort.R')
  if (file.exists(src)) source(src)
}
if (!exists('compare_to_baseline')) {
  exit_file('compare_to_baseline() not available; skipping')
}

# --- the three outcomes ---------------------------------------------

expect_identical(compare_to_baseline(10, 10), 'exact',
                 info = 'an identical value is exact')
expect_identical(compare_to_baseline(10 * (1 + 1e-10), 10), 'exact',
                 info = 'a relative difference below tol is exact')
expect_identical(compare_to_baseline(10.03, 10, mcse = 0.02),
                 'within Monte Carlo error',
                 info = 'a seed-exact failure within 3 MCSE is MC error')
expect_identical(compare_to_baseline(10.1, 10, mcse = 0.02), 'changed',
                 info = 'a difference beyond 3 MCSE is a change')

# --- the boundaries are inclusive -------------------------------------

# 10, 11.5, 0.5, and 1.5 are exact in binary, so the difference is
# exactly k * mcse with no rounding.
expect_identical(compare_to_baseline(11.5, 10, mcse = 0.5),
                 'within Monte Carlo error',
                 info = 'a difference of exactly k MCSE is within')
expect_identical(compare_to_baseline(11.5 + 1e-6, 10, mcse = 0.5),
                 'changed',
                 info = 'just beyond k MCSE is changed')
expect_identical(compare_to_baseline(11.5, 10, mcse = 0.5, k = 2),
                 'changed',
                 info = 'k sets the width of the second tier')
expect_identical(compare_to_baseline(1 + 0.5e-8, 1), 'exact',
                 info = 'a relative difference just under tol is exact')
expect_identical(compare_to_baseline(1 + 2e-8, 1), 'changed',
                 info = 'a relative difference above tol is not exact')
expect_identical(compare_to_baseline(1 + 2e-8, 1, tol = 1e-6), 'exact',
                 info = 'tol sets the width of the first tier')

# --- mcse = NULL: a deterministic quantity has only the exact tier ---

expect_identical(compare_to_baseline(10.03, 10), 'changed',
                 info = 'with no MCSE a small difference is a change')
expect_identical(compare_to_baseline(10.03, 10, mcse = NULL), 'changed',
                 info = 'an explicit NULL MCSE behaves as the default')

# --- vectors, and the exact tier takes precedence ---------------------

expect_identical(
  compare_to_baseline(c(10, 10.03, 10.1), c(10, 10, 10), mcse = 0.02),
  c('exact', 'within Monte Carlo error', 'changed'),
  info = 'each element is classified separately')
expect_identical(
  compare_to_baseline(c(10.03, 10.03), c(10, 10), mcse = c(0.02, 0.005)),
  c('within Monte Carlo error', 'changed'),
  info = 'an MCSE vector applies element by element')
expect_identical(compare_to_baseline(10, 10, mcse = 0), 'exact',
                 info = 'an exact match is exact even with zero MCSE')
expect_identical(compare_to_baseline(0, 0), 'exact',
                 info = 'a zero baseline is compared absolutely')

# --- invalid input is refused rather than classified -----------------

expect_error(compare_to_baseline(c(1, 2), 1),
             info = 'lengths must match')
expect_error(compare_to_baseline(NA_real_, 1),
             info = 'a missing value is refused')
expect_error(compare_to_baseline(1.1, 1, mcse = -1),
             info = 'a negative MCSE is refused')
expect_error(compare_to_baseline(c(1, 2), c(1, 2), mcse = c(1, 1, 1)),
             info = 'an MCSE of the wrong length is refused')
