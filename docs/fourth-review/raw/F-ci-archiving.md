# Reviewer F: Continuous Integration (Ch 12) and Archiving (Ch 13)
*2026-11-25 17:52 PST*

## Summary

Both chapters are careful, current in their Actions pins, and honest
about what each check proves, but neither is written for a first-year
novice. Ch 12 (17,409 words) never shows how to create, push, and watch
a first workflow, its main workflow needs a tool from the author's
personal GitHub when a renv-only gate is already in the chapter, and no
exercise has the student run CI. Ch 13 (16,152 words) is strong on
restricted data but narrow (NIH-only funders, Zenodo-only repositories,
no license guidance). It has one verified data-leak error
(`.dockerignore`), and a union model that contradicts Ch 6. The book
ends inside Ch 13, after the solutions, with no call to action.

## Strengths

- The 'turn each gate red on purpose' table (09:611-627) and the
  `ci/run-tests.R` exit-status caveat (09:1053-1073) report real runs
  and teach the most transferable CI habit.
- The secrets and SHA-pinning section is current and accurate: the pin
  `actions/checkout@3d3c42e…` is v7.0.1, and `r-lib/actions@v2` is the
  current major version (verified, `gh api`: v2.14.0; `setup-r`
  supports `r-version: renv` and declares `node24`).
- The honest-level callouts state what was not run (09:1148-1167).
- The restricted-data material in Ch 13 is unusually complete for a
  textbook: HIPAA routes, the trusted research environment section, the
  EHDS dates, SPIRIT and CONSORT 2025, and a dated journal table
  (10:754-1127).
- The cohort deposit checks are computed, not typed, and test an
  invented filename with `git check-ignore` (10:1454-1571).

## Findings

