# Phase 28, Agent C report: Chapter 12 first workflow
*2026-11-25 22:48 PST*

File edited: `analysis/report/09-continuous-integration.qmd` only.
Nothing committed, pushed, or created on GitHub.

## Summary of changes

- Lines 40: Reading time 70 to 80 minutes (the value the
  reading-time test gave).
- Lines 50-56: prerequisite sentence rewritten. It no longer says
  'no YAML is written from scratch here'; it says no prior YAML is
  assumed, that the first workflow is read construct by construct,
  that Exercise 4 asks for one complete GitLab file, and points to
  `[Reading YAML](shell-primer.qmd)`. (I checked the exercises:
  only Exercise 4 asks for a complete YAML file.)
- Lines 76-80: Outline gains 'a first workflow that runs the tests
  on every push'; lines rewrapped.
- Lines 415-567: new section `## Your first workflow
  {#sec-ci-first-workflow}`, placed after 'The machine that is not
  yours' (and its check-your-understanding callout) and before 'What
  the checks are: the three gates', so it precedes the 60-line
  workflow. Contents: assumptions; where the file goes; a 24-line
  workflow; a paragraph reading it; the six-row table
  `@tbl-ci-reading-workflow`; the short `ci/run-tests.R`; where the
  result appears and how to open a failed step's log; the
  'watch it fail once' habit as prose (no new numbered exercise);
  a YAML indentation error with the real R parser message.
- Line 1160: added the id `{#sec-verification-l3}` to 'Verification
  and level L3' so the new section can point to it.
- Lines about 1210-1215: the L3 text that introduced
  `ci/run-tests.R` now says the script is the one from
  @sec-ci-first-workflow, with the baseline check added, instead of
  re-explaining the exit-0 problem.

Words added: about 785 words of prose in the section, about 210 in
the table, plus about 40 net in the prerequisite and Outline,
about 1,050 in all (counted by script; approximate).

## R12-01 Your first workflow

### Decisions

- **`ci/run-tests.R` does not exist in the repository.** `find` for
  `run-tests*` (excluding renv and `_book`) returned nothing. The
  script exists only as the listing in the L3 section. That listing
  stops with 'No baseline test ran', so a newcomer's first workflow
  using it verbatim would fail for a reason unrelated to their
  tests. The new section therefore shows the same script without
  the baseline check (four code lines plus the header comment), and
  calls it 'the first form of a file that @sec-verification-l3
  extends'. The L3 section was edited to say so.
- **Pins.** The chapter pins `actions/checkout@v7` and
  `r-lib/actions/*@v2` by major tag, and the secrets section
  explains SHA pinning. The first workflow uses the same tags and
  says @sec-ci-secrets explains why a SHA is safer.
- **`permissions: contents: read`** added, because the secrets
  section (about line 870 now) says 'The chapter's own example
  already does this' and the first workflow passes
  `GITHUB_TOKEN` into `env`.
- **`GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}`** kept, partly to
  give the table's expression row a real example, and because the
  long workflow uses it the same way.
- **`run: |` with two lines** (`Rscript --version` and
  `Rscript ci/run-tests.R`) so the block-scalar row has a real
  example. This is slightly contrived; the version line does make
  the log record which R ran.
- **Trigger** is `push` to `main` only; the prose warns that a
  repository whose default branch is `master` must change it.
- **Package for the failure habit:** `fixest`, because it is not
  installed on this host, so the error line shown is observed.
  (`sandwich`, used elsewhere in the chapter, is installed here.)
- **No cost, quota or time statements**, per the assignment.
- **No `usethis::use_github_action()`**: not run here; the
  hand-written file was what the assignment specified.

### Versions checked (run)

```
$ gh api repos/r-lib/actions/releases/latest --jq '.tag_name, .published_at, .name'
v2
2021-12-12T17:39:09Z
v2
$ gh api "repos/r-lib/actions/tags?per_page=8" --jq '.[].name'
v2.14.0
v2.13.0
v2.12.1
...
$ gh api repos/actions/checkout/releases/latest --jq '.tag_name, .published_at'
v7.0.1
2026-07-20T15:10:05Z
```

`releases/latest` for r-lib/actions returns an old floating `v2`
release; the tags show the current release is v2.14.0, so `@v2`
is the current major. I read `setup-r/action.yml` at `v2`: its
`r-version` input documents `'renv': retrieve the R version
recorded in renv.lock file`. I read `setup-renv/action.yaml` (note
the `.yaml` extension) at `v2`: it installs renv if absent, calls
`renv::activate()`, restores a cache, and runs `renv::restore()`.
The prose describes exactly those steps.

### Workflow validation (run)

The script `scratchpad/check-final.R` extracts the first ```` ```yaml ````
block after the new heading from the final `.qmd`, writes it to a
file, and parses it with `yaml::read_yaml()`. Output (excerpt):

```
lines in printed workflow: 24
max code line width: 45
 $ :List of 2
  ..$ uses: chr "r-lib/actions/setup-r@v2"
  ..$ with:List of 1
  .. ..$ r-version: chr "renv"
