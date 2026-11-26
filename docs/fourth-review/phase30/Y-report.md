# Phase 30, Agent Y: `targets` as Core in Chapter 9 (`pipelines.qmd`)
*2026-11-26 08:32 PST*

I edited only `analysis/report/pipelines.qmd`. No shared file was
touched, and nothing was committed. Line numbers below refer to the
new file. They were spot-checked with `grep -n` after the last edit.

## Word counts

These were measured with `wc -w`, and with a whitespace-split count
for the sections (script `.../scratchpad/y/counts.R`).

**Whole chapter.** 13,774 before, 13,873 after (+99).

**Make section.** 932 words before. Afterwards it is 861 words, not
counting the comparison check moved into it from the `targets`
section, which is 182 words.

**`targets` section.** 1,378 words before, including that check.
Afterwards it is 1,203 words without the check, so it is about the
same once the check is counted in.

**Why the chapter grew.** The net rise comes from additions the
findings or the scratch runs required:

- the card's list of optional parts;
- the `targets` variant of Exercise 4 and its new solution;
- the setup steps for Exercise 7;
- the cohort `_targets.R` header and the `tar_source()` paragraph
  (a defect found by running it);
- one install sentence and a `visNetwork` clause.

The cuts for R10-09 did not offset them.

## Changes by finding

### D28 / R10-04 / R10-01: `targets` is core, Make is optional

**The swap.** The old `## GNU Make` section (589-727) and the old
`## targets` section (729-937) were swapped by a script. The script
asserted that the line count was unchanged and that the set of lines
was the same (`setequal`). `git diff --stat` then showed 140
insertions and 140 deletions. Seams were edited only after that.
The new positions are `## targets` at 588-769 and `## GNU Make, for
comparison (optional)` at 771-933.

**The `targets` section.**

- The opening (589-597) is rewritten without reference to Make. It
  gives two reasons the package is core: it is an R package, so it
  needs no separate program; and it tracks functions and objects.
- Make contrasts inside the section were removed:
  - 'no colons and no prerequisites';
  - 'Several features distinguish this from the Makefile';
  - 'Where Make compares timestamps';
  - 'Make, seeing only files, cannot detect';
  - the last sentence of the Verification box.
- New text at 714-722:
  - how to install the packages, with
    `install.packages(c('targets', 'tarchetypes'))`;
  - that in an `renv` project they belong in the lockfile, with a
    pointer to `@sec-dependencies`;
  - that `tar_visnetwork()` also needs `visNetwork` (verified
    below).

**The Make section.**

- The opening (772-783) says the section may be skipped and why
  Make still matters: the simplest model and language-agnostic
  reach.
- Kept: rules, the Pitfall, the four-rule Makefile, `make`, the
  timestamp rule, and the 'what Make rebuilds' check.
- Trimmed: 'the one subtlety worth dwelling on', and the sentences
  about undeclared inputs that repeated item 2 of the analyst's
  contribution. The limitations paragraph now ends by naming what
  `targets` closes.
- Moved without rewriting: the 'what `targets` tracks that Make does
  not' check now follows the Make check. It cannot be answered
  without Make.

**Optional headings.**

- `## Beyond R: Snakemake, Nextflow, and workflowr (optional)`
  (1092).
- `## A language model inside the pipeline (optional)
  {#sec-llm-in-pipeline}` (1464), with the anchor kept.
- No `.qmd` in the book or the instructor guide links to the changed
  automatic anchors. A grep for `#gnu-make`, `#beyond-r` and
  `#targets-a-function` found nothing.

**Chapter card (38-107).**

- Prerequisites:
  - The `targets` section and the worked example are named as core.
  - The optional sections and exercises are named.
  - The shell-reading prerequisite is limited to the optional Make
    section.
  - The wording avoids 'you', per the voice rule.
- Objectives:
  - The `targets` objective now comes first. The Make objective is
    marked '(Optional.)'.
  - The `targets` objective's 'a changed function, object, or
    package' now reads 'function, object, or file', because the
    chapter itself says `targets` does not track package versions.
- Outline: reordered, with the three optional sections marked.

**Seams elsewhere.**

- The orientation's 'two tools' sentence.
- Item 2 of the analyst's contribution: `targets` first, Make
  second.
- The vocabulary box: the Target entry now names `targets` first,
  and the Prerequisite and Recipe entries are labeled as Make terms.
- '`tar_make()` or `make`' at two sites.
- 'With both tools' is now 'With the tools'.
- The figure caption now reads '`targets` and Make'.

