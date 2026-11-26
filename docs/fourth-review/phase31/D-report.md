# Phase 31, Agent D: Literate Programming (Ch 8), Backends (Appendix A), Translating the Tools
*2026-11-26 09:10 PST*

Files: `analysis/report/07-literate-programming.qmd` (Ch 8; REVIEW
calls it Ch 9), `analysis/report/06-backends-runtimes.qmd`
(Appendix A; REVIEW calls it Ch 8), and the new
`analysis/report/translating-tools.qmd`. No other file was edited.
Line numbers below are of the edited files.

Evidence labels: **V** = I ran it and saw the result, or opened the
primary source today; **I** = I read the source or documentation and
the claim follows from it; **Inf** = inferred; **U** = not verified.

Word counts (`wc -w`, HEAD to now): Ch 8 13,388 to 14,046 (+658);
Appendix A 10,098 to 11,222 (+1,124); `translating-tools.qmd` 697
(new). Nothing was cut, so no anchors were removed.

## Findings

| ID | Status | Change (file:lines) | Evidence |
|---|---|---|---|
| R9-03 | done | Ch 8 1003-1013 ('the usual typesetter ... is LaTeX'); new Typst paragraph 1033-1047; cheat-sheet row `format: typst` (2026) | V: rendered a minimal `format: typst` doc (the anatomy listing) with Quarto 1.11.9 under `PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Applications/quarto/bin`, where `pdflatex`, `xelatex`, `tlmgr` were all 'none'; output `report.pdf` read 'The laser-treated arm holds 197 eyes.' `quarto typst --version`: `typst 0.15.1`. Quote 'no separate installation of Typst is required' and 'still some limitations' from https://quarto.org/docs/output-formats/typst.html. The page says nothing about journal templates, so the book only says a document relying on LaTeX packages or a publisher's LaTeX template stays with `format: pdf` (I, not a claim from the page) |
| R9-04 | done | Ch 8 worked example 1332-1404: Quarto header (`format: pdf`/`html`, `execute:` echo/message/warning false, `date: today`); setup chunk reduced to `library()` calls; paragraph that R Markdown still works; `tbl-rmd-to-quarto` (three rows). `report.Rmd` to `report.qmd` at 8 places where it named the reader's report (877, 1002, 1196, 1247, 1254, 1277, 1309, 1334); the historical mentions at 410 and 2027 keep `.Rmd`. Check 'choosing the profile' now says `format: pdf`. Cheat-sheet `opts_chunk` row replaced by an `execute:` row | V: the header plus setup chunk plus a `fig-name` chunk rendered in scratch to HTML and PDF (exit 0; code and the chunk's `message()` absent from both; `@fig-name` resolved to 'Figure 1'; date 'November 26, 2026' in HTML, '2026-11-26' in PDF). `fig.path` was dropped: it is not an `execute:` key, and Quarto manages figure paths. R Markdown status quoted from https://quarto.org/docs/faq/rmarkdown.html ('not going away', 'no plans for deprecation', 'in most cases be rendered without modification'). `execute:` override behavior from https://quarto.org/docs/computations/execution-options.html |
| R9-05 | done | Ch 8 1075-1086 (frozen TeX Live paragraph); Exercise 4 solution (1829-1831) | V: `tlmgr help` (local TinyTeX) gives the default `https://mirror.ctan.org/systems/texlive/tlnet` and `tlmgr option repository`; https://www.tug.org/historic/ (via curl, HTTP 200; WebFetch got 403) lists the mirrors and says TL releases are under `systems/texlive/`; `https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2025/tlnet-final/` returned HTTP 200. I: zzcollab `modules/docker.sh:222-236`. That a past release's repository works only with that release's `tlmgr` is stated from the zzcollab comment ('a mirror serving a TeX Live release mismatched against the local install ... makes tlmgr refuse'), not run |
| R9-06 | done | Ch 8 check 'what the header's `date` field buys' rewritten (question and answer, about 1420-1445); cheat-sheet row `date: today` | V: scratch Quarto project with `freeze: true`: second render advanced `date: now` (09:03:44 to 09:03:53) while a chunk's printed `Sys.time()` stayed 09:03:43. A header `date` holding an inline R `Sys.time()` (with `engine: knitr`) kept 09:04:53 across two renders. `today` quoted from https://quarto.org/docs/reference/dates.html |
| R9-07 | done | Exercise 2 statement (1630-1637): render the single file, since a frozen project render reuses stored results | I: the chapter's own `@sec-freeze` text, cited to `quartoexecution` |
| R9-08 | done | 1176-1178 'a dated, traceable presentation' | I |
| R9-09 | done | 756: 'We call these landmines' (playbook attribution dropped). 1062-1066: tool-neutral rule (`format: pdf` in Quarto; `pdf_document`, `latex_engine` in R Markdown; Typst needs no LaTeX) replaces the uncited playbook description. I did not include `pdf-engine`, which can name a non-LaTeX engine | I |
| R9-10 | done | 1010-1013 'Its absence, or the absence of one package within it, is a common cause' | I |
| R9-11 | done | 1294-1295 `R/`, `inst/tinytest/`, `analysis/scripts/` (1241 already said `inst/tinytest/`) | I |
| R8-02 | done | Vocabulary 'Daemon' (243-249, no longer says they 'run without administrative rights'); Podman opening (310-320); new paragraph 338-350 (subuid/subgid, `newuidmap`/`newgidmap`, user-mode networking, administrator needed); 'Two properties' (352-356); `best_fit` 'licensing constraint; a workstation you administer'; Exercise 1 solution; cheat-sheet `podman run` row | V: https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md, quoted 'Root privileges are required to add or update entries within these files.' The glossary entries are the lead's (proposals below) |
| R8-03 | done, hedged | 1075-1085, after the cluster paragraph of the worked example | I: OpenBLAS FAQ https://github.com/OpenMathLib/OpenBLAS/blob/develop/docs/faq.md (run-time kernel selection, `OPENBLAS_CORETYPE`; deviations from FMA and from splitting work). Inf: that a laptop and a cluster node then differ in R results. The book says so: 'We infer, without having measured it' |
| R8-04 | done | `--platform linux/amd64` on `podman build` and `podman run` (Podman section) and on the worked-example `podman run` and the Exercise 1 solution; `--arch amd64` on the Apptainer section's build and the Exercise 2 solution, with a sentence on `--arch` and `uname -m` (`x86_64` for amd64) at 422-428; cheat-sheet rows | I: https://docs.podman.io/en/latest/markdown/podman-run.1.html and podman-build.1.html (`--platform`); https://apptainer.org/docs/user/latest/cli/apptainer_build.html (Apptainer 1.5): '--arch architecture to build for'. Following advice, I do not repeat the page's '(default "amd64")', which may reflect the build host. The cluster's `apptainer build` in the worked example and Slurm script runs on a login node, so it carries no `--arch`. U: no Podman or Apptainer is installed here; none of these commands was run |
| R8-05 | done (table lead-in and two rows revised after review: the module row cites https://modules.readthedocs.io/en/latest/module.html; the Slurm row now rests on https://slurm.schedmd.com/sbatch.html, 'If the requested time limit exceeds the partition's time limit, the job will be left in a PENDING state (possibly indefinitely)'; the unsourced memory-kill claim was dropped) | 'Where Apptainer runs' note (callout after the SingularityCE paragraph, 384-397); vocabulary entry 'Login node and partition' (259-264); Binder limits (731-738); `tbl-backend-failures`, five rows, after the Slurm disclaimer (about 1270-1289); Exercise 2 made conditional on a Linux machine or login node | V: https://apptainer.org/docs/admin/latest/installation.html (Apptainer 1.5.5): Linux only, 'cannot run natively on Windows or Mac', WSL2 and Lima. https://mybinder.readthedocs.io/en/latest/about/user-guidelines.html: 1 GB guaranteed, 2 GB maximum ('kernel will be restarted'), 10 minutes of inactivity, up to six hours. The table names no error text verbatim; its rows follow from the cited pages and were not reproduced on a cluster (said in the text). `module avail`/`module load` is generic environment-module usage (U for any given site) |
| R8-07 | done, reworded | 1255-1260: select the task's stream, the per-task streams of `@sec-testing`, precomputed from one seed with `parallel::nextRNGStream()`, indexed by the task | I: `R/cohort.R:312-333`. `replicate_streams()` runs all B replicates in one process, so it cannot hand a single Slurm array task its stream; I name the scheme, not the function, as the reviewer's wording would have misled |
| R8-08 | done, reworded | Pitfall, 1107-1115 | I: https://apptainer.org/docs/user/latest/bind_paths_and_mounts.html says the CWD is mounted with `--no-home` and that a CWD under `$HOME` needs `--no-mount home,cwd`. The page does not say `--no-home` 'has no effect'; the book says a job started in `$HOME` sees the home directory through the working-directory mount (Inf from the doc) |
| R8-09 | done | Opening (19-27), objectives (67-72), outline ('four'), orientation (162-176): the same four situations everywhere (cluster; no Docker Desktop license; Windows laboratory mixing R and Python; reviewer installing nothing). Grep finds no other 'three health scientists' | I |
| R8-10 | done | New hidden chunk `lock-r-version` (529-537) reads `renv.lock`; the `rix()` call (main text and Exercise 3 solution) is printed by an `asis` chunk with the computed version; the LLM prompt uses it inline; `dev_txt` reads the devcontainer's image from `.devcontainer/devcontainer.json` instead of typing `rocker/verse:4.4.0` and adds 'Its R, 4.4.0, is not the 4.6.1 the lockfile records.' Exercise 3 solution: the typed `2024-04-29` (true only for R 4.4.0) replaced by `rix::available_dates()` and the selection rule | V: scratch render prints `r_ver = '4.6.1'` and the dev sentence. I: rix main branch (`DESCRIPTION` 0.18.6): `inst/extdata/available_df.csv` lists 10 dates for 4.6.1; `R/get_latest.R` comment 'If a user provides an R version, use most recent date for that version'. The 'from earlier chapters' check keeps `rocker/r-ver:4.4.0`, which is a deliberate bad example |
| R8-11 | done | `tbl-backends` tibble (788-828) converted to single quotes; the new `rix` displays use single quotes. Double quotes inside single-quoted shell `Rscript -e` strings are required by the shell and remain | I |
| R8-12 | done | 376-386: Sylabs kept the name, continues as SingularityCE 4.6; a cluster may offer `singularity`; 'its own documentation says which flags it accepts' (no compatibility claim) | V: https://apptainer.org/news/community-announcement-20211130/ ('When Sylabs forked the Singularity project, they chose not to rename their fork'); https://sylabs.io/docs/ ('Latest Released Version: SingularityCE v4.6') |
| Daemon (glossary) | proposed | See proposals | V: Podman tutorial above |
| R4-009 bridge | done | New `translating-tools.qmd` (697 words, about one page): `tbl-translating-tools` (8 rows: version control, package versions, language behavior, environment, literate document, pipeline, tests, CI) and one cited source line per non-R tool; empty cells where nothing was confirmed (Python language-behavior row; Stata package versions, environment, pipeline, CI). Ch 8 paragraph on Jupyter and Pimentel et al. at 829-845, pointing to `@sec-translating-tools` | V, each opened today: uv https://docs.astral.sh/uv/concepts/projects/layout/; pixi https://pixi.prefix.dev/latest/workspace/lock_file/; Jupyter https://docs.jupyter.org/en/latest/; Quarto and notebooks https://quarto.org/docs/computations/python.html; Snakemake https://snakemake.readthedocs.io/en/stable/ (9.27.2); pytest https://docs.pytest.org/en/stable/; GitHub 'Building and testing Python' https://docs.github.com/en/actions/tutorials/build-and-test-code/python; Stata `version` https://www.stata.com/manuals/pversion.pdf (also selects the RNG: mt64 or kiss32), `dyndoc` https://www.stata.com/manuals/rptdyndoc.pdf (HTML or Word only), `assert` https://www.stata.com/manuals/dassert.pdf (return code 9). Pimentel figures V from the author PDF https://leomurta.github.io/papers/pimentel2019a.pdf: 1.4 million notebooks (abstract); '36.36% have cells out-of-order' among unambiguous-order notebooks; of 863,878 attempted executions 24.11% without errors, 4.03% same results. The book does not attribute the 4.03% to hidden state; it calls it the largest study of the landmine and reports the out-of-order share separately |

## Proposals for the lead (shared files)

1. **`_quarto.yml`:** add `translating-tools.qmd` under `appendices`,
   after `ci-other-forges.qmd` (Appendix C). It must be numbered:
   Ch 8 links it with `@sec-translating-tools`, which the test suite
   rejects for an unnumbered page.
2. **`references.bib`** (from Crossref, `10.1109/MSR.2019.00077`):

   ```bibtex
   @inproceedings{pimentel2019,
     author    = {Pimentel, Jo{\~a}o Felipe and Murta, Leonardo and
                  Braganholo, Vanessa and Freire, Juliana},
     title     = {A Large-Scale Study About Quality and
                  Reproducibility of {Jupyter} Notebooks},
     booktitle = {2019 IEEE/ACM 16th International Conference on
                  Mining Software Repositories (MSR)},
     publisher = {IEEE},
     year      = {2019},
     pages     = {507--517},
     doi       = {10.1109/MSR.2019.00077}
   }
   ```

3. **`glossary.qmd`:**
   - Daemon: 'A background system service that runs continuously
     with elevated privilege. A standard Docker installation relies
     on one; Podman and Apptainer do not. Running without a daemon
     is not running without an administrator: rootless Docker or
     Podman needs subordinate user IDs that only an administrator can
     add. (@sec-backends)'
   - Podman: replace 'A daemonless, rootless container runtime' with
     'A daemonless container runtime, able to run rootless once an
     administrator has set up subordinate user IDs, that runs the same
     images as Docker.'
   - `podman run`: 'without a root daemon' stays correct; no change
     needed.
   - New entries (optional): 'Login node', 'Partition',
     'SingularityCE', with the wording of Appendix A's vocabulary box
     and the 376-386 paragraph.
4. **`cheat-sheet-index.qmd`:** no edit needed. I read it, and it
   builds its index from each chapter's `## Cheat sheet` table, read
   through `_quarto.yml`. If its output is frozen, clear the frozen
   copy so the four new Ch 8 rows and the changed Podman and
   Apptainer rows appear (Phase 29 did this for the same reason).
5. **Instructor guide:** Exercise 2 of Appendix A now begins 'On a
   cluster login node or a Linux machine'; check whether a rubric
   assumes a laptop.

## Verification

- **Scratch render (V).** A mirror of the repository layout
  (`R/`, `DESCRIPTION`, `NAMESPACE`, `renv.lock`,
  `.devcontainer/`, `.github/workflows/render-book.yml`, the cohort
  CSV, and in `analysis/report/` the three files, `_llm-rule.qmd`,
  `references.bib` plus the proposed `pimentel2019` entry, and a
  minimal `_quarto.yml`) under
  `/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility-analysis-report/c73a943a-f77b-4453-b927-b5b84a883755/scratchpad/render/`,
  each rendered with `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE quarto
  render <file> --to html`: exit 0 for all three. The only warnings
  are unresolved cross-references to other chapters (expected), and
  `@sec-translating-tools` from Ch 8. No R error and no citation
  warning. The three new tables resolve locally. The rendered
  output was checked for the computed `r_ver = '4.6.1'` in both
  `rix` displays, the dev-container sentence, the Pimentel figures,
  and the literal display of the new YAML header. An earlier render
  showed `#\|` printed with its backslash in the cheat-sheet row;
  that cell was reworded.
- **Side effect (V):** the old worked-example header printed
  `date: 'November 26, 2026'`, because the inline R inside the
  displayed YAML block executed. The new `date: today` removes that.
- **Inline R:** `grep '`r '` over both chapters: every hit is a
  deliberate inline expression (Ch 8 hits as before; Appendix A adds
  `lock_r` at 561 and 1367).
- **Test suite (V):** 456/456. A first run failed one invariant
  (an indented line starting with `@sec-...` followed by a period in
  `translating-tools.qmd`); reworded. The reading-time test passed
  without card changes.
- **Voice:** no em or en dashes in the three files (grep); prose
  uses single quotes; 'we' in exposition (the table cell 'a
  workstation you administer' became 'the analyst administers').
  A sentence-length scan of every added line (script in the
  scratchpad, `sentlen.py`) found six sentences over 35 words; all
  were split. 'The largest study' became 'A large study' (no source
  for the superlative). 'PDF asks for LaTeX' (1070) and the
  vocabulary entry 'Rendering toolchain' (311) were qualified for
  Typst. The date answer now names freeze only, since the chunk
  cache was not tested. The Stata licensing caution was reduced to
  'not checked; cell left empty'.
- **Ids:** the three new `tbl-` ids each occur once in the book.
- **Re-verified after the review fixes:** tinytest 456/456; the
  three scratch renders exit 0 with only cross-chapter references
  unresolved; `pdftotext` on the restricted-PATH Typst
  `report.pdf` (absolute path) reads 'The laser-treated arm holds
  197 eyes.'

## Not done, skipped, or unverified

- **Docker rule (lead's message):** I ran no Docker command of any
  kind in this phase; all renders used the host's Quarto and R.
- **Printed commands not run:** `podman build` and `podman run`
  (with `--platform`), `apptainer build --arch amd64`,
  `apptainer exec`, `module avail` and `module load`, `sbatch`,
  `uname -m` on a cluster login node, `tlmgr option repository
  <url>` (not run so as not to change the user's TinyTeX
  configuration), `quarto render notebook.ipynb --execute`,
  `quarto render fig.qmd` (Exercise 2's file is the reader's), and
  `rix::available_dates()` (`rix` is not installed). Each rests on
  the documentation cited above. `rix::rix()` itself was not run;
  only its printed form was rendered.
- **Quotations:** every quotation printed in the three files was
  checked against the raw page text by `curl` and `grep`, not only
  WebFetch's summaries: Typst, Podman rootless tutorial, Apptainer
  install guide (the full sentence was matched), uv, pytest,
  Snakemake, and Jupyter (quote completed to the end of its list).
  Binder, Apptainer news, Sylabs, OpenBLAS, and Quarto FAQ and
  dates pages were read through WebFetch only; the book
  paraphrases them except for the quoted Binder and Quarto phrases
  in this report.

- No Podman, Apptainer, SingularityCE, Slurm, or Binder command was
  run; none is installed. The `--platform` and `--arch` flags rest
  on the official manual pages only.
- R8-03 stays an inference; I found no source measuring R results
  across CPUs.
- The 'When it fails' table was not reproduced on any cluster; the
  text says so.
- The `zzcollab` 'publishing profile' prose in Ch 8 (1016-1061),
  outside any box, was left as Phase 30 left it; only the uncited
  playbook sentence was replaced.
- Licensed software in containers (Stata) is discussed only as an
  open caution; no vendor route was confirmed, so the cell is empty.
- `quarto::quarto_render()` and the RStudio and Positron routes were
  not touched.
- Not checked: whether rix's rule for picking a date (comment in
  `get_latest.R`) holds in released versions other than 0.18.6.
