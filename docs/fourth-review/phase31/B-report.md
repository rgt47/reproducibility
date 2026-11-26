# Phase 31, agent B: Chapters 4 and 5
*2026-11-26 09:02 PST*

Files edited: `analysis/report/version-control.qmd` (Ch 4) and
`analysis/report/03-research-compendium.qmd` (Ch 5). No other book
file was touched. No commit.

## Summary table

| ID | Status | Change (file) |
|---|---|---|
| R4-V05 | Done, with one deviation | Ch 4. The git-model section keeps one core paragraph on the limits of tamper evidence: client-set identity and dates, and rewriting by amend, rebase, and filter-repo. A collapsed 'For regulated work' callout follows it. The callout holds the backdating command, signing and branch protection, the Part 11 audit-trail point with the 11.10(e) quotation, and the 11.50(a) signature point. The pull-request section's 11.50(a) passage is now one pointer sentence. The repeated 11.50(a) passage in the Exercise 5 solution is deleted. `git fsck --lost-found` is cut to 'may be partly recoverable; ask for help before doing anything else'. **Deviation:** the step-3 'Regulated records' warning in the incident procedure stays, because the LLM section ('its third step requires') and the cheat-sheet row depend on it. Its 11.10(e) quotation moved into the new callout, and the warning now points there. |
| R4-V06 | Done | Ch 4 worked example. The `check-ignore` line now reads `.gitignore:1:analysis/data/raw_data/*`. The block header says 'git 2.56.1, run 2026-11-26', and the section's provenance sentence notes that date. One sentence after the `!` refinement says to use `dir/*`, not `dir/`, and why. The LLM section's 'better prompt' now says `raw_data/*`. |
| R4-V07 | Done | Ch 4 `.gitignore` section. Added GitHub's 100 MiB block, citing the existing `@githublargefiles`. Large data are to stay outside git with location and checksum recorded (`@sec-archiving`). Git LFS stores a pointer and keeps the content elsewhere, but it does not make restricted data safe to push. A file link points to preflight step 5 for line endings. |
| R4-V08 | Partly done | Ch 4 credentials bullet. GitHub's user push protection is on by default and blocks recognized secrets pushed to public repositories. Repository-level protection is off until an administrator enables it. It matches secret formats, not patient data, so it supplements `.gitignore`. The refusals-table row is in `setup-appendix.qmd`, which is not my file; it is proposed below. |
| R4-V09 | Done | Ch 4, after the first commit cycle: one paragraph on RStudio's Git pane (with a link to the Happy Git chapter), Positron's Source Control view, and GitHub Desktop. It also says why the chapter uses the command line. |
| R4-V10 | Done | Ch 4 vocabulary box ('Git 2.x still names it `master`'; Git 3.0 is planned to change it), the `git init -b main` paragraph ('no release date as of 26 November 2026', with the BreakingChanges URL), and the SHA-1 sentence ('default in git 2.x; the planned Git 3.0 makes SHA-256 the default for new repositories'). |
| R4-V11 | Done | Ch 4 reset paragraph: 'like `git commit --amend` and `git rebase`, which also replace commits (named in the git-model section)'. The core paragraph still names both. |
| R4-V13 | Done | Added `echo: false` to `fig-stack-version-control`, `tbl-audit-trail`, and `fig-branch` (Ch 4), and to `fig-stack-compendium`, `tbl-archetypes`, and `fig-gates` (Ch 5). The Ch 4 prerequisite's 'two R chunks' is now true: a grep finds exactly two echoed chunks, the cohort check and the fixture check. The text was left unchanged. The two stack-figure chunks were not on the reviewer's list. I hid them too because they draw figures, and hiding them is what makes the count right. |
| R5-04 | Done | Ch 5 vocabulary box gains six entries after one pointer line to *R Packages* (2e) [@wickham2023]: package tarball, `Imports` and `Suggests`, `NAMESPACE`, roxygen comment, exported function, and vignette. `load_all()` is already explained where it is used. |
| R5-05 | Done: **moved to the end of the chapter**, not into a callout | The whole section 'How each archetype treats the chapters ahead', including `tbl-archetype-weight`, now sits just before `## Exercises`, after 'Collaborating with an LLM'. It opens with a sentence saying it is a reference, not first-pass reading. At its old place, a four-line pointer remains. The label is unchanged, because seven other chapters cite `@tbl-archetype-weight`. The Orientation roadmap and the card's Outline were updated. A callout was rejected for two reasons: a captioned seven-column float inside a box is a PDF risk, and a cross-reference into a collapsed box lands on hidden content in HTML. |
| R5-06 | Partly done | Moving the comparison and Exercise 3 to Ch 5 is moving material between files, which the brief forbids. The local fix in Ch 4 instead frames the `.gitignore` split by what the project produces, glosses 'archetypes' once as the next chapter's word for project types, rewords the objective ('a `.gitignore` suited to what the project produces') and the Exercise 3 prompt, and drops 'naming the archetype'. The Exercise 3 solution still uses 'archetype', which is now glossed in the chapter. |
| R5-07 | Already done (inspected) | `grep -n -E '^\s*\$ '` finds no `$` prompt in either file. Phase 30 rewrote the worked example. |
| R5-08 | Done | Ch 5 Exercise 3 solution: 'Each *can* have functions in `R/`...' and 'For an analysis whose code is all in `analysis/`, with `R/` still empty, the check verifies little until functions move into `R/`.' |
| R5-09 | Done; flagged for the author | Ch 5. 'A representative deployment is...' (manuscript) became 'Consider a paper on the comorbidity of PTSD, depression, and diabetes in a trauma-study cohort'. 'among Black women' was dropped as identifying detail of what may be a real study. The package archetype's 'representative deployment' sentence became a neutral description. Each of the five archetypes gained one non-health parenthetical: an ecological field survey, an economics replication package, a package of survey-design estimators, a simulation of an estimator's bias under nonresponse, and a methods blog. **Author:** if either example is your own published work, cite it, and restore the population if you want it. |
| R5-10 | Done | Further reading now cites *R Packages* (2e) by Wickham and Bryan (`@wickham2023`) and spells it 'Nüst'. The body's historical `@wickham2015` (line 375, Marwick et al. built on the first edition) is kept on purpose. |

