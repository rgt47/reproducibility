# Phase 30, Agent X: Chapter 11 (CI) cuts and zzcollab track
*2026-11-26 08:32 PST*

Files: `analysis/report/09-continuous-integration.qmd` (edited) and
`analysis/report/ci-other-forges.qmd` (new). No shared file was
edited. Line numbers labeled 'old' are those of the file before this
phase's edits, not REVIEW.md's numbering. Unlabeled ranges refer to
the edited chapter and are approximate.

## Word counts (`wc -w`)

| File | Before | After |
|---|---|---|
| `09-continuous-integration.qmd` | 18,573 | 15,895 (-2,678) |
| `ci-other-forges.qmd` | (none) | 1,672 |

The chapter cut is about 2,700 words, roughly 300 short of the 3,000
target. About 300 words were added inside the chapter: three 'With
zzcollab' boxes, the real output of `ci/dependency-gate.R`, the
rewritten debugging order, and qualifications that the script makes
only the weaker check. The vocabulary box, which duplicates the
glossary, is the obvious remaining cut; I did not make it.

The appendix has no 'Before you start' card or reading time. It has
one check and one exercise, each with a collapsed answer or solution.

## Changes by finding

**R4-011 item 3 and R12-03 (cuts).**

- The capture test matrix section ('Proving the framework itself',
  old 1482-1548, with its check) is deleted. Before deleting it, I
  grepped the book for the section, 'capture test matrix' and
  'testing the claim': nothing outside the chapter refers to it, so no
  pointer sentence was left.
- The GitLab and presence-driven material (old 998-1158, including
  the 'presence-driven trap' check) moved to `ci-other-forges.qmd`.
  The chapter keeps a 14-line `## Other forges` section (996-1010).
  It covers the Makefile shim and gives `@sec-ci-other-forges`.
- Old Exercise 4 (GitLab translation) and its solution moved to the
  appendix as its Exercise 1. Its YAML now calls
  `Rscript ci/dependency-gate.R` instead of `make check-renv-no-fix`,
  and the three Makefile cautions moved into the appendix's
  'With zzcollab' box.
- Restatements removed:
  - the Orientation paragraph's 'captures no new layer ...
    pinning is capture' (old 182-190);
  - most of 'The machine that is not yours' paragraph (old 378-391);
  - the 'capture versus validation' check after 'Where CI bugs
    hide' (old 850-878), which duplicated Exercise 1. It is replaced
    by a shorter check on the two cross-boundary failures (860-876);
  - 'validate and capture nothing' in the external-verification
    section;
  - 'a CI run captures nothing' in the 'what CI does not know'
    answer, now a pointer to `@fig-stack-ci`;
  - the Exercise 1 solution, cut from 3 paragraphs to 2 short ones;
  - the first paragraph of Further reading.
- Kept: the stack section, the figure, the honest-level callout, and
  Exercise 1 itself, since removing it would shift Exercise 7.
- The Exercise 3 solution's serialization essay and plot paragraph
  (old 2434-2483) are cut to a three-sentence paragraph, 'Why it is
  still the wrong tool' (about 2185-2197). It still answers each
  sub-question: what makes the digest unreliable when the values are
  unchanged, and why a tolerance is the right instrument.
- Card: the Prerequisites no longer mention Exercise 4. The Outline
  replaces 'two CI dialects' with 'other forges' and drops the capture
  test matrix. The reading time goes from 80 to 70, the value the
  test gives. No objective mentioned GitLab or the matrix.
- 'The presence-driven workflow discovers the archetype' (archetype
  section) was rewritten to cite `@sec-ci-other-forges`.

**Exercise renumbering (a deviation from the assignment, flagged).**
A plain renumber would have made the cohort exercise number 6. Exercise
7 is the cohort exercise in every chapter, and the instructor guide
depends on that: 'Exercise 7 of each of Chapters 2 to 12', the
`ig-ch09` chunk, and the chunk label `ci-ex7-key`. I therefore
reordered instead:

| Old | New |
|---|---|
| 5 | 4 |
| 6 | 5 |
| 8 (Spacing) | 6 |
| 7 (cohort) | 7 |

Exercises and solutions were renumbered together. The cost is that
Spacing is now 6, not 8 as in the other chapters. If the lead prefers
eight exercises, the cheapest fix is a new Exercise 6. One candidate
is R12-01's 'push a workflow, see green, add `library(sandwich)`, see
red'; slot 8 would then go back to Spacing. The Solutions preamble now
reads 'Exercises 3 and 7 are hands-on'. A grep found no reference to
this chapter's exercise numbers elsewhere in the book or the
instructor guide.

**R12-02 / D29 (zzcollab track).**

- In the main workflow (about 689-750), Gate 2 is now
  `run: Rscript ci/dependency-gate.R`, with no `shell: Rscript {0}`.
  The install step installs only `rcmdcheck`. The faded copy and
  answer (4) match (about 1547-1645).
- The `zzrenvcheck` paragraph became a 'With zzcollab' box (656-675).
  It covers `check_packages(strict = TRUE, error_on_fail = TRUE)`, the
  pinned `install_github`, and `make check-renv-no-fix` versus the
  auto-fixing `make check-renv`.
- The `.Rprofile` caveat is stated generally (a conditional profile)
  outside the box. `ZZCOLLAB_CONTAINER` is in a box (829-840).
- The `zzc verify` / `--full` / stamp paragraph became a box
  (1101-1125). The honest-level callout and the old 'trusting a
  stamp' check are reworded neutrally: 'a green verify run', and a
  check retitled 'trusting an old green run'.
- In the secrets section, the sentence about the personal-repository
  pin was removed.
