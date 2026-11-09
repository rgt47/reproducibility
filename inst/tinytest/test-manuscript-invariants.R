# Structural invariants of the book sources. These are gates, not unit
# tests of R functions (those live in the other test files): the thing
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

# The licenses are declared consistently (author, 2026-11-09): the
# prose under CC BY 4.0, code printed in the book under MIT, and the
# repository code under GPL-3. Disagreement between these files is the
# defect this guards; earlier versions declared CC0 and NonCommercial
# licenses, so any leftover 'by-nc' URL is stale.
root <- dirname(dirname(book_dir))
desc <- read.dcf(file.path(root, 'DESCRIPTION'))
expect_equal(
  unname(desc[1, 'License']), 'GPL-3',
  info = 'DESCRIPTION licenses the repository code as GPL-3'
)

cff <- readLines(file.path(root, 'CITATION.cff'), warn = FALSE)
expect_true(
  any(grepl('^license:\\s*CC-BY-4[.]0\\s*$', cff)),
  info = 'CITATION.cff declares CC BY 4.0'
)

for (f in c('index.qmd', 'copyright.qmd')) {
  expect_false(
    any(grepl('by-nc', sources[[f]], fixed = TRUE)),
    info = paste('no stale NonCommercial license URL in', f)
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

# An indented continuation line that begins with a cross-reference
# label followed by a period or parenthesis is parsed by Pandoc as an
# example-list marker inside a list item, and the reference vanishes
# from the rendered page. Rewrapping prose produced three such lines.
example_marker <- '^\\s+@[A-Za-z][A-Za-z0-9_:-]*[.)](\\s|$)'
for (f in names(sources)) {
  hits <- grep(example_marker, sources[[f]])
  expect_equal(
    length(hits), 0L,
    info = paste('no list-item line begins with @label. in', f,
                 if (length(hits)) paste('at line', hits[1]) else '')
  )
}

# Quarto cannot resolve an @sec- cross-reference to a section on an
# unnumbered page (the conventions page, the setup appendix), so the
# reference renders as a warning and a literal '?'. Such targets must
# be linked as [text](file.qmd#id) instead. Two phases hit this.
unnumbered_ids <- character(0)
for (f in names(sources)) {
  lines <- sources[[f]]
  top <- grep('^# ', lines, value = TRUE)
  if (length(top) && grepl('.unnumbered', top[1], fixed = TRUE)) {
    ids <- regmatches(lines, regexpr('\\{#sec-[A-Za-z0-9_-]+', lines))
    unnumbered_ids <- c(unnumbered_ids, sub('^\\{#', '', ids))
  }
}
for (f in names(sources)) {
  refs <- unlist(regmatches(
    sources[[f]],
    gregexpr('(?<![\\w#])@sec-[A-Za-z0-9_-]*[A-Za-z0-9]',
             sources[[f]], perl = TRUE)
  ))
  bad <- intersect(sub('^@', '', refs), unnumbered_ids)
  expect_equal(
    length(bad), 0L,
    info = paste('no @sec- reference to an unnumbered page in', f,
                 if (length(bad)) paste(':', bad[1]) else '')
  )
}