Incidental: the Ch 5 Exercise 1 solution still said 'seed
determinism' (R5-03 residue); it now says 'the seeded-baseline gate'.

## Currency sources opened today (2026-11-26)

- <https://git-scm.com/docs/BreakingChanges>: Git 3.0 is
  'upcoming', and the page says 'There is no planned release
  date for this breaking version yet'. New repositories will
  default to `main` and to `sha256`. Last updated in 2.55.0.
- <https://git-scm.com/>: the latest release is 2.56.1, dated
  2026-10-26. Git 3.0 has not shipped.
- <https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github>:
  'GitHub blocks files larger than 100 MiB'; a warning appears
  above 50 MiB.
- <https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage>:
  LFS stores 'references to the file in the repository, but not
  the actual file itself'.
- <https://docs.github.com/en/code-security/secret-scanning/introduction/about-push-protection>:
  repository push protection 'is disabled by default'. User push
  protection is enabled by default and stops pushes of secrets
  to public repositories. It detects partner, generic, and custom
  patterns.
- <https://happygitwithr.com/rstudio-git-github.html> ('Connect
  RStudio to Git and GitHub'),
  <https://positron.posit.co/git.html> (Source Control view:
  stage, commit, push, pull), and
  <https://docs.github.com/en/desktop/overview/about-github-desktop>
  (commit and push, on Windows and macOS). The GitHub Desktop page
  did not confirm pull, so the book says only 'commits and
  pushes'.