### `.dockerignore` exercise teaches a pattern that does not exclude the data
- Location: 10-archiving-sharing.qmd:1782 (premise); 2119-2124 (solution)
- Quote: 'Because `*.csv` does not match `extra.tsv`, the file is copied into the image'
- Severity: blocking
- Viewpoint: referee
- Evidence: verified (https://docs.docker.com/build/concepts/context/ : '`*.md` ... markdown files under subdirectories are still included'; `**` 'matches any number of directories')
- Prior: new
- Problem: `.dockerignore` patterns are matched from the context root, so `*.csv` excludes only CSV files at the top level. In the exercise, `analysis/data/raw_data/*.csv` files, the real extract included, are also copied into the image. The solution implies that `*.csv` protected them and that only the `.tsv` leaked.
- Why it matters: this is the patient-data chapter, and a student who copies `*.csv` into a real `.dockerignore` ships the extract to a registry and then to Zenodo.
- Fix: change the premise to `analysis/data/raw_data/**` versus `**/*.csv`, and add one sentence to the body near 10:804-808: 'Patterns in `.dockerignore` are anchored at the build-context root; `*.csv` excludes only top-level files, and `**/*.csv` or the directory path is needed for files below it.' Recompute the exercise so that the leak is the unanticipated extension, as intended.

### No novice on-ramp: the student never creates, pushes, or watches a workflow
- Location: 09-continuous-integration.qmd:51-53, 514-593, 2068-2159
- Quote: 'enough comfort reading YAML to follow a workflow file line by line; no YAML is written from scratch here.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The first workflow shown is a 60-line, eight-step file with three gates and a tool installed from GitHub. Nothing tells the reader where the file goes and why, that a push triggers it, where the result appears (the Actions tab, the red X or green check on the commit), how to open a failed step's log, or what a YAML indentation error looks like. None of the eight exercises has the student push a workflow and watch it pass and then fail, although habit 4 ('watch it fail once') is the chapter's thesis. Exercise 4 has the student write a complete `.gitlab-ci.yml`, which contradicts the prerequisite quoted above. The mentor is not told the cost either: setup time, or whether CI minutes are free for the lab's private repositories.
- Why it matters: a first-year student cannot get from this chapter to a working CI run without outside help, so the chapter teaches about CI rather than how to use it.
- Fix: open the practical part with 'Your first workflow' (about 800 words). Show `usethis::use_github_action('check-standard')`, or a 15-line hand-written file that restores `renv.lock` and runs a short `ci/run-tests.R` (the bare `tinytest::run_test_dir()` call exits 0 on failure, as 09:1053-1058 says, so it cannot go red). Then walk through commit, push, the Actions tab, and opening a red step's log, with one annotated screenshot of each. Add Exercise 0: push it, see green, add `library(sandwich)` without snapshotting, see red, paste the failing log line. Add a three-line 'what it costs' note (setup time, minutes on public versus private repositories; check the current GitHub billing page before printing numbers). Change the prerequisite to say that the chapter writes YAML.

### The main workflow depends on the author's personal-repository tool when a tool-free gate is already in the chapter
- Location: 09-continuous-integration.qmd:507-508, 563-584, 668-674, 1095-1120, 2390-2412; 10-archiving-sharing.qmd:390-392, 466-469, 1373, 2276-2279
- Quote: 'It is not on CRAN, so the workflow installs it from its source repository, pinned to a commit.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (non-disclosure: grep of `preface.qmd`, `00-intro.qmd`, `credits.qmd`, `copyright.qmd` for an authorship statement found none)
- Prior: 'fix for D2 incomplete' (D2, REFACTOR-PLAN:2071-2075, decided 'concepts first, zzcollab optional' in boxed sections, teachable with renv, a Dockerfile, GitHub Actions, and tinytest alone; Ch 12's main workflow still requires a zzcollab-family tool)
- Problem: Gate 2 of the canonical workflow, its faded copy (09:1594-1716), the GitLab file, Ex 4, and the cheat sheet all call `zzrenvcheck` from `rgt47/zzrenvcheck`, but 09:486-496 already gives `ci/dependency-gate.R`, which needs only renv. The rest of the zzcollab material is tool documentation rather than principle: `zzc verify` and its stamp semantics (09:1095-1120), the zzcollab `.Rprofile` caveat (09:668-674), the capture test matrix, the Makefile targets in Ex 4, `make docker-build` (10:1373), the 'framework's vignette' (10:406-409, 466-469), and `zzc verify` in the book's closing argument (10:2276-2279). A reader without zzcollab can follow the concepts, but cannot copy the main workflow without adopting a single-maintainer tool. Ch 13 calls that tool a 'bus factor of one' (10:1191-1192), and the preface (preface.qmd:59-71) does not say the author wrote it.
- Why it matters: the skeptical mentor will read the dependence as promotion, and a student in another lab gets a workflow that relies on one person's repository.
- Fix: in the main and faded workflows, replace Gate 2 with `run: Rscript ci/dependency-gate.R`. Collect every zzcollab-specific item in Ch 12 into one callout, 'If your compendium was scaffolded with zzcollab' (`zzrenvcheck`, `zzc verify --full`, `ZZCOLLAB_CONTAINER`, `check-renv-no-fix`). At 10:2276-2279, write 'Running the verify job once (in zzcollab, `zzc verify --full`)'. Add an authorship disclosure to the preface.

### Chapter 12 length: what to cut or move
- Location: 09-continuous-integration.qmd:127-145, 179, 214, 374-387, 711, 1328-1394, 841-1001, 2280-2329
- Quote: 'One rung below the compendium's own verification sits an easily overlooked question: how does the framework know that a project configured for, say, L1'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`wc -w`: 17,409 words; grep finds the 'captures nothing / pins nothing / trusted rather than tested' point at 127, 144, 179, 214, 387, 711, 1485, 2072, 2180)
- Prior: 'reopens D18' and 'reopens D10'. The new argument: D10 (accept growth) and D18 (no cuts) were decided for MS and PhD biostatistics students 'who know R and basic git'. The fourth-review reader is a first-year student in any field who is new to all of this, and for that reader the length of this chapter is itself a barrier. The third review's personas proposed the same cuts (persona-rse:168-169; persona-pharma:102; Finding 38).
- Problem: about a fifth of the chapter is not needed for a novice to use CI. (a) The capture test matrix (1328-1394, about 600 words) is QA for the framework's own test suite, which no student will perform. (b) Translating the workflow into the GitLab dialect, plus presence-driven workflows (841-1001, about 1,500 words with the file), plus Ex 4 and its long solution (about 700 words) is a second implementation of the same content. (c) Capture versus validation is restated about nine times. (d) The Ex 3 solution's essay on serialization (2280-2329, about 600 words) repeats 1122-1146.
- Why it matters: the 70-minute reading time sits in a single-semester course, and the on-ramp proposed above has to be paid for with words cut elsewhere.
- Fix: move (a) to the zzcollab documentation; move (b) to a short appendix, 'CI on GitLab and other forges', and keep one paragraph plus the Makefile-shim idea in the chapter; keep capture versus validation in the stack section and the honest-level callout only; cut the Ex 3 essay to three sentences. Estimated saving: 3,000 to 3,500 words, of which about 800 fund the on-ramp.

### No diagram of the CI pipeline
- Location: 09-continuous-integration.qmd:411-627, 1003-1051
- Quote: 'A CI run on a research compendium executes, in the general case, three gates.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (the only figure is `fig-stack-ci`)
- Prior: new (recommended in `docs/third-review/learning-science.md:74`; not taken up by any phase or decision)
- Problem: Trigger, runner, steps, the two jobs (`gates`, then `verify` with `needs:`), the three gates, the baseline test, and the verdict are explained only in prose and YAML. A novice cannot see that verification is a second job inside a rebuilt image while the gates run on the host runner.
- Why it matters: this is the chapter's central mental model, and the reader most likely to need a picture is the target reader.
- Fix: add one flow figure beside the first workflow: push or PR, then a fresh runner, then the job `gates` (check, deps, render), then the job `verify` (docker build, then tests including `test-baseline-*`), then a green or red status on the commit. Label which box maps to which YAML lines.

### The 'union model' contradicts renv's behavior as Chapter 6 teaches it, and its mechanism is never given
- Location: 10-archiving-sharing.qmd:324-327, 415-445, 1838-1840, 2200
- Quote: 'A package installed once for an exploratory notebook remains in the lockfile for everyone until it is deliberately removed.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (04-dependencies.qmd:1697: '`renv::snapshot()` | Scans the code for referenced packages and writes their installed versions')
- Prior: 'fix for reader-e M1 incomplete' (the term is now introduced in Ch 13, but nothing says how the union is produced)
- Problem: The chapter defines the lockfile as the union of every package 'any contributor has installed'. Under renv's default implicit snapshot, which Ch 6 teaches, the lockfile records packages referenced by the project's code, and a package used only in a deleted notebook disappears at the next snapshot. The chapter never says which setting or tool produces an install-based union (`snapshot.type = 'all'`, or zzcollab's own merging). It also never addresses the practical team problem: concurrent snapshots on branches produce merge conflicts in `renv.lock`.
- Why it matters: a student who follows Ch 6 and then expects Ch 13's behavior will see packages vanish from the lockfile, with no explanation.
- Fix: redefine the union model as 'the union of packages the project's code uses, across all contributors', which is what implicit snapshot gives when everyone's code is in one repository. Say that recording installed-but-unused packages needs `renv::settings$snapshot.type('all')` and explain the trade-off. Add one paragraph on resolving a conflict in `renv.lock` after a merge: re-run `renv::snapshot()` on the merged branch rather than hand-editing the JSON.

### 'The Dockerfile, not the image, is the guarantee' overstates the recipe's durability on archival time scales
- Location: 10-archiving-sharing.qmd:449-464, 511-513, 1866-1870
- Quote: 'If the registry vanishes tomorrow, a compendium whose guarantee is the Dockerfile can be rebuilt; a compendium whose guarantee was the pushed image cannot.'
- Severity: major
- Viewpoint: referee
- Evidence: inferred (from the recipe's dependencies as the book itself describes them in Ch 7; the chapter's own answer at 10:1432-1438 concedes part of this)
- Prior: new (not raised in the third review; the Phase 25 correction, 'an image rebuild gives the same pinned environment, not identical bytes', concerned byte identity rather than the recipe's durability)
- Problem: A digest-pinned Dockerfile rebuilds only while its inputs survive: the base image on Docker Hub, the operating system's package mirrors (apt versions are usually unpinned), and the dated package snapshot service. Over a ten-year archival horizon those are less durable than a deposited image file. The section heading and the Ex 2 'recipe and cake' answer present the recipe as the guarantee without that condition. The check at 1432-1438 states the condition, but the section does not.
- Why it matters: a reader who deposits only the recipe because the book called it 'the guarantee' loses the route most likely to work in 2036.
- Fix: retitle the section 'The Dockerfile is the record; the archived image is the fallback'. State that the recipe is the human-readable account and the short-horizon rebuild path, that its third-party inputs decay, and that for a deposit the archived image is the durable artifact. Change 'can be rebuilt' at 463 to 'can be rebuilt while its base image, package mirrors, and snapshot service survive'.

### Funder policy is NIH DMS only; the OSTP memo and the 2025 NIH Public Access Policy are absent
- Location: 10-archiving-sharing.qmd:1016-1046, 2242-2247
- Quote: 'The NIH Data Management and Sharing Policy applies to proposals due on or after 25 January 2023.'
- Severity: major
- Viewpoint: mentor
- Evidence: verified for NIH (https://www.grants.nih.gov/grants/guide/notice-files/NOT-OD-25-101.html, opened: the 2024 policy took effect 'July 1, 2025' for manuscripts 'with acceptance dates on or after July 1, 2025'; the zero-embargo point comes from library summaries, not this notice); unverified for the OSTP memo (a search found the 31 December 2025 implementation target in secondary sources but no report on agency compliance)
- Prior: new
- Problem: The chapter does not mention the 2022 OSTP 'Nelson' memo, its agency implementations (NSF, DOE, and others), or NIH's zero-embargo Public Access Policy in force since 1 July 2025, and it gives no non-US funder (UKRI, Wellcome, Horizon Europe open-science requirements). The book's stated audience spans disciplines and countries, and for the mentor these mandates are the strongest argument that the practices are no longer optional.
- Why it matters: a mentor funded by NSF, or outside the US, finds nothing that applies to them, and the case for compliance appears only in the last chapter.
- Fix: add a short paragraph and a table of four to six funders (NIH DMS and Public Access, the OSTP memo with NSF as an example, UKRI, Wellcome, Horizon Europe), each with effective date and requirement. Open each agency's own policy page on the date of writing before stating what is in force; do not infer it from the OSTP memo's target dates. Cross-reference it from the persuasion chapters (01) so the mandate argument appears where the mentor is being persuaded.

### Repository landscape is too narrow; Zenodo mechanics and version DOIs are missing
- Location: 10-archiving-sharing.qmd:576-584, 655-672, 1077-1088, 1734-1738
- Quote: 'Depositing the compendium in Zenodo, the general-purpose repository operated at CERN, produces a Digital Object Identifier.'
- Severity: major
- Viewpoint: student
- Evidence: verified (https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content : 'Zenodo can only access public repositories'; 'issues a new DOI each time you create a new GitHub release'; https://zenodo.org/help/versioning : the concept DOI 'represents all the versions', each version DOI represents 'the specific version of your record'); inspected (no occurrence of OSF, Dryad, ICPSR, or 'concept DOI' in 10)
- Prior: new (reader-e noted that the cheat-sheet index listed 'OSF deposition' that the chapter lacked; it was removed rather than added)
- Problem: Only Zenodo, dbGaP, and Software Heritage appear. OSF (widely used in psychology, often with preregistration), Dryad (ecology), openICPSR (social science and economics), and institutional repositories are absent. So is the GitHub-release-to-Zenodo integration, which only works for public repositories, and so is the distinction between Zenodo's concept DOI (all versions) and version DOI. The code-availability statement (10:1081-1083) demands 'which version', which the version DOI answers directly.
- Why it matters: a student outside health research will not find their field's repository, and a student who cites the concept DOI cites a moving target.
- Fix: add a short 'Choosing a repository' table (general-purpose, discipline, institutional, controlled-access) with one example each across fields. Add three sentences on the GitHub-Zenodo release integration (public repositories only; one DOI per release) and on citing the version DOI in the article.

### No guidance on choosing a license for code or for data
- Location: 10-archiving-sharing.qmd:637-650, 1523-1542
- Quote: 'In the absence of a license, that defaults, under copyright, to nothing.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The chapter shows that a license is required (FAIR R1.1) and discusses this repository's three licenses, but never helps the reader choose one: permissive (MIT, Apache-2.0) against copyleft (GPL-3) for code, CC0 against CC BY for data, and the point that data held under a data use agreement are not the analyst's to license at all.
- Why it matters: the license is the one deposit decision a student has to make alone, and the chapter's own example (three licenses in one repository) is the hardest case rather than a model.
- Fix: add a five-row decision table (code you wrote; data you collected; derived data from licensed sources; restricted data; prose and figures) with a default choice for each and pointers to choosealicense.com and the `usethis::use_*_license()` functions shown in Ch 5.

### The book has no real ending and no call to action for the student or the mentor
- Location: 10-archiving-sharing.qmd:2249-2317; _quarto.yml:74-76
- Quote: 'has learned the one thing the book most wished to teach.'
- Severity: major
- Viewpoint: mentor
- Evidence: inspected
- Prior: new (reader-e:215 judged the conclusion adequate as consolidation; this finding concerns its placement and the call to action, which reader-e did not assess)
- Problem: The conclusion is the last subsection of Ch 13, after nine exercises, their solutions, the cheat sheet, and the further reading (and, in the PDF, after the moved answers). It restates four points and the seven habits. It offers no staged plan for adoption, no brief the student can hand a mentor, and no return to the cases that opened the book, and its one concrete action is a zzcollab command (2276-2279). Part 'Collaboration and Stewardship' holds a single chapter that mixes team governance, registries, deposit, restricted data, trusted research environments, funder and journal policy, recovery, and the book's conclusion.
- Why it matters: the prompt makes persuasion goal one; a book that opens by persuading should close by telling the persuaded reader, and the doubting mentor, what to do next.
- Fix: move 'In conclusion' into a separate closing chapter (about 1,500 to 2,000 words). Content: the four points; an adoption ladder by time (this week: git and a README; this month: `renv.lock`; before submission: container, CI, baseline test, deposit); a one-page 'For your mentor' (time cost, what the lab gains, the funder and journal mandates, the risk avoided, with references back to Ch 2's cases); and 'when your lab does not do this yet'. Consider splitting Ch 13 into 'Working as a team' and 'Depositing and sharing'.

### Exercise 5 solution states the seed claim without the condition the book elsewhere requires
- Location: 09-continuous-integration.qmd:2436-2445
- Quote: 'With the seed fixed, the first hundred replicates of the reduced run are *the same hundred replicates* the full run begins with.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (contrast 10-archiving-sharing.qmd:2078-2085, which adds 'That holds only when a replicate's draws are fixed by its index')
- Prior: 'fix for Finding 35 incomplete' (Phase 21 added the condition in Ch 13 but not here)
- Problem: The statement holds only for one serial stream consumed in the same order, or for per-replicate streams. It fails for parallel runs whose streams are assigned per worker, and when the replicate count changes how draws are allocated.
- Why it matters: a statistics audience will design the CI check around a correspondence that may not exist.
- Fix: insert the Ch 13 sentence verbatim after 2440 and cross-reference the per-task streams of @sec-testing.

### The debugging sequence puts reading the error message last
- Location: 09-continuous-integration.qmd:1807-1833
- Quote: 'Reading the CI log carefully is usually the last step, because by the time it is needed the first four moves'
- Severity: major
- Viewpoint: student
- Evidence: inferred (standard debugging practice; the chapter's own 'Second, read what it printed' at 1814-1817 is the cheaper first move)
- Prior: new
- Problem: Bisection needs a known good commit and a full render at each step, which is the most expensive move, yet it is placed first. The error text, which often names the missing package or the failing chunk outright, is placed last.
- Why it matters: a novice following the stated order spends an afternoon bisecting a failure that the first log line explains.
- Fix: reorder: (1) read the failing step's message; (2) reproduce that step locally; (3) compare environments (`sessionInfo()`, `renv::status()`, a diff of `renv.lock`); (4) bisect only when the change is in the history and the cause is still unclear; (5) `targets` diagnostics where a pipeline is involved. Change 'five moves' accordingly.

### SHA pinning also freezes the Node runtime; the 2026 Node 20 removal is the concrete example
- Location: 09-continuous-integration.qmd:786-793
- Quote: 'A SHA pin does not move on its own, so it also does not pick up a security fix.'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (https://github.blog/changelog/2026-09-23-node-20-is-no-longer-available-in-github-actions , opened: 'Node 20 is no longer available on GitHub Actions runners', maintainers should 'update its `runs.using` value to `node24`'; `gh api` on 2026-11-25: `actions/checkout` at `ref=v4` still declares `using: node20`, while v7.0.1 and `r-lib/actions/setup-r` declare `node24`)
- Prior: new
- Problem: The chapter does not mention that an action pinned to an old SHA also fixes the JavaScript runtime it declares. GitHub removed Node 20 from its runners in September 2026, and `actions/checkout@v4`, the pin most tutorials still show, declares `node20`. What exactly happens to such a step on current runners was not observed here.
- Why it matters: students copy older tutorials that show `@v4` pins, and the runtime is a concrete, current example of why a SHA pin needs a maintained update path.
- Fix: add after 793: 'A pin also freezes the JavaScript runtime the action declares. GitHub removed Node 20 from its runners in September 2026 and asked maintainers to release Node 24 versions; a workflow pinned to an older release does not receive that change until someone updates the pin, which is one more reason to let Dependabot propose updates.'

### Workflow syntax a novice cannot parse is left unexplained
- Location: 09-continuous-integration.qmd:543, 576, 595-596, 1046
- Quote: 'Three choices in the file merit a word. First, `error-on` is set to `"warning"` explicitly'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The nested quotes (a YAML string holding an R string), `${{ secrets.GITHUB_TOKEN }}` expression syntax, why `GITHUB_PAT` is set at all (to authenticate `remotes::install_github` and avoid rate limits), and the `|` and `>` block scalars are used without explanation.
- Why it matters: these are exactly the lines a novice will mistype.
- Fix: add a six-row 'Reading the workflow' table beside the first workflow, one row per construct.

### Zenodo metadata precedence and the CFF license list are not stated
- Location: 10-archiving-sharing.qmd:663-672
- Quote: 'Zenodo can read the same file when it archives a GitHub release and use it to pre-fill the deposit's own citation metadata'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (https://help.zenodo.org/docs/github/describe-software/citation-file/ : page opened, when both exist 'Zenodo will only use the .zenodo.json metadata and ignore the CITATION.cff entirely'; CFF schema guide via `gh api`: 'When there are multiple licenses, it is assumed their relationship is OR, not AND')
- Prior: new
- Problem: If a `.zenodo.json` exists, Zenodo ignores `CITATION.cff`. The CFF `license` key can hold a list, but a list means 'any of', so it cannot express per-file licensing, which is the chapter's point but is left unstated.
- Why it matters: a reader who adds `.zenodo.json` for funding metadata will find their CFF edits silently ignored.
- Fix: add two sentences with these facts and the citations.

### Exercise 5 asks the reader to use an archived package with no install route
- Location: 10-archiving-sharing.qmd:1748-1754, 2004-2010
- Quote: 'Take a compendium with an `renv.lock` and, using `rang`, generate a Dockerfile'
- Severity: minor
- Viewpoint: student
- Evidence: verified (https://cran.r-project.org/package=rang : 'Archived on 2026-08-22 as issues were not corrected in time')
- Prior: 'fix for reader-e m7 incomplete' (the solution still hard-codes `snapshot_date = '2026-06-29'`, and the exercise gives no install route)
- Problem: `install.packages('rang')` now fails, and the solution's date is not the compendium's creation date that the exercise asks for.
- Why it matters: the exercise fails at the first command for a self-study reader.
- Fix: give the install line (from the CRAN archive or its GitHub repository) in the exercise, use a placeholder `snapshot_date = '<creation date>'`, and name a dated-snapshot alternative (a dated Posit Package Manager URL) as the fallback.

### The image inspection is overclaimed as catching unanticipated files
- Location: 10-archiving-sharing.qmd:1378-1379, 2138-2149
- Quote: 'Only the second one catches a file the plan did not anticipate.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: `find / -xdev -path '*raw_data*' -type f` is itself a name-based plan: data copied to any path without 'raw_data' in it are not listed.
- Why it matters: it gives false assurance in the same restricted-data setting as the blocking finding above.
- Fix: list every file under the project's `COPY` destination (for example `find /home/analyst/project -type f`) and compare the listing with `git ls-files`, or avoid `COPY . .` entirely and mount the project at run time.

### zzcollab claims cited to uncited internal documents
- Location: 10-archiving-sharing.qmd:406-409, 1187-1192
- Quote: 'Its own system review describes it candidly as a strong scaffolding tool'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (no citation key at either site)
- Prior: new
- Problem: The 'system review' and the vignette's 'fifteen or twenty minutes ... to a matter of seconds' are quoted without a reference.
- Why it matters: they are the only evidence offered for the framework's limits and benefits.
- Fix: cite both documents with URLs, or remove the quotation.

### GitLab example image is amd64-only
- Location: 09-continuous-integration.qmd:883, 2341
- Quote: 'image: rocker/verse:4.6.1'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (Docker Hub API, `rocker/verse` tag 4.6.1: architectures `['amd64']`)
- Prior: 'fix for persona-rse:154 incomplete' (the tag was updated to 4.6.1 to match the lockfile; the amd64-only point raised there was not addressed)
- Problem: On an institutional arm64 GitLab runner the job fails or runs under emulation, which D15's `--platform linux/amd64` advice does not cover for CI images.
- Why it matters: institutional GitLab is the case the section was written for.
- Fix: one comment line noting that the image is amd64-only and that the runner must be amd64.

### Terminology drift: 'data-integrity gate' and 'verification gate'
- Location: 09-continuous-integration.qmd:2236-2244
- Quote: 'The **data-integrity gate** addresses it, by hashing the inputs and derived outputs'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The body defines three gates plus a verify job and a checksum manifest. The solution introduces two more 'gates', and extends hashing to 'derived outputs', which the body advises comparing by tolerance.
- Why it matters: the novice's count of gates is the chapter's core vocabulary.
- Fix: write 'the checksum manifest' and 'the verify job', and drop 'and derived outputs'.

### Exercise 1 solution overstates what CI catches when a tag moves
- Location: 09-continuous-integration.qmd:2184-2191
- Quote: 'With CI, the next push rebuilds and the check fails, naming the day it broke.'
- Severity: minor
- Viewpoint: referee
- Evidence: inferred
- Prior: new
- Problem: A repointed base tag usually rebuilds without error, so CI turns red only if something breaks or the baseline test detects a changed number.
- Why it matters: it repeats the 'green means unchanged' belief that the chapter argues against.
- Fix: write 'the next rebuild either fails or, if the verify job runs a baseline test, reports the changed estimate'.

### Garbled sentence from rewrapping
- Location: 10-archiving-sharing.qmd:555-556
- Quote: 'recipe that reconstructs the same pinned environment, though not byte-identical image layers, from pinned inputs.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: The inserted qualifier separates 'reconstructs' from its source, and the line is overlong in the source.
- Why it matters: it is harder to read than it needs to be.
- Fix: 'recipe that, from pinned inputs, reconstructs the same pinned environment (though not byte-identical image layers).'

## Scope disclosure

- Read in full: `09-continuous-integration.qmd` (2,597 lines), `10-archiving-sharing.qmd` (2,317 lines), `THIRD-REVIEW-PLAN.md` (991 lines), the fourth-review prompt, `_quarto.yml`, `_habits.qmd`, `_llm-rule.qmd`.
- Grepped only: `REFACTOR-PLAN.md` (decisions D1-D12 read at 2065-2139; chapter-file hits read) and `docs/third-review/*` (full grep output for both chapter filenames read; reader-d, reader-e, persona-rse, persona-ms, persona-pharma, learning-science, phase reports), `04-dependencies.qmd` (snapshot wording), `preface.qmd:55-71`, `glossary.qmd` (union model), and other chapters for YAML and `.dockerignore`.
- Verified on the web or by API on 2026-11-25: checkout v7.0.1 and its SHA; r-lib/actions v2.14.0; node24 in both actions; upload-artifact v7.0.2 (the chapter does not use upload-artifact: grep count 0; its honest-level callout says to download and keep logs but shows no step that saves them, a possible addition); the Node 20 removal (changelog opened); checkout `@v4` declaring node20 (`gh api`); the NIH Public Access effective date (NOT-OD-25-101 opened); Zenodo concept and version DOIs (help page opened); the `.dockerignore` matching rules; Zenodo public-repository requirement and `.zenodo.json` precedence; the CFF license semantics; the `rang` archival; Docker Hub free-tier limits (book correct); `rocker/verse:4.6.1` architectures.
- Not verified: OSTP memo implementation by agencies (secondary sources only); the zero-embargo wording of the NIH policy (library summaries only); runner behavior for node20-declaring actions after removal; current GitHub Actions billing for private repositories; SWHID ISO standard number; JASA, Biostatistics, and AJE policy rows (they were checked in Phase 25 and not rechecked); `tinytest` `as.data.frame()` column names; whether `rocker/verse` ships renv.
- No code was executed: no render, no workflow run, no Docker.
- Word counts are `wc -w` on source and include code and YAML. The prompt's figure of about 17,400 words for Ch 12 matches.
