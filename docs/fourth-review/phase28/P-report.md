# Phase 28, Agent P: Shell Primer and Setup Appendix
*2026-11-25 22:50 PST*

Files edited: `analysis/report/shell-primer.qmd` (about 290
lines added and 23 removed) and `analysis/report/setup-appendix.qmd`
(about 30 lines added, 4 headings given anchors). No other file
was touched. Nothing was committed.

## Test result

The full suite passes: 452 results, 0 failures
(`test-manuscript-invariants.R` 378/378,
`test-reading-times.R` 12/12). The primer and the appendix have
no chapter card, so no Outline or Reading time line was needed.

Scratch renders of copies of both files
(`quarto render <copy> --to html` in the session scratchpad)
succeeded. The only warnings were the expected unresolved
`@sec-` references to other chapters, which resolve in the book.

## R4-004 (content part): primer on-ramp

Changes in `shell-primer.qmd`:

- Lines 3-13: the false first sentence is replaced. It now says
  that from `@sec-version-control` onward most chapters run
  commands and the earlier chapters need little beyond R. It
  also announces the YAML page.
- Lines 15-49: new `## Opening a terminal {#sec-shell-open}`.
  It covers the macOS Terminal and recommends one Windows shell,
  the WSL2 terminal, linked to the appendix's WSL2 section. Git
  Bash is named as sufficient for the git chapters, with a note
  to clone again inside WSL2 before the Docker chapters. It says
  plainly that PowerShell and the Command Prompt are not what
  the book assumes, and that `ls` in PowerShell is an alias for
  `Get-ChildItem`. It also covers the RStudio Terminal tab
  (New Terminal, Alt+Shift+R, and Git Bash under Tools > Global
  Options > Terminal) and the Positron Terminal in the Panel.
- Lines 51-61: new `## Getting unstuck {#sec-shell-unstuck}`,
  a five-row table (`tbl-shell-unstuck`) covering Ctrl-C, the
  up arrow, Tab, `--help` and `man`.
- Lines 136-169: the file-operations heading now includes
  `mkdir` and `cat`. New paragraphs cover `mkdir` and `mkdir -p`,
  `cat` and `less`, `~` and `HOME`, and quoting a path that
  contains a space. They also show that a quoted `~` is not
  expanded, and that a variable expands inside double quotes
  but not inside single ones.
- RA-05 (typed chapter numbers): 'Chapter 5' became
  `@sec-compendium` (twice), and 'Chapter 12's
  continuous-integration examples' became 'the
  continuous-integration examples of `@sec-verification`'.
- RA-06: the export example now shows the unexported case
  first (empty output) and then the exported one. The label
  'in subshell' became 'in child shell'. A new paragraph
  explains why a parenthesized `( ... )` subshell would not
  show the distinction.
- Three folded checks, each with a nested collapsed Answer:
  'relative moves' (after the path section), 'an empty log'
  (after standard error), and 'what R can see' (after `PATH`).
- One exercise under new `## Exercises` and `## Solutions`
  headings at the end of the file. It has a single numbered
  item, and its solution sits in a collapsed callout titled
  'Exercise 1'.

### Runs (verified, real output)

The child-shell behavior, run under bash 5.3 from a script:

```
MYVAR=hello (unexported)
bash -c 'echo "in child shell: $MYVAR"'   -> in child shell:
( echo "in (subshell): $MYVAR" )          -> in (subshell): hello
export MYVAR=hello
bash -c 'echo "in child shell: $MYVAR"'   -> in child shell: hello
```

zsh, run as `env -u MYVAR zsh -f -c ...`, gives the same
results: `unexported child: []`, `exported child: [hello]`,
`parens: [hello]`.

The exercise solution and the file-operation examples were run
in interactive bash (`bash --norc --noprofile -i`) and
interactive zsh (`zsh -f -i`), with `HOME` set to a scratch
directory. The bash output follows; scratch paths are shortened
to `$H` here.

