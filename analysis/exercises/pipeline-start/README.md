# Starter project for the pipeline exercises
*2026-11-26 09:02 PST*

A small analysis, run by hand, for readers who have no multi-step
analysis of their own to use in the exercises of the chapter
'Automating the Analysis: targets and Make'. It has the shape of the
chapter's worked example: three scripts and a report, run in order.

The data are the diabetic retinopathy trial shipped with the
`survival` package (`survival::diabetic`): 394 eyes of 197 patients,
one eye of each patient treated by laser. The question is whether
laser treatment delays vision loss.

## Files

| File | Reads | Writes |
|---|---|---|
| `data/raw_data.csv` | (the raw extract) | |
| `clean_data.R` | `data/raw_data.csv` | `cleaned.rds` |
| `fit_model.R` | `cleaned.rds` | `model.rds` |
| `make_figures.R` | `cleaned.rds`, `model.rds` | `figures.rds` |
| `report.Rmd` | `model.rds`, `figures.rds` | `report.html` |

`data/raw_data.csv` was written once with
`write.csv(survival::diabetic, 'data/raw_data.csv', row.names = FALSE)`.
Every other output is derived and is listed in `.gitignore`.

There is deliberately no `Makefile` and no `_targets.R`: writing
them is the exercise.

## Before you start

- Copy this directory out of the book's clone, so that your work
  does not mix with the book's own files and your copy can become
  its own git repository:

  ```bash
  cp -R analysis/exercises/pipeline-start ~/pipeline-start
  cd ~/pipeline-start
  ```

- You need R with the packages `survival`, `ggplot2`, and
  `rmarkdown`. Rendering the report also needs pandoc, which RStudio
  and Quarto both include. In R, `rmarkdown::pandoc_available()`
  should return `TRUE`.
- The exercises add `targets` and `tarchetypes`
  (`install.packages(c('targets', 'tarchetypes'))`), and the optional
  Make exercise needs the `make` program (`make --version`).

## Running the analysis by hand

From this directory, in a terminal:

```bash
Rscript clean_data.R
Rscript fit_model.R
Rscript make_figures.R
Rscript -e 'rmarkdown::render("report.Rmd")'
```

Open `report.html`. It reports the hazard ratio for laser treatment,
with robust standard errors clustered on patient (each patient
contributes two eyes), and draws the survival curves by arm.

The order matters, and nothing but your memory enforces it. That is
the problem the chapter's exercises ask you to solve.

## Which exercises use it

- Exercise 1: draw the dependency graph of these four steps.
- Exercise 2 (optional): write a four-rule `Makefile` for them.
- Exercise 3: refactor each script into a function in `R/`
  (`read_raw()`, `clean_data()`, `fit_model()`, `make_figures()`),
  change `report.Rmd` to fetch `model` and `figures` with
  `targets::tar_read()`, and write `_targets.R`.
- Exercises 4 and 5: work on the pipeline of Exercise 3.
