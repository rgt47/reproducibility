# Reviewer G: appendices, structure, and cross-cutting analysis
*2026-11-25 17:58 PST*

## Summary

The appendices are individually competent and in places exemplary
(the git refusals table, the computed colophon, the generated
cheat-sheet index). As a system for the stated reader they fail. The
book's own Welcome page still states the old prerequisites
(command-line and basic git comfort), which exclude the student the
fourth-review brief describes. The shell primer that is meant to close
the gap has no inbound link from any chapter, from the preface, or
from 'How to use this book'. It sits after the References and does
not show a never-terminal user how to open a terminal, which shell to
use on Windows, or what YAML is. The Docker half of the setup
appendix is linked once, from inside a callout. The zzcollab
dependence is moderate, and the principle-first wording has largely
been achieved. Two problems remain: the author's authorship of
zzcollab and zzrenvcheck is nowhere stated, and several zzcollab
coinages (Five Pillars, archetypes, profiles, progressive disclosure)
are taught and glossed as general vocabulary. The health framing is
thin in density (about 1 to 5 hits per 1,000 prose words) but
concentrated where a non-health student meets it first. R, by
contrast, is structural. I recommend narrowing the stated audience to
R users explicitly and keeping the health focus with explicit bridges,
rather than broadening.

## Strengths

- The git refusals table (setup-appendix.qmd:278-289) is indexed by
  the verbatim message, dated, and honest about the two rows that
  were not reproduced. A novice can use it.
- The colophon computes its own table and prose from one execution
  and states the R 4.6.0 versus locked 4.6.1 mismatch openly (frozen
  output in `_freeze/colophon/execute-results/html.json`).
- The cheat-sheet index is generated from the chapters' own tables,
  so it cannot drift (cheat-sheet-index.qmd:12-58).
- The shell primer chooses its content well for what it covers:
  relative versus absolute paths tied to `here`, `>` versus `>>`,
  environment-variable inheritance tied to the renv autoloader, and
  the zsh unmatched-glob trap (shell-primer.qmd:261-281).
- Dated facts are mostly stamped with the date they were checked
  ('run 2026-11-08', 'as stated ... on 8 November 2026'). This is the
  right instinct for currency.
- Chapter 12 states the dependency gate as base R plus renv before it
  names zzrenvcheck or `zzc verify` (09-continuous-integration.qmd:485-510,
  1094-1120). That is the right order: principle first, then tool.

## Findings

### The book's stated prerequisites exclude the stated reader
- Location: index.qmd:51-55
- Quote: 'Comfort at the command line: running a shell command, editing a text file, and using `git` at a basic level.'
- Severity: blocking
- Viewpoint: student
- Evidence: inspected
- Prior: new (the audience parameter changed: THIRD-REVIEW-PLAN.md:36 fixed the reader as knowing R and basic git; the fourth-review brief does not; this is not a reopened decision)
- Problem: The Welcome page requires command-line comfort, basic git, and the ability to render R Markdown or Quarto. The intended reader has used R in one course and has never opened a terminal. shell-primer.qmd:4-7 contradicts the Welcome page: it says the primer supplies this prerequisite.
- Why it matters: A student who reads the Welcome page concludes the book is not for them, and a mentor reads it as confirmation that the book needs training the student lacks.
- Fix: Replace the list with: 'R from one course: running a script and installing a package. No terminal, git, Docker, or Quarto experience is assumed; the Shell Primer (@sec-shell) and the Setup Appendix (@sec-setup) take you from a first terminal to a first commit.' Drop 'rendering an R Markdown or Quarto document', since Chapter 9 teaches it.

### The shell primer is unreachable from the text
- Location: shell-primer.qmd:3-7; preface.qmd:141-152; 00-intro.qmd:316-330
- Quote: 'The book assumes a reader can already type these and read what comes back.'
- Severity: blocking
- Viewpoint: student
- Evidence: inspected (`grep -n -i primer *.qmd` and a newline-joined search for 'shell primer' or 'sec-shell' in every .qmd file: the only hits are contents.qmd:45 and the primer itself)
- Prior: new (REFACTOR-PLAN added the primer; no review checked inbound links)
- Problem: No chapter, no chapter card, neither the preface nor the 'How to use this book' section, and not the Conventions page links to `@sec-shell`. version-control.qmd has 192 lines of shell in bash-fenced blocks, and its prerequisites point to the git preflight but not to the primer (version-control.qmd:54-64).
- Why it matters: The reader who most needs the primer cannot find it at the moment they need it, at the first `git init` in Chapter 4.
- Fix: Add '@sec-shell, if you have not used a terminal' to the prerequisites of version-control.qmd, 03-research-compendium.qmd, 05-containers.qmd and pipelines.qmd. Add one paragraph to 'How to use this book' (00-intro.qmd:316) that names the primer and the setup appendix as the first hands-on step. Add a sentence to conventions.qmd:17-22 that points to the primer.

### Novice prerequisites are placed after the References
- Location: _quarto.yml:78-82
- Quote: '- references.qmd'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The book order is Chapter 13, then References, then Appendix A, the shell primer, then the setup appendix. Back matter is where readers look for reference material, not for a step to take before Chapter 4.
- Why it matters: Even a reader who knows the primer exists meets it after roughly 600 pages, with nothing in the sequence marking it as a prerequisite.
- Fix: Move both files into an unnumbered 'Getting set up' part placed before Part I or immediately before version-control.qmd, and keep a pointer in the appendices. If they stay where they are, at least list them in the preface under 'Before you begin'.

### The shell primer omits the first-contact skills and Windows
- Location: shell-primer.qmd:13-23
- Quote: 'A shell session has a current working directory, the folder commands act on by default.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (grep for 'Terminal.app', 'PowerShell', 'Git Bash', 'Ctrl-C', 'mkdir', 'nano' across all .qmd: no instructional hits)
- Prior: new
- Problem: The primer starts at `pwd`. It never says how to open a terminal on macOS, Windows, or Linux. It never says which shell a Windows user should use (Git Bash, WSL2, or PowerShell, which aliases `ls`, `cd`, `rm` with different behavior and has no `export` or `chmod`). It also omits several basics the book's own commands need: `mkdir` (used at 03-research-compendium.qmd:1429), `cat`/`less`, `--help`/`man`, Ctrl-C to stop a command, tab completion and history, quoting paths with spaces (common in synced folders), `~` and `$HOME` (used at shell-primer.qmd:210 without definition), and how to recognize the prompt.
- Why it matters: A Windows student who opens PowerShell and types the primer's commands gets partial success and baffling errors on the first page.
- Fix: Add an opening section, 'Opening a terminal', with one short paragraph per OS. Recommend one shell for Windows (WSL2, to match setup-appendix.qmd:66-113, or Git Bash for git-only chapters) and say that PowerShell is not supported by the book's commands. Add a four-row 'getting unstuck' table: Ctrl-C, up-arrow, Tab, `command --help`. Add `mkdir`, `cat`, and quoting to the file-operations section.

