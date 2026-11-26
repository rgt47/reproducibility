# Phase 28, Agent L: Report
*2026-11-25 22:47 PST*

Files edited: `analysis/report/07-literate-programming.qmd`
(Chapter 9) and `analysis/report/version-control.qmd` (Chapter 4).
Nothing committed. Scratch work is under the session scratchpad
(`.../scratchpad/anatomy`, `.../display`, `.../gitjoin`).

## R9-01 (blocking): Anatomy of a literate document

**Changed.**

- `07-literate-programming.qmd:75-76`: the Outline now says we take apart a
  minimal Quarto document and render it three ways.
- `07-literate-programming.qmd:473-564`: new `## Anatomy of a literate
  document`, placed after the two check callouts that close 'From
  Sweave to Quarto' and before 'The sealed render'. It contains the
  verbatim listing, the three parts (YAML header, code chunk with
  `#| label` and `#| echo`, inline expression), the three render routes,
  the real `quarto render` output, and the output file names.
- `07-literate-programming.qmd:681-688`: 'If we read the source of that
  sentence' is replaced. The paragraph now points to the last line of
  the listing and shows the source form `` `r n_eyes` `` inline.

**Run, with real output.** I wrote the example as
`scratchpad/anatomy/report.qmd` and rendered it with Quarto 1.11.9
(`quarto --version` printed `1.11.9`):

```
processing file: report.qmd
1/3
2/3 [count-eyes]
3/3
output file: report.knit.md
pandoc
  to: html
  output-file: report.html
  ...
Output created: report.html
```

The run produced `report.html` and `report_files/libs/` (bootstrap,
quarto-html, clipboard). `grep` on the HTML found
`<p>The laser-treated arm holds 197 eyes.</p>`. `survival::diabetic`
occurs 0 times in the HTML, which confirms `echo: false`. The book
prints only three of those output lines, labeled 'abridged'.

**How literal display was ensured.**

