# Tests for replicate_streams(): per-task random-number streams make
# the replicates invariant to the number of workers.

if (.Platform$OS.type == 'windows') {
  exit_file('forking is unavailable on Windows; invariance not testable')
}
if (!exists('replicate_streams')) {
  src <- file.path('R', 'cohort.R')
  if (!file.exists(src)) src <- file.path('..', '..', 'R', 'cohort.R')
  if (file.exists(src)) source(src)
}
if (!exists('replicate_streams')) {
  exit_file('replicate_streams() not available; skipping')
}

draw <- function(i) stats::runif(3)

one <- replicate_streams(20, draw, seed = 42, cores = 1)
two <- replicate_streams(20, draw, seed = 42, cores = 2)

expect_identical(one, two,
                 info = 'one and two workers give identical replicates')
expect_identical(one, replicate_streams(20, draw, seed = 42, cores = 1),
                 info = 'a rerun with the same seed is identical')
expect_false(identical(one, replicate_streams(20, draw, seed = 43)),
             info = 'a different seed gives different replicates')
expect_equal(length(unique(vapply(one, `[`, numeric(1), 1))), 20L,
             info = 'no two replicates share a stream')
expect_identical(replicate_streams(5, draw, seed = 42), one[1:5],
                 info = 'the leading replicates do not depend on B')

# The caller's generator kind and state are left as they were.
kind_before <- RNGkind()
set.seed(7)
state_before <- get('.Random.seed', envir = globalenv())
invisible(replicate_streams(3, draw, seed = 1, cores = 2))
expect_identical(RNGkind(), kind_before,
                 info = 'the caller RNG kind is restored')
expect_identical(get('.Random.seed', envir = globalenv()), state_before,
                 info = 'the caller RNG state is restored')
