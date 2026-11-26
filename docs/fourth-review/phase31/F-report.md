# Phase 31, Agent F: CI (Ch 11), Archiving (Ch 12), Appendix B
*2026-11-26 09:09 PST*

Files edited: `analysis/report/09-continuous-integration.qmd`
(Ch 11), `analysis/report/10-archiving-sharing.qmd` (Ch 12),
`analysis/report/ci-other-forges.qmd` (Appendix B). No shared
file was edited. Proposed bib entries are at the end. Chapter
numbers below are the new ones.

## Summary table

| ID | Status | Where |
|---|---|---|
| R12-04 | Done (computed figure) | Ch 11, `fig-ci-flow`, after the `verify` job listing in 'Verification and level L3' |
| R12-07 | Done | Ch 11, `sec-ci-secrets`, new paragraph after the Dependabot paragraph |
| R12-08 | Done (seventh row) | Ch 11, `tbl-ci-reading-workflow` row 'Nested quoting'; lead-in and caption updated |
| R12-09 | Done | Appendix B: comment in both GitLab listings, two sentences in the prose after the first listing |
| R12-10 | Done | Ch 11, Exercise 2 prompt and solution; 'Before you start' card |
| R12-11 | Done | Ch 11, Exercise 1 solution |
| R12-12 | Partly done (most already present) | Appendix B prose; Ch 11's first workflow already says 'not necessarily the newest release' |
| R4-008 (Ch 12) | Done for four funders | Ch 12, new `tbl-funders` in 'Funder and journal obligations', cross-referencing `tbl-mandates` |
| R13-04 | Partly done (openICPSR not added) | Ch 12, new `tbl-repositories` and a version-DOI paragraph in 'Sharing with the world' |
| R13-05 | Done | Ch 12, new `tbl-license-choice` in 'Licensing, CITATION.cff, and Software Heritage' |
| R13-06 | Done | Ch 12, CITATION.cff paragraph |
| R13-07 | Done | Ch 12, NIH funder paragraph |
| R13-08 | Done | Ch 12, `rang` paragraph in 'Stewardship over time', Exercise 5 prompt and solution |
| R13-09 | Done | Ch 12, worked-example listing, Exercise 8 solution, cheat sheet row |
| R13-11 | Done | Ch 12, the sentence after 'restores from' in the registry check answer |
| R4-010 (Ch 12) | Done; journal rows not added | Ch 12, opening of `sec-restricted-deposit` and its 'Restricted data' callout; journal note before `tbl-journal-code` |

## Word counts (`wc -w`)

| File | Before | After |
|---|---|---|
| `09-continuous-integration.qmd` | 15,895 | 16,719 (+824) |
| `10-archiving-sharing.qmd` | 16,191 | 17,622 (+1,431) |
| `ci-other-forges.qmd` | 1,672 | 1,764 (+92) |

About 400 of the Ch 11 increase are the figure's two R chunks
(`wc -w` counts code). This gives back roughly 30 percent of the
Phase 30 cut (D27). The reading-time test still passes for both
chapter cards (70 and 65 minutes), so no card was changed.

## Changes and evidence, by finding

**R12-04 (figure).** A two-row flow figure, `fig-ci-flow`. The top row is
the job `gates`: push or pull request, check out and restore, then
Gates 1 to 3. An arrow labeled `needs: gates` leads to the bottom
row, the job `verify`: rebuild the image, run the tests with a
baseline, then the commit status. Each box carries, in code type,
the key, action, step name, or script it corresponds to in the
listings (`on:`, `setup-renv`, `check-r-package`,
`dependency-gate.R`, `Render gate`, `docker build`,
`run-tests.R`). The listings have no line numbers, so boxes map to
names, not lines. The figure follows `fig-pipeline-dag` and
`fig-tag-digest`, which are inline ggplot chunks. The node data and
the alt text are built in a hidden chunk before it, and
`fig-alt: !expr ci_flow_alt` computes the alt text from the same
data frame the plot draws. That is the property the shared
`fig-stack` functions provide. One lead-in paragraph was added. No
Unicode glyphs are used. *Proposal for the lead:* move the
data and the alt builder into `R/` as a shared function, as the
stack figure does. `R/` is not my file. Verified: rendered in the
scratch book; the PNG was inspected and the HTML `alt` attribute
holds the computed text.