### YAML is required but never taught
- Location: 09-continuous-integration.qmd:52-53
- Quote: 'enough comfort reading YAML to follow a workflow file line by line; no YAML is written from scratch here.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`grep -n YAML *.qmd`: 11 uses, no definition or syntax explanation; the glossary has no YAML entry)
- Prior: new
- Problem: YAML carries the Quarto headers (Chapter 9), the GitHub Actions and GitLab files (Chapter 12), `CITATION.cff` (Chapter 13), and `zzcollab.yaml` (Chapter 5). The book never explains key-value pairs, lists, indentation sensitivity, or quoting.
- Why it matters: Indentation errors in workflow files are among the most common failures a first-time CI user hits, and the book's prerequisite assumes a skill it does not supply.
- Fix: Add a one-page 'Reading YAML' section to the shell primer, with a six-line example annotated for mapping, list, nesting, and quoting. Add a glossary entry and link the Chapter 12 prerequisite to it.

### The setup appendix covers Docker and git, not the toolchain a novice must install first
- Location: setup-appendix.qmd:1-15
- Quote: 'Setup Appendix: Docker and Git on Your Own Machine'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new (Finding 39 added git; installing R, Quarto, and a TeX distribution and the Linux case were never in scope)
- Problem: Nothing tells a novice how to install R, an editor (RStudio or Positron), Quarto, renv, a TeX distribution for PDF (Chapter 9), or Docker itself. There is no Linux section: Docker Engine, the `docker` group's root-equivalence, and rootless mode are not covered. Step 1 assumes Docker Desktop is already installed.
- Why it matters: The 'Before you start' cards state chapter prerequisites but never machine prerequisites, so a student discovers missing software chapter by chapter.
- Fix: Open the appendix with a 'Machine checklist' table: one row per tool, the chapter that first needs it, the official install page, a one-line check command with expected output (`R --version`, `quarto check`, `git --version`, `docker version`), and 'not needed until Chapter N'. Add a short Linux section.

### The Docker half of the setup appendix is barely signposted
- Location: 05-containers.qmd:852-860
- Quote: 'the [setup appendix](setup-appendix.qmd) covers such locked-down machines.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (newline-joined grep: the only chapter link to the appendix's Docker sections is this one, inside the FDA Pilot 4 callout)
- Prior: new
- Problem: Chapter 7's card says that no Docker background is assumed, but it does not say where to install Docker or what to do on Apple Silicon or Windows. Chapters 8, 12 and 13 run Docker commands and never link the appendix's diagnosis table.
- Why it matters: The first failed `docker build` is when a novice gives up, and the right table is two clicks away but unannounced.
- Fix: In the Chapter 7 card add: 'Docker must be installed and running; see @sec-setup, including the Apple Silicon and Windows sections.' Link the diagnosis table from the first `docker build` in Chapters 7 and 13. Give the Docker sections anchors (`#sec-setup-apple`, `#sec-setup-wsl`, `#sec-setup-diagnose`) so that they can be cross-referenced.

### The Rocker architecture claim is stale for the book's own R version
- Location: setup-appendix.qmd:23-27
- Quote: '`rocker/tidyverse` and `rocker/verse` at 4.4.0, the bases of the tidyverse and publishing profiles, publish a `linux/amd64` entry only'
- Severity: major
- Viewpoint: referee
- Evidence: verified (Docker Hub API, fetched 2026-11-25: `hub.docker.com/v2/repositories/rocker/tidyverse/tags/4.4.0` lists amd64 only; `.../rocker/tidyverse/tags/4.6.1` lists amd64 and arm64; `.../rocker/verse/tags/4.6.1` lists amd64 only; `.../rocker/tidyverse/tags/latest` lists amd64 and arm64, updated 2026-11-16. Read through a summarizing fetch tool)
- Prior: new (Finding 30 and T1-4 addressed digests, not this per-image claim)
- Problem: The statement is true for 4.4.0. For the R version the book's lockfile records (4.6.1), however, `rocker/tidyverse` now publishes arm64 and `rocker/verse` does not. Step 2 (lines 39-46) generalizes from the 4.4.0 case, so a student on 4.6.1 with the tidyverse profile is told that a build without the flag will fail, when in fact it succeeds natively and silently.
- Why it matters: The appendix's purpose is to predict what a Mac student sees, and here it predicts the wrong behavior for the current image.
- Fix: Replace the per-image claim with a check: 'Run `docker buildx imagetools inspect rocker/verse:<version>`; if no `linux/arm64` line appears, the flag is required.' Give 4.4.0 as a dated example, and keep the rule that the book always passes `--platform linux/amd64`.

