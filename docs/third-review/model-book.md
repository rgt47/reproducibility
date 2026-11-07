# Model-book comparison: Happy Git and GitHub for the useR
*2026-11-07, reviewer: model-book*

## Summary

1. Major [V]: on a stock git 2.56.0 install, `git init` creates `master`. The chapter's `git push -u origin main` (version-control.qmd:1223, :1417) then fails, and :947-948 says that `main` is git's default. Happy Git's 'Introduce yourself to Git' chapter covers this case.
2. Major [I]: the book has no git or GitHub setup anywhere. Nothing covers identity, credentials (PAT or SSH), or a first push. The setup appendix covers Docker only, so Happy Git's 'half the battle' lesson goes unapplied where the appendix says it is avoiding lost weeks.
3. Devices worth borrowing: one-line task-first openings, commands paired with 'should look something like this' transcripts, a throwaway-repo test drive that ends in cleanup, symptom-titled troubleshooting, and 'practice before you need it' for the PHI-removal procedure.
4. Not worth borrowing: RStudio-pane instructions and screenshots, the informal register, forty short chapters, and Happy Git's 'accumulation of diffs' storage model (the book's snapshot account at :329-331 is the correct one). Committing rendered outputs should be presented as a competing view, not adopted.
5. Rendering defect [V, rendered HTML inspected]: `@sec-archiving.` at the start of a line inside a list item becomes a Pandoc example list. The Chapter 13 cross-reference disappears in version-control (:1932), and the same defect appears in 01 (:275) and 03 (:487). Of the prior-pass items checked, seven are confirmed, one is probably refuted, and one is partly confirmed (details at the end).

## Sources opened (all on 2026-11-07)

These are the Happy Git pages I actually read. I read them through a fetch tool that summarizes, so short quotations are as returned by that tool [I].

- https://happygitwithr.com (table of contents, landing page)
- https://happygitwithr.com/big-picture.html
- https://happygitwithr.com/install-intro.html
- https://happygitwithr.com/install-git.html
- https://happygitwithr.com/hello-git.html
- https://happygitwithr.com/https-pat.html
- https://happygitwithr.com/push-pull-github.html
- https://happygitwithr.com/troubleshooting.html
- https://happygitwithr.com/new-github-first.html
- https://happygitwithr.com/rmd-test-drive.html
- https://happygitwithr.com/git-basics.html
- https://happygitwithr.com/push-rejected.html
- https://happygitwithr.com/burn.html
- https://happygitwithr.com/workflows-browsability.html

## How the two books are built