```
bash-5.3$ ls data
cohort_backup.csv
cohort.csv
bash-5.3$ cat data/cohort.csv
id,age
1,34
2,51
bash-5.3$ ls ~/'shell practice'
data
bash-5.3$ ls ~/shell practice
ls: $H/shell: No such file or directory
ls: practice: No such file or directory
bash-5.3$ cd ~/shell practice
bash: cd: too many arguments
bash-5.3$ cd '~/shell practice'
bash: cd: ~/shell practice: No such file or directory
bash-5.3$ echo '$HOME' "$HOME"
$HOME $H
bash-5.3$ cd ~/project/analysis/report; cd ../..; pwd
$H/project
bash-5.3$ cd; pwd
$H
bash-5.3$ mkdir a/b
mkdir: a: No such file or directory
```

The zsh run differed only in its error wording, as quoted in the
text: `cd: string not in pwd: $H/shell` and
`cd: no such file or directory: ~/shell practice`.

Other verified runs:

- `cat does_not_exist.txt > out.txt` printed
  `cat: does_not_exist.txt: No such file or directory`, and
  `wc -c < out.txt` reported `0`.
- After an unexported `MYVAR=hello`,
  `Rscript -e 'Sys.getenv("MYVAR")'` printed `[1] ""`. After
  `export MYVAR`, it printed `[1] "hello"`.
- `ls --help` on this Mac printed ``ls: unrecognized option
  `--help'`` and a `usage:` line. `mkdir --help` printed
  `mkdir: illegal option -- -` and a `usage:` line.
  `git --help` printed its usage normally.
- `man ls | col -b | head` showed the `LS(1)` manual page.

### Disclosures

- **Path substitution.** In the primer, the home path in the
  `ls ~/shell practice` error is printed as `/Users/jane/...`,
  following the primer's existing convention. The real run used
  a scratch path. Everything else in that line is verbatim.
- **`ls` layout.** `ls data` was captured with output piped,
  not on a terminal, so each name is on its own line. In an
  interactive terminal, `ls` prints names in columns. The order
  shown is the observed BSD order.
- **Interactive keys not run.** Ctrl-C, the up arrow, Tab,
  paging in `less`/`man` with Space and `q`, and the bash `>` and
  zsh `quote>` continuation prompts were not run, because they
  need an interactive terminal. They are standard shell
  behavior.
- **Not tested here (documentation only).**
  - Windows: opening WSL2 from the Start menu
    (<https://learn.microsoft.com/en-us/windows/wsl/install>,
    already cited as `mswslinstall2024`).
  - Git Bash as the Happy Git target shell
    (<https://happygitwithr.com/shell.html>, `bryanhappygit`).
  - The PowerShell `ls` alias (Get-ChildItem page, Notes:
    'Windows: ls';
    <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem>).
    I opened only that page, so the text claims only `ls`, not
    `cd` or `rm`.
  - The RStudio Terminal
    (<https://docs.posit.co/ide/user/ide/guide/tools/terminal.html>
    for New Terminal and Alt+Shift+R;
    <https://happygitwithr.com/shell.html> for Tools > Global
    Options > Terminal).
  - The Positron Terminal (<https://positron.posit.co/layout.html>
    says only that the Panel 'contains ... the Console as well
    as the Terminal'). I found no documented menu path or
    shortcut, so none is printed.
  - The macOS Terminal, from Apple's 'Open or quit Terminal'
    page. That page is cited by URL inline, because there is no
    bib key.
- **No time estimate.** The brief's 'five-minute exercise' is
  not printed as a duration, because the time is unsourced
  (rule 4).

## R4-014: Reading YAML

Lines 424-513 of `shell-primer.qmd` hold a new
`## Reading YAML {#sec-shell-yaml}` section. It has an
annotated example covering mapping, nesting, a list, quoting
(`'1.10'`), comments and a `|` block scalar. Five rules follow,
then the real parse, a mis-indented variant with its real error,
and the tab error. The YAML 1.1 `no`-as-FALSE case was tested
but left out, because it is specific to the parser.