**'Collaborating with an LLM'.**

- The `targets` prompt block now comes first (a moved block).
- The Makefile prompt and the LLM-step prompt carry '(for readers
  of the optional ... section)'. Their label is now `**Prompt**
  (...)`, not `**Prompt.**`. Nothing in `inst/`, `R/`, `tools/` or
  `cheat-sheet-index.qmd` keys on that string (grep).

**Cheat sheet (2040-2056).**

- The `targets` rows come first, and a `tar_source('R')` row is
  added.
- The three Make-only rows are prefixed '(Optional, Make.)' in the
  second column. `cheat-sheet-index.qmd` reads only the first
  column.

### R10-01: exercises consistent with the core path

The numbering is unchanged (1 to 9), because the instructor guide
keys on Exercise 7. 'Optional' appears only in the item text, never
in the `## Exercise N` headings.

- **Exercise 2 (1654)** is labeled '(Optional; uses the optional
  Make section.)'. It now refers to 'Exercise 1' rather than 'the
  previous exercise'.
- **Exercise 3 (1663)** reads 'Convert the analysis of Exercise 1'.
- **Exercise 4 (1672)** is recast on the Exercise 3 pipeline:
  - edit a helper loaded by `tar_source()`, which is caught;
  - add an undeclared `read.csv()` and change the file, which is
    not caught;
  - explain the difference;
  - an optional final part asks about Make.
- **The Exercise 4 solution (1865-1898)** is rewritten to match,
  including the R10-02 wording that was already there.
- **The Exercise 3 solution** now says 'each step of the hand-drawn
  graph (or each Make rule, if you did Exercise 2)'. It names the
  `library(targets)` and `tar_source('R')` header.
- **Exercise 9 (1726)** is labeled optional.
- **Exercise 7** stays core and now uses the core tool (see R10-08).

### R10-06

The Exercise 2 solution now says that the second behavior is the
timestamp blind spot named in the Make section, and that the
`targets` section's `trust_timestamps` passage shows it for
`targets`. It then says Exercise 4 takes up the related failure of
an undeclared input.

### R10-08

Exercise 7 (1702-1715) now has three steps:

1. Start at the repository root and generate the CSV with
   `Rscript analysis/scripts/simulate_cohort.R`.
2. Load the functions with `pkgload::load_all()`.
3. Write the `_targets.R` with `tar_source('R')`.

### R10-09: 'captures no determinant' stated once

The full statement stays in 'What a pipeline does, and does not,
add', which now has the anchor `{#sec-pipeline-adds}` (934). That
is a new anchor in a numbered chapter. The prose restatements were
replaced as follows:

- **The stack section (145-150):** one clause, with a forward
  reference.
- **Item 3 of the analyst's contribution (316-323):** a
  back-reference. Its closing two sentences were cut.
- **The sentence beginning 'Like continuous integration, a pipeline
  captures no determinant...'** (old 986-989) was deleted.
- **The honest-level box (1033-1039):** a back-reference.
  - This also fixes **R10-05**, which was not in my assignment. The
    box no longer claims the chapter 'runs `tar_make()` and
    `make`', and it says the compendium has no `_targets.R`.
  - If the lead wants R10-05 kept out of this phase, revert this
    box.
- **The cohort section (1430-1435):** a back-reference.

Kept unchanged: the figure, its caption and title, every check, the
Exercise 5 solution (it is an answer), and the cheat-sheet row.

### Found by running the code

**The cohort fragment would not run.** It used an undefined
`cohort_path` and gave no way to load `load_cohort()`. Run as
printed, it failed with `object 'cohort_path' not found`.

- It is now a complete `_targets.R` (1398-1411): `library(targets)`,
  `tar_source('R')`, and the literal path.
- A new paragraph (1418-1428) explains why to use `tar_source('R')`
  and not `pkgload::load_all()`. Under `load_all()`, an edit to
  `clean_cohort()` leaves `tar_outdated()` empty.

**The Exercise 9 solution omitted file targets.** In case (b) the
list now includes `notes_file`, and in case (c) it includes
`prompt_file`.

**Version numbers.** The two scratch-run claims in the `targets`
section now cite 1.12.1 and 0.14.2, the versions re-run here.

### Partial R10-03

The Solutions preamble said every exercise is done on the reader's
own analysis. That is false for Exercises 6 to 9, so it now reads
'Exercises 1 to 5'.

## What I ran

**Setup.**