Happy Git has about 40 short chapters, typically 600 to 1,800 words each [I]. Setup takes up two whole parts ('Installation', 'Connect Git, GitHub, RStudio'). Chapters open with the task itself. Push-pull-github starts 'Objective: make sure that you can pull from and push to GitHub from your computer'. Push-rejected starts 'Problem: You want to push changes to GitHub, but you are rejected like so:' and then shows the verbatim error. The voice is first person and opinionated ('Just don't.'), and it uses few screenshots: push-pull-github has one annotated image, and install-git and troubleshooting have none [I].

Chapter 4 of this book is a single chapter of about 12,700 words including code (`wc -w`) [V], with a stated reading time of 60 minutes (:51). It argues a position. Version control is the L0 rung, a git history is weaker evidence than a regulated audit trail (:423-457), and PHI governs what may be committed (:648-773). For a graduate health-sciences course, that argument is the book's main advantage over Happy Git. Happy Git never discusses 21 CFR Part 11, tamper-evidence, or data-use agreements, and it should not be the model for those sections.

## Findings, ranked

### Major

**M1. The default branch name is wrong, and the chapter's own commands fail on a stock install.** version-control.qmd:300-301, :947-948, :1223, :1417, :1899. [V] In a scratch directory with `GIT_CONFIG_GLOBAL=/dev/null`, git 2.56.0 prints 'Using 'master' as the name for the initial branch. This default branch name will change to "main" in Git 3.0'. `git branch --show-current` reports `master`, and `git push -u origin main` fails with 'error: src refspec main does not match any'. The sentence 'main is merely the branch git creates by default' (:947-948) is false for current git. A student who follows the worked example on a fresh laptop hits this on the first push. Happy Git's hello-git chapter handles it with `git config --global init.defaultBranch` and the usethis equivalent [I].
*Fix:* rewrite :947-948 to say that git currently creates `master` unless `init.defaultBranch` is set, and that GitHub creates `main`. Add `git config --global init.defaultBranch main` to the setup preflight proposed in M2. Alternatively, have the worked example run `git branch -M main` before the first push.

**M2. No git or GitHub setup exists anywhere in the book.** setup-appendix.qmd:1-14, version-control.qmd:53-60, :1218-1230. [I] A grep of every chapter qmd plus the setup appendix and shell primer finds no `git config`, `user.email`, personal access token, SSH key, or credential helper [V, structural check only]. The appendix opens by citing a review that warned 'weeks 2 to 4' are lost to installation trouble (:10-12), yet it addresses only Docker. On a fresh install, the first `git commit` stops with 'Author identity unknown *** Please tell me who you are.' [V, same scratch run]. The first HTTPS push to GitHub needs a token, because GitHub does not accept account passwords for git operations [EK]. Happy Git spends five chapters on exactly this. Its install-intro calls setup 'honestly half the battle' and notes that experts underwrite it because it stopped being hard for them [I]. The audience 'knows basic git' (brief), but a course that relies on that assumption still needs a five-minute check that it holds.
*Fix:* add a short 'Git and GitHub preflight' section to setup-appendix.qmd, before the Apple Silicon section at :16. It needs no theory, only checks with expected output:

- `git --version`
- `git config --global --list`, showing `user.name`, `user.email`, and `init.defaultBranch`
- `usethis::git_sitrep()`, or `gh auth status`, to confirm a stored credential

Each check should point to the matching Happy Git chapter (install-git, hello-git, https-pat) instead of repeating it. Add one line to the 'Before you start' box (:53) that names this preflight as a prerequisite.

**M3. Nothing in the chapter is a runnable end-to-end rehearsal.** version-control.qmd:1365-1372 says 'The shell sessions below are illustrative and are not executed'. :770-773 asserts a scratch-repository result for the PHI rewrite without showing it. [I] Happy Git's push-pull-github chapter is a complete test drive with a clear end: create the repo on GitHub, clone, edit, commit, push, check in the browser, then delete both copies. Its burn chapter says 'Practice this before you need it' [I]. The book's most consequential procedure, the five-step PHI response (:727-768), is the one a reader most needs to have rehearsed. In this chapter it is described but not practiced. Exercise 2 (:1549-1554) is the only exercise with a hands-on loop, and it never touches a remote.
*Fix:* add a 'Test drive' exercise built around a throwaway GitHub repository:

1. Create the repository with a README and clone it, which teaches clone-first (see m1).
2. Commit a synthetic `extract.csv`, push, delete the file in a new commit, and show with `git log --all -- extract.csv` that it is still in the history.
3. Run the filter-repo recipe from :744-752 on a fresh clone.
4. Show that an old clone still holds the file.
5. Delete both repositories.

This turns the claim at :770-773 into something the reader watches happen, which also enacts habit 4 ('watch it fail once').

**M4. Commands are mostly shown without their output.** :395-398, :478-487, :540-568, :1218-1230, :1380-1430. [I] Happy Git pairs nearly every command block with 'This should look something like this:' and a transcript [I]. The book does this once, for the merge conflict (:1119-1126), and that block is among the chapter's clearest passages. Without expected output, a reader cannot tell success from a near miss. Examples are `git status` at :1384 ('confirm the extract is NOT listed') and `git log --all` at :750 ('expect no output').
*Fix:* add abbreviated `#>` transcripts, the shell primer's own convention (shell-primer.qmd:22-35), to at least `git status` before and after a `.gitignore` takes effect, `git log --oneline`, and the first `git push -u` (including the 'branch 'main' set up to track' line).

**M5. There is no troubleshooting organized by symptom for git.** version-control.qmd as a whole. setup-appendix.qmd:143-154 does this well for Docker. [I] Happy Git's troubleshooting chapter titles each entry with the symptom in the reader's words ('Push rejected', 'I hear you have some Git repo inside your Git repo'), and push-rejected opens on the verbatim error [I]. The book's appendix table (:148-154) already takes this form for Docker and is the right model. Chapter 4 has no equivalent, yet these failures are predictable in a course:

- 'Please tell me who you are' [V]
- 'src refspec main does not match any' [V]
- push rejected because a GitHub-created README is absent locally [EK]
- `git pull` refusing divergent branches without a configured strategy [EK, current git behavior from recall]
- a repository nested inside another repository
- CRLF warnings on Windows

*Fix:* add a 'When git refuses' table to the setup appendix, with columns for the verbatim message, its cause, and the fix. Link to it from Chapter 4's cheat sheet (:1888).

### Minor

**m1. Local-first is the only workflow taught, and clone is never taught as a starting point.** :392-398, :1214-1230. `git clone` appears only inside the filter-repo recipe (:745) and an exercise solution (:1775) [V, grep]. Happy Git recommends 'GitHub first, then RStudio' and gives local-first ('Existing project, GitHub last') its own chapter as the harder case [I]. Course work usually starts from a cloned template, so the book should present clone as the main entry. *Fix:* in the remote section, present `git clone` first and `git remote add` second.

**m2. The chapter has four previews before its first command.** :20-28 (aims), :30-37 (roadmap), :62-82 (five questions), :84-101 (outline), and then two orienting sections before `git init` at :395 [I]. Happy Git uses one line. *Fix:* keep the five questions and the outline, and merge :20-37 into a two-sentence task-first opening, for example 'By the end you will have a tagged repository whose `.gitignore` you have watched block a file.'

**m3. The book disagrees with Happy Git on committing rendered outputs without saying so.** :660-668, :800-803. Happy Git's browsability chapter argues for committing derived `.md` and PNG figures. Its reason is that 'diffs of downstream files can expose unexpected shifts in the underlying data or in the packages' [I]. That is the book's own habit 5 (baseline comparison) in different form. The check answer at :896-903 concedes the choice is a judgment, but the body text presents ignoring outputs as the default without naming the alternative. *Fix:* add two sentences at :664 giving the counter-argument with a citation, and noting that committed outputs act as a crude baseline.

**m4. Happy Git is mentioned but neither cited nor linked.** :1919-1920. `references.bib` has `bryan2018` but no Happy Git entry [V, grep]. *Fix:* add a bib entry with its URL. Then cite specific chapters where they are the right reference: hello-git and https-pat for M2, push-rejected for M5, browsability for m3.

**m5. A rendering defect drops cross-references.** version-control.qmd:1931-1932 renders, in `_book/version-control.html:1592-1595` (built 2026-11-07 11:14, after the qmd was last edited), as '...developed in Chapter 12 and' followed by an `<ol class="example">` holding 'This chapter is best read...'. The reference to `@sec-archiving` is lost [V, rendered HTML read]. Pandoc reads a continuation line inside a list item that begins with `@label.` as an example-list marker. The same `ol class="example"` appears in `_book/01-reproducibility-crisis.html` (source 01:275) and `_book/03-research-compendium.html` (source 03:487) [V, grep]. *Fix:* rewrap those three lines so no line inside a list item begins with `@sec-...`. Add a lint check that greps rendered HTML for `class="example"`.

**m6. Exercise 5's solution uses an older command than the chapter teaches.** :1780 uses `git checkout -b`, while the body teaches `git switch -c` (:937, :1898) [I]. *Fix:* use `git switch -c fix/outlier-threshold upstream/main`.

**m7. The setup appendix opens with justification instead of a check.** setup-appendix.qmd:3-14. Happy Git's install-git opens with 'Git already installed?' and two commands to run [I]. *Fix:* open with `docker version` and its expected two-block output (currently item 1 at :28-31), and move the rationale below it. Drop the uncited '2026 expert review' (:10-12, :105-108); see item 38 below.

## Devices not worth borrowing, and why

- **RStudio-pane workflows and screenshots** (Happy Git new-github-first, rmd-test-drive). The book is shell-first by design (:56-60), its later chapters need the shell for Docker and CI, and IDE screenshots go stale quickly. A single sentence noting that the RStudio and Positron Git panes run these same commands is enough, perhaps at :479.
- **The informal, joking register** ('Just don't.', mild profanity in troubleshooting). This conflicts with the author's academic style rules. The part worth keeping is the firmness: give one recommended default, such as HTTPS with a token.
- **Forty short chapters.** Chapter 4's argument from capture to L0 to the limits of evidence needs to be read in one piece. The better move is to put the reference material (M5's table, the undo recipes at :1032-1166) where readers can look it up, as the cheat sheet partly does.
- **'Burn it all down' as everyday advice.** The book's `reflog` route (:1084-1088) is more precise. A fresh clone also does nothing about PHI that has already been pushed. If the burn advice is mentioned at all, it should carry that caveat.
- **Happy Git's storage model.** git-basics says 'Git's notion of any specific version... is as an accumulation of diffs' [I]. The book correctly says git stores snapshots and computes diffs on demand (:329-331) [EK: git stores whole objects, with delta compression only inside packfiles]. Keep the book's version.
- **The `.Renviron` fallback for a PAT** (https-pat, Linux section). It conflicts with the book's rule that `.Renviron` is a secret to ignore (:684, :796). Refer readers to a credential helper or `gitcreds` instead.

## Status of prior-pass items for these two files

- **28 (:144-161), confirmed [I].** Seven files are listed, three of them with 'final' in the name. The text then says 'five FINAL files' and 'four snapshots'.
- **29 (:1849-1854), confirmed [I].** The 'Verification' callout (:829-843) is about `.gitignore`. The cohort check is the untitled paragraph at :869-875, and it reports no `nrow`.
- **31 (setup :35-37, :152), probably refuted.** `docker buildx imagetools inspect rocker/tidyverse:4.4.0` shows an index containing only `linux/amd64` plus attestations [V]. Against such an index, an arm64 pull reports 'no matching manifest' [EK; the user's own global instructions record this error]. So the book's claim holds for the pinned tag. However, `rocker/tidyverse:latest` now lists `linux/arm64` [V], so :18-21 ('publish a `linux/amd64` entry only') needs a 'for the 4.4.0 tags this book pins' qualifier. `rocker/verse:latest` is still amd64-only [V].
- **32 (setup :93-98), confirmed [V].** A CRLF-shebang script gives 'bad interpreter: /bin/sh^M' on macOS and 'exec /w/x.sh: no such file or directory' in an Alpine container, not `exec format error`. *Fix:* quote the 'no such file or directory' or 'bad interpreter ... ^M' messages instead.
- **33, confirmed for :154 [I].** '/mnt/c ... or on Windows' own filesystem' names the same place twice.
- **38, confirmed [I].** The '2026 expert review' (setup :10-12, :105-108) is uncited and refers to the book's own production history.
- **48, confirmed in each part [I].**
  - 'Habit 1' labels both `git status` (:1895) and 'Commit before you compute' (:1906). `_habits.qmd` makes the latter habit 1.
  - The Exercise 8 solution (:1860-1885) says both 'L0 holds' and 'restore... L1 and L2' without naming one rung.
  - The Exercise 5 solution (:1791-1793) says a fork 'establishes that the contributor did not hold write access'. Anyone, including maintainers, can fork, so it establishes nothing of the kind [EK].
  - The Exercise 3 solution (:1694-1710) lists `renv/library/` and `inst/doc/`, which are absent from the samples at :792-827, and omits `docs/`.

## What was not done

I did not render the book; the HTML check used the existing `_book` build. I did not build a project image. I did not test an actual GitHub push, so the token requirement and the README-rejection case are [EK]. I read Happy Git through a summarizing fetch tool, not the raw page source.