- Not opened, and not asserted: whether push protection can be
  bypassed.

## What I ran (verified)

Script: `scratchpad/v06.sh`, run with `GIT_CONFIG_GLOBAL=/dev/null`,
git 2.56.1, and a synthetic identity.

- A plain `git init` gives branch `master` and object format
  `sha1`, with the hint 'will change to "main" in Git 3.0'.
- In the worked-example tree, before `.gitignore`, the untracked
  list names `analysis/data/raw_data/extract.csv`. After a
  `.gitignore` whose line 1 is `analysis/data/raw_data/*`, the
  extract is gone from the list, and `git check-ignore -v` prints
  `.gitignore:1:analysis/data/raw_data/*	analysis/data/raw_data/extract.csv`.
  That is the line now in the book, with the tab shown as spaces,
  as before.
- Reviewer premise, verified: with `raw_data/` and
  `!raw_data/data_dictionary.csv`, the dictionary stays ignored
  (`check-ignore` names `.gitignore:1:raw_data/`). With
  `raw_data/*`, `git status` lists it as untracked, and
  `check-ignore` names the `!` line.
- Only the status and check-ignore block was regenerated. The
  commit, log, diff, and push transcripts keep their 2026-11-08
  hashes, because they recur across blocks.

## Word counts (`wc -w`)

| File | Before | After |
|---|---|---|
| `version-control.qmd` | 15839 | 16195 |
| `03-research-compendium.qmd` | 14428 | 14753 |

Nothing that other text depends on was cut. The deleted Ex 5
11.50(a) sentences, the PR-section 11.50(a) sentences, and the
step-3 11.10(e) quotation all survive in the new callout. The
`fsck` detail had no other reference.

## Tests and render

- tinytest: 456/456 before and 456/456 after, including the
  reading-time test, so no card change was needed.
- Inline R: every `` `r `` hit in both files is meant to run
  (Ch 5: `skeleton_*`, `desc_*`, `root_readme`, `pillars`, and
  `rung`; Ch 4: the cohort and fixture checks). None is new.
- Scratch render (`scratchpad/render.sh`): a mirror of the
  project layout, rendered with `quarto render <file> --to html`
  and `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`. Both files exit 0.
  The only warnings are unresolved `@sec-` references to other
  chapters, which are expected. There is no R error. Neither HTML
  contains `quarto-unresolved-ref` or `citation-missing`.
  `tbl-archetype-weight` resolves within Ch 5, and the 'For
  regulated work' callout renders. PDF was not rendered.

## Proposed changes to shared or other files

1. `setup-appendix.qmd`, `tbl-git-refuses`: add a row (R4-V08).
   Symptom: 'A push to a public GitHub repository blocked by push
   protection, naming a detected secret (the forge's message; not
   reproduced)'. Cause: 'A recognized credential, such as a
   provider token, is in a commit being pushed.' Remedy: 'Treat
   the secret as exposed and rotate it; remove it from the
   unpushed commits (`git commit --amend` or `git reset`) before
   pushing again; do not bypass the block. Push protection
   matches secret formats, not patient data.' Update the caption
   from 'the two forge rows' to 'the three forge rows'.
2. `references.bib`: bump `githublargefiles` `urldate` to
   2026-11-26. Optionally add bib entries for the push-protection,
   Git LFS, and BreakingChanges pages, which are cited by inline
   URL for now.
3. Instructor guide: if its key for Ch 4 Exercise 5 relies on the
   deleted 11.50(a) sentence, update it. I did not inspect the
   guide.
4. Glossary: 'archetype' could note the Ch 4 gloss. This is
   optional.

## Not done or untested

- The forge's own push-protection and size-limit messages were
  not reproduced.
- PDF rendering of the moved table was not checked. Its position
  changed, not its markup.
- I could not determine whether the two Ch 5 examples (the
  comorbidity paper and the summary-table package) are the
  author's real projects. They are flagged above.