- Scratch library: `.../scratchpad/y/lib`.
- Command: `install.packages(c('targets', 'tarchetypes',
  'visNetwork'), lib = <scratch>, repos = 'https://cloud.r-project.org')`.
- Output: `also installing the dependencies ‘base64url’, ‘igraph’,
  ‘secretbase’` and then `1.12.1 0.14.2` (`targets` and
  `tarchetypes`).
- R version: 4.6.2.
- `R_LIBS` was set so the `callr` child session sees the scratch
  library.
- Scripts: `.../scratchpad/y/run-main.R`, `run-claims.R`,
  `run-cohort.R`, `run-llm.R`, `run-lone.R`.

**Not run as printed.** The chapter's
`install.packages(c('targets', 'tarchetypes'))` was not run as
printed, because brief rule 2 forbids installing into the host
library. Only the scratch-library form with `lib =` was run.

**Output.** The excerpts below are verbatim lines from the console.
Lines were selected, and some lines between them omitted, but none
was retyped.

### 1. The running example's `_targets.R`

This was run verbatim, with stub `R/` functions on
`survival::diabetic` and a `report.Rmd`.

```
✔ ended pipeline [1.6s, 6 completed, 0 skipped]

== outdated after first make ==
character(0)

== edit make_figures body ==
[1] "report"  "figures"
...
✔ ended pipeline [834ms, 2 completed, 4 skipped]

== edit report prose ==
[1] "report"
...
✔ ended pipeline [772ms, 1 completed, 5 skipped]

== change one value in CSV ==
[1] "raw_data" "raw_file" "report"   "figures"  "cleaned"  "model"
...
✔ ended pipeline [1.3s, 6 completed, 0 skipped]

== touch CSV only ==
character(0)

== tar_visnetwork returns ==
[1] "visNetwork" "htmlwidget"
```

The `tar_network(targets_only = TRUE)$edges` output includes
`cleaned figures`, `model report`, `figures report`, and
`model figures`.

### 2. Without `visNetwork`

This used a library holding `targets` and its dependencies but not
`visNetwork`:

```
FALSE
Error : The package "visNetwork" is required.
```

### 3. Further claims (`run-claims.R`)

```
default trust_timestamps, outdated:
character(0)
trust_timestamps = FALSE, outdated:
[1] "raw_data" "raw_file" "cleaned"
plain pattern after prose edit, outdated:
character(0)
✔ ended pipeline [904ms, 5 completed, 0 skipped]      (Exercise 3 solution list)
character(0)
✖ raw errored                                         (format = 'file' on a data frame)
5 raw          Error resolving stored output: target raw did not return a chara…
after changing the undeclared file, outdated:
character(0)
==== E2. edit helper body loaded by tar_source ====
[1] "model"
```

The two parenthetical labels were added by me. They are not R
output.

### 4. Exercise 7 and the cohort fragment

This ran in a scratch copy of the repository holding `R/`,
`DESCRIPTION`, `NAMESPACE` and `simulate_cohort.R`.

```
$ Rscript analysis/scripts/simulate_cohort.R
wrote analysis/data/raw_data/cohort_raw.csv with 338 rows and 10 columns
```

`cmp` against the repository's copy printed nothing, so the two
files are identical. The rest of the run:

```
== console route of Exercise 7 ==
[1] 337

== route 1: tar_source() ==
✔ ended pipeline [130ms, 3 completed, 0 skipped]
outdated after first make:
character(0)
✔ skipped pipeline [72ms, 3 skipped]
outdated after second make, nothing changed:
character(0)
nrow(tar_read(cleaned)): 337
outdated after editing clean_cohort():
[1] "cleaned"

== route 2: pkgload::load_all() in _targets.R ==
...
outdated after editing clean_cohort():
character(0)

== bare fragment, no loading ==
1 raw_file object 'cohort_path' not found
```

This confirms the instructor guide's rubric: `tar_outdated()` is
empty after the first and the second `tar_make()`.

### 5. The 'lone' pattern

```
lone pattern after CSV correction, outdated:
character(0)
```

### 6. The LLM fragment

The fragment ran verbatim except that `model_id` was `'model-a'`.
The helper functions are stubs I wrote:

- `read_notes()`, `make_key()` and `join_responses()`;
- the key is the SHA-256 of the note text, the prompt and the model
  identifier;
- the stub stops when keys are missing.