- `ci/dependency-gate.R` checks only that a used package is pinned in
  `renv.lock`. The gates prose, the Exercise 2 solution and the
  archetype section now say that the strict `DESCRIPTION` inclusion
  is not what the script checks.
- Cheat sheet: the `zzrenvcheck` row is now `Rscript
  ci/dependency-gate.R`, and the two `zzc verify --full` mentions are
  gone.
- After these changes, `grep` finds `zzc`, `zzrenvcheck`, `make
  <target>` and `ZZCOLLAB` only inside the three boxes.
- Box claims checked against the zzcollab source (inspected):
  - `templates/Makefile:134-138` (`check-renv` auto-fixes;
    `check-renv-no-fix` uses `error_on_fail = TRUE`);
  - `:300` (`check` is `--as-cran`);
  - `:402-418` (the three `docker-render*` targets);
  - `templates/.Rprofile:52-53` and `modules/docker.sh:1228` (the
    generated Dockerfile sets `ZZCOLLAB_CONTAINER=true`);
  - `modules/verify.sh:145-332` (coherence checks include the R
    version across lockfile, Dockerfile and state, and the data
    manifest; `--full` stamps or clears the stamp);
  - `modules/toggle.sh:22-44`, `zzcollab.sh:2492` and
    `help.sh:177` (`zzc config set-local forge gitlab` followed by
    `zzc add cicd` installs `templates/gitlab/.gitlab-ci.yml`, whose
    header describes `exists:`-driven check and render stages).
- The correction to the `zzc verify` coherence sentence changed what
  the R version is compared with. It is now the `Dockerfile` and the
  state record, as `verify.sh:204-210` does.

**R12-06 (debugging order).** The section now runs (1659-1755):

1. read the failing step's log;
2. reproduce that step locally;
3. compare environments (`sessionInfo()`, `renv::status()`, a diff
   of `renv.lock`);
4. use the `targets` diagnostics, if the analysis is a pipeline;
5. bisect, last.

It is still five moves. The closing paragraph now argues for this
order, from cheapest to most expensive. The bisect paragraph gained a
sentence: bisection presumes an otherwise identical environment,
which is why the environment comparison comes first.

**Other small fixes.** The faded-workflow prompt now says one
placeholder (not two) stands for a block. One 'That is,' was removed
from the 'what CI does not know' answer.

## What I ran (real output)

- `ci/dependency-gate.R` on a scratch project. The lockfile pinned
  `digest` and `renv`; `analysis/scripts/01_clean.R` used `digest`.
  The script was
  `.../scratchpad/gate/run.sh`, run under R 4.6.2 and `renv` 1.3.1.
  - The passing run exited 0.
  - After `library(sandwich)` was added, it printed
    `Finding R package dependencies ... Done!`, then
    `Error: Used in analysis/ but not pinned in renv.lock: sandwich`
    and `Execution halted`, and exited 1.
  - This output is printed in the chapter (about 640-654). The
    breakage sentence now credits the second breakage to this run.
- `yaml::yaml.load` on every `yaml` block in both files, rerun after
  the final edits. All parse,
  including both GitLab files, the main workflow and the faded copy.
  A line-set diff of the main workflow against the faded copy shows
  that they differ only in the four placeholders.
- Test suite (brief rule 9), rerun after the final edits: 455
  results, 0 failures. On the first run, `test-reading-times.R`
  failed ('card says 80, rule gives 70'), so I set the card to 70.

## Untested, and why

- No workflow was pushed or run on GitHub or GitLab. The brief
  forbids it, and the text says so.
- `rcmdcheck` was not re-run for the first and third breakages. The
  sentence keeps their earlier October 2026 provenance.
- `zzc config set-local forge gitlab` and `zzc add cicd` were
  inspected in the source, not executed.
- The book was not rendered (brief rule 2). In particular,
  `@sec-ci-other-forges` (two uses in the chapter) does not resolve
  until the appendix is listed in `_quarto.yml`.
- The appendix contains no R chunk, and `_quarto.yml` sets no global
  engine, so Quarto would likely treat it as plain markdown. I
  therefore removed the one inline R expression the moved text
  carried (the lockfile's R version); the appendix now executes no
  code.
- Back-references to this chapter were read, not only grepped:
  - `shell-primer.qmd:315` still holds, because the verify job keeps
    `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`;
  - `shell-primer.qmd:428`, `06-backends-runtimes.qmd:379` and
    `:1496`, `03-research-compendium.qmd:432`, and
    `05-containers.qmd:855` refer only to content that stays.

## Proposed changes to shared files

1. `_quarto.yml`: add `ci-other-forges.qmd` under `appendices`,
   after `06-backends-runtimes.qmd`.
2. `06-backends-runtimes.qmd:1593-1596`: 'the presence-driven
   principle ... developed in @sec-verification' should point to
   `@sec-ci-other-forges`. Line 663 ('met throughout') can stay.
3. `10-archiving-sharing.qmd:1951-1957` prints `make check`, `make
   check-renv-no-fix` and `make docker-render` outside a box. It also
   duplicates the shim argument now in the appendix. It belongs to
   whoever owns Chapter 12, and should be boxed or replaced with
   `@sec-ci-other-forges`.
4. `glossary.qmd:247` (Forge) and `:871` (Workflow) cite only
   `@sec-verification`; add `@sec-ci-other-forges`.
5. The instructor guide needs no change for numbering, since Exercise
   7 is unchanged. If the lead instead renumbers plainly, the guide's
   'Exercise 7' text and `ci-ex7-key` must change.
6. `conventions.qmd` (lead): if the eight-exercise pattern (7 cohort,
   8 spacing) is a stated convention, record the exception or add the
   Exercise 6 proposed above.
