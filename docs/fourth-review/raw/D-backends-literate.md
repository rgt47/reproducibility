# Reviewer D: Backends and Runtimes (Ch 8) and Literate Programming (Ch 9)
*2026-11-25 17:55 PST*

Files: `06-backends-runtimes.qmd` (book Chapter 8, marked Optional
on the core path) and `07-literate-programming.qmd` (book Chapter 9,
Core).

## Summary

Both chapters are accurate where the third review worked (Apptainer
flags, Binder routes, rix, PDF hashing, freeze), and their organizing
ideas are sound. The remaining problems are novice accessibility and
currency. Core Chapter 9 never shows a chunk fence or teaches a render
command, its worked example is R Markdown although the objective says
Quarto, and it omits Typst. Chapter 8 lost a code block in Phase 25,
predates Docker's August 2026 terms, misstates rootless Podman, and
ignores CPU-dependent numerics on clusters. Both are R-only, and the
core Chapter 9 opens with a check that needs the optional Chapter 8.

## Strengths

- The three-axes framework (runner, environment model, location) and
  the rule 'diagnose the binding constraint first' transfer to any
  language and outlast any one tool.
- The Apptainer Pitfall and the Slurm script now state precisely
  what `--cleanenv`, `--no-home`, and `--vanilla` each isolate. The
  claim that the image's own `ENV` thread pins survive `--cleanenv`
  is correct: Apptainer documents that image `ENV` values always
  apply and are not overridden by host variables
  (https://apptainer.org/docs/user/latest/environment_and_metadata.html).
- The freeze section matches the Quarto documentation on all three
  points checked: `true` versus `auto`, single-document renders
  always execute, and `_freeze/` should be committed
  (https://quarto.org/docs/projects/code-execution.html).
- 'The seal and the pins are different virtues' and the PDF-hash
  section give the reader a real conceptual tool, and the
  `seal-inline` example on `survival::diabetic` is a clean
  demonstration.
- The honest-level callouts in both chapters keep L2 and L3 apart
  consistently.

## Findings

### Chapter 9 never shows the syntax or the command it teaches

- Location: 07-literate-programming.qmd:588
- Quote: 'If we read the source of that sentence, we find no numerals in it.'
- Severity: blocking
- Viewpoint: student
- Evidence: inspected (`grep -n -E "quarto render|quarto preview|rmarkdown::render|inline_expr|format: "` on the chapter returns only a regex string at 847 and the Exercise 1 solution at 1527; among the earlier core chapters and appendices only `shell-primer.qmd:4` mentions `quarto render`, as a name in a list; `_quarto.yml:97-99` sets `code-tools: source: repo`, so HTML readers have a link to the source but PDF readers do not; the only current rendered HTML on disk is a stale July build, so the rendered page was not checked)
- Prior: new
- Problem: The prerequisites (51) say no prior exposure to chunk syntax is assumed, yet no chunk fence with `#|` options is ever displayed (Quarto hides the fence and options by default, so `fig-simpson` appears as bare R code), and no render command is taught other than the zzcollab-specific `make docker-render`. The inline form appears literally only once before the Exercise 1 solution, inside the YAML `date:` field at 1202, unexplained as general syntax. A PDF reader cannot 'read the source of that sentence'.
- Why it matters: A first-year student cannot complete Exercises 1 to 3 or the objective 'Build a sealed render in Quarto or `knitr`' from this chapter alone.
- Fix: Add a short 'Anatomy of a literate document' subsection before 'The sealed render': one minimal `.qmd` shown verbatim (YAML with `format: html`, one fenced chunk with two `#|` options, one inline expression), set with `echo: fenced` or as a display block; then the three ways to render it (`quarto render report.qmd` in the terminal, the Render button in RStudio or Positron, `quarto::quarto_render()` from R), with the expected output file named. Point to the shell primer for running the terminal command.

### The Binder worked example introduces a Dockerfile that is not there

- Location: 06-backends-runtimes.qmd:1014
- Quote: 'and RStudio and has the required user:'
- Severity: major
- Viewpoint: student
- Evidence: verified (`git show 343c589 -- analysis/report/06-backends-runtimes.qmd` shows the ```` ```dockerfile ```` block deleted; `docs/third-review/phase25/agent2-report.md` A2-41 proposed a two-line replacement with `FROM ...@sha256` and `COPY --chown=${NB_USER} . /home/${NB_USER}`)
- Prior: 'fix for A2-41 incomplete'
- Problem: Phase 25 removed the one-line Dockerfile instead of replacing it with the two-line version, so the sentence ends in a colon followed by two blank lines. The reader is told what the file does and never sees it.
- Why it matters: This is the only place in the book that shows the Binder route that actually preserves the pin; the cheat sheet (1562) and two checks depend on it.
- Fix: Restore the block exactly as A2-41 proposed. Add a render check that fails when a line ending in ':' is followed by a blank line and then prose (a cheap lint for deleted displays).

### Chapter 9's opening check requires the optional Chapter 8

- Location: 07-literate-programming.qmd:92
- Quote: 'runs the same image as a SIF under Apptainer on her cluster, with `--cleanenv`, the same seed, and the same data'
- Severity: major
- Viewpoint: student
- Evidence: inspected (conventions.qmd:197 marks Chapter 8 Optional and :198 marks Chapter 9 Core; 07:41-46 lists prerequisites without @sec-backends)
- Prior: new (side effect of the Phase 24 spaced checks)
- Problem: The first exercise a core-path reader meets in Chapter 9 turns on Apptainer's home mount and `--no-home`, taught only in the chapter the core path skips. The prerequisites box does not list Chapter 8.
- Why it matters: The core-path student fails the first check of a core chapter through no fault of their own, which undermines the spaced-retrieval design it was meant to serve.
- Fix: Recast the vignette so it needs only Chapters 3, 6, and 7: the colleague runs the same Docker image with `-v "$HOME":/home/rstudio` mounted, so her `~/.Rprofile` is read. Keep the Apptainer version as an optional second part labeled 'if you read @sec-backends'.

### Docker Desktop licensing guidance predates the August 2026 terms

- Location: 06-backends-runtimes.qmd:333
- Quote: 'The terms do carve out an exception for education, but institutions differ on whether a given use qualifies.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (`curl -s https://www.docker.com/legal/docker-subscription-service-agreement/ | grep -o -i -E "Educational Use[^<]{0,400}"` returned 'Educational Use. Use is limited to individual members of an educational organization enrolled in a classroom learning environment solely for academic or research purposes ... Educational Use does not include use by multiple individuals under a coordinated arrangement intended to achieve institutional-scale usage through aggregated personal accounts.'; the agreement is dated 'Last updated August 26, 2026' per WebFetch; Section 3.2 'Educational Use ... does not include use by multiple individuals under a coordinated arrangement ...' where 'a number of individuals affiliated with the same educational institution, department, or research group intends to use Personal Service Subscriptions in connection with a shared project ... requires procurement of an appropriate paid institutional Service'; Section 3.3 'Government Entities shall not use Docker Desktop ... without a paid subscription'; the shorter page https://docs.docker.com/subscription/desktop-license/ still lists 'Education' without qualification. Both read via WebFetch on 2026-11-25.)
- Prior: new (Phase 25 row A2-48 verified the shorter docs page, which omits the narrowing)
- Problem: The binding agreement now limits free educational use to individuals in a classroom setting and excludes a research group sharing a project, which is exactly this book's reader. It also bars government entities, which can include public universities, without a paid subscription. The book's 'contested' framing understates this.
- Why it matters: A student in a lab that follows Chapter 7 on Docker Desktop may be out of compliance, and the mentor is the person who will be asked to pay.
- Fix: Replace the sentence with: 'Docker's subscription agreement (as of August 2026) limits free educational use to individual students in a classroom setting, excludes shared research-group projects, and requires a paid subscription for government entities, which may include a public university. Check with your institution before relying on Docker Desktop for lab work.' Cite the agreement with its date, and name free alternatives on macOS and Windows in one sentence (candidates: Podman Desktop, Colima, Rancher Desktop [unverified: licenses and current status not checked]). Also make the Chapter 7 and setup-appendix references to Docker Desktop point here.

### Rootless Podman also needs administrator setup, which the chapter implies it does not

- Location: 06-backends-runtimes.qmd:245
- Quote: 'Podman and Apptainer do not, which is why they run without administrative rights.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (Podman rootless tutorial, https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md: 'Rootless Podman requires the user running it to have a range of UIDs listed in the files' `/etc/subuid` and `/etc/subgid`; 'Root privileges are required to add or update entries within these files')
- Prior: new
- Problem: The chapter holds rootless Docker to the standard 'prerequisites installed by an administrator' but presents Podman as free of it. Rootless Podman needs administrator-configured subordinate ID ranges and helper binaries, which shared HPC systems frequently do not provide (their home directories are also often on network filesystems that rootless storage handles poorly [unverified]). The table's 'rootless Linux' best-fit for Podman (754) inherits the error.
- Why it matters: A student told to use Podman on the cluster will hit an unexplained `newuidmap` or subuid error and conclude they did something wrong.
- Fix: Change the daemon entry to: 'A standard Docker installation relies on one; Podman and Apptainer do not. Rootless operation of either Docker or Podman still needs some one-time administrator setup (subordinate user IDs); Apptainer is the runtime most clusters already provide.' Change Podman's best fit to 'licensing constraint; a workstation you administer'.

### A pinned image does not pin the CPU, and the chapter's cluster story implies it does

- Location: 06-backends-runtimes.qmd:970
- Quote: 'Nothing is rebuilt, and the image contents are the same ones pinned on the laptop'
- Severity: major
- Viewpoint: referee
- Evidence: inferred (OpenBLAS selects compute kernels by detected CPU at run time in its DYNAMIC_ARCH builds, which Debian and Ubuntu ship; the Guix maintainers document CPU-dependent OpenBLAS behavior at https://issues.guix.gnu.org/51536, which concerns build-time variation and so supports the general point only; `grep -i -E "microarch|avx|instruction set"` over chapters 02, 05, 06, 08 returns nothing)
- Prior: new
- Problem: The laptop-to-cluster narrative, and the 'identical L2 environment' language throughout, never says that the same image on a different processor can take different BLAS code paths, so matrix results can differ in the last bits between a laptop and a cluster node, or between two node types in the same partition. The book's tolerance-based baseline handles this, but this chapter, where the hardware actually changes, does not connect them.
- Why it matters: A student who sees a sixth-decimal difference between laptop and cluster will suspect the pin, not the hardware, and the referee will see an oversimplification in the chapter that should state it.
- Fix: Add two sentences after 973: 'The image fixes the software, not the processor. Numerical libraries such as OpenBLAS choose code paths by the CPU they find, so a laptop and a cluster node, or two node types on one cluster, can disagree in the last digits; this is why @sec-testing compares outputs within a stated tolerance.' Add a parallel note to the axis-two section: moving from Docker to Nix or conda changes the R build, compiler, and BLAS, so results across backends agree only within tolerance.

### The chapter's own container commands omit `--platform`, contrary to D15 and its own LLM advice

- Location: 06-backends-runtimes.qmd:319
- Quote: '$ podman build -t myproject .'
- Severity: major
- Viewpoint: referee
- Evidence: inspected for the absence (`grep -n -- "--platform" 06-backends-runtimes.qmd` finds only 1203 and 1216, both in the LLM section; Podman commands at 319-321, 962-964, 1319-1320 and Apptainer builds at 370-371, 999-1000, 1537-1538 carry no platform or `--arch`); inferred for the Mac behavior (not run); `apptainer build --arch` exists, help text 'architecture to build for' (https://apptainer.org/docs/user/latest/cli/apptainer_build.html)
- Prior: 'fix for Finding 30 / D15 incomplete' (D15: index digest plus `--platform linux/amd64`)
- Problem: D15 requires the platform flag with every index digest. Podman on a Mac runs an arm64 virtual machine and will select the arm64 manifest, and `apptainer build` inside an arm64 Lima VM does likewise. The LLM prompt (1203) tells the reader to check that the flag survives translation, which the chapter's own commands would fail.
- Why it matters: The multi-architecture failure that Finding 30 fixed in Chapter 7 reappears here for every Apple Silicon reader.
- Fix: Add `--platform linux/amd64` to each Podman command, add `--arch amd64` to each `apptainer build` shown for a laptop, and add one sentence: 'On a cluster node the architecture is already amd64; on a Mac it must be stated.'

### Apptainer is presented as something a laptop user can run, but it is Linux-only

- Location: 06-backends-runtimes.qmd:1261
- Quote: 'Build an Apptainer SIF file from a digest-pinned `docker://` reference.'
- Severity: major
- Viewpoint: student
- Evidence: verified (https://apptainer.org/docs/admin/main/installation.html: 'To run Apptainer on a Windows or macOS computer, a Linux virtual machine (VM) is required.')
- Prior: new
- Problem: The objectives (64) and Exercise 2 ask the reader to run and build with Apptainer, and the recommended pattern (387-390) is to develop on a laptop and run on the cluster, but the chapter never says Apptainer needs Linux, WSL2, or Lima on a Mac. It also never says what to do if the cluster provides `singularity` (SingularityCE, still maintained by Sylabs, 4.5.0 in June 2026 [unverified: search results only]) rather than `apptainer`, or neither.
- Why it matters: Most students own a Mac or Windows laptop and will fail at the first command with no failure path.
- Fix: Add a 'Where Apptainer runs' note in the Apptainer section: Linux natively; WSL2 on Windows; Lima on macOS; on a cluster, check `module avail` for `apptainer` or `singularity`, and note that `singularity` (SingularityCE) accepts the same `build` and `exec` commands used here [unverified: flag-by-flag compatibility not checked]. Make Exercise 2 conditional: 'on a cluster login node or a Linux machine'.

### Typst is absent; 'PDF means LaTeX' is out of date

- Location: 07-literate-programming.qmd:902
- Quote: 'PDF is heavier, because a PDF is typeset, and typesetting in this ecosystem means LaTeX.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (https://quarto.org/docs/output-formats/typst.html: 'Quarto includes the Typst CLI so no separate installation of Typst is required.'; `grep -rli typst analysis/report` returns nothing)
- Prior: new
- Problem: Since Quarto added Typst output, a Quarto user can produce a typeset PDF with no LaTeX distribution at all, because the Typst binary ships inside Quarto. The chapter's whole toolchain argument (several gigabytes of TeX Live, the publishing profile, `tlmgr` landmines) omits the option that removes most of the problem.
- Why it matters: The student is steered to a 4.2 GB image (zzcollab `templates/bundles.yaml:111`) and an amd64-only base when a smaller route exists for many manuscripts; the referee will read the omission as dated.
- Fix: After 913, add a paragraph: 'Quarto also renders PDF through Typst (`format: typst`), a typesetting engine bundled with Quarto itself, so a Typst PDF needs no LaTeX in the image. Journal templates and some LaTeX-specific features still require LaTeX; when they do not, Typst is the lighter choice, and it is pinned by pinning the Quarto version.' Add a `format: typst` row to the cheat sheet.

### The worked example teaches R Markdown and bookdown in a Quarto-first chapter

- Location: 07-literate-programming.qmd:1203
- Quote: 'output:
  bookdown::pdf_document2:'
- Severity: major
- Viewpoint: student
- Evidence: inspected (objective at 59 says 'Build a sealed render in Quarto or `knitr`'; 417-419 say the book uses the `#|` form and is a Quarto book; the worked example at 1196-1241 uses an `.Rmd` YAML `output:` field and `knitr::opts_chunk$set()`); Quarto current release 1.11 [unverified: search result, https://quarto.org/docs/download/ shows 1.11 highlights but no version string]
- Prior: new
- Problem: A novice starting in late 2026 will most likely start with Quarto, which uses `format:` and `#|` chunk options, not `output:` and `opts_chunk$set()`. The only complete document the chapter shows is in the older dialect, and the two are not interchangeable (an `.qmd` ignores `output:`). The chapter also never states which tool to start with, or that R Markdown remains maintained but receives no new features.
- Why it matters: A student copying the header into a `.qmd` gets no PDF and no error message pointing at the reason.
- Fix: Rewrite the worked example as `report.qmd` with `format: pdf` and `format: html`, `execute: echo: false`, and `#|` options; add a two-column 'R Markdown to Quarto' table (`output:` to `format:`, `opts_chunk$set` to `execute:`, `pdf_document2` cross-references to `@fig-` labels). State a recommendation: 'Start new work in Quarto; existing `.Rmd` files keep working' (any claim about R Markdown's maintenance status should be checked against Posit's current statement first [unverified]). Update the zzcollab-scaffolded `report.Rmd` reference (406) accordingly or flag it as the tool's default.

### 'Pin LaTeX in the image' omits that TeX Live itself is unpinned by default

- Location: 07-literate-programming.qmd:938
- Quote: 'The honest way to supply LaTeX is to pin it in the image, not to install it, fragilely and at render time'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (zzcollab `modules/docker.sh:222-239`: 'The script defaults to https://mirror.ctan.org, a redirector resolving to an arbitrary mirror per build. That leaves the TeX package set unpinned'; the tool pins a frozen `tlnet-final` snapshot for this reason)
- Prior: new
- Problem: Installing LaTeX packages 'in the image' with `tlmgr` against the default CTAN redirector fetches whatever is current at each rebuild, which is the same drift the book closes for CRAN with a dated snapshot. The author's own tool documents and fixes this; the chapter does not tell the reader.
- Why it matters: A student who follows the advice gets an image that pins nothing about TeX packages across rebuilds, and the claim 'pin it in the image' overstates what was pinned.
- Fix: Add after 940: 'Installing in the image fixes TeX only for that one built image. A rebuild fetches whatever the CTAN mirror serves that day unless `tlmgr` is pointed at a frozen TeX Live snapshot (a `tlnet-final` archive for a past release), the TeX analogue of the dated CRAN snapshot.' Add the same to the Exercise 4 solution's steps.

### The chapters are framed only for R, with no bridge for Python or Stata users

- Location: 07-literate-programming.qmd:414
- Quote: 'It keeps the `knitr` engine as one option and adds a Jupyter engine for Python and Julia.'
- Severity: major
- Viewpoint: student
- Evidence: verified for the proposed citation (Pimentel et al. 2019, MSR, https://leomurta.github.io/papers/pimentel2019a.pdf, p. 1: 'out of 863,878 attempted executions of valid notebooks ... only 24.11% executed without errors and only 4.03% produced the same results'); inspected for the absence (`grep -i pimentel` over `analysis/report` finds nothing; Python appears in Ch 8 only as a reason to choose conda)
- Prior: new argument against a recorded scope position (THIRD-REVIEW-PLAN.md Section 7: 'Python, Shiny, SQL, ... remain out of scope'; `uv` and Positron 'not recommended'). The new argument is the audience: prompt Section 2 states the reader is a first-year student in any empirical field, not an R-using health scientist. The fix is bridges, not Python coverage.
- Problem: The five landmines are stated in R terms (`install.packages`, `pacman::p_load`, `rm(list = ls())`); the Python equivalents (`!pip install` in a notebook cell, out-of-order cell execution as hidden state) and Stata's literate tools (`dyndoc`) are never mentioned. Chapter 8 offers Python users conda but not the Python-native lockfile tools, and says nothing about licensed software such as Stata or MATLAB inside a container, a real obstacle for economists and engineers.
- Why it matters: A psychology, economics, or engineering student who uses Python or Stata cannot map the chapter's rules onto their own documents, and the strongest published evidence for the hidden-state landmine comes from Python notebooks.
- Fix: Add a short 'If you work in Python or Stata' box to each chapter. In Chapter 9: Jupyter notebooks are literate documents; out-of-order execution is the hidden-state landmine, shown at scale by Pimentel et al. (24 percent of notebooks ran, 4 percent reproduced); 'Restart and run all' or `quarto render notebook.ipynb --execute` is the fresh-session render; Stata's `dyndoc` is the equivalent of inline expressions [unverified]. In Chapter 8: a Python project pins with a lockfile (`uv.lock` [unverified] or `pixi.lock`) the way `renv.lock` does; a licensed program in a container needs a license mechanism (a network license server or a mounted license file) and may not be redistributable in a deposited image.

### Chapter 8's placement and length suit an appendix more than a chapter for this reader

- Location: 06-backends-runtimes.qmd:48
- Quote: 'This chapter is marked optional in the one-quarter core path'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected (`wc -w`: 10,147 words of source; 9 checks, 8 exercises; conventions.qmd:197 Optional)
- Prior: 'Reopens D18' (option b proposed moving Chapter 8 out of the main sequence; the author chose no cuts)
- Problem: New argument: the review now evaluates the book for first-year students in any empirical field who know no shell, not for health-science students who know R and git (the D18 premise). For that reader, a 10,000-word chapter on Nix flakes, Slurm arrays, Binder configuration, and devcontainers between Docker and the first validation chapter is the point of greatest cognitive load in the book, and the core path already skips it. Most of its content is reference material consulted when a constraint arises.
- Why it matters: A novice reading in order meets four new tools and three new vocabularies just after their first Dockerfile; the mentor sees the length and doubts the whole program.
- Fix: Keep in Chapter 7 a two-page section 'When Docker is not an option' with the three axes and a constraint-to-tool table (cluster, no license, reviewer who installs nothing, Windows with Python). Move the rest of Chapter 8 to an appendix, 'Alternative runtimes and backends', with the Slurm example and the Nix and conda detail. The remaining cross-references (09-continuous-integration.qmd:1361; 10-archiving-sharing.qmd:46, 587, 597; setup-appendix.qmd:123, 133; 00-intro.qmd:239, 306; 05-containers.qmd:456, 2111) then point to the appendix. If D18 stands, at least move 'An HPC worked example' (1057-1179) and the Guix and conda detail to an appendix.

### Failure paths for the alternative runtimes are missing

- Location: 06-backends-runtimes.qmd:1142
- Quote: 'No Slurm cluster was available to actually submit it.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The chapter states its own Slurm script is untested but offers no guidance for the failures a novice will meet: the login node forbids `apptainer build` (no user namespaces or fakeroot), the compute node cannot reach the registry, `module load` is needed before `apptainer` exists, Nix installation fails on a managed Mac, Binder's build times out or exceeds its memory limit (mybinder.org guarantees 1 GB and caps at 2 GB, https://mybinder.readthedocs.io/en/latest/about/user-guidelines.html). Terms such as 'login node', 'partition', and 'module loads' are used without definition.
- Why it matters: Prompt Section 5.2 asks what a novice does when a step fails on their machine or on university HPC; here the answer is nothing.
- Fix: Add a 'When it fails' table (symptom, likely cause, what to try, whom to ask) with five rows for the cases above, and add 'login node', 'compute node', 'partition', and 'environment module' to the vocabulary box. State Binder's 2 GB limit in the Binder section.

### The `date` check claims a seal that freeze breaks

- Location: 07-literate-programming.qmd:1282
- Quote: 'It is the same seal, applied to metadata rather than to a result: the date is computed from the render itself, so it cannot drift'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (07:788-801 states that frozen and cached chunks are not re-executed; inline expressions are evaluated with the document's code)
- Prior: new
- Problem: Under Quarto `freeze` or the knitr cache, an inline `Sys.Date()` keeps the date of the last execution, so the header claims a date the render did not have, which is exactly the 'fresh build date over numbers computed earlier' problem the freeze section describes, inverted. The date is also not a result of the analysis, so calling it 'the same seal' blurs the chapter's own distinction between the object of record and presentation metadata.
- Why it matters: A careful reader will notice the contradiction with @sec-freeze three sections earlier.
- Fix: Rewrite the answer: 'It records when the code last ran, not when the file was produced; under freeze or cache those differ. In Quarto, `date: today` is set at render time instead. Neither is part of the seal on results.'

### Exercise 2 gives the wrong result inside a frozen Quarto project

- Location: 07-literate-programming.qmd:1452
- Quote: 'Then remove the `set.seed()` call, render twice more, and explain in terms of this chapter why the figure now differs between renders'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (Quarto: `freeze: auto` re-renders 'only when source changes', https://quarto.org/docs/projects/code-execution.html)
- Prior: new
- Problem: In a project render with `freeze: auto`, the second of the 'two more' renders reuses the frozen result because the source did not change, so the unseeded figure does not differ. A student working inside a Quarto project, such as this book's own repository, will see no difference and conclude the seed did not matter.
- Why it matters: The exercise's lesson inverts for exactly the reader who set the project up as the chapter recommends.
- Fix: Add: 'Render the single file (`quarto render fig.qmd`), which always executes, or turn freeze off for the exercise.'

### Slurm seeding advice conflicts with Chapter 11's per-task streams

- Location: 06-backends-runtimes.qmd:1132
- Quote: '`SLURM_ARRAY_TASK_ID` tells `simulate.R` which replicate set to run, and should also choose its seed.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (08-testing-quality.qmd:1133-1145 introduces `replicate_streams()` and shows it invariant for one and two workers; THIRD-REVIEW-PLAN.md Phase 21 row 'Parallel streams')
- Prior: new
- Problem: 'Choose its seed' invites `set.seed(task_id)`, which gives Mersenne Twister streams with no independence guarantee, while Chapter 11 teaches per-task L'Ecuyer-CMRG streams that do not depend on worker count.
- Why it matters: The simulation archetype is this section's audience, and it is where stream independence matters.
- Fix: 'and should select that task's random-number stream, as `replicate_streams()` in @sec-testing does, rather than a seed of its own.'

### `--no-home` does not apply when the working directory is the home directory

- Location: 06-backends-runtimes.qmd:989
- Quote: 'A verified run therefore adds `--no-home`, binds only the project directory with `--bind "$PWD"`'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (https://apptainer.org/docs/user/latest/cli/apptainer_exec.html: '--no-home: do NOT mount users home directory if /home is not the current working directory')
- Prior: new (Phase 25 A2-43 verified the flag's general effect, not this condition)
- Problem: A novice who submits from `$HOME` itself, a common habit, still gets the home directory mounted.
- Why it matters: The isolation the Pitfall promises fails silently in the most novice-typical case.
- Fix: Add: 'Run from a project directory, not from your home directory itself; `--no-home` has no effect when the working directory is `$HOME`.'

### The three motivating situations change between the opening, the objectives, and the orientation

- Location: 06-backends-runtimes.qmd:168
- Quote: 'The second works in a laboratory of Windows machines and a pipeline that mixes R with Python'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (22-25: licensing lab; 67-69: Windows-only lab; 168-170: Windows lab with Python)
- Prior: new
- Problem: The second situation is a licensing constraint at 24, a Windows constraint at 68, and a Windows-plus-Python constraint at 168. These select different tools (Podman versus conda), which is the chapter's own point.
- Why it matters: A chapter whose thesis is 'diagnose the binding constraint' blurs its own constraints.
- Fix: List four situations consistently in all three places (cluster, unlicensed Docker Desktop, Windows with Python, reviewer who installs nothing), or keep three and use the same three.

### 'Signed' overstates the provenance footer

- Location: 07-literate-programming.qmd:1031
- Quote: 'signed presentation of a result; the object of record is the computation.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (1024-1028 describe a footer with render time and source path and a manifest row; no cryptographic or personal signature)
- Prior: new (A3-32 rewrote the preceding sentence and left this word)
- Problem: Nothing signs the document; 'signed' suggests an attestation, which the regulated readers of Chapter 11 will read as an electronic signature.
- Why it matters: The book elsewhere (Phase 21, Ch 12 L3 stamp) is careful to say a stamp is not a validation record.
- Fix: 'a dated, traceable presentation of a result'.

### The publishing-profile detection described would miss a Quarto PDF

- Location: 07-literate-programming.qmd:931
- Quote: 'It scans every report's YAML for a `pdf_document` or `latex_engine` output and, finding one, concludes that the verse base is required.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (chapter text only; the playbook itself was not located or read)
- Prior: new
- Problem: A `.qmd` declares `format: pdf` and `pdf-engine:`, neither of which the described scan matches, so the playbook as described would not move a Quarto project to the publishing profile. The playbook is also uncited and unavailable to the reader (655 cites it for the term 'landmines').
- Why it matters: The book's own recommended format would fall through the tool's check, and the reader cannot consult the source named.
- Fix: Describe the rule as tool-neutral ('any PDF output: `pdf_document`, `format: pdf`, or `pdf-engine`') and either cite the playbook with a URL or drop the attribution and keep 'landmines' as the book's term.

### Unsupported superlative about PDF failures

- Location: 07-literate-programming.qmd:909
- Quote: 'Its absence is the single most common cause of a PDF render failing on a machine where the HTML render succeeds.'
- Severity: minor
- Viewpoint: referee
- Evidence: unverified (no source given; none found)
- Prior: new
- Problem: A frequency claim with no evidence; a missing individual LaTeX package or font is at least as common once a distribution is installed.
- Why it matters: The book trains readers to source claims.
- Fix: 'Its absence, or the absence of one package within it, is a common cause ...'.

### A real case would strengthen the orientation's hypothetical drift story

- Location: 07-literate-programming.qmd:167
- Quote: 'Consider a familiar scene from a clinical-trial analysis.'
- Severity: minor
- Viewpoint: mentor
- Evidence: verified (Nuijten et al. 2016, abstract, https://pmc.ncbi.nlm.nih.gov/articles/PMC5101263/: 'half of all published psychology papers that use NHST contained at least one p-value that was inconsistent' and 'One in eight papers contained a grossly inconsistent p-value that may have affected the statistical conclusion.'); `nuijten2016` is in `references.bib:172` but cited in no chapter (`grep -n nuijten *.qmd` empty)
- Prior: new
- Problem: The chapter's motivating case is invented. The skeptical mentor's objection, 'my numbers have always been fine', is answered best by measured prevalence of exactly the prose-code mismatch the seal prevents, and the source is already in the bibliography, from outside biomedicine.
- Why it matters: Persuasion and breadth (prompt Sections 2 and 5.1) both gain from one sentence.
- Fix: After 180: 'This is not rare. Scanning eight psychology journals from 1985 to 2013, Nuijten and colleagues found that half of the papers reporting significance tests contained at least one p-value inconsistent with its own test statistic, and one in eight contained a gross inconsistency that may have affected the statistical conclusion [@nuijten2016].'

### R versions in examples are two years old and typed

- Location: 06-backends-runtimes.qmd:479
- Quote: 'r_ver = "4.4.1",'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (Ch 7 computes its recipe from the lockfile, R 4.6.1, per THIRD-REVIEW-PLAN Phase 19 T1-4; Exercise 3 solution at 1386 uses '4.4.0'; the cohort devcontainer text at 879 cites `rocker/verse:4.4.0` without noting it differs from the locked R)
- Prior: new
- Problem: Examples pin R 4.4.x while the book's own lockfile pins 4.6.1, and the devcontainer stand-in runs a different R from the lockfile without saying so.
- Why it matters: These will look dated to a referee and contradict Chapter 7's computed recipe.
- Fix: Compute `r_ver` from `renv.lock` as Chapter 7 does, and add to `dev_txt` that the stand-in image's R differs from the locked R.

### Directory names in the write-as-you-go passage disagree with the compendium

- Location: 07-literate-programming.qmd:1148
- Quote: 'the `R/`, `tests/`, and `scripts/` directories fill in as the code in the document matures.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (1140 and 1142 name `inst/tinytest/` and `analysis/scripts/`)
- Prior: new
- Problem: Two sentences after naming the real paths, the summary names different ones.
- Why it matters: Novices take directory names literally.
- Fix: 'the `R/`, `inst/tinytest/`, and `analysis/scripts/` directories'.

### Code in printed examples uses double quotes

- Location: 06-backends-runtimes.qmd:728
- Quote: '"Docker", "Podman", "Apptainer",'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (also 479-484 in the `rix` call; the Exercise 3 solution at 1385-1389 uses single quotes for the same call)
- Prior: new
- Problem: The same `rix()` call is printed with double quotes in the text and single quotes in the solution, and `tbl-backends` uses double quotes throughout, against the house style the rest of the R code follows.
- Why it matters: Minor consistency only.
- Fix: Convert to single quotes.

## Scope disclosure

- Read in full: `06-backends-runtimes.qmd` (1,603 lines),
  `07-literate-programming.qmd` (1,882 lines),
  `THIRD-REVIEW-PLAN.md` (991 lines), the prompt and brief.
- Read in part: `docs/third-review/reader-c.md` (Part B for Chapters
  8 and 9), `phase25/agent2-report.md` (A2-35 to A2-44),
  `phase25/agent3-report.md` (A3-30 to A3-32), `persona-rse.md` and
  `persona-pharma.md` by grep; `conventions.qmd:180-200`;
  `05-containers.qmd:700-735` and grep hits; zzcollab
  `modules/docker.sh` (TeX Live and profile comments) and
  `templates/bundles.yaml` (publishing profile);
  `.devcontainer/devcontainer.json`. `REFACTOR-PLAN.md` was grepped
  for the chapter names only.
- Rendered output: the only HTML build on disk
  (`_book/07-literate-programming.html`, dated 26 July) predates the
  third review, so no claim about the current rendered page was
  checked against output.
- Executed: nothing. No render, no R chunk, no Apptainer, Podman,
  Nix, Binder, or Slurm. All statements about tool behavior rest on
  documentation as cited.
- Web sources were read through a summarizing fetch tool on
  2026-11-25; quotations from the Docker agreement, Apptainer, Podman,
  Quarto, mybinder, Nuijten, and Pimentel pages are as returned by
  that tool (Pimentel and Nuijten confirmed from the PDF text and the
  PMC abstract). The Quarto current version (1.11), SingularityCE
  status, and the OpenBLAS run-time dispatch claim rest on search
  results or expert knowledge and are labeled unverified or inferred.
- Not checked: the zzcollab publishing playbook named at 07:655 and
  931 (not located); the knitr release year and Sweave date; whether
  the Phase 22 freeze-facts chunk prints correctly in the current
  render.