```
== (a) fresh, no store ==
[1] "notes_file"     "notes"          "prompt_file"    "smoking"
[5] "responses_file"
✔ ended pipeline [112ms, 5 completed, 0 skipped]
== (b) corrected spelling in one note ==
[1] "notes_file" "notes"      "smoking"
1 smoking missing keys: 1
== (c) new prompt version ==
[1] "prompt_file" "smoking"
1 smoking missing keys: 3
== (d) new model identifier ==
[1] "smoking"
1 smoking missing keys: 3
```

The chapter still labels this fragment 'not run'. That remains
accurate, because the book does not show the helper functions.

### Executed chunks

No executed chunk calls `targets`. I scanned every
`` ```{r `` chunk for `tar_` or `targets`, and the only match was
the text of the figure caption. All `targets` code is in display
fences (`` ```r `` or `` ```{.r} ``). `renv.lock` was not touched.

### Tests

The suite was run after the final edit: 455 of 455 passed, with 0
failures. The reading-time test passed, so the card stays at 55
minutes.

## Untested, and risks

**`renv` in a real clone (unverified, and the lead's decision).**
The repository's `.Rprofile` activates `renv` and has an
'Auto-Snapshot on Exit' part. `targets` is not in `renv.lock`, and
my cohort run used a scratch copy without `.Rprofile` and `renv/`.
In a real clone, then:

- `library(targets)` probably fails until the package is installed
  into the project library (inferred, not run in the repository).
- Installing it may then be snapshotted into the lockfile on exit,
  but only inside the container. I read `.Rprofile` lines 198-215
  ('Auto-Snapshot on R Exit (Container only)', which calls
  `renv::snapshot(prompt = FALSE)`) and line 117
  (`snapshot.type = "implicit"`). From those I infer that a
  `_targets.R` calling `library(targets)` would put `targets` into
  `renv.lock` when R exits in the container. I did not run this.

Exercise 7 now asks for exactly this. Options:

- add `targets` to the lockfile;
- tell readers to run Exercise 7 in a separate scratch project;
- accept the snapshot as the reader's own change.

I did not change the lockfile.

**Make material.** I did not run `make`, the Pitfall's error text,
or `touch` under Make. That material was moved and trimmed, not
changed in substance, and it rests on earlier phases.

**The faded `_targets.R`.** Its placeholders make it incomplete by
design. Its answer lines are the main example, which was run.

**No render.** Brief rule 2 forbids one. The rendered output is
therefore unverified for:

- the moved sections;
- the new `@sec-pipeline-adds` references;
- the '(optional)' headings in the HTML and PDF tables of contents.

**Not done in this file:**

- R10-07: name `crew` alongside `clustermq` (1163-1164).
- R10-10: `cluster(id)` for paired eyes in the timing chunk.
- R10-03: no starter directory was added.

**Sentence length.** New sentences were checked against the 35-word
limit by hand. Unchanged prose was not re-audited.

## Proposed changes to shared files

1. **`conventions.qmd:231`**, the core-path row, could read: 'Core
   for the `targets` section and the worked example. The comparison
   with GNU Make, Snakemake, Nextflow, and workflowr, and a language
   model inside the pipeline, are optional.'
2. **The chapter title.** 'Automating the Analysis: Make and
   targets' puts the optional tool first. 'Automating the Analysis:
   targets and Make' would match the new order. The title appears
   in:
   - `contents.qmd:39`;
   - `conventions.qmd:231`;
   - instructor guide 491 and 727;
   - the instructor guide's `stopifnot` title list (about line 750),
     which fails the guide render if only the chapter heading
     changes.

   'make and targets' also appears in `00-intro.qmd:302` and
   `preface.qmd:100`. I did not rename the chapter heading.
3. **Instructor guide.**
   - Line 727, week 7: replace 'the Make section of Ch 9' with 'the
     `targets` section and worked example of Ch 9'.
   - Line 758: the optional list should read 'the Make comparison,
     Snakemake, Nextflow, workflowr, and the language-model
     section', replacing '`targets`, Snakemake, ...'.
   - Lines 502-515: add `library(targets)` and `tar_source('R')` to
     the `_targets.R` fragment. Without them it does not run, and
     with `load_all()` edits to functions are not tracked (run 4).
   - The rubric could credit 'functions loaded with `tar_source()`'.
4. **`08-testing-quality.qmd:114-118`**, the R10-01 warm-up answer.
   With `targets` now core, its `format = 'file'` answer fits the
   core path, so no change is needed.
5. **`glossary.qmd`.** The Prerequisite and Recipe entries (around
   lines 471 and 573) could say they are Make terms, if they do not
   already. I did not read those entries.
6. **Setup appendix.** The book has no instructions for installing
   `make`. That is now less pressing, because Make is optional.