1. Negative control (`display/naive.qmd`): a plain
   ```` ````{.markdown} ```` block containing ```` ```{r} ```` and
   `` `r n_eyes` ``. knitr **executed** the inner chunk. The block showed
   `::: {.cell}` and 'holds 197 eyes'. A plain display block is therefore
   not enough, because the book is knitr-rendered.
2. Fix: the chunk fence is written ```` ```{{r}} ```` (Quarto's
   unexecuted-block syntax:
   <https://quarto.org/docs/computations/execution-options.html>), and
   the inline expression is written `` `r knitr::inline_expr('n_eyes')` ``.
   An HTML comment in the source records this for maintainers. It does
   not appear in the LaTeX output (checked).
3. Verification: `display/build.sh` copies the chapter's own lines
   (473-564 and 657-696) into a scratch document and renders it to HTML
   and LaTeX. The `<pre>` text of the listing, extracted from the HTML,
   is **byte-identical to `report.qmd`** (`diff` empty). The LaTeX shows
   `\textasciigrave{}r n\_eyes\textasciigrave{}` and the literal
   `` ```{r} `` fence. In the revised prose paragraph, the inline source
   renders as `<code>r n_eyes</code>`, which is code font without the
   surrounding backticks. That is acceptable but worth knowing.
4. Exercise 8 (an `renv::dependencies()` scan of this chapter at build
   time): I ran the scan on the file. It returns dplyr, ggplot2, knitr,
   pkgload, renv, rmarkdown, survival and tibble. `knitr` and `survival`
   were already present, so the new `knitr::` call and the displayed
   `survival::` line do not change what Exercise 8 prints.

**Untested or not run.**

- `quarto::quarto_render()`: **not run**. The `quarto` R package is not
  in the host library (`packageVersion('quarto')` gives an error), and
  the brief forbids installs. Source:
  <https://quarto-dev.github.io/quarto-r/reference/quarto_render.html>.
  The book says that this route needs the R package as well as the
  Quarto program.
- RStudio and Positron: untested. The review's 'Render button' is
  correct for RStudio (<https://quarto.org/docs/tools/rstudio.html>).
  It is **not** correct for Positron, whose docs name the **Preview**
  button and the command 'Quarto: Preview'
  (<https://quarto.org/docs/tools/positron/>). The book follows the docs.

**Mechanics note.** The brief says `@sec-shell` works as a page-level
target, but the test suite's unnumbered-page check
(`test-manuscript-invariants.R:163-188`) flags it. I used
`[Shell Primer](shell-primer.qmd)` in both files, and both pass. The
same check currently fails for `03-research-compendium.qmd`,
`05-containers.qmd` and `pipelines.qmd`, which are not my files. The
lead should decide whether the test or the brief is right.

## R4-V02: Joining an existing project, and the Exercise 5 solution

**Changed.**

- `version-control.qmd:1529-1615`: new `### Joining an existing project`
  at the end of 'The remote'. It is a `###`, so no Outline line is
  needed. It covers `git clone`, what `origin` is, `git pull` (fetch
  plus merge, fast-forward), the fork route (Fork button, cloning the
  fork, `git remote add upstream`, `git fetch upstream`), branching with
  `--no-track`, `git push -u origin <branch>`, and opening the pull
  request (the web button, or `gh pr create`).
- `version-control.qmd:2218-2237` (Exercise 5 solution): the branch is
  now created with `--no-track` and pushed with `-u`. `gh pr create
  --fill` is added, and a paragraph explains the web alternative.

**Finding from testing (a correction to the existing solution).** The
previous solution used `git switch -c fix/outlier-threshold
upstream/main`. In the scratch run, that branch tracked `upstream/main`,
and `git status` advised `(use "git push" to publish your local
commits)`. A bare `git push` then failed:

```
fatal: The upstream branch of your current branch does not match
the name of your current branch.  To push to the upstream branch
on the remote, use

    git push upstream HEAD:main
...
[exit 128]
```

Following git's own first suggestion would push straight into the
canonical `main`. That is the opposite of the fork route's purpose. With
`--no-track` plus `push -u origin`, the branch tracks the fork.

**Run, with real output** (`gitjoin/run3.sh`; git 2.56.1; synthetic
identity; `GIT_CONFIG_GLOBAL=/dev/null`). Local bare repositories stood
in for the forge: `lab.git` for the canonical repository, and
`site2-study.git`, a bare clone of `lab.git`, for the fork. Nothing was
pushed anywhere off the machine. Paths below are replaced with
`<scratch>`.

```
$ git clone <scratch>/lab.git diabetes-cohort
Cloning into 'diabetes-cohort'...
done.
$ git remote -v
origin	<scratch>/lab.git (fetch)
origin	<scratch>/lab.git (push)
$ git pull
From <scratch>/lab
   623d925..eb78c59  main       -> origin/main
Updating 623d925..eb78c59
Fast-forward
 R/clean_cohort.R | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git clone <scratch>/site2-study.git study
Cloning into 'study'...
done.
$ git remote add upstream <scratch>/lab.git
$ git fetch upstream
From <scratch>/lab
 * [new branch]      main       -> upstream/main
$ git switch -c fix/outlier-threshold --no-track upstream/main
Switched to a new branch 'fix/outlier-threshold'
$ git add R/clean_cohort.R
$ git commit -m 'Raise outlier threshold to 4 SD per SAP amendment 2'
[fix/outlier-threshold 6e4ed97] Raise outlier threshold to 4 SD per SAP amendment 2
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git push -u origin fix/outlier-threshold
To <scratch>/site2-study.git
 * [new branch]      fix/outlier-threshold -> fix/outlier-threshold
branch 'fix/outlier-threshold' set up to track 'origin/fix/outlier-threshold'.
```

The book prints the `From <path>` lines and the final 'set up to track'
line only in abridged form. The latter is 81 characters, over the 78
limit. It is described in the prose instead. The book shows GitHub URLs
in the commands, while the outputs come from local paths. Each block
says 'local bare repository standing in for the forge'. The `git clone`
output contains no URL, so nothing shown is invented.

**Untested.**

- The `gh pr create --fill` line was **not run**, because it needs a
  real GitHub push. Source: <https://cli.github.com/manual/gh_pr_create>;
  `--fill` and `--web` were confirmed there and in local `gh pr create
  --help`. Risk: in a clone with both `origin` (the fork) and `upstream`,
  `gh` may first prompt for the base repository. I did not observe this;
  it is a plausible first-use prompt.
- The GitHub web steps (the Fork button; 'Compare & pull request') are
  taken from
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo>
  and
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork>.
- I did not add `gh repo clone`, which REVIEW.md suggested. It is not
  needed for Exercise 5, and the budget was tight.

## Chapter 4 prerequisites: shell pointer

`version-control.qmd:64-66`: 'Every command here is typed in a
terminal; a reader who has never opened one should read the [Shell
Primer](shell-primer.qmd) first.' I used the link form, not
`@sec-shell` (see the mechanics note above).

## R4-V12: create the remote first; token, not password

`version-control.qmd:1801-1810`, before the first push in the worked
example. The new text says:

- The remote must exist first, as an empty private repository created
  without a README, license, or `.gitignore`. This follows GitHub docs:
  <https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github>.
- A scratch test of a push into a non-empty remote was rejected.
- Over HTTPS, the push asks for a personal access token, not the
  password. It points to step 4 of the Git preflight, which already
  covers tokens and cites Happy Git. GitHub's own statement ('When Git
  prompts you for your password, enter your personal access token';
  'Password-based authentication for Git has been removed') is at
  <https://docs.github.com/en/get-started/git-basics/about-remote-repositories>.