...
  ..$ run : chr "Rscript --version\nRscript ci/run-tests.R"
List of 1
 $ contents: chr "read"
```

It parses. Note: R's `yaml` package (2.3.12) reads the top-level
key `on` as the logical `TRUE` (a YAML 1.1 rule). GitHub reads it
as the key `on`. This is kept out of the chapter; it shows that a
local parse checks syntax only, which the chapter already says.

### Mis-indented copy (run)

The same script moves `r-version: renv` (line 19 of the workflow)
from column 11 to column 8 and parses again. Real output from
`yaml::yaml.load()` on that file:

```
Error in yaml::yaml.load(paste(readLines(".../bad.yml"),  :
  Parser error: while parsing a block collection at line 16, column 7 did not find expected '-' indicator at line 19, column 8
Execution halted
```

The chapter prints the 'Parser error' part, wrapped to three lines,
and says it is wrapped. Line numbers were regenerated from the
final printed file. Only this one mis-indentation was tried; the
chapter does not claim that every indentation error produces this
message.

GitHub's own message for an invalid workflow: **not shown,
untested**. I found no GitHub Docs page describing it (checked the
workflow-syntax, troubleshooting, and quickstart pages). The
chapter says only that GitHub cannot run such a file and that its
message is not reproduced.

### Test-script exit status (run, scratch copy only)

Toy package in
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/toy/`
(not the repository's `inst/tinytest`). Host R 4.6.2, tinytest
1.4.3.

Passing:
```
$ env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE Rscript ci/run-tests.R; echo "exit status: $?"
test-bmi.R....................    1 tests OK 22ms
All ok, 1 results (23ms)
exit status: 0
```

With a deliberately failing test:
```
test-bmi.R....................    1 tests OK 20ms
test-fail.R...................    1 tests 1 fails 1ms
----- FAILED[data]: test-fail.R<1--1>
 ...
Showing 1 out of 2 results: 1 fails, 1 passes (22ms)
exit status: 1
```

Bare call, same failing test:
```
$ env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE Rscript -e "pkgload::load_all('.', quiet = TRUE); tinytest::run_test_dir('inst/tinytest')"; echo "exit status: $?"
...
Showing 1 out of 2 results: 1 fails, 1 passes (21ms)
exit status: 0
```

With `library(fixest)` at the top of the test file (fixest not
installed):
```
Error in library(fixest) : there is no package called 'fixest'
Calls: <Anonymous> -> lapply -> FUN -> eval -> eval -> library
Execution halted
exit status: 1
```

The chapter prints the first line and says it was observed outside
a runner. That the runner's log shows the same line is **inferred**
(same R error), not observed.

### Untested, from documentation

- Location `.github/workflows/`, `.yml`/`.yaml` extension; default
  shell `bash -e {0}` (stops at first failing line); 'each line runs
  in the same shell': Workflow syntax for GitHub Actions,
  https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax
  (opened 2026-11-25).
- `${{ }}`: 'You need to use specific syntax to tell GitHub to
  evaluate an expression rather than treat it as a string.'
  Evaluate expressions in workflows and actions,
  https://docs.github.com/en/actions/reference/workflows-and-actions/expressions
- Push triggers the run: 'Committing the workflow file to a branch
  in your repository triggers the push event and runs your
  workflow.' Quickstart for GitHub Actions,
  https://docs.github.com/en/actions/get-started/quickstart
- Actions tab, run, job, 'Any failed steps are automatically
  expanded to display the results.' Using workflow run logs,
  https://docs.github.com/en/actions/how-tos/monitor-workflows/use-workflow-run-logs
- **Unsourced and untested:** the sentence that the commit carries
  'a green check or a red cross' in the commit list and on a pull
  request. The 'Status checks' page shows a screenshot of commits
  with statuses but does not describe the icons in text. The lead
  may want to soften this to 'a status mark' or find a source.
- `permissions: contents: read` leaving other scopes unset: from
  the chapter's existing `@githubhardening` discussion; not tested.

## R4-014 part: 'Reading the workflow' table

Six rows (key-value, list item, nesting, expression, block scalar,
quoting) as `@tbl-ci-reading-workflow`, beside the first workflow,
citing `[@githubworkflowsyntax; @githubexpressions]`.

Checks (run, R `yaml` 2.3.12):

```
str(yaml::yaml.load("r-version: 4.10"))    -> num 4.1
str(yaml::yaml.load("r-version: '4.10'"))  -> chr "4.10"
str(yaml::yaml.load("branches: [main]"))   -> chr "main"
str(yaml::yaml.load("key: ${{ secrets.GITHUB_TOKEN }}"))
                                           -> chr "${{ secrets.GITHUB_TOKEN }}"
yaml::yaml.load("a:\n\tb: 1")  -> Scanner error: ... found character
                                  that cannot start any token
```

- 'Key and value: the space after the colon is required': YAML
  spec; not separately run.
- 'YAML forbids tabs for indentation': observed (scanner error above).
- 'Expression: to YAML it is plain text': observed. 'GitHub
  evaluates it': documentation quote above.
- 'Block scalar keeps line breaks': observed (`run` parsed as
  `"Rscript --version\nRscript ci/run-tests.R"`). 'One shell; the
  default shell stops at the first failing line': documentation
  (`bash -e {0}`), untested.
- 'Quoting: 4.10 becomes 4.1': observed for R's YAML parser. That
  GitHub's parser does the same is **inferred**, not tested. The
  example (`r-version: '4.10'`) is not in `tests.yml`; the caption
  says so.

Pipe-table check (run): the escaped `\|` displayed a literal
backslash in pandoc, so the row uses an unescaped `` `run: |` ``.
`quarto pandoc -f markdown -t html` on the extracted table gives 18
`<td>` cells (6 rows by 3 columns) and `<td><code>run: |</code></td>`.
The full book was not rendered (brief rule 2).

## Prerequisite sentence

Old (line 52-53): '...enough comfort reading YAML to follow a
workflow file line by line; no YAML is written from scratch here.'
New: 'No prior YAML is assumed. The chapter's first workflow is a
short file that is read construct by construct, and Exercise 4 asks
for one complete GitLab workflow file. The shell primer's [Reading
YAML](shell-primer.qmd) section covers the syntax.' The same link
also closes the new section (line about 565). **Lead action:** once
the primer section exists, append its anchor to both links, as
`[Reading YAML](shell-primer.qmd#<anchor>)`. The chapter contains
no `@sec-shell` or `@sec-setup` reference (checked with grep after
the coordinator's correction to rule 7).

## Proposed bib entries (lead to add; keys are cited and currently undefined)

```bibtex
@misc{githubworkflowsyntax,
  author       = {{GitHub}},
  title        = {Workflow Syntax for {GitHub} Actions},
  howpublished = {GitHub Docs},
  url          = {https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax},
  urldate      = {2026-11-25}
}

@misc{githubexpressions,
  author       = {{GitHub}},
  title        = {Evaluate Expressions in Workflows and Actions},
  howpublished = {GitHub Docs},
  url          = {https://docs.github.com/en/actions/reference/workflows-and-actions/expressions},
  urldate      = {2026-11-25}
}

@misc{githubquickstart,
  author       = {{GitHub}},
  title        = {Quickstart for {GitHub} Actions},
  howpublished = {GitHub Docs},
  url          = {https://docs.github.com/en/actions/get-started/quickstart},
  urldate      = {2026-11-25}
}

@misc{githubrunlogs,
  author       = {{GitHub}},
  title        = {Using Workflow Run Logs},
  howpublished = {GitHub Docs},
  url          = {https://docs.github.com/en/actions/how-tos/monitor-workflows/use-workflow-run-logs},
  urldate      = {2026-11-25}
}
```

Until these are added, the four citations render as unresolved.
No test checks citation keys.

## Proposed glossary entries

- **YAML.** A plain-text format for structured data, in which
  indentation shows nesting, `key: value` pairs name settings, and
  lines beginning `- ` are list items. Quarto headers, CI workflows,
  and `CITATION.cff` are written in it.
- **Block scalar.** In YAML, a value introduced by `|` whose
  following indented lines form one text value with line breaks
  kept; a workflow's multi-line `run:` commands use it.
- **Expression (GitHub Actions).** Text of the form `${{ ... }}` in
  a workflow, which GitHub evaluates (for example to insert a
  secret) before using the value; to YAML it is plain text.

## Test result (run)

```
File                           Results fails passes
  test-baseline-cohort.R             5     0      5
  test-cohort.R                     25     0     25
  test-compare-baseline.R           20     0     20
  test-fit-cox.R                     5     0      5
  test-manuscript-invariants.R     372     3    369
  test-reading-times.R              12     0     12
  test-replicate-streams.R           7     0      7
  Total                            446     3    443
```

The three failures are 'no @sec- reference to an unnumbered page'
for `sec-shell` in `03-research-compendium.qmd`,
`05-containers.qmd`, and `pipelines.qmd`: other agents' files, not
this chapter. The reading-time test failed for this chapter at
first ('card says 70, rule gives 80') and passes after the card
change.

## Skipped or deferred

- No numbered 'Exercise 0'; the habit is prose, as the assignment
  allowed.
- No screenshots (brief rule 5).
- GitHub's error text for invalid YAML and the commit status icons:
  not observed (see above).
- The rest of R12-08 (nested quoting `'"warning"'` in the long
  workflow) is not addressed; the table covers quoting in general
  only.
- The long workflow's lead-in sentence was not changed to refer
  back to the first workflow.
