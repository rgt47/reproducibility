# Structural invariants of the book sources. These are gates, not unit
# tests of R functions: the package exports no functions, and the thing
# that can silently decay here is the manuscript.

find_book_dir <- function(start = getwd()) {
  dir <- normalizePath(start, mustWork = FALSE)
  repeat {
    candidate <- file.path(dir, 'analysis', 'report', '_quarto.yml')
    if (file.exists(candidate)) {
      return(dirname(candidate))
    }
    parent <- dirname(dir)
    if (identical(parent, dir)) {
      return(NA_character_)
    }
    dir <- parent
  }
}

book_dir <- find_book_dir()

# analysis/ is in .Rbuildignore, so a built tarball has no manuscript to
# check. Skip rather than fail there.
if (is.na(book_dir)) {
  exit_file('book sources not present (built package); skipping')
}

chapters <- list.files(book_dir, pattern = '[.]qmd$', full.names = TRUE)
sources <- lapply(chapters, readLines, warn = FALSE)
names(sources) <- basename(chapters)

expect_true(
  length(chapters) > 0,
  info = 'the book directory contains at least one .qmd source'
)

# Every chapter named in _quarto.yml exists on disk.
manifest <- readLines(file.path(book_dir, '_quarto.yml'), warn = FALSE)
listed <- manifest |>
  grep(pattern = '^\\s*-\\s+[A-Za-z0-9_-]+[.]qmd\\s*$', value = TRUE) |>
  trimws() |>
  sub(pattern = '^-\\s*', replacement = '')

for (f in listed) {
  expect_true(
    file.exists(file.path(book_dir, f)),
    info = paste('chapter listed in _quarto.yml exists on disk:', f)
  )
}

# Every 'Check your understanding' has an answer, so that a reader who
# attempts the question can find out whether they were right.
for (f in names(sources)) {
  n_check <- sum(grepl('^## Check your understanding', sources[[f]]))
  n_answer <- sum(grepl('^## Answer$', sources[[f]]))
  if (n_check == 0) next
  expect_equal(
    n_answer, n_check,
    info = paste('every check has an answer in', f)
  )
}

# Every answer is concealed behind its own collapsed callout, so the
# retrieval attempt is not optional. An answer heading must be preceded
# by a collapsible callout opener.
for (f in names(sources)) {
  lines <- sources[[f]]
  answer_at <- which(grepl('^## Answer$', lines))
  for (i in answer_at) {
    opener <- if (i >= 2) lines[i - 1] else ''
    expect_true(
      grepl('callout-note', opener) && grepl('collapse=true', opener),
      info = paste('answer is behind a collapsed callout in', f,
                   'at line', i)
    )
  }
}

# Every executable figure carries alt text (WCAG 2.1).
for (f in names(sources)) {
  lines <- sources[[f]]
  n_fig <- sum(grepl('^#\\| label: fig-', lines))
  n_alt <- sum(grepl('^#\\| fig-alt:', lines))
  if (n_fig == 0) next
  expect_equal(
    n_alt, n_fig,
    info = paste('every labelled figure has fig-alt in', f)
  )
}

# The license is declared consistently. GPL was wrong for both the prose
# and a CC0 code base, and the disagreement is the defect this guards.
root <- dirname(dirname(book_dir))
desc <- read.dcf(file.path(root, 'DESCRIPTION'))
expect_equal(
  unname(desc[1, 'License']), 'CC0',
  info = 'DESCRIPTION licenses the code as CC0'
)

cff <- readLines(file.path(root, 'CITATION.cff'), warn = FALSE)
expect_true(
  any(grepl('^license:\\s*CC-BY-NC-SA-4[.]0\\s*$', cff)),
  info = 'CITATION.cff declares CC BY-NC-SA 4.0'
)

for (f in c('index.qmd', 'copyright.qmd')) {
  expect_false(
    any(grepl('by-nc-nd', sources[[f]], fixed = TRUE)),
    info = paste('no stale NoDerivatives license URL in', f)
  )
}

# Where a chapter publishes solutions, there is one solution per
# exercise and each sits behind its own collapsed callout. Chapters
# without a Solutions section are not yet converted and are skipped
# rather than failed, so this goes red only on a miscount.
count_exercises <- function(lines) {
  start <- which(grepl('^## Exercises$', lines))
  if (length(start) == 0) return(0L)
  rest <- lines[(start[1] + 1):length(lines)]
  stop_at <- which(grepl('^## ', rest))
  if (length(stop_at) > 0) rest <- rest[seq_len(stop_at[1] - 1)]
  sum(grepl('^[0-9]+[.] ', rest))
}

for (f in names(sources)) {
  lines <- sources[[f]]
  if (!any(grepl('^## Solutions$', lines))) next
  n_ex <- count_exercises(lines)
  n_sol <- sum(grepl('^## Exercise [0-9]+$', lines))
  expect_equal(
    n_sol, n_ex,
    info = paste('one published solution per exercise in', f)
  )
  solution_at <- which(grepl('^## Exercise [0-9]+$', lines))
  for (i in solution_at) {
    opener <- if (i >= 2) lines[i - 1] else ''
    expect_true(
      grepl('callout-note', opener) && grepl('collapse=true', opener),
      info = paste('solution is behind a collapsed callout in', f,
                   'at line', i)
    )
  }
}