**Run.** A push into a bare remote that already held a README commit
was rejected:

```
$ git push -u origin main
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to '<scratch>/readme-remote.git'
hint: Updates were rejected because the remote contains work that you do not
...
[exit 1]
```

The token prompt and creating the repository on the forge are
**untested**, because no GitHub interaction was performed.
`gh repo create --private` was not added to the book. Its flags were
checked in the manual (<https://cli.github.com/manual/gh_repo_create>)
and in local `--help`, but it was not run.

## Word counts

These are counts of added lines (`git diff -U0`, `wc -w`), including
code and URLs. Chapter 9 adds about 630 words (budget 900). Chapter 4
adds about 640 words (budget 700). Four prose lines exceed 66
characters only because each holds an unbreakable URL. The setup
appendix uses the same pattern.

## Proposed glossary and bib entries (for the lead)

- Glossary, **upstream (remote)**: 'By convention, the name given to a
  second remote that points at the canonical repository from which a
  fork was made; `git fetch upstream` brings its new commits down.'
- Glossary, **clone**: 'A complete local copy of a remote repository,
  history included, made with `git clone`; the source is recorded as
  the remote `origin`.'
- Glossary, **YAML header**: 'The block between two `---` lines at the
  top of a literate document, holding document-wide settings such as
  the title and output format.'
- Bib (optional): `quartorstudio`
  (<https://quarto.org/docs/tools/rstudio.html>), `quartopositron`
  (<https://quarto.org/docs/tools/positron/>), `quartor`
  (<https://quarto-dev.github.io/quarto-r/>), and `ghcli`
  (<https://cli.github.com/manual/>). These are cited as bare URLs at
  present, so no bib change is required.

## Test result

```
File                           Results fails passes
  test-manuscript-invariants.R     372     3    369
  test-reading-times.R              12     1     11
  (all other files pass)
  Total                            446     4    442
```

Remaining failures, none in my files:

- `@sec-shell` to an unnumbered page in `03-research-compendium.qmd`,
  `05-containers.qmd` and `pipelines.qmd`.
- Reading time in `09-continuous-integration.qmd` (the card says 70; the
  rule gives 80).

Both of my chapters pass the reading-time check; their cards were not
changed.