Runs: `yaml` 2.3.12, `env RENV_CONFIG_AUTOLOADER_ENABLED=FALSE
Rscript`, host library, no installs. The example was saved as
`report.yml` and the mis-indented variant as `bad.yml`.

```
> str(yaml::read_yaml('report.yml'))
List of 6
 $ title  : chr "Cohort report"
 $ draft  : logi FALSE
 $ version: chr "1.10"
 $ format :List of 2
  ..$ html:List of 1
  .. ..$ toc: logi TRUE
  ..$ pdf :List of 1
  .. ..$ toc: logi FALSE
 $ params :List of 2
  ..$ sites  : chr [1:2] "Boston" "San Diego"
  ..$ min_age: int 18
 $ notes  : chr "Synthetic data only.\nNo identifiers."
> str(yaml::yaml.load('version: 1.10'))
List of 1
 $ version: num 1.1
> yaml::read_yaml('bad.yml')
Error in yaml.load(string, error.label = error.label, ...) :
  (bad.yml) Parser error: while parsing a block mapping at line 2,
  column 3 did not find expected key at line 4, column 4
> yaml::yaml.load('format:\n\thtml: default')
Error ... Scanner error: while scanning for the next token at
  line 2, column 1 found character that cannot start any token
  at line 2, column 1
> str(yaml::yaml.load('answer: no'))
 $ answer: logi FALSE        (tested; not printed in the book)
```

In the book, the error message is wrapped across `#>` lines to
fit 78 characters; the words are verbatim.

The tab error is quoted in the book only by its phrase `found
character that cannot start any token`.

The example uses the place names 'Boston' and 'San Diego' and no
personal data.

### Proposed glossary entry (for the lead)

