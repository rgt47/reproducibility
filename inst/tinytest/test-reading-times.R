# The reading time on each chapter card is computed by one stated rule,
# not guessed. The third review found the guessed times 25 to 40
# percent low. The rule (also stated on the Conventions page): prose
# words in the chapter body, plus ten words for every line of code,
# read at 200 words a minute, rounded to the nearest five minutes.
# The body ends at the Exercises heading. A card may differ from the
# rule by at most five minutes, so ordinary edits do not fail the
# suite but a chapter that grows by a quarter does.

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
if (is.na(book_dir)) {
  exit_file('book sources not present (built package); skipping')
}

expand_includes <- function(lines) {
  include_re <- '^\\s*\\{\\{< include (\\S+) >\\}\\}\\s*$'
  hits <- grepl(include_re, lines)
  if (!any(hits)) {
    return(lines)
  }
  out <- character(0)
  for (ln in lines) {
    if (grepl(include_re, ln)) {
      path <- file.path(book_dir, sub(include_re, '\\1', ln))
      if (file.exists(path)) {
        out <- c(out, expand_includes(readLines(path, warn = FALSE)))
      }
    } else {
      out <- c(out, ln)
    }
  }
  out
}

count_body <- function(lines) {
  if (length(lines) && trimws(lines[1]) == '---') {
    yaml_end <- which(trimws(lines) == '---')[2]
    lines <- lines[-seq_len(yaml_end)]
  }
  fence <- grepl('^\\s*```', lines)
  in_code <- (cumsum(fence) %% 2 == 1) & !fence
  code <- lines[in_code]
  n_code <- sum(nzchar(trimws(code)) & !grepl('^\\s*#\\|', code))
  prose <- lines[!in_code & !fence]
  prose <- gsub('\\{[^}]*\\}', '', prose)
  prose <- gsub('`[^`]*`', ' x ', prose)
  prose <- gsub('\\[([^]]*)\\]\\([^)]*\\)', '\\1', prose)
  prose <- sub('^:::.*', '', prose)
  words <- regmatches(
    prose, gregexpr("[A-Za-z0-9][A-Za-z0-9'.-]*", prose)
  )
  c(words = sum(lengths(words)), code = n_code)
}

rule_minutes <- function(file) {
  lines <- expand_includes(readLines(file, warn = FALSE))
  ex <- which(grepl('^## Exercises', lines))
  if (length(ex)) {
    lines <- lines[seq_len(ex[1] - 1)]
  }
  n <- count_body(lines)
  5 * round((n[['words']] + 10 * n[['code']]) / 200 / 5)
}

chapters <- list.files(book_dir, pattern = '[.]qmd$', full.names = TRUE)
for (f in chapters) {
  card <- grep('^\\*\\*Reading time[.]\\*\\*', readLines(f, warn = FALSE),
               value = TRUE)
  if (length(card) == 0) next
  stated <- as.numeric(sub('^[^0-9]*([0-9]+).*$', '\\1', card[1]))
  computed <- rule_minutes(f)
  expect_true(
    abs(stated - computed) <= 5,
    info = sprintf('reading time in %s: card says %g, rule gives %g',
                   basename(f), stated, computed)
  )
}
