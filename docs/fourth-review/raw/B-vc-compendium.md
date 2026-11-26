# Reviewer B: Version Control and the Research Compendium
*2026-11-25 17:50 PST*

Scope: `analysis/report/version-control.qmd` (Chapter 4) and
`analysis/report/03-research-compendium.qmd` (Chapter 5).
Emphasis: prompt Sections 2 (zzcollab dependence), 5.2, 5.3, 5.4, 5.5,
5.6, and failure paths.

## Summary

The version-control chapter is accurate and unusually careful. Its
data model is correct (snapshots, not diffs), its undo section now
handles `reset --hard` honestly, and its PHI response puts reporting
before commands. It is still written for a reader who already has a
terminal open and knows what `cd` does. It never links the shell
primer, offers no GUI route, never teaches `git clone` although an
exercise depends on it, and leaves out the decision a health-data
student most needs: whether the remote is public or private. Its
novice core is also weighed down by regulated-records material
(backdating, 21 CFR Part 11 in three places). The compendium
chapter teaches the tool-independent principles well (`rrtools`
lineage, the `R CMD check` blind spot, raw versus derived, README
requirements, `here`). Its organizing taxonomy, however, is
zzcollab's: the Five Pillars, the five archetypes, progressive
disclosure, and a worked example in `zzc` and `make`. That taxonomy
is presented as the field's and is already out of date with the
tool (zzcollab has six archetypes, and this repository is the sixth,
`book`). The book never says how to obtain zzcollab and never
discloses that its author built the tool. Decision D2 ('concepts
first, zzcollab in a boxed track') is not implemented in this
chapter.

## Strengths

- Version control is explained as a data model before commands
  (vc:418-526). The account of the commit hash and the limits of
  tamper evidence is correct and appropriately hedged.
- The PHI response (vc:805-876) puts reporting and credential
  rotation before any rewrite. It names forge caches, forks, and
  clones, and includes the GxP warning.
- Restore, reset, and revert are distinguished correctly. The reflog
  caveat about uncommitted work is now right (vc:1283-1301).
- Repository facts are computed rather than typed: the `.gitignore`
  state, the leaked fixture history, the pillar count, and the README
  excerpt (vc:978-1087; 03:875-959, 1506-1563).
- The `R CMD check` blind spot for `analysis/` is stated precisely,
  with a fail-on-purpose verification (03:408-446).
- The operative raw-versus-derived test ('could the code regenerate
  it?') and the manual-correction case (03:1776-1805) teach well.
- `#>` transcripts dated to git 2.56.0 (vc:606-650, 1630-1700) answer
  Finding 39's request.

## Findings

### zzcollab cannot be obtained from anything in the book
- Location: 03-research-compendium.qmd:1428-1431
- Quote: '$ zzc analysis  # tidyverse base-image profile; archetype set separately'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`grep -rn -i --include='*.qmd' "install.*zzcollab\|zzcollab.*install\|github.com/rgt47"` over `analysis/report` returns only an unrelated line in 07; no URL, repository, or install command for zzcollab appears anywhere)
- Prior: new
- Problem: The worked example, the layout listing (03:712-742), and the make targets (03:1447-1462) assume a tool the book never tells the reader how to install or where to find. The glossary entry (glossary.qmd:871-873) gives no link either.
- Why it matters: A self-study reader cannot follow the chapter's only hands-on walkthrough, and a skeptical mentor will read an unobtainable tool as vendor lock-in.
- Fix: Add an install box at first use (repository URL, version or commit, and the one-line install), plus a note on what to do without Docker. Alternatively, follow D2 and make the worked example tool-neutral (see the next findings).

### The author's stake in zzcollab is not disclosed
- Location: 03-research-compendium.qmd:629-633
- Quote: 'The `zzcollab` framework organizes these as the Five Pillars.'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (references.bib:916-923, author `rgtlab curriculum team`, `@unpublished`, no URL; preface.qmd:57-71 'The tool, and why it is here' gives no authorship statement; credits.qmd:3-9 calls it an 'accompanying methodological paper')
- Prior: new
- Problem: The book's central organizing constructs are attributed to a whitepaper that readers cannot obtain. It credits a team rather than a person, and nowhere does the book state that the book's author develops the tool. Section 2 of the prompt asks whether the dependence is disclosed. The use is disclosed; the competing interest is not.
- Why it matters: A referee or a skeptical mentor will discount the framework's claims once they discover the relationship, and an undisclosed self-citation in a book about transparency is a credibility risk.
- Fix: Add one sentence to the preface section: 'The author developed `zzcollab`; it is open source under <license> at <URL>.' Give `thomas2026zzcollab` a named author and a resolvable URL or DOI, or cite the repository itself.

### Tool-specific taxonomy is taught as the field's; D2 not implemented here
- Location: 03-research-compendium.qmd:1020-1035
- Quote: '`zzcollab` treats the research archetype as a first-class initialization parameter, orthogonal to the choice of computational environment'
- Severity: major
- Viewpoint: referee
- Evidence: inspected (15 zzcollab or `make docker-` references in 03; the Five Pillars at 625-676, the archetypes at 1010-1357, progressive disclosure at 1359-1396, and the worked example at 1418-1474 all appear in unboxed body text; no `use_compendium`, `create_project`, or plain `mkdir` alternative appears; Marwick's small, medium, and large compendium scale is absent)
- Prior: 'fix for D2 incomplete' (D2, REFACTOR-PLAN:2071-2075: concepts first, a boxed 'With zzcollab' track)
- Problem: The chapter's learning objectives (03:57-65) and cheat sheet (03:2031-2034) make zzcollab's Five Pillars, five archetypes, and 'progressive disclosure' the things to learn. None of the three is established vocabulary outside this tool. The literature the chapter cites classifies compendia differently: Marwick et al. 2018 grade them small, medium, and large. A reader without zzcollab learns the principles (raw versus derived, the package skin, gates by deliverable) only as embedded in one tool's vocabulary.
- Why it matters: Students outside this lab will not meet 'Five Pillars' or 'archetype' in papers, reviews, or other courses, so transfer suffers. The preface's claim that 'the concepts transfer without loss' is then asserted rather than shown.
- Fix: Introduce each construct in neutral words first ('five things to capture'; 'what the project delivers decides which checks apply'). Name Marwick's small, medium, and large compendia. Put every `zzc` and `make` command, and the `zzcollab.yaml` and `.zzcollab-state` lines of the layout, in a 'With zzcollab' callout. Give the worked example a parallel neutral path: `rrtools::use_compendium()` or `usethis::create_package()` plus `mkdir -p analysis/{data/raw_data,data/derived_data,scripts,figures}`, with `Rscript -e 'devtools::check()'` and `quarto render` in place of the make targets.

### The tool facts in Chapter 5 are stale: six archetypes, not five
- Location: 03-research-compendium.qmd:1026-1027
- Quote: 'Five archetypes are advertised.'
- Severity: major
- Viewpoint: referee
- Evidence: verified (`grep -n archetype zzcollab/modules/config.sh` line 574: 'valid: manuscript, analysis, book, package, simulation, blog'; `cat .zzcollab-state` in this repository: `archetype=book`; `zzcollab.yaml`: `archetype: book`)
- Prior: new (REFACTOR-PLAN:1711 noted 'six archetypes' in the second review; the text still says five)
- Problem: zzcollab offers six archetypes, and the repository the reader holds is the sixth, `book`, which the chapter never mentions. Meanwhile 'The cohort, continued' classifies the same repository as a data analysis (03:1549-1550). The table, figure, cheat sheet, objectives, and exercises all hard-code five.
- Why it matters: A reader who runs `zzc help` sees a list that contradicts the chapter, and a careful reader notices that the book's own compendium carries an archetype the chapter does not teach.
- Fix: Either teach six, with a one-paragraph 'book' archetype that uses this repository as its example and reconciles it with the cohort's 'data analysis' classification, or state that the chapter teaches five of the tool's six and why. Better, since prose cannot keep up with the tool, compute the list from the tool.

### The worked example uses a deprecated command and calls an auto-fixing target a gate
- Location: 03-research-compendium.qmd:1430, 1448
- Quote: '$ make check-renv     # dependencies declared and locked'
- Severity: major
- Viewpoint: referee
- Evidence: verified (zzcollab `templates/Makefile:134` `check-renv: ... ## Validate deps on host: strict + auto-fix`; `:137` `check-renv-no-fix ... nonzero on failure`; `modules/profiles.sh:265` and `modules/help.sh:32-36`: 'analysis' is a deprecated alias for the `tidyverse` profile; archetype is set with `zzc init --archetype A`)
- Prior: 'fix for Finding 32 (Ch 12 Exercise 4) incomplete': the same auto-fix defect, here in Chapter 5
- Problem: `make check-renv` rewrites the lockfile and then passes, so it cannot fail as a gate. This breaks habit 4, which the book itself teaches. `zzc analysis` is a deprecated alias whose name collides with the 'analysis' archetype the chapter is teaching, and the comment 'archetype set separately' never shows how to set it. The example also runs `make docker-*` two chapters before Docker or `make` is introduced.
- Why it matters: The chapter's one demonstration of a gate uses a command that cannot fail, and a novice cannot reproduce the setup from the comment.
- Fix: Use `zzc init --archetype analysis` followed by `zzc tidyverse`, and `make check-renv-no-fix`. Add one sentence saying that `make` runs named recipes from the `Makefile` and that the `docker-` targets need Chapter 7. Or use the neutral path proposed above.

### No route from 'never opened a terminal' to the first git command
- Location: version-control.qmd:57-64
- Quote: 'Git itself must be installed and configured; the preflight in the setup appendix'
- Severity: major
- Viewpoint: student
- Evidence: inspected (version-control.qmd has no link to `shell-primer.qmd` or `sec-shell`; `grep -n -i "open a terminal\|Git Bash\|PowerShell"` over the shell primer and setup appendix finds only one WSL line; the shell primer opens at `pwd` and assumes a prompt is already open)
- Prior: new (the third review assumed 'basic git'; the stated reader has never used a terminal)
- Problem: This is the first chapter in which the reader types commands (`cd`, `touch ... && git status`, `echo ... >`). Its prerequisites name the git preflight but not the shell primer. Nothing in the book says how to open Terminal on macOS, Git Bash or WSL on Windows, or the Terminal pane in RStudio or Positron.
- Why it matters: A student at the stated level stalls on page one of the chapter and cannot tell which window the commands belong in.
- Fix: Add to the prerequisites: 'If you have never used a terminal, work through @sec-shell first (about 30 minutes).' Add a short 'Opening a terminal' subsection to the shell primer (macOS Terminal; Windows Git Bash, installed with Git for Windows, or WSL; the Terminal tab in RStudio and Positron).

### Public versus private remote is never discussed for health data
- Location: version-control.qmd:1419-1423
- Quote: 'A public remote is the mechanism by which a compendium becomes locatable to the world.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (no occurrence of 'private repository', visibility, or 'make public' as a decision in the chapter; the only 'private' hits are 'private branch' and the 'private trial repository' at 1452)
- Prior: new
- Problem: The chapter equates L0 with a public remote but never tells a health-research student that the default choice is usually a private or institutional repository. Nor does it say that switching a private repository to public later publishes its entire history, including anything committed by mistake. Whether a private repository satisfies 'locatable by a second person' is also left undefined.
- Why it matters: This is the most consequential click a student makes on GitHub, and it is also a common route by which data leak in practice.
- Fix: Add a paragraph and a check: 'Create the repository private (or on your institution's GitLab or GitHub Enterprise) unless you have decided to publish. A private repository shared with your committee is L0. Before making any repository public, audit the whole history (`git log --all --stat`), not just the current files, because visibility applies to every commit.'

### Exercise 5 requires commands the chapter never teaches; no `clone`, `fetch`, or GitHub CLI
- Location: version-control.qmd:1871-1875; 2089-2105
- Quote: 'Construct the sequence of commands by which a collaborator at a second trial site would contribute a change through a fork'
- Severity: major
- Viewpoint: student
- Evidence: inspected (`git clone` appears only inside the PHI rewrite recipe at 827, and `git fetch` and `upstream` only in the solution; the fork and pull request of the worked example, 1709-1713, are prose only)
- Prior: new
- Problem: The exercise asks the reader to construct a sequence the chapter has not taught: clone, add an upstream remote, fetch, branch from `upstream/main`, push to the fork, open the pull request. The solution ends at `git push` and never says how the pull request is opened. Cloning, the first thing a student joining a lab does, is never taught as an everyday command. The GitHub CLI (`gh repo create`, `gh repo fork --clone`, `gh pr create`), now the common novice path, appears only in the appendix for authentication.
- Why it matters: The exercise cannot be done from the chapter, and the realistic first-week task (clone the lab's repository) has no instructions.
- Fix: Add a short 'Joining an existing project' subsection with `git clone`, `git pull`, and a `gh` alternative (`gh repo clone`, `gh pr create --fill`). End the Exercise 5 solution with 'open the pull request on the forge's web page, or `gh pr create`'.

### The PHI rule's second clause reads as an exemption
- Location: version-control.qmd:780-782
- Quote: 'not even briefly on a branch that is never merged, and not even in a local repository that will ever be pushed.'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: 'fix for T1-8 incomplete' (same callout; the negation was restored for the branch clause only)
- Problem: 'That will ever be pushed' is ungrammatical, and the natural reading is that a local repository that will never be pushed is exempt. That contradicts 'The rule admits no exception' in the preceding sentence and the IRB reality that a laptop clone is itself a copy.
- Why it matters: This is the rule the chapter calls gravest, and a literal reader can take the clause as permission.
- Fix: '...not even briefly on a branch that is never merged, and not even in a local repository that is never pushed.'

### The history-rewrite recipe omits the install and version requirement
- Location: version-control.qmd:820-834
- Quote: '`git filter-repo` removes the file from every commit on every branch and tag.'
- Severity: major
- Viewpoint: student
- Evidence: verified (<https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository>: 'You need a version with the `--sensitive-data-removal` flag, meaning at least version 2.47'; install separately, for example with Homebrew)
- Prior: new
- Problem: `git filter-repo` is not part of git. A reader in an incident who runs the command gets 'not a git command' or, with an older filter-repo, an unknown-option error.
- Why it matters: This failure arrives at the worst moment, under time pressure, and invites a fallback to the deprecated `filter-branch` or a search for unvetted advice.
- Fix: Add: 'filter-repo is a separate tool (`brew install git-filter-repo`, `pip install git-filter-repo`, or your package manager); `--sensitive-data-removal` needs version 2.47 or later (`git filter-repo --version`).'

### Seed-determinism label contradicts the chapter's own baseline rule
- Location: 03-research-compendium.qmd:1211, 1245, 1755, 1820
- Quote: ''R CMD check plus seed determinism','
- Severity: major
- Viewpoint: referee
- Evidence: inspected (text at 1146-1152 and Ex 5 solution 1929-1942 say a same-session determinism check is not the gate; `tbl-archetypes`, `fig-gates`, the Ex 1, 3, and 4 solutions, and `tbl-archetype-weight` 1354 still name 'seed determinism')
- Prior: 'fix for Tier 2 item (03, simulation gate contradicts itself) incomplete'
- Problem: The prose fix landed, but the table, the figure, and four solutions still name the gate by the property the text says is insufficient.
- Why it matters: Students remember tables and figures, and the label teaches the wrong test.
- Fix: Rename the column and gate 'Seeded baseline' everywhere, including the `fig-gates` factor levels and the solutions.

### Regulated-records material overloads a novice chapter
- Location: version-control.qmd:473-507; 1470-1478; 2130-2138
- Quote: 'Even then, a git history is not, by itself, the audit trail that FDA's regulations require of electronic records'
- Severity: major
- Viewpoint: student
- Evidence: inspected
- Prior: new (D20 kept the regulated material and scoped it; this finding concerns its placement in a novice chapter, not its retention)
- Problem: A reader who has never committed meets backdated commits under `GIT_AUTHOR_DATE`, collision detection, SHA-256, commit signing, branch protection, 21 CFR 11.10(e), and 11.50(a) in the core path. The 11.50(a) point appears twice more, once in the PR section and once in the Exercise 5 solution. The chapter runs to 65 minutes.
- Why it matters: Cognitive load pushes out the everyday cycle (status, add, commit, push, pull) that a novice must automate first.
- Fix: Keep the one-paragraph limit of tamper evidence in the core text. Move backdating, signing, and both Part 11 points into one collapsible 'For regulated work' callout, and delete the repetition in the Exercise 5 solution. Cut `git fsck --lost-found` (1297-1299) to 'may be partly recoverable; ask for help before doing anything else'.

### Package-development vocabulary is used without definition in Chapter 5
- Location: 03-research-compendium.qmd:44-46; 598-610
- Quote: 'No R fluency beyond reading a short script and a directory listing is assumed; this chapter writes almost no code itself.'
- Severity: major
- Viewpoint: student
- Evidence: inspected (tarball, roxygen, `NAMESPACE`, `Imports`, `Suggests`, `@export`, vignette, `load_all()` simulating 'a build, an install, and an attach' are used without a gloss; the vocabulary box at 283-318 defines none of them)
- Prior: new
- Problem: A student who has used R in one course has not met package anatomy, yet the package-skeleton section and the `R CMD check` section rely on it.
- Why it matters: The chapter's central argument (why the package skin matters) rests on terms the reader cannot parse.
- Fix: Add six entries to the vocabulary box: package tarball, `DESCRIPTION` `Imports` and `Suggests`, `NAMESPACE`, roxygen comment, exported function, vignette. Each one line, pointing to *R Packages* (2e).

### The archetype-weight table forward-references six chapters of undefined terms
- Location: 03-research-compendium.qmd:1349-1357
- Quote: 'Recorded seeds and the union lockfile are what a re-runner needs'
- Severity: major
- Viewpoint: student
- Evidence: inspected ('sealed render', 'union lockfile', '`targets` branching', 'R-universe', 'one-target build', and 'L3 compares tables and figures' all precede their chapters)
- Prior: new
- Problem: A 5-by-6 table of cells that cannot be read until Chapter 13 sits in the middle of the chapter's core path.
- Why it matters: It is the densest page in the chapter, and nothing in it is actionable for the novice at this point.
- Fix: Move `tbl-archetype-weight` to the end of the book (Chapter 13 or the cheat-sheet index), leaving one sentence here: 'Each later chapter notes how its weight differs by archetype.'

### Version control precedes the compendium but borrows its layout and archetypes
- Location: version-control.qmd:878-896
- Quote: 'its content depends on the archetype of the compendium, a classification the next chapter, @sec-compendium, develops in full.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected
- Prior: new
- Problem: Chapter 4's `.gitignore` section, Exercise 3, and the worked example use `analysis/data/raw_data/`, `DESCRIPTION`, and the archetype distinction before Chapter 5 introduces them. Putting version control first is defensible (habit 1), but the archetype comparison is a Chapter 5 topic.
- Why it matters: It adds a forward dependency to the novice's first hands-on chapter.
- Fix: Keep the chapter order. In Chapter 4 show one `.gitignore` for a plain analysis folder, and move the two-archetype comparison and Exercise 3 to Chapter 5's directory-layout section.

### The check-ignore transcript uses a pattern that defeats the `!` re-include
- Location: version-control.qmd:1647
- Quote: '#> .gitignore:1:analysis/data/raw_data/  analysis/data/raw_data/extract.csv'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (the recommended file at 901 and this repository use `analysis/data/raw_data/*`; the re-include example at 955-956 works only with `/*`, because gitignore(5) does not re-include a file whose parent directory is excluded; that documentation was not opened in this review)
- Prior: new
- Problem: The scratch transcript excludes the directory itself. With that pattern, the data-dictionary re-include the chapter recommends silently fails.
- Why it matters: A reader who copies the transcript's pattern loses the data dictionary without any warning.
- Fix: Regenerate the transcript with `analysis/data/raw_data/*`, and add one sentence: 'Use `dir/*`, not `dir/`, if you will re-include anything inside it.'

### Large files and line endings are not signposted from the chapter
- Location: version-control.qmd:747
- Quote: 'Large raw data files bloat every clone.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (no 'LFS', size limit, or `.gitattributes` in the chapter; setup-appendix.qmd:237-247 and the 100 MiB row of `tbl-git-refuses` cover them, but no link reaches them from here)
- Prior: new (THIRD-REVIEW-PLAN Section 7 asked for one sentence on large files in this chapter; it is absent)
- Problem: The chapter names the problem but gives no threshold, no alternative (Git LFS, an external archive with a checksum, DVC), and no warning that LFS does not make PHI safe. Windows line endings are not mentioned at all.
- Why it matters: Pushes refused at 100 MiB and CRLF diffs on every line are two of the most common novice failures.
- Fix: Add: 'GitHub refuses files over 100 MiB; keep large data outside git and record its location and checksum (@sec-archiving). Git LFS moves large files but does not make restricted data shareable. On Windows, see the line-endings step of the preflight.'

### No mention of the forge's secret scanning and push protection
- Location: version-control.qmd:765-769
- Quote: 'a credential committed to a repository, and worse pushed to a remote, is a credential to be treated as compromised.'
- Severity: minor
- Viewpoint: referee
- Evidence: verified (<https://github.blog/changelog/2024-03-11-secret-scanning-and-push-protection-are-enabled-by-default-on-new-public-repositories/>; <https://docs.github.com/en/code-security/how-tos/secure-your-secrets/prevent-future-leaks/push-protection-for-users>)
- Prior: new
- Problem: GitHub blocks many token formats at push by default for public repositories, and the chapter does not mention it. A novice who hits the block does not know what it is, and may bypass it.
- Why it matters: This is a current, free safety net, and it is also a refusal message the reader will meet.
- Fix: Add one sentence to the credentials bullet and one row to `tbl-git-refuses`. Note that push protection detects known secret formats, not PHI, so it does not replace `.gitignore`.

### No graphical route for a student who works in RStudio or Positron
- Location: version-control.qmd:58-61
- Quote: 'The git and shell commands that make up most of this chapter are independent of R'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (setup-appendix.qmd:185 'with the RStudio detail this book omits')
- Prior: new (the third-review model-book report judged RStudio screenshots 'not worth borrowing'; this finding asks for a pointer, not screenshots)
- Problem: The stated reader has used R in one course, most likely in RStudio, which has a Git pane. The chapter does not mention that the same operations exist there.
- Why it matters: A familiar interface lowers the first barrier, and the command-line model still applies.
- Fix: Add one paragraph: 'RStudio's Git pane, Positron's Source Control view, and GitHub Desktop perform the same stage, commit, push, and pull. This chapter uses the command line because it is the same everywhere and is what CI runs.' Link the Happy Git RStudio chapter.

### Default-branch and hash statements will age at Git 3.0
- Location: version-control.qmd:339-342; 441-443; 459-461
- Quote: 'although git itself still names it `master` unless told otherwise'
- Severity: minor
- Viewpoint: referee
- Evidence: verified, via search-result summaries only (<https://git-scm.com/docs/BreakingChanges>: `main` and SHA-256 are planned defaults for Git 3.0; no release date found as of this review; page not opened in full)
- Prior: new
- Problem: Both 'still names it master' and 'SHA-1 remains the default' become false when Git 3.0 ships. The glossary-style box does not qualify them by version, although line 442 does.
- Why it matters: These are the first facts to go stale, and they sit in the vocabulary box readers consult.
- Fix: Qualify every instance: 'as of git 2.x (Git 3.0 changes the default to `main`)'. Keep `git init -b main` and `init.defaultBranch`, which work under both.

### 'amend and rebase discussed earlier' were not discussed
- Location: version-control.qmd:1283-1285
- Quote: 'A reset, like the `amend` and `rebase` discussed earlier in this chapter, is a rewrite'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (both are only named in one sentence at 490-492)
- Prior: new
- Problem: The cross-reference promises an explanation the reader never received.
- Why it matters: A novice looks back for something that is not there.
- Fix: 'like `git commit --amend` and `git rebase`, which also replace commits (named in the git-model section)'.

### Creating the remote and authenticating are invisible in the worked example
- Location: version-control.qmd:1688-1707
- Quote: 'The work is backed up and made locatable by connecting a remote and pushing.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (the empty-repository step and the token step exist in setup-appendix.qmd:226-266 and are linked only after a failure; `git pull` at 1442 is shown with no outcome or divergence case)
- Prior: new (Finding 39 is largely fixed in the appendix; this concerns signposting)
- Problem: The worked example jumps from a local commit to `git remote add` with a URL that does not yet exist, and never says the push will ask for a token rather than a password.
- Why it matters: The first push is where most novices fail, and the chapter points to help only after the failure.
- Fix: Insert two lines before the push: 'Create an empty private repository on the forge (no README), or run `gh repo create --private --source . --push`. The first push asks for a token, not your password; see preflight step 4.'

### Displayed plotting code, and a prerequisite that miscounts R chunks
- Location: version-control.qmd:59-61; 1168-1215; 03-research-compendium.qmd:1232-1309
- Quote: 'the two R chunks that appear are read for their output, not written by the reader.'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (`_quarto.yml:151` `echo: true`; the VC chapter echoes five chunks, including 45 lines of ggplot for `fig-branch` and a tibble for `tbl-audit-trail`; 03 prints 75 lines for `fig-gates`, with comments on WCAG contrast ratios)
- Prior: new
- Problem: The prerequisite count is wrong. The figure-drawing code, including accessibility-engineering comments, is printed in two chapters aimed at novices.
- Why it matters: Pages of irrelevant code raise apparent difficulty and dilute the commands that matter.
- Fix: Set `echo: false` on `fig-branch`, `tbl-audit-trail`, `fig-gates`, and `tbl-archetypes`, and correct the prerequisite sentence.

### Shell prompts in Chapter 5 break copy and paste
- Location: 03-research-compendium.qmd:1429-1450
- Quote: '$ mkdir diabetes-cohort && cd diabetes-cohort'
- Severity: minor
- Viewpoint: student
- Evidence: inspected (Chapter 4 and the setup appendix use no `$` prefix)
- Prior: new
- Problem: The convention is inconsistent across chapters. Copying `$ make ...` gives 'command not found: $'.
- Why it matters: Novices copy and paste.
- Fix: Drop the `$` prefixes, following the book's other chapters.

### 'Universal gate' overstated for an analysis with an empty `R/`
- Location: 03-research-compendium.qmd:1813-1817
- Quote: 'each has functions in `R/` that must load, declared dependencies that must resolve, and tests that must pass.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected
- Prior: new
- Problem: The chapter's own first archetype, and its worked example at day one, keeps code in `analysis/scripts/`. There `R CMD check` passes almost vacuously, as the chapter's own blind-spot section implies.
- Why it matters: Students may take a passing check as evidence about the analysis.
- Fix: 'each can have functions in `R/`...; for an analysis whose code is all in `analysis/`, the check verifies little until functions move into `R/`.'

### An uncited 'representative deployment' names a real study population
- Location: 03-research-compendium.qmd:1074-1078
- Quote: 'A representative deployment is a study of the comorbidity of PTSD, depression, and diabetes among Black women drawn from a trauma-study cohort.'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (no citation)
- Prior: new
- Problem: Calling it a 'deployment' implies a real project, yet nothing is cited and the reader cannot inspect it. The archetype examples are also all biomedical, so a student in another field sees no example of their own (prompt Section 2).
- Why it matters: The example cannot be verified, and it reinforces the health-only framing.
- Fix: Cite it or say 'for example, a hypothetical...'. Add one non-health example in a parenthesis for each archetype (for example, an ecology field-survey analysis or an economics replication package).

### Further reading cites the superseded *R Packages* and spells Nüst two ways
- Location: 03-research-compendium.qmd:2053-2058
- Quote: 'should consult Wickham's book on R packages, which is the standard reference'
- Severity: minor
- Viewpoint: referee
- Evidence: inspected (body cites `wickham2023`, 2e, at 602 and 620; further reading cites `wickham2015`; 'Nüst' at 355, 'Nust' at 2057)
- Prior: new
- Problem: The reading list points to the first edition, which predates `usethis` and `tinytest` setup, and the author's name is spelled inconsistently.
- Why it matters: Readers buy or read the wrong edition.
- Fix: Cite `wickham2023` and use 'Nüst' in both places.

## Scope disclosure

- Read in full: `version-control.qmd` (2,284 lines);
  `03-research-compendium.qmd` (2,064 lines);
  `docs/fourth-review-prompt.md` (257); `THIRD-REVIEW-PLAN.md` (991);
  `docs/fourth-review/raw/BRIEF.md`.
- Read in part, for context: `setup-appendix.qmd` lines 176-292 (git
  preflight and refusals table); `shell-primer.qmd` lines 1-60;
  `_habits.qmd`; the zzcollab passages of `preface.qmd`, `index.qmd`,
  `00-intro.qmd`, `credits.qmd`, `colophon.qmd`, and `glossary.qmd`;
  `references.bib` entry `thomas2026zzcollab`; REFACTOR-PLAN
  2060-2100 and the grep hits for these chapters; the grep hits in
  `docs/third-review/model-book.md`, `reader-a.md`, and `reader-b.md`
  (excerpts only, not read in full).
- zzcollab source inspected by grep only (`modules/help.sh`,
  `config.sh`, `profiles.sh`, `status.sh`, `templates/Makefile`),
  plus this repository's `.zzcollab-state` and `zzcollab.yaml`.
- Code: nothing was executed. No render, no git commands in a scratch
  repository, no `R CMD check`, and no zzcollab command was run. The
  claim that a `dir/` pattern defeats a `!` re-include rests on
  gitignore documentation known to the reviewer, not on a run or an
  opened page.
- Web: the GitHub sensitive-data removal page was opened. Searches
  covered the status of Git 3.0 (no release found; result summaries
  only) and the default for push protection (changelog and docs URLs
  as cited). Not verified: the current maintenance status of
  `rrtools`; the Git for Windows installer's default branch setting;
  current GitHub ruleset terminology.
- Not assessed: the exercises' instructor-guide keys (distributed
  separately) and the rendered HTML and PDF of either chapter.