**R12-07.** One paragraph: a pin freezes the runtime the action
declares; GitHub removed Node 20 in September 2026 and asked
maintainers to move to Node 24. It also states that `checkout`
at `v4` still declares `node20` and that `v7.0.1` declares
`node24`. It quotes the changelog's 'Runners now use Node 24 for
JavaScript actions' and says that whether a Node 20 action runs
correctly under it was not checked. The closing sentence says only
that a pinned workflow gets the maintainer's Node 24 *release* when
someone updates the pin. Verified
today: changelog opened
(<https://github.blog/changelog/2026-09-23-node-20-is-no-longer-available-in-github-actions>,
dated 23 September 2026: 'Node 20 is no longer available on
GitHub Actions runners'; maintainers 'update its `runs.using`
value to `node24`'). `gh api` on `actions/checkout`
`action.yml`: `ref=v4` gives `using: node20`, and `ref=v7.0.1`
gives `using: node24`. The latest release is v7.0.1 (published
2026-07-20).

**R12-08.** Phase 28 had already added the six-row table. I added
the missing row: `error-on: '"warning"'`, a YAML string holding
an R string. The lead-in now says 'and a seventh that the next
workflow adds', and the caption was split into two sentences to
stay under 35 words. Inspected today: `r-lib/actions`
`check-r-package/action.yaml` (via `gh api`) pastes the input into
R code as `error_on = (${{ inputs.error-on }})`, and its default
is `'"warning"'`. The row's last sentence says only that unquoted
`warning` is read as a name, not as text. What `rcmdcheck` then
does was not run.

**R12-09.** The YAML comments are scoped to the tag and the date
('rocker/verse:4.6.1 listed amd64 only on 26 November 2026').
Docker Hub tags API, today: `rocker/verse:4.6.1`
(updated 2026-10-29) and `4.6.2` (updated 2026-11-16) each list
only `('amd64', 'linux')`. Both GitLab listings carry a comment,
and the prose states the consequence for an arm64 runner. 'Fails
or runs under emulation' is inferred, not observed.

**R12-10.** Exercise 2's prompt now names 'the verify job or the
checksum manifest'. The solution says 'checksum manifest' and
'verify job' and drops 'and derived outputs'. The Ch 11 'Before
you start' card said 'verification gate', which became 'verify
job'. The phrase 'verification gate' remains in
`07-literate-programming.qmd:1790`, not my file.

**R12-11.** The Exercise 1 solution now says that a repointed tag usually
rebuilds without error. CI then either fails or, if the verify job
runs a baseline test, reports the changed estimate. Inferred, as
in the review.

**R12-12.** CRAN today
(<https://cran.r-project.org/src/base/R-4/>): R-4.6.2 dated
2026-10-29 is the newest; there is no 4.6.3. `renv.lock` records
4.6.1. Ch 11's first workflow already reads 'the R version
recorded in `renv.lock`, which is not necessarily the newest
release', so nothing was added there. Appendix B now says that
4.6.1 is the version this book's lockfile records, that 4.6.2
was the newest release on 26 November 2026, and that a compendium
names its lockfile's release, not the newest.

**R4-008 (Ch 12).** `tbl-mandates` (Ch 2) already holds NIH DMS,
NIH Public Access, the OSTP memo, PLOS Computational Biology and
the AEA, so Ch 12 cross-references it. The new `tbl-funders` adds
only the four funders whose pages I opened today, and each row
states only what the page says:

- NSF (<https://www.nsf.gov/public-access>, updated 18 September
  2025): a data management plan in every proposal, with
  unit-specific requirements in solicitations; publications
  deposited in NSF-PAR for proposals due on or after 25 January
  2016; datasets not required there. The page links 'Public
  Access Plan 2.0' but gives no effective date for it, so the
  table says nothing about it.
- UKRI
  (<https://www.ukri.org/manage-your-award/publishing-your-research-findings/making-your-research-publications-open-access/>,
  updated 26 August 2026): articles submitted on or after
  1 April 2022; CC BY 'or other permitted licence'; 'A publisher
  embargo period is not permitted' on route two; a data access
  statement in every article. I did not open a UKRI data policy,
  so the Plan column reads 'Not stated on the page read'.
- Wellcome
  (<https://wellcome.org/research-funding/guidance/policies-grant-conditions/data-software-materials-management-and-sharing-policy>,
  updated 3 July 2026): an outputs management plan where outputs
  will be of value to others. Data underpinning a publication are
  available at publication, 'as well as any original software that
  is required to view datasets or to replicate analyses'.
  Persistent identifiers are required.
- Horizon Europe, from the European Research Executive Agency page
  (<https://rea.ec.europa.eu/open-science_en>, undated): open
  access to publications and to research data is mandatory, 'as
  open as possible, as closed as necessary', with FAIR data and a
  data management plan kept up to date. The page does not mention
  software, so neither does the row.

The quotes on these four pages were confirmed with a text
extract, not only with WebFetch's summary. British spellings were paraphrased
into US English outside quotations.

**R13-04.** New `tbl-repositories` with four kinds: general-purpose
(Zenodo, OSF); general-purpose, data only (Dryad, which takes data
in any discipline); institutional; controlled access (dbGaP).
**The table has no discipline-specific row**: openICPSR, the one
candidate, could not be opened. The Zenodo sentence no longer
carries the 'be sure the files did not change' clause, which came
from a different Zenodo page (`help.zenodo.org/docs/deposit/manage-versions/`)
than the one cited. It is followed by
a paragraph on the GitHub integration and on concept and version
DOIs. Opened today:

- Zenodo <https://zenodo.org/help/versioning>: the concept DOI
  'represents all of the versions' and 'resolves to the landing
  page of the latest version'. 'You should normally always use
  the DOI for the specific version'.
- GitHub
  <https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content>:
  'Zenodo can only access public repositories'; 'issues a new DOI
  each time you create a new GitHub release'.
- OSF <https://help.osf.io/article/220-create-dois>: DOI for a
  project or component that is public; 'DOIs are minted for
  preprints and registrations automatically when they are made
  public'.
- Dryad <https://datadryad.org/requirements>: no files with terms
  incompatible with CC0; code and software can be uploaded via
  Dryad for hosting on Zenodo, 'linked and accessible through the
  Dryad DOI'.

**Not done:** openICPSR. <https://www.openicpsr.org/openicpsr/>
redirects to an ICPSR page that returned HTTP 403, so it is not in
the table. The institutional row makes no factual claim beyond
'ask the library'.

**R13-05.** New five-row `tbl-license-choice`: code, data you
collected, derived data from a licensed source, restricted data,
and prose and figures. Two rules precede it: Creative Commons
licenses are not recommended for software, and licensed or
restricted data are not the analyst's to license.

- choosealicense.com (opened today): MIT and GPLv3 descriptions.
  The non-software page names CC0-1.0, CC-BY-4.0, and CC-BY-SA-4.0
  for non-software material and says 'Creative Commons does not
  recommend its licenses be used for software'.
- `usethis` 3.2.1 on this machine exports `use_mit_license`,
  `use_apache_license`, `use_gpl_license`, `use_cc0_license`, and
  `use_ccby_license`. The table uses `use_gpl_license(version = 3)`,
  as Ch 5 does. No function was run.
- Ch 5 line 621 already says 'the choice is argued in
  @sec-archiving'; it now is.
- A paragraph after the table warns that the functions do not
  combine. Verified in a scratch package, in a non-interactive
  session with `usethis` 3.2.1: `use_mit_license()` and then
  `use_ccby_license()` left `License: CC BY 4.0` in `DESCRIPTION`
  while `LICENSE.md` still began '# MIT License'. A mixed compendium
  therefore runs one function, for its code, and writes the rest
  by hand. Interactive behavior (usethis may ask before
  overwriting) was not tested.

**R13-06.** Two sentences, verified today:

- CFF schema guide via `gh api`: 'When there are multiple licenses,
  it is assumed their relationship is OR, not AND.'
- Zenodo <https://help.zenodo.org/docs/github/describe-software/citation-file/>:
  'Zenodo will only use the .zenodo.json metadata and ignore the
  CITATION.cff entirely.'

**R13-07.** Ch 12 already cited NOT-OD-26-100 for the new format
from 25 May 2026. The transition rules were added. An active award
under the 2023 policy revises its Plan at its next progress report
(RPPR). Every active award expected to generate scientific data,
including those under the 2003 policy, does so by the FY2027 RPPR.
Verified today with a text extract of
<https://grants.nih.gov/grants/guide/notice-files/NOT-OD-26-100.html>
(released 29 July 2026). I also re-opened NOT-OD-26-120: K awards
'are not required to submit a DMS Plan', effective immediately. That
confirms the existing sentence.

**R13-08.** The CRAN page today reads 'Archived on 2026-08-22 as
issues were not corrected in time'. The archive's last release is
`rang_0.3.0.tar.gz`. Changes:

- The body names the install route and the bib entry `rangcran`.
- Exercise 5 gives the install line.
- The solution uses `created <- '<YYYY-MM-DD>'` in place of the
  hard-coded '2026-06-29'.
- The solution states what was run.
- The GitHub route in the old body text was removed, because I did
  not run it.

Verified, with R 4.6.2 and scratch libraries under the
scratchpad:

- `remotes::install_version('rang', version = '0.3.0')` into a
  fresh library installed `parsedate` and `pkgsearch` from CRAN
  and then `rang` 0.3.0. The host library supplied the other
  dependencies, so a bare machine would also fetch those, which
  the text says.
- `rang::resolve('digest', snapshot_date = '2024-01-01')` reported
  `digest` 0.6.33.
- `rang::dockerize()` wrote `Dockerfile`, `rang.R`, and `README`.

Not run: the solution's whole-lockfile listing, and the docker
build of the generated file.

**R13-09.** The worked example now prints the full listing of
the image's `/project` (pruning `renv/library`), which is the check,
and then a `comm -23` against `git ls-files` as a filter that
brings untracked files forward. The comments say that a committed
data file appears in the full listing but not in the filtered one.
The temporary files go to `/tmp`, outside the repository, because
files in the build context are copied by a later `COPY . .` (the
test showed exactly that). The old claim that the expected result
is an empty listing was removed. The Exercise 8 solution and the
cheat-sheet row were changed to match. The solution explains why a
name search is itself a plan, and notes that the listing covers
only the directories that `COPY` writes to. Verified on Docker 29.9.2 with a scratch repository and
an `alpine:3.20` image (`--platform linux/amd64`, `COPY . .`,
`.dockerignore` `**/*.csv`), with untracked files `extra.tsv` under
`raw_data/` and `notes-cohort.tsv` at the root:

- The old `find / -xdev -path '*raw_data*' -type f` printed only
  `/project/analysis/data/raw_data/extra.tsv`.
- The new pipeline printed `analysis/data/raw_data/extra.tsv` and
  `notes-cohort.tsv`.
- After `extra.tsv` was committed (Exercise 8's premise, read as
  a commit on the branch), the full listing still showed it but the
  `comm -23` filter did not. This is why the full listing is the
  check.
- The test used an alpine toy image with no `renv` restore; an R
  image was not tested. Its image, `inspect-demo:latest`, was
  removed by exact tag afterward. No prune or other Docker
  cleanup was run, and the pulled `alpine:3.20` base was left
  alone.

The book's listing omits `--platform` and uses the example's image
name; it remains a static illustration. No check answer used the
old command (grep).

**R13-11.** The garbled sentence was reordered as the review
proposes.

**R4-010 (Ch 12).** The opening of `sec-restricted-deposit` and
the 'Restricted data' callout now name patient records, licensed
survey microdata, administrative records, and export-controlled or
proprietary data. The release conditions now read 'de-identified or
otherwise cleared', 'any consent, and the agreement or license',
and 'data steward, IRB, or data provider'. One sentence marks the
HIPAA, dbGaP, and NIH material as examples. The journal rows for
PLOS Computational Biology and the AEA were **not added**: they
would duplicate `tbl-mandates`. A sentence before
`tbl-journal-code` points there instead.

## How quoted strings were checked

Confirmed with a plain-text extract (Python `urllib` or `curl`) on
26 November 2026: the four funder pages, NOT-OD-26-100,
NOT-OD-26-120, the OSF and Dryad pages, the GitHub
referencing-and-citing page, the Zenodo citation-file page, both
choosealicense pages, the Node 20 changelog, and the CFF schema
guide (`gh api`). **WebFetch summary only:**
`zenodo.org/help/versioning`, which refused scripted fetches
(HTTP 403, and `curl` returned a 763-byte stub). The book makes no
direct quotation from it, only a paraphrase: the concept DOI
represents all versions and resolves to the newest, and Zenodo
advises citing the version DOI.

## Checks run

- `` `r `` grep on all three files: every hit is pre-existing,
  intended inline R. No new prose code span begins with `r `.
- No em or en dashes and no contractions in added lines. Added
  prose was split at sentence ends; the two sentences over 35
  words, the NIH transition sentence and the `tbl-ci-reading-workflow`
  caption, were split.
- Test suite (command from the Phase 30 brief): an earlier run
  showed one failure, in `translating-tools.qmd` line 67, a file
  that is not mine. The final run after all edits: 456/456 pass,
  including the reading-time checks.
- Scratch render: I cloned the repository into
  `/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/clone`
  and copied in my three files. I appended the proposed entries to
  that clone's `references.bib` (HEAD version). Then I ran
  `quarto render <file> --to html` per file with
  `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`. All three exited 0. The
  only warnings are unresolved cross-references to other chapters
  (`sec-*`, `tbl-archetype-weight`, `tbl-mandates`). There were no
  R errors and no missing citations. `fig-ci-flow`,
  `tbl-repositories`, `tbl-license-choice`, and `tbl-funders` are
  present in the HTML. All three were re-rendered after the final
  edits, with the same result. **PDF not rendered**: the three new
  tables have relative column widths in their dash rows, as
  `tbl-mandates` does, but their PDF layout is unchecked.

## Not done, untested, or open

- openICPSR (HTTP 403), as above.
- The figure's mapping is to names, not YAML line numbers.
- 'Fails or runs under emulation' on arm64 GitLab runners is
  inferred.
- What GitHub runners now do with a `node20` action was not
  observed.
- The new tables add about 1,000 words to Ch 12. The author may
  prefer `tbl-funders` in Ch 2 beside `tbl-mandates`; I kept it in
  Ch 12 per the finding.

## Proposed changes to shared files

1. `references.bib`: add the 17 entries below (each has a `year`).
2. `R/`: optionally hoist the `fig-ci-flow` data and alt-text
   builder into a shared function, as `plot_determinant_stack()`
   and `determinant_stack_alt()` are.
3. Glossary (optional): 'concept DOI' and 'version DOI'.

```bibtex
@misc{rlibcheckaction,
  author  = {{r-lib}},
  title   = {check-r-package: action.yaml, in r-lib/actions},
  year    = {2026},
  url     = {https://github.com/r-lib/actions/blob/v2/check-r-package/action.yaml},
  urldate = {2026-11-26}
}

@misc{githubnode20removal,
  author  = {{GitHub}},
  title   = {Node 20 Is No Longer Available in {GitHub} Actions},
  year    = {2026},
  note    = {GitHub Changelog, 23 September 2026},
  url     = {https://github.blog/changelog/2026-09-23-node-20-is-no-longer-available-in-github-actions},
  urldate = {2026-11-26}
}

@misc{cranrsources,
  author  = {{The R Foundation}},
  title   = {R Sources, {R}-4 Series},
  year    = {2026},
  note    = {CRAN directory listing; R-4.6.2.tar.gz dated 29 October 2026},
  url     = {https://cran.r-project.org/src/base/R-4/},
  urldate = {2026-11-26}
}

@misc{rockerversetags,
  author  = {{Rocker Project}},
  title   = {rocker/verse Tags},
  year    = {2026},
  note    = {Docker Hub; tags 4.6.1 and 4.6.2 list the linux/amd64 architecture only},
  url     = {https://hub.docker.com/r/rocker/verse/tags},
  urldate = {2026-11-26}
}

@misc{zenodoversioning,
  author  = {{Zenodo}},
  title   = {Versioning},
  year    = {2026},
  url     = {https://zenodo.org/help/versioning},
  urldate = {2026-11-26}
}

@misc{osfdoi,
  author  = {{Center for Open Science}},
  title   = {{OSF} Projects: Create a {DOI}},
  year    = {2026},
  url     = {https://help.osf.io/article/220-create-dois},
  urldate = {2026-11-26}
}

@misc{dryadrequirements,
  author  = {{Dryad}},
  title   = {Submission Requirements},
  year    = {2026},
  url     = {https://datadryad.org/requirements},
  urldate = {2026-11-26}
}

@misc{githubciting,
  author  = {{GitHub Docs}},
  title   = {Referencing and Citing Content},
  year    = {2026},
  url     = {https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content},
  urldate = {2026-11-26}
}

@misc{choosealicense,
  author  = {{GitHub}},
  title   = {Choose an Open Source License},
  year    = {2026},
  url     = {https://choosealicense.com/},
  urldate = {2026-11-26}
}

@misc{choosealicensenonsoftware,
  author  = {{GitHub}},
  title   = {Licenses for Non-Software Material},
  year    = {2026},
  url     = {https://choosealicense.com/non-software/},
  urldate = {2026-11-26}
}

@misc{cffschemaguide,
  author  = {{Citation File Format}},
  title   = {Guide to the Citation File Format Schema},
  year    = {2026},
  url     = {https://github.com/citation-file-format/citation-file-format/blob/main/schema-guide.md},
  urldate = {2026-11-26}
}

@misc{zenodocitationfile,
  author  = {{Zenodo}},
  title   = {Citation File},
  year    = {2026},
  note    = {Zenodo help, GitHub integration: describe your software},
  url     = {https://help.zenodo.org/docs/github/describe-software/citation-file/},
  urldate = {2026-11-26}
}

@misc{nsfpublicaccess,
  author  = {{National Science Foundation}},
  title   = {Public Access},
  year    = {2025},
  note    = {Page last updated 18 September 2025},
  url     = {https://www.nsf.gov/public-access},
  urldate = {2026-11-26}
}

@misc{ukrioa,
  author  = {{UK Research and Innovation}},
  title   = {Making Your Research Publications Open Access},
  year    = {2026},
  note    = {Page last updated 26 August 2026},
  url     = {https://www.ukri.org/manage-your-award/publishing-your-research-findings/making-your-research-publications-open-access/},
  urldate = {2026-11-26}
}

@misc{wellcomedata,
  author  = {{Wellcome}},
  title   = {Data, Software and Materials Management and Sharing Policy},
  year    = {2026},
  note    = {Page last updated 3 July 2026},
  url     = {https://wellcome.org/research-funding/guidance/policies-grant-conditions/data-software-materials-management-and-sharing-policy},
  urldate = {2026-11-26}
}

@misc{reaopenscience,
  author  = {{European Research Executive Agency}},
  title   = {Open Science},
  year    = {2026},
  note    = {Undated page on open science under Horizon Europe},
  url     = {https://rea.ec.europa.eu/open-science_en},
  urldate = {2026-11-26}
}

@misc{rangcran,
  author  = {{CRAN}},
  title   = {Package rang},
  year    = {2026},
  note    = {Archived on 2026-08-22; last release 0.3.0 in the CRAN archive},
  url     = {https://CRAN.R-project.org/package=rang},
  urldate = {2026-11-26}
}
```