> **YAML.** A plain-text format for configuration data, built
> from key-value pairs (`key: value`), lists (lines beginning
> `- `), and nesting expressed by indentation with spaces. It
> carries Quarto document headers, CI workflow files,
> `CITATION.cff`, and `zzcollab.yaml`. Unquoted values are typed,
> so `1.10` is read as a number; quote values meant as text. See
> [Reading YAML](shell-primer.qmd#sec-shell-yaml).

No bib entries are proposed. The primer cites only existing keys
(`swcarpentry2024shell`, `mswslinstall2024`, `bryanhappygit`).
New sources are linked by URL inline.

## R4-013: Machine checklist

Lines 14-38 of `setup-appendix.qmd`: the intro gains one
sentence, and a new `## Machine checklist {#sec-setup-checklist}`
follows, with table `tbl-machine-checklist`. It has eight rows:
R, RStudio or Positron, git, Quarto, TeX, Typst, Docker and
make. The 'Success looks like' column describes each output's
shape and never prints a version number. 'First needed' uses
chapter cross-references, with `@sec-dependencies` for `make`
because of `make check-renv`.

Check commands run on this Mac (verified):

| Command | Real output (first line or relevant lines) |
|---|---|
| `R --version` | `R version 4.6.2 (2026-10-29) -- "Diversified Portfolio"`, then copyright and license lines |
| `git --version` | `git version 2.56.1` |
| `quarto --version` | `1.11.9` (a bare number) |
| `quarto check` | `[✓] Checking LaTeX....OK`, `Using: TinyTex`, `Path: .../TinyTeX/bin/universal-darwin`, `Version: 2026` |
| `quarto typst --version` | `typst 0.15.1 (9dfd3a08)` |
| `docker version` | `Client:` block (`OS/Arch: darwin/arm64`) and `Server: Docker Desktop 4.98.0` block (`OS/Arch: linux/arm64`) |
| `make --version` | `GNU Make 3.81`, then copyright lines |

Not run:

- **RStudio check.** RStudio is not installed on this Mac
  (`/Applications/RStudio.app` is absent). Positron is
  installed, but the 'open the application' check is a GUI
  step and was not run.
- **`make` on Windows.** The 'distribution's package manager
  inside WSL2' route is untested, and no source page was
  opened for it.

Design choices for the lead:

- `docker version` is used rather than `docker --version`. The
  latter succeeds even when the daemon is down; the former
  matches the appendix's own step 1.
- `quarto check` is used for TeX rather than `xelatex --version`.
  The reason is documentation, not a test: Quarto's PDF-engine
  page says `quarto install tinytex` does not put TinyTeX on the
  PATH.

Install URLs opened (curl, HTTP 200 after redirects):

- <https://cran.r-project.org/>
- <https://posit.co/download/rstudio-desktop/>, which redirects
  to `docs.posit.co/ide/user/`, a page with a download section.
- <https://positron.posit.co/download.html>
- <https://git-scm.com/downloads>
- <https://gitforwindows.org/>
- <https://quarto.org/docs/get-started/>
- <https://quarto.org/docs/output-formats/pdf-engine.html>,
  which contains `quarto install tinytex`.
- <https://quarto.org/docs/output-formats/typst.html>
- <https://docs.docker.com/get-started/get-docker/>, which
  redirects to `docs.docker.com/get-docker/`.
- <https://developer.apple.com/documentation/xcode/installing-the-command-line-tools/>.
  The page title is 'Installing the command-line tools'. The
  body is rendered by JavaScript, so its text was not read.

<https://www.gnu.org/software/make/> failed with curl TLS error
35 and is not used.

Not done (out of my files or scope): the 'Before you run this'
boxes for Chapters 10 and 11, the Apptainer note for Chapter 8,
Rtools, and a Linux section.

## RA-01: anchors for the lead to link

| Heading | Link target |
|---|---|
| Machine checklist (new) | `setup-appendix.qmd#sec-setup-checklist` |
| Apple Silicon (M-series Mac) | `setup-appendix.qmd#sec-setup-apple` |
| Windows with WSL2 | `setup-appendix.qmd#sec-setup-wsl` |
| Locked-down institutional laptops | `setup-appendix.qmd#sec-setup-locked` |
| Diagnosing a failed or unexpectedly slow build | `setup-appendix.qmd#sec-setup-diagnose` |
| Primer: Opening a terminal | `shell-primer.qmd#sec-shell-open` |
| Primer: Getting unstuck | `shell-primer.qmd#sec-shell-unstuck` |
| Primer: Reading YAML | `shell-primer.qmd#sec-shell-yaml` |

All of these are on unnumbered pages, so link them as
`[text](file.qmd#anchor)`, never as `@sec-`.

## RA-04: Rosetta (done)

One sentence was added to step 3 of the Apple Silicon section,
at lines 82-87 of `setup-appendix.qmd`. It names the setting
exactly as Docker's settings page gives it (General tab): 'Use
Rosetta for x86_64/amd64 emulation on Apple Silicon',
'(Available with the Apple Virtualization framework VMM)',
described as 'Accelerate x86/AMD64 binary emulation on Apple
Silicon'
(<https://docs.docker.com/desktop/settings-and-maintenance/settings/>,
fetched 2026-11-25). The sentence makes no speed figure or
default-state claim. The page lists its default as 'Disabled',
which may differ by version, so it is not printed. The existing
QEMU sentences are unchanged.

## Notes for the lead

- **Word budget.** The added text is about 2,000 words by
  `git diff --word-diff` count, over the 1,500 target. That
  count includes code blocks, R output, URLs and table cells.
  The prose alone is closer to the budget. The largest single
  item is the YAML page, at about 600 words including code.
- **Missing anchor.** The 'Project-oriented paths' heading in
  `03-research-compendium.qmd` (line 972) has no anchor, so the
  primer can only point to `@sec-compendium`. I propose
  `{#sec-here-paths}`, after which the primer could link that
  section directly.
- **Stale title.** The setup appendix's page title still reads
  'Docker and Git on Your Own Machine'. The page now opens with
  a checklist for every tool, so the lead may want to retitle
  it. I did not change the title because the table of contents
  and other chapters show it.
- **Version mismatch.** This Mac's git is now 2.56.1, while the
  appendix's git preflight still cites 2.56.0 as observed on
  2026-11-08. That text records a dated run, so I did not
  change it.