### Docker Desktop licensing is not mentioned
- Location: setup-appendix.qmd:141-151
- Quote: 'Ask specifically for Docker Desktop.'
- Severity: major
- Viewpoint: mentor
- Evidence: verified (docs.docker.com/subscription/desktop-license/, fetched 2026-11-25: free use is limited to 'Small businesses (fewer than 250 employees AND less than $10 million in annual revenue)', 'Personal use', 'Education', and 'Non-commercial open source projects'; read through a summarizing fetch tool)
- Prior: new (the glossary's Podman entry, glossary.qmd:471-473, alludes to licensing; the appendix does not)
- Problem: The appendix tells the student to ask IT for Docker Desktop without saying that it is licensed software. Whether research at a university hospital or a large institution counts as 'Education' is a question for the institution. 05-containers.qmd:851 itself reports that FDA reviewers met an 'unlicensed Docker Desktop' barrier.
- Why it matters: IT departments in large academic medical centers often refuse requests on exactly this ground, and a student who does not know it cannot pre-empt the refusal.
- Fix: Add two sentences: 'Docker Desktop is free for education and small organizations but requires a paid subscription in larger ones; ask IT which applies. If it does not, Podman Desktop, or Docker Engine on Linux or WSL2, runs the same images (@sec-backends).'

### The author's authorship of zzcollab and zzrenvcheck is not disclosed
- Location: preface.qmd:57-71; credits.qmd:3-10; glossary.qmd:871-873
- Quote: 'The choice is deliberate and, we hope, honestly motivated.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (newline-joined grep across all .qmd and references.bib for 'we wrote', 'we developed', 'our tool', 'author of', 'install zzcollab' and the zzcollab repository URL: no hits. The bib entry `thomas2026zzcollab` lists the same 'rgtlab curriculum team' as the book, and 09-continuous-integration.qmd:802 calls zzrenvcheck a package from 'a personal repository' without naming whose)
- Prior: new
- Problem: The preface defends the choice of zzcollab but never says that the book's authors wrote it, or that they wrote zzrenvcheck, which the CI examples install. Credits calls zzcollab 'The framework at the center of this book', which is stronger than the preface's 'concepts first, tool second'. The book's only source for the Five Pillars and the archetypes is an unpublished manuscript by the same team (03-research-compendium.qmd:633, 1022).
- Why it matters: A skeptical mentor or referee who discovers the authorship independently will discount the whole book. The book's own LLM-disclosure discipline makes the omission conspicuous.
- Fix: Add to the preface's 'The tool, and why it is here': 'zzcollab and its companion zzrenvcheck are written and maintained by the authors of this book. Every chapter states the principle first and shows how to do it without them.' Replace 'at the center of this book' in credits with 'the running example's framework'. Add a 'written by the authors' note to the glossary entries for zzcollab and zzrenvcheck, and an install pointer (repository URL and a pinned version).

### The promised 'With zzcollab' track does not exist, and worked examples depend on the tool
- Location: 03-research-compendium.qmd:1428-1462; 05-containers.qmd:1330-1361; 10-archiving-sharing.qmd:1370-1373
- Quote: '$ zzc analysis  # tidyverse base-image profile; archetype set separately'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`grep -i 'with zzcollab'` finds nothing; conventions.qmd:86-124 lists three callout kinds and no tool box; the make targets exist in zzcollab's templates/Makefile:134-402, and the book never shows their definitions)
- Prior: D2 (REFACTOR-PLAN: 'Concepts first, with a 'with zzcollab' track in boxed sections') implementation incomplete; this does not reopen the decision
- Problem: The tool content is interleaved with the prose ('In the framework this book uses'), not separated into a skippable box. The worked examples in Chapters 5, 7 and 13 run `zzc`, `make docker-build`, `make docker-test`, `make docker-render` and `make r` with no equivalent the reader can type. The book never says how to install `zzc`. A reader without the tool can follow every chapter's principles, but not these worked examples.
- Why it matters: The worked example is where a novice imitates, and the book gives them commands they cannot run.
- Fix: Implement D2 as decided: put every `zzc` and zzcollab make-target block in a callout titled 'With zzcollab', paired with a 'By hand' block. For example, after 03:1450, 'By hand: `Rscript -e "tinytest::test_package(...)"`; `R CMD build . && R CMD check *.tar.gz`'. Add the device to conventions.qmd and an install pointer to the setup appendix.

### zzcollab coinages are taught and glossed as general vocabulary
- Location: 03-research-compendium.qmd:625-633; glossary.qmd:27-30, 498-504, 778-780
- Quote: 'The `zzcollab` framework organizes these as the Five Pillars.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected ('pillar' 86 hits and 'archetype' 92 hits in 03-research-compendium.qmd; 'profile' 22 in 05 and 12 in 07; glossary entries Archetype, Profile, Progressive disclosure, The Five Pillars, and Baseline test with the `test-baseline-*.R` naming rule)
- Prior: new
- Problem: Five Pillars, the five archetypes, profiles, progressive disclosure, and the `test-baseline*.R` naming rule are zzcollab's design vocabulary. The chapters and the glossary present them unmarked, as if they were field terms. 'Progressive disclosure' already has an established, different meaning in interface design. The tool itself now accepts six archetypes (zzcollab modules/config.sh:573 lists `book`), while the book and glossary say five.
- Why it matters: A student will use these words with a mentor or reviewer who has never heard them, and a referee will read the chapter as tool documentation.
- Fix: Tag each such glossary entry '(zzcollab term)' and give the field-neutral equivalent where one exists: compendium components; project type; base-image choice; 'grows without restructuring'. In Chapter 5, state the pillars as 'what any compendium must capture', and attribute the name to zzcollab once.

### Health and R framing against a broader stated audience: recommendation
- Location: index.qmd:60-62; preface.qmd:15-23; _quarto.yml:22-23
- Quote: 'The reader we have in mind is a graduate student or working analyst in public health, biostatistics, epidemiology, or a related quantitative health science.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (structural counts in the 'Audience analysis' section below)
- Prior: new (the audience parameter changed; THIRD-REVIEW-PLAN.md:36 and REFACTOR-PLAN D11 assumed a health audience)
- Problem: The persuasive evidence is already multi-field: psychology, oncology, Dataverse, OSF (00-intro.qmd:94-125). The orientations, running example, restricted-data material, and regulated material, however, are biomedical, and R is structural in every hands-on chapter. A student in physics or engineering who works in Python, MATLAB, or Julia is lost from Chapter 6 onward.
- Why it matters: Without an explicit decision, the title and the course brief promise different books to different readers.
- Fix: Narrow and bridge. (1) State the audience as 'empirical researchers who analyze data in R; examples are drawn from the health sciences'. (2) Add an appendix, 'Translating the tools', with one row per capture point: renv against uv or pip-tools, conda-lock, Stata `version`; tinytest against pytest; knitr against Jupyter and Quarto with Python; targets against Snakemake. (3) Add one non-health case per persuasive chapter. Reasons: health terms are thin in density (1 to 5 per 1,000 words) and easy to bridge locally. R is woven through every chapter, so broadening to other languages would be a rewrite.

### Restricted-data and regulated material has no bridge for other kinds of sensitive data
- Location: _llm-rule.qmd:4-11; version-control.qmd:730-935; 10-archiving-sharing.qmd (TRE, NIH DMS, HIPAA sections)
- Quote: 'Never paste or upload protected health information, identifiable records, or data held under a data use agreement'
- Severity: major
- Viewpoint: student
- Evidence: inspected (grep for 'export control', 'proprietary', 'ITAR': at most one passing hit per chapter; HIPAA, IRB, DUA and PHI cluster in version-control.qmd and 10-archiving-sharing.qmd)
- Prior: new
- Problem: The restricted-data guidance is framed through PHI, HIPAA, NIH and FDA. Psychology and economics students hold human-subjects and administrative data under IRB and licensing terms; engineering and physics students hold export-controlled or industry-proprietary data. Neither case is named. The journal-policy table (10-archiving-sharing.qmd:1116-1127) lists three biomedical and statistics journals only.
- Why it matters: The student outside health concludes that the book's most careful guidance does not apply to them, though most of it does.
- Fix: Add one paragraph to the shared include and to Chapter 13: 'The same rule governs any data released under terms: survey microdata under a license, administrative records, export-controlled or partner-proprietary data.' Add one row each for a social-science journal (for example, the AEA data editor policy) and an engineering or physics venue to the journal table, after verifying each.

### Acronyms used without expansion
- Location: 01-reproducibility-crisis.qmd:680 (and the list in 'Acronym audit' below)
- Quote: 'specifically the BLAS and LAPACK implementation that performs the singular value decomposition'
- Severity: major
- Viewpoint: student
- Evidence: inspected (script pass over prose outside code blocks, then hand-checked first use against first spelled-out form for each acronym listed)
- Prior: new
- Problem: CRAN (34 uses), BLAS (33), LAPACK (9), NIH (13), FDA (6), CFR (7), HIPAA (2), QEMU (5), and SHA (9) are never expanded. IRB first appears through the shared LLM include in Chapter 2, before any chapter explains it. CI (about 170 uses) appears from Chapter 2 on, but is expanded only in Chapter 12's vocabulary (09-continuous-integration.qmd:268). WSL appears at 05-containers.qmd:850, before its expansion at 06-backends-runtimes.qmd:542.
- Why it matters: For a non-biostatistics novice, CRAN, BLAS, IRB and NIH are not self-evident, and an unexpanded acronym in a persuasive chapter reads as insider talk.
- Fix: Expand each at first use in book order, and add glossary entries for CRAN, BLAS/LAPACK, IRB, PHI, DUA, NIH, FDA, HIPAA, QEMU and SHA-256. Add a lint to `test-manuscript-invariants.R` that flags any all-caps token whose first occurrence in book order has no parenthetical expansion, with an allowlist.

### Glossary 'Tag and digest' contradicts the index-digest fix
- Location: glossary.qmd:745-749
- Quote: 'A digest, `@sha256:...`, is an immutable hash of the image's exact content. The same digest always denotes the same bytes.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (05-containers.qmd:591, 971, 1762, 2077 now distinguish index and manifest digests)
- Prior: fix for Finding 30 (T1-4) incomplete
- Problem: The glossary still says a digest denotes one set of bytes. The chapter now says that the pinned index digest resolves to different per-platform filesystems. The `docker pull and docker inspect` entry (glossary.qmd:211-213) also presents `docker inspect` as the way to read the digest to pin, while the chapter's cheat sheet (05:2077-2078) says to use `docker buildx imagetools inspect` and warns that the local digest may be stale.
- Why it matters: The glossary restates the exact claim the third review classed Tier 1.
- Fix: Rewrite as: 'A digest is a hash of content. An index digest names one entry per platform, so the same index digest can yield different filesystems on arm64 and amd64; pin the index and pass `--platform linux/amd64` (@sec-containers).' Point the inspect entry to `docker buildx imagetools inspect`.

### Glossary `digest()` contradicts Chapter 12
- Location: glossary.qmd:193-196
- Quote: 'Used to verify that a regenerated computational output matches a recorded one, on objects rather than on rendered documents.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (09-continuous-integration.qmd:1276-1280 shows that serialized-object hashes change with class; 09:2559 calls `digest()` 'the wrong tool for a floating-point estimate')
- Prior: fix for Finding 33 (Chapter 9 and 12 hashing as verification) incomplete in the glossary
- Problem: The glossary recommends exactly what the chapter now rejects.
- Why it matters: A student who looks up the term learns to verify results by hash, which fails on harmless floating-point differences.
- Fix: 'Computes a hash of a file's bytes or an R object's serialization. Use it with `file =` to detect changed raw data; do not use it to compare estimates, which need a tolerance (@sec-testing).'

### The glossary lacks the terms a novice needs most
- Location: glossary.qmd:3-8
- Quote: 'together with the commands, functions, tools, and services the book relies on.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (no entry headed Dockerfile, YAML, shell, terminal, working directory, path, environment variable, `here`, Makefile, PHI, IRB, data use agreement, LLM, hash, emulation, Monte Carlo standard error, tolerance, CITATION.cff, Software Heritage, CRAN)
- Prior: new
- Problem: The glossary's 164 entries come from the chapters' vocabulary boxes, so it holds the book's coinages and misses the prerequisites the book assumes. It has no Dockerfile entry, though 'Dockerfile' is a Five Pillars item.
- Why it matters: The glossary is where a lost novice turns, and the words that lose them are absent.
- Fix: Add the listed entries, each pointing to the shell primer, the setup appendix, or the chapter that uses the term.

### One-semester load and a minimum viable path
- Location: conventions.qmd:180-202; preface.qmd:125-139
- Quote: 'The book is written for a one-quarter, ten-week course.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`wc -w`; chapter cards); inferred for reading rates
- Prior: 'Reopens D18' and D3, with a new argument: both decisions assumed a reader who already knows R and basic git (THIRD-REVIEW-PLAN.md:36), and the fourth-review reader does not. That reader must add the primer, the setup work, and first-contact debugging to the same ten weeks
- Problem: The core path keeps 11 of 13 chapters, about 145,000 words including code and exercises (about 14,500 a week). The card times for the core path sum to about 570 minutes at 200 words a minute; at a more realistic 100 to 150 words a minute for technical prose, that is 13 to 19 hours, before about 95 exercises and all installation. No path is offered for a student who wants the benefit without the course.
- Why it matters: The skeptical mentor's objection, 'this takes too long', is answered by a short path the book does not offer.
- Fix: Add the 'minimum viable path' below to the preface as a second, labeled path. It builds on the core path and cuts nothing from the book.

### The shell primer's first sentence is inaccurate
- Location: shell-primer.qmd:3-4
- Quote: 'Every chapter in this book runs commands at a shell prompt'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (00-intro, 01, and 02 contain no bash-fenced block)
- Prior: new
- Problem: The first three chapters run no shell commands, by design.
- Why it matters: It tells the novice that the terminal is a barrier from page one, which works against the persuasion-first design.
- Fix: 'From Chapter 4 on, the book runs commands at a shell prompt.'

### Hard-coded chapter numbers in the shell primer
- Location: shell-primer.qmd:36, 59, 197
- Quote: 'the `.here` marker Chapter 5 relies on'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new (REFACTOR-PLAN recorded fixing these numbers once; they remain typed)
- Problem: 'Chapter 5' and 'Chapter 12' are typed, not cross-referenced, and have already been wrong once.
- Fix: Use `@sec-compendium` and `@sec-verification` (with a section anchor for project-oriented paths).

### 'Subshell' is the wrong term for a child process
- Location: shell-primer.qmd:184-190
- Quote: '#> in subshell: hello'
- Severity: minor
- Viewpoint: referee
- Evidence: inferred (in bash, a subshell is `( ... )`, a fork that inherits unexported variables too; `bash -c` starts a new child shell, which inherits only exported ones)
- Prior: new
- Problem: The example demonstrates export to a child process but labels it a subshell, the one context in which unexported variables are also visible.
- Fix: Change the label to 'in child shell' and the prose to 'child process'.

### The appendices have no checks or exercises
- Location: shell-primer.qmd (whole file); setup-appendix.qmd (whole file)
- Quote: 'This appendix supplies that prerequisite for a reader who has not yet acquired it.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: Every chapter has folded checks and exercises; the primer, which a novice needs to practice most, has none.
- Fix: Add three folded checks (predict the output of `cd ../..` then `pwd`; `>` versus `>>`; why `rm *.csv` in the wrong folder is not harmless) and one five-minute exercise that builds a toy compendium tree with `mkdir`, `cd`, and `ls -a`.

### The locked-down-laptop route depends on an optional chapter
- Location: setup-appendix.qmd:123-139
- Quote: '@sec-backends already covers GitHub Codespaces'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (conventions.qmd:197 marks Backends and Runtimes as optional)
- Prior: new
- Problem: The fallback for students without admin rights is in the one chapter the core path tells them to skip.
- Fix: Add to this section a three-line Codespaces quick start (open the repository, choose 'Codespaces', wait for the devcontainer), and keep the pointer for depth.

### The setup appendix uses zzcollab vocabulary before defining it
- Location: setup-appendix.qmd:23-24
- Quote: 'the bases of the tidyverse and publishing profiles'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (profiles are defined at 05-containers.qmd:1170)
- Prior: new
- Problem: 'Profiles' is a zzcollab term that a reader using the appendix before Chapter 7 has not met.
- Fix: 'the bases a tidyverse analysis or a PDF manuscript would use'.

### The Apple Silicon section omits the Rosetta option
- Location: setup-appendix.qmd:48-55
- Quote: 'Docker's own documentation on multi-platform builds warns that QEMU emulation'
- Severity: minor
- Viewpoint: referee
- Evidence: verified, with limited confidence (docs.docker.com/desktop/settings-and-maintenance/settings/, fetched 2026-11-25 through a summarizing tool, describes 'Use Rosetta for x86_64/amd64 emulation on Apple Silicon' as an available setting, default disabled)
- Prior: new
- Problem: The appendix mentions only QEMU. Docker Desktop offers Rosetta-based emulation, which is usually faster for amd64 builds.
- Fix: One sentence: 'Docker Desktop's setting "Use Rosetta for x86_64/amd64 emulation" can shorten emulated builds; it changes speed, not the image.' Verify the setting name at revision time.

### 'Recipe' means two things, and there is no Dockerfile entry
- Location: glossary.qmd:562-563
- Quote: 'The shell command Make runs to bring a target up to date from its prerequisites.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected ('recipe' 46 times in 05-containers.qmd, meaning a Dockerfile; glossary entries for Base image, Container image, and docker build all say 'recipe' in that sense)
- Prior: new
- Problem: The only glossary definition of 'recipe' is Make's, while the glossary itself uses the word for a Dockerfile.
- Fix: Split into 'Recipe (Dockerfile)' and 'Recipe (Make)', or define 'Recipe' as 'a file of instructions that builds something: a Dockerfile for an image, a Make rule for a target'.

### Validation, verification, and capture are hard to tell apart in the glossary
- Location: glossary.qmd:71-74, 829-844
- Quote: 'Capture sets levels L0 to L2; L3 is reached by validation, which pins nothing new.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (02-levels-of-reproducibility.qmd:538-541 says rebuild and re-run without a baseline is 'L2 confirmed, not L3')
- Prior: new (Finding 41 aligned the 'capture sets the level' wording, not this pair)
- Problem: 'Validation' is defined as rebuild and re-run; 'Capture' says that validation reaches L3; 'Verification' says that passing a baseline comparison is L3. A novice combines the first two and concludes that rebuild and re-run equals L3, which Chapter 3 denies.
- Fix: Capture entry: 'L3 is reached by verification, the form of validation that compares regenerated outputs with a baseline.' Validation entry: add 'Without a baseline comparison, validation confirms L2, not L3.'

### Duplicate and overlapping glossary entries
- Location: glossary.qmd:96-99 and 262-264; 636-639 and 602-604; 645-652 and 692-704; 314-318 and 113-119
- Quote: 'The atomic unit of history.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: Commit and `git commit` repeat a sentence. Restore and `renv::restore()`, Snapshot and `renv::snapshot()`, Tag and `git tag`, tinytest and 'tinytest and testthat', and Linting, Styling, and 'lintr and styler' each cover one concept twice. RNG kind, `RNGkind()`, 'Seed and RNG kind', and `set.seed()` make four entries for one idea. Image and Container image give different contents: Image includes packages and configuration; Container image includes system libraries and the runtime.
- Fix: Merge each set into one entry, with see-also stubs.

### Misfiled glossary entries
- Location: glossary.qmd:121-133, 423-425, 665-668, 778-785
- Quote: 'The Five Pillars.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: 'Output checking' is under P; 'Controlled access' precedes 'Continuous integration'; 'R-package skin' sits after 'Rootless'; 'The Five Pillars' and 'The level ladder' are under T.
- Fix: File them under O, C (in order), R (after `R CMD check`), F, and L.

### The 'Daemon' entry oversimplifies rootless operation
- Location: glossary.qmd:138-141
- Quote: 'Docker relies on one; Podman and Apptainer do not, which is why they run without administrative rights.'
- Severity: minor
- Viewpoint: referee
- Evidence: inferred (Docker has a rootless mode; rootless Podman needs subordinate UID ranges that an administrator usually configures)
- Prior: new
- Problem: Having no daemon is neither necessary nor sufficient for unprivileged operation.
- Fix: '... do not. Both are designed to run as an ordinary user, though rootless Podman usually needs a one-time administrator setting.'

### The cheat-sheet index lists labels without meanings
- Location: cheat-sheet-index.qmd:26-47
- Quote: 'lists the first column of that chapter's cheat-sheet table.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (frozen output `_freeze/cheat-sheet-index/execute-results/html.json`: entries include 'Rule of thumb', 'Habit 1', 'Git refuses')
- Prior: new
- Problem: The index is a semicolon list of bare commands and generic row labels, with no meanings. It omits the shell primer and both setup-appendix tables, which a novice needs most often.
- Fix: Filter generic labels ('Rule of thumb', 'Habit N'). Render each chapter as a two-column table (first and second cells). Add entries for `@sec-shell`, `@sec-setup`, and `@tbl-git-refuses`.

### The render fetches its citation style from the network
- Location: _quarto.yml:147
- Quote: 'csl: https://www.zotero.org/styles/apa'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: By the book's own definition (07-literate-programming.qmd, landmines section), this is a landmine: the render reaches outside the committed material, so a changed style or an offline build changes or breaks the bibliography.
- Fix: Commit `apa.csl` to `analysis/report/` and reference it locally.

### The `$` prompt convention is inconsistent, and its example is a zzcollab command
- Location: conventions.qmd:17-22
- Quote: '$ zzc status'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (bash-fenced blocks: version-control.qmd 192 lines with no `$`; shell-primer.qmd and setup-appendix.qmd none; 03, 05, 06 and 10 use `$`)
- Prior: new
- Problem: The convention is stated but not followed, and the book's first shell example is a command most readers cannot run.
- Fix: Pick one convention and apply it everywhere (the primer's no-prompt, `#>`-output style is the better choice for copying). Change the example to `git status`.

### Objectives are labeled two ways
- Location: 04-dependencies.qmd:52; 01-reproducibility-crisis.qmd:47
- Quote: '**Objectives.** By the end of this chapter, can you:'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (seven chapters use '**By the end of this chapter you will be able to answer:**'; five use '**Objectives.**')
- Prior: new
- Fix: Use one label throughout, as conventions.qmd:39 describes.

### Each chapter spends about 2,000 words on apparatus before its first content section
- Location: for example, 01-reproducibility-crisis.qmd:35-331
- Quote: '**Reading time.** About 35 minutes.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (words before the first section after 'The vocabulary of this chapter': 1,859 to 2,624 per chapter, 13 to 21 percent; exercises, cheat sheet and further reading another 20 to 27 percent)
- Prior: new (Finding 38 noted the duplicated roadmap and Outline pairs; this is the whole front block)
- Problem: The card, a cross-chapter check, the orientation, the stack figure, 'the analyst's contribution', and the vocabulary come before the first substantive section in every chapter. For a time-pressed novice that is 10 minutes per chapter before the chapter begins.
- Fix: Add the minimum viable path's 'skip to' anchors (below). Consider moving the vocabulary box after the first content section in Part II and later chapters.

### Typed version literals and relative-time phrases will age
- Location: see the 'Aging audit' table below
- Quote: 'The fourth and most recent is Quarto'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (`_variables.yml` exists and has zero `{{< var >}}` uses in the book)
- Prior: new
- Problem: Versions such as renv 1.2.3, git 2.56.0, `actions/checkout` v7.0.1, targets 1.12.0, R 4.4.0 and 4.6.1, and Docker Desktop menu paths are typed in many places. Several phrases are relative and will become false ('most recent', 'is young', 'will change in Git 3.0').
- Fix: Keep the dated 'run on' stamps, which are correct practice, but single-source the tool versions in `_variables.yml` or compute them from `renv.lock`, and add a 'Versions this edition was checked against' table to the colophon. Replace relative phrases with dated ones ('Quarto, released in 2022').

## Audience analysis (Section 2a)

Structural counts, not a semantic judgment. These are prose words
outside code blocks. 'Health' counts health, clinical, patient, PHI,
HIPAA, IRB, biostatistics, epidemiology, biomedical, medical,
hospital, disease, NIH, FDA, CFR, pharma, regulatory, trial, diabetic,
retinopathy, cohort, hazard ratio, Cox, odds ratio, and DUA (word
boundaries; 'registry' excluded). 'Other fields' counts ecology,
psychology, economics, physics, engineering, social science,
political science, genomics, bioinformatics, astronomy, climate,
neuroscience, sociology, and geophysics.

| File | Prose words | Health | Per 1k | Other fields |
|---|---|---|---|---|
| index | 492 | 5 | 10.2 | 0 |
| preface | 1,051 | 5 | 4.8 | 0 |
| 00-intro | 2,025 | 3 | 1.5 | 2 |
| 01 crisis | 9,087 | 37 | 4.1 | 4 |
| 02 levels | 10,346 | 46 | 4.4 | 0 |
| version-control | 13,206 | 66 | 5.0 | 0 |
| 03 compendium | 12,149 | 47 | 3.9 | 1 |
| 04 dependencies | 10,360 | 16 | 1.5 | 0 |
| 05 containers | 12,842 | 18 | 1.4 | 0 |
| 06 backends | 9,229 | 23 | 2.5 | 1 |
| 07 literate | 11,811 | 28 | 2.4 | 0 |
| pipelines | 12,692 | 11 | 0.9 | 4 |
| 08 testing | 13,444 | 62 | 4.6 | 2 |
| 09 CI | 15,944 | 22 | 1.4 | 1 |
| 10 archiving | 15,344 | 55 | 3.6 | 1 |
| _llm-rule (in 12 chapters) | 239 | 5 | 20.9 | 0 |

An earlier, looser R count (the token 'R' plus renv, CRAN, tidyverse,
Rocker, knitr, tinytest, Rscript, including code) ran from 3.6 per
1,000 words (version-control, archiving) to 24 (dependencies). Python,
Julia, Stata, SAS, MATLAB and SPSS together appear 17 times, mostly in
06 and pipelines.

Where a non-health student is lost first: the Welcome page audience
sentence (index.qmd:60-62); the Chapter 2 orientation, a clinical-trial
regulatory audit (01:124-152); the epidemiology-student orientation
and the archetype table with a 'Health-sciences example' column in
Chapter 5 (03:154, 1227); 'three health scientists' in Chapter 8
(06:162); the regulated-validation section in Chapter 11
(08:1468-1599); and the TRE, NIH DMS, HIPAA, and biomedical
journal-policy material in Chapter 13. Where a non-R student is lost:
from Chapter 6 onward, every capture tool is R-specific, and no
translation table exists. The persuasive evidence itself
(00-intro.qmd:94-125) is drawn from psychology, oncology, and two
cross-disciplinary repositories, so it already serves a broad reader.

Recommendation: narrow and bridge, as in the finding above. Health is
a local framing layer and can be bridged with a sentence per site; R
cannot be bridged short of a parallel book.

## zzcollab dependence (Section 2b)

Counts are from `grep -c -i -E 'zzcollab|\bzzc\b'` (column A) and
`grep -c -i -E 'zzrenvcheck|make (check-renv|docker-|r\b|test)|zzc verify|zzc status'`
(column B); the columns overlap on `zzc verify`.

| Chapter | A | B | Classification | Followable without the tool? |
|---|---|---|---|---|
| 00 intro | 3 | 0 | Principle: why compose; honest about what zzcollab leaves unpinned | Yes |
| 01 crisis | 0 | 0 | none | Yes |
| 02 levels | 2 | 2 | Tool interface used to operationalize L3, after the principle | Yes |
| version-control | 0 | 0 | none | Yes |
| 03 compendium | 12 | 4 | Heavy: Five Pillars, archetypes, progressive disclosure, `zzcollab.yaml` in the layout tree, worked example with `zzc` and make targets | Partly: `usethis` section gives a skeleton; layout and vocabulary are tool-specific |
| 04 dependencies | 0 | 18 | Gate is the author's zzrenvcheck via `make check-renv`; a base renv `dependencies()` and `setdiff` check is shown on the cohort | Mostly |
| 05 containers | 3 | 4 | Profiles section is zzcollab's menu; worked example `zzc minimal`, `make r`; hand-written showcase Dockerfile earlier | Yes, except the worked example |
| 06 backends | 0 | 0 | none | Yes |
| 07 literate | 3 | 3 | 'Landmine' term attributed to the zzcollab playbook; `make docker-render` 'or its equivalent' | Mostly; the provenance footer step is not reproducible by hand |
| pipelines | 0 | 0 | none | Yes |
| 08 testing | 3 | 2 | `make style`/`lint` 'in the framework'; `test-baseline*.R` naming | Yes |
| 09 CI | 8 | 17 | Principle first (hand-written gate), then `zzc verify`; zzrenvcheck installed from a 'personal repository' in workflows | Yes |
| 10 archiving | 3 | 5 | `make docker-build` in worked example; `CITATION.cff` generated by zzcollab | Mostly |

Disclosure: not stated anywhere (see the finding above). No install
pointer for `zzc` exists in the book.

## Structure map (Section 5.3)

`wc -w` includes code, checks, and exercises. Objectives counted as
bullets in the card; exercises counted as 'Exercise N' headings.

| Part | Chapter (file) | Words | Card minutes | Objectives | Exercises |
|---|---|---|---|---|---|
| Front | intro (00) | 2,336 | none | none | 0 |
| I Foundations | 2 Crisis (01) | 9,674 | 35 | 5 | 8 |
| | 3 Levels (02) | 10,878 | 40 | 5 | 8 |
| | 4 Version control | 15,036 | 65 | 5 | 8 |
| | 5 Compendium (03) | 13,675 | 60 | 5 | 8 |
| II Capturing | 6 Dependencies (04) | 11,183 | 45 | 5 | 8 |
| | 7 Containers (05) | 14,007 | 55 | 5 | 8 |
| | 8 Backends (06), optional | 10,147 | 45 | 4 | 8 |
| III Validation | 9 Literate (07) | 12,733 | 50 | 5 | 8 |
| | 10 Pipelines | 13,737 | 55 | 5 | 9 |
| | 11 Testing (08) | 15,482 | 65 | 5 | 9 |
| | 12 CI (09) | 17,409 | 70 | 5 | 8 |
| IV Stewardship | 13 Archiving (10) | 16,152 | 60 | 5 | 9 |
| Appendices | Shell primer | 1,835 | none | none | 0 |
| | Setup | 2,710 | none | none | 0 |
| | Glossary | 5,126 | | | |

The '##' headings of every chapter were extracted
(script in the scratchpad; the list is in this session's transcript)
and agree with each chapter's template: card, orientation, stack,
analyst's contribution, vocabulary, content, honest level, worked
example, cohort, LLM, exercises, cheat sheet, further reading.

Sequence judgment for a novice:

- Part I is well ordered for persuasion. The first terminal command,
  however, arrives in Chapter 4 with no setup step before it (see the
  primer findings).
- Version control before the compendium is right. Testing (Chapter 11)
  arrives late given that L3, defined in Chapter 3, rests on the
  baseline test. A baseline test needs no Docker and could follow
  Chapter 6 for a student who wants L3 evidence early.
- Pipelines sit in Part III, though the chapter itself says they
  capture nothing. For a novice they are the most deferrable core
  chapter after Backends.
- Balance: Part III is about 59,000 words against Part I's about
  49,000; Chapter 12 (17,400) is the longest, and the shell primer
  (1,835) the shortest prerequisite for the longest hands-on stretch.

### Proposed minimum viable path (about four weeks, to an honest L1 plus a baseline test)

1. Introduction; Chapter 2, 'The evidence that re-execution fails'
   and 'Three words that are not synonyms'; Chapter 3, 'The ladder:
   capture sets the level, validation confirms it'.
2. Shell primer and setup appendix, git preflight only.
3. Chapter 4: 'The git model', 'Reading the history', 'What must never
   be committed', 'The remote'. Skip 'Branches, lightly' on a first pass.
4. Chapter 5: 'The directory layout, concretely', 'The README and the
   data dictionary', 'Project-oriented paths'. Skip archetypes and
   progressive disclosure.
5. Chapter 6: 'From packrat to renv' (init, snapshot, restore) and
   'The limits of renv'.
6. Chapter 9: 'The sealed render' and 'The landmines that break the
   seal'.
7. Chapter 11: 'tinytest: bare expectations' and the baseline-test
   part of 'The four kinds of test'.
8. Chapter 13: 'Sharing with the world: archiving' (Zenodo deposit).

Second pass, to L2 and L3: Chapter 7, Chapter 12, the setup
appendix's Docker sections, then the rest. Each step needs a stable
anchor so that the preface can link it.

## Signposting map (Section 5.2)

| Target | Inbound links from chapters or front matter |
|---|---|
| `@sec-shell` (shell primer) | none (contents.qmd only) |
| `@sec-setup` Docker sections | 05-containers.qmd:859 (inside a callout) |
| `#sec-git-preflight` | version-control.qmd:63, 445, 1668, 2250 |
| `#sec-git-refuses` | version-control.qmd:1669, 1707, 2250 |

## Acronym audit (Section 5.6)

First use in book order, hand-checked:

| Acronym | First use | Expanded? |
|---|---|---|
| CFR | preface.qmd:116 | never |
| BLAS, LAPACK, MKL | 01-reproducibility-crisis.qmd:680 | never |
| CI | 01-reproducibility-crisis.qmd:1027 | spelled out in prose earlier; formal '(CI)' only at 09:268 |
| IRB, DUA | _llm-rule.qmd (included from Chapter 2) | IRB never; 'data use agreement' spelled out |
| NIH | 01-reproducibility-crisis.qmd:1106 | never |
| PHI | version-control.qmd:98 (Outline) | spelled out at 263 |
| CRAN | version-control.qmd:114 | never |
| FDA | version-control.qmd:501 | never |
| WSL | 05-containers.qmd:850 | at 06-backends-runtimes.qmd:542 |
| QEMU | 05-containers.qmd:940 | never |
| YAML | 07-literate-programming.qmd:931 | never, and never explained |
| DAG | pipelines.qmd:90 (Outline) | pipelines.qmd:357 |
| SHA | 09-continuous-integration.qmd:776 | never |
| HIPAA | 10-archiving-sharing.qmd:815 | never |

Checked and fine: LLM (heading, then spelled out at 01:934), FAIR
(spelled out at 10:333; the preface links the glossary), SIF and OCI
(expanded in Chapter 8's vocabulary), MCSE (08:908), TRIPOD, SPIRIT
and CONSORT (named as guidelines in context).

## Aging audit (Section 5.4)

| Location | Phrase | Risk |
|---|---|---|
| 07-literate-programming.qmd:410 | 'The fourth and most recent is Quarto' | false when a successor appears |
| 06-backends-runtimes.qmd:542 | '`rix` is young enough that its own version must be pinned' | relative |
| 06-backends-runtimes.qmd:523 | 'Newer Nix workflows prefer a flake' | relative |
| setup-appendix.qmd:213-214 | 'with a hint that the default will change in Git 3.0' | flips when Git 3.0 ships; then version-control.qmd:442 and the preflight step 3 change too |
| setup-appendix.qmd:23-27 | Rocker 4.4.0 architecture claim | already stale for 4.6.1 (finding above) |
| setup-appendix.qmd:74-78 | Docker Desktop menu paths | user-interface drift |
| 05-containers.qmd:197, 892 | 'recent Mac' | relative |
| 02-levels-of-reproducibility.qmd:876 | 'no integrative framework that currently pins these layers' | relative claim about the field |
| 00-intro.qmd:44-46 | 'cannot currently support ... available today' | relative |
| 09-continuous-integration.qmd:2554 | `actions/checkout` v7.0.1 | version |
| 04-dependencies.qmd:361 and 7 further sites | `renv` 1.2.3 | version, typed |
| pipelines.qmd:794, 828, 880 | `targets` 1.12.0 | version, typed |
| setup-appendix.qmd:188, 213, 270, 289 | git 2.56.0 | version, typed |
| 05-containers.qmd (many), 06:99, 10:106 | `rocker/r-ver:4.4.0` and `4.4.1` beside a 4.6.1 lockfile | mixed versions across chapters |
| 10-archiving-sharing.qmd:942-949, 1027-1031 | EHDS dates, SATRE 2.0.1, NIH 2026 notices | policy, dated (good) |
| 10-archiving-sharing.qmd:1117, 1127 | journal policies 'on 8 November 2026' | dated (good); needs a re-check cycle |
| 05-containers.qmd:855 | FDA Pilot 4 review 'dated May 2026' | dated (good) |
| _quarto.yml:25; copyright.qmd:20 | `date: today`; '(2026)' citation | edition identity |

Recommendation to resist aging: keep every dated 'checked on' stamp
(house rule 7). Move tool versions into `_variables.yml` or compute
them from `renv.lock`. Put a 'Versions and policies this edition was
checked against' table in the colophon, with dates. Replace each
relative phrase above with a dated one.

## Scope disclosure

Read in full: shell-primer.qmd (287 lines), setup-appendix.qmd (289),
cheat-sheet-index.qmd (58), glossary.qmd (879), credits.qmd (21),
colophon.qmd (129), _quarto.yml (161). Also read in full: index.qmd
(82), preface.qmd (152), conventions.qmd (209), copyright.qmd,
_llm-rule.qmd, THIRD-REVIEW-PLAN.md (991). I grepped REFACTOR-PLAN.md
and docs/third-review/ for my files and topics and read the matching
passages (REFACTOR-PLAN 10.11, D1 to D12; reader-e m9 to m12;
factual-issues 31 to 43; model-book M2, M5, m7).

Inspected by grep, heading extraction, and targeted reads, not read
in full: all thirteen chapter files. Targeted reads covered
00-intro.qmd:94-180 and 221-330; 01:35-190 and 676-686;
02:538-552 and 872-880; version-control.qmd:50-66;
03-research-compendium.qmd:620-640, 1010-1030 and 1418-1470;
04:680-730 and 1520-1530; 05:848-862, 1170-1200 and 1318-1365;
06:538-545; 07:402-410, 652-660, 918-928 and 1218-1256; 08:1385-1400;
09:485-510, 660-675, 795-812, 1090-1120 and 2385-2400;
10:718-728, 1365-1380 and 1920-1935. Chapter-level judgments (sequence, health
density, zzcollab classification) rest on these reads and on
structural counts, not on full reading.

Not verified: no render was run (there is no rendered HTML; I read
the frozen JSON for the cheat-sheet index and the colophon). No code
was executed except read-only grep, wc, and Python counting scripts
over the sources. Web checks were made through a summarizing fetch
tool (Docker Hub tag API, Docker license page, Docker Desktop
settings page). The Rosetta default and the exact setting name should
be rechecked on the page itself. Reading-rate figures (100 to 150
words a minute) are an assumption. The acronym and health counts
are regex-based structural counts with known false positives and
negatives. The zzcollab source was inspected only for `bundles.yaml`
profiles, the archetype list in `modules/config.sh:573`, and the
Makefile target names.
