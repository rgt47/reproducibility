# Phase 25, Agent 2: environment and archiving tools
*2026-11-08 17:23 PST*

Subject: renv, dated snapshots, Docker and Rocker, Podman,
Apptainer, Nix/rix, Guix, conda, Binder, devcontainers, groundhog,
rang, capsule, Zenodo and Software Heritage, git, BLAS threading,
locale and time zone, R 3.6.0 and 4.0.0 defaults, R startup files.

Evidence: V = ran it here; I = opened the primary source now;
EK = not checked. All runs on this Mac, 2026-11-08: R 4.6.0
(host), renv 1.2.3 from the locked library (Phase 20 prefix,
`RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`), git 2.56.0, GNU bash
5.3.20, zsh 5.9.2. The Docker daemon was not running, so registry
facts come from the Docker Hub registry API (`curl` with a pull
token; script `p25/a2/reg.sh`), not `docker buildx`. Scripts and
scratch output are in
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p25/a2/`.

## 1. Claims

Date accessed is 2026-11-08 for every row.

| id | file:line | claim | status | source | evidence |
|---|---|---|---|---|---|
| A2-01 | 01:573-590 | R 3.6.0 (2019) changed the `sample()` default; `rnorm()`/`rpois()` unaffected | verified | R `doc/NEWS.3` l.284-290; CRAN `src/base/R-3/` (R-3.6.0 2019-04-26); `checks.R` | NEWS: discrete-uniform method 'used in sample()' changed; Rounding 3 8 4 7 6 1, Rejection 3 10 2 8 6 9; `rnorm`, `rpois`, `runif` identical under both kinds [V] |
| A2-02 | 01:591-593, 1438 | R 4.0.0 (2020) flipped `stringsAsFactors` to `FALSE` | verified | R `doc/NEWS` l.5606; CRAN listing R-4.0.0 2020-04-24 | 'R now uses a stringsAsFactors = FALSE default'; `formals(data.frame)` FALSE [V] |
| A2-03 | 01:679-682 | `prcomp()` rests on an eigendecomposition | corrected | `?prcomp` (stats Rd) | 'done by a singular value decomposition ... not by using eigen' [V] |
| A2-04 | 02:440-454 | `crossprod()` goes to the BLAS, `solve()` to LAPACK | verified | `?options` (matprod), `?solve` | matprod 'default' 'uses BLAS'; solve 'interface to the LAPACK routines DGESV' [V] |
| A2-05 | 02:404-411; 05:1025-1032 | R keeps `LC_NUMERIC` at C, warns if changed; `as.numeric('1,5')` is NA; `dec = ','` reads it | verified | `checks.R`, `checks3.R` | LC_NUMERIC C after `Sys.setlocale('LC_ALL','fr_FR.UTF-8')`; warning 'setting LC_NUMERIC may cause R to function strangely'; `read.csv(dec=',')` gives 1.5 [V] |
| A2-06 | 05:1082-1088 | `sort()` order and `%B` month differ between C and fr_FR | verified | `checks.R` | fr: cote coté côte coter, 'mars'; C: different order, 'March' [V] |
| A2-07 | 05:1095-1100 | late-evening event falls on different days by `TZ` | verified | `checks.R` | 23:30 UTC is 03-15 in LA, 03-16 in Berlin [V] |
| A2-08 | 05:1147-1150 | without `TZ` in the image, a container may inherit the host's time zone | hedged | apptainer.org bind_paths_and_mounts (1.5); rocker-versioned2 `r-ver_4.6.1.Dockerfile` | Apptainer binds `/etc/localtime` by default; Docker does not pass host TZ unless asked; Rocker sets `TZ=Etc/UTC` [I] |
| A2-09 | 05:1114-1118, 1468-1469 | `rocker/r-ver` links multithreaded OpenBLAS (`openblas-pthread`) | verified | rocker-versioned2 `scripts/setup_R.sh`; rocker-project.org r-ver page | `update-alternatives --set ... openblas-pthread/libblas.so.3`; 'By default rocker/r-ver uses the OpenBLAS' [I] |
| A2-10 | 05:1111-1123, 1468-1470, 1950-1953 | OpenBLAS is governed by `OPENBLAS_NUM_THREADS`; either variable alone leaves threads in place | hedged | OpenBLAS `README.md` (develop) l.327-331 | 'priorities are OPENBLAS_NUM_THREADS > GOTO_NUM_THREADS > OMP_NUM_THREADS', so a pthread OpenBLAS falls back to `OMP_NUM_THREADS` [I] |
| A2-11 | 05:703, 907-912 | showcase digest is an index with amd64 and arm64; tidyverse and verse 4.4.0 amd64 only | verified | registry API, `reg.sh` | `73adabf3...`: OCI index, amd64 `8d7a9eb2`, arm64 `38625d86`, 2 attestations; tidyverse `3e72037a...` and verse `aedce707...`: amd64 only [V] |
| A2-12 | 05:744-749, 1555-1558 | `r-ver:4.4.0` is `FROM ubuntu:jammy`; `r-ver:4.6.1` runs noble | verified | rocker-versioned2 at a0b9e60 (`r-ver_4.4.0.Dockerfile`) and master (`r-ver_4.6.1.Dockerfile`) | `FROM docker.io/library/ubuntu:jammy`; `FROM ...ubuntu:noble` [I] |
| A2-13 | 05:789-793 | Rocker's snapshot is 'one taken when the image was built' | corrected | same Dockerfiles; CRAN `src/base/R-4/` | 4.4.0: `CRAN=.../jammy/2024-06-13`, the day before R 4.4.1 (2024-06-14); 4.6.1: `noble/2026-10-28`, day before R 4.6.2 (2026-10-29). The date is fixed per R version, not per build [I] |
| A2-14 | 05:719 | later `options(repos)` line in Rprofile.site wins | verified | `setup_R.sh` | Rocker writes its own `options(repos = ...)` to Rprofile.site; a later line overrides [I] |
| A2-15 | 05:761-768; 05:2060 | `restore()` uses the lockfile's repositories unless `repos.override` | verified | `?renv::restore`, `?renv::config` (renv 1.2.3) | 'By default, the repositories recorded in the lockfile will be used'; `repos.override` 'enforce ... over what is defined in renv.lock' [V] |
| A2-16 | 05:750-755 | `renv::init()` refuses a project directory containing home | verified | `renv:::renv_init_validate_project` | 'refusing to initialize project in directory' when home is within project [V] |
| A2-17 | 05:756-760 | renv 1.2.3 was the current release on 2026-06-27 | verified | CRAN Archive/renv | 1.2.3 dated 2026-05-16, 1.2.4 dated 2026-08-04 [I] |
| A2-18 | 05:933-944 | Docker Desktop emulates amd64 with QEMU; 'can be much slower than native builds' | verified | docs.docker.com build/building/multi-platform; Desktop settings page | quotation exact; Rosetta setting 'Disabled' by default [I] |
| A2-19 | 05:345-351; 04:1027-1033; 04:983-990 | lockfile records R in its `R` block but cannot install R | verified | renv vignette `renv.Rmd` l.176, 187; `renv:::renv_load_r` | 'renv tracks, but doesn't help with, the version of R'; notice 'Using R %s (lockfile was generated with R %s)' on major.minor mismatch [V] |
| A2-20 | 05:360-361 | 'the random-number default that changed in R 3.6.0' | hedged | as A2-01 | only the `sample()` method changed; generator unchanged [V] |
| A2-21 | 05:337-339 | lockfile records 'every R package an analysis loaded' | hedged | `?renv::snapshot` default implicit type | snapshot records packages found by scanning code, not those loaded [EK on wording; scan behavior V via A2-24] |
| A2-22 | 05:2098-2100 | `rrtools` 'first combined a lockfile and a Dockerfile' | corrected | benmarwick/rrtools `inst/templates/Dockerfile` history | 2017 to 2020 template installs with `devtools::install(dep=TRUE)`; `renv::restore()` added 2022-08-31 ('use renv') [I] |
| A2-23 | 04:378, 400-412 | renv 1.2.3 lockfile has no `Hash`/`Requirements`; v1 had them | verified | `renv:::renv_snapshot_description_impl_v1/_v2`; NEWS 1.1.0 | v1 writes `Hash`, `Requirements`; v2 (default) does not; repo `renv.lock` has 0 `Hash` [V] |
| A2-24 | 04:1204, 1262-1271, 1697 | `dependencies()` reports only contributed packages; base calls are filtered | corrected | `checks.R` | a file with `library(utils)` and `stats::rnorm()` yields `stats`, `utils`; the scan is silent on `simulate_cohort.R` because it uses no `::` or `library()` [V] |
| A2-25 | 04:438-439, 1229-1231 | base packages have no lockfile record; `survival` does | verified | `grep renv.lock` | 0 base records; `Matrix`, `lattice`, `survival` present [V] |
| A2-26 | 04:1246-1249 | `renv::init()` 'followed by' `renv::snapshot()` writes the lockfile | hedged | `?renv::init` | init itself 'Create[s] a lockfile' (step 3) [V] |
| A2-27 | 04:1662-1667 | renv's generated `.gitignore` lists | verified | `renv:::renv_infrastructure_write_gitignore`; default settings | `library/ local/ cellar/` (settings all TRUE) plus `lock/ python/ sandbox/ staging/` [V] |
| A2-28 | 04:946-951 | Linux binaries only from the `__linux__/<codename>` URL; plain path serves source | hedged | docs.posit.co/rspm/admin/serving-binaries.html | two Linux binary URL forms (`__linux__/<distro>` and `bin/linux/<distro>-<arch>/<r-version>`); user agent may need R version; plain-CRAN behavior not stated [I] |
| A2-29 | 04:309-310 | packrat 'introduced in 2013' | hedged | GitHub rstudio/packrat; CRAN Archive/packrat | repo created 2013-10-08; first CRAN tarball 2014-09-03 [I] |
| A2-30 | 04:316-317 | renv superseded packrat in 2019 | verified | CRAN Archive/renv | renv 0.8.0 2019-10-25 [I] |
| A2-31 | 04:1049-1058; 10:1133-1146 | rang reconstructs from a date; archived on CRAN 2026-08-22 | verified | cran.r-project.org/package=rang; gesistsa/rang `R/resolve.R` | 'Archived on 2026-08-22 as issues were not corrected in time' [I] |
| A2-32 | 10:1996-1997 | `rang::resolve(pkgs, snapshot_date =)`, `rang::dockerize(graph, output_dir =)`; `renv::lockfile_read()` | verified | gesistsa/rang HEAD (0.3.0) `resolve.R:333`, `installation.R:506`; renv exports | signatures match; `lockfile_read` exported in renv 1.2.3 [I, V] |
| A2-33 | 04:1074-1083 | capsule develops in the user library, runs in a pinned renv library | verified | MilesMcBain/capsule README | 'You develop interactively in a dynamic package environment. You run code for real in a well-defined static capsule' [I] |
| A2-34 | 06:473-485 | `rix()` arguments `r_ver`, `r_pkgs`, `system_pkgs`, `git_pkgs`, `ide`, `project_path` | verified | ropensci/rix HEAD 0.18.6 `R/rix.R:224-241`; CRAN rix 0.18.5 | all six are arguments; `ide = "rstudio"` valid (macOS warning applies) [I] |
| A2-35 | 06:509-516; 06:1396-1403 | rix pins a dated `rstats-on-nix` branch; `fetchTarball` 'usually carries no sha256' | corrected | rix NEWS 0.18.3 (2026-06-26); `R/make_nixpkgs_url.R`; `inst/extdata/available_df.csv` | since 0.18.3, date snapshots get a precomputed `sha256`; branch refs only are hashless; branch `2024-10-01` exists [I] |
| A2-36 | 06:1386-1399 | Ex 3 (`r_ver = '4.4.0'`) yields a URL such as `2024-10-01.tar.gz` | corrected | `available_df.csv`; `get_right_commit()` | `r_ver = '4.4.0'` maps to `2024-04-29`; `2024-10-01` is the last 4.4.1 date [I] |
| A2-37 | 06:504-508 | flakes still behind an experimental flag | verified | nix.dev manual (Nix 2.34.9), experimental features | 'flakes' listed under currently available experimental features [I] |
| A2-38 | 06:553-556 | Guix has a smaller R ecosystem | not verified | none opened | see Section 4 |
| A2-39 | 06:562-574 | conda-forge `win-64` R coverage narrower than Linux | not verified | none opened | see Section 4 |
| A2-40 | 06:645-656 | repo2docker builds its own image; Dockerfile config, Jupyter required; `rocker/binder` with `jupyter-rsession-proxy` | verified | repo2docker docs configuration/system.html; mybinder docs tutorials/dockerfile.html; rocker `install_jupyter.sh` | 'If a Dockerfile is present, all other configuration files will be ignored'; 'must install ... Jupyter'; pip installs `jupyter-rsession-proxy` [I] |
| A2-41 | 06:1008-1023 | a one-line `.binder/Dockerfile` (`FROM` digest) suffices | corrected | mybinder dockerfile tutorial; rocker `binder_4.4.0.Dockerfile` | Binder also requires a uid-1000 user and 'must copy its contents to the $HOME directory'; rocker/binder sets `NB_USER=rstudio` [I] |
| A2-42 | 06:979-981 | Apptainer binds `$HOME` read-write and passes host variables | hedged | apptainer.org bind_paths, environment_and_metadata (1.5) | `$HOME` in default binds; host variables 'available inside the container'; read-write mode not stated for `$HOME` [I] |
| A2-43 | 06:984-996, 1130-1172 | `--cleanenv` clears variables only; `--no-home`; `--containall` uses a temporary `$HOME`; `--env` passes variables | verified | same pages; RSE persona runs (Apptainer 1.5.5) | '--cleanenv ... exclude passing environment variables'; '--no-home ... without mounting your host $HOME'; `--env NAME=VALUE` [I] |
| A2-44 | 06:1561 | cheat-sheet row: 'only the project directory bound' | hedged | apptainer bind_paths | system binds (`/tmp`, `/var/tmp`, `/etc/hosts`, `/etc/localtime`, CWD) remain [I] |
| A2-45 | 06:992, 1128 | `--vanilla` reads no startup file; `.Rprofile` lookup | verified | `Rscript --help`; `?Startup` | '--vanilla Combine --no-save, --no-restore, --no-site-file, --no-init-file and --no-environ'; user profile: '.Rprofile ... in the current directory or in the user's home directory (in that order)' [V] |
| A2-46 | 06:1548; 10:588-596 | SIF embeds build metadata; build writes a compressed read-only file | verified | apptainer environment_and_metadata, build_a_container (1.5) | `org.label-schema.build-date` label; 'a compressed read-only Singularity Image File (SIF)' [I] |
| A2-47 | 06:350-352 | Apptainer was Singularity until its Linux Foundation move | verified | apptainer.org/news/community-announcement-20211130 | 2021-11-30: 'officially moving into the Linux Foundation ... renaming the project to Apptainer' [I] |
| A2-48 | 06:330-339 | Docker Desktop not free for larger organizations; education exception | verified | docs.docker.com/subscription/desktop-license | free for 'fewer than 250 employees AND less than $10 million', personal, education, non-commercial OSS; paid for larger organizations and 'Government entities' [I] |
| A2-49 | 06:243-251 | rootless Docker exists, prerequisites usually admin-installed | not verified | none opened | EK; text already hedged |
| A2-50 | 03:408-417 | plain `R CMD check dir/` skips the build and never parses `analysis/` | verified | toy package, `rcheck.sh`, R 4.6.0 | syntax error and undeclared `library()` in `analysis/bad.R`: 'checking R files for syntax errors ... OK', no mention of `analysis/`, with or without `.Rbuildignore` [V] |
| A2-51 | VC:442; setup:229-233 | git 2.56.0 names the first branch `master`, hint about Git 3.0 | verified | `gitcheck.sh` | 'This default branch name will change to "main" in Git 3.0' [V] |
| A2-52 | VC:454-467 | SHA-1 default; built-in collision detection | verified | `git version --build-options` | 'SHA-1: SHA1_DC', 'default-hash: sha1'; `rev-parse --show-object-format` sha1 [V] |
| A2-53 | setup:213-228; tbl-git-refuses | auto-identity notice; `src refspec main does not match any`; detached HEAD text | verified | `gitcheck.sh` with empty `$HOME` | 'Your name and email address were configured automatically'; refspec error; 'You are in 'detached HEAD' state' [V] |
| A2-54 | VC:819-824 | `--sensitive-data-removal` fetches all refs and keeps the remote | verified | newren/git-filter-repo `Documentation/git-filter-repo.txt` l.318-331; `git-filter-repo` l.4483-4492 | 'Fetching all refs'; `if sensitive_data_removal: return` before 'Removing origin remote' [I] |
| A2-55 | setup:276 (tbl) | GitHub file limit 100 MiB | not verified | not opened this phase | Phase 22 cited `githublargefiles`; not reopened |
| A2-56 | setup:159-167; shell:228-232 | CRLF and permission messages | verified | `shellcheck.sh` | '/bin/bash^M: bad interpreter: No such file or directory'; bash 'Permission denied'; 'zsh:1: permission denied: ./greet.sh' [V] |
| A2-57 | shell:271-282 | unmatched glob: bash passes literal, zsh 'no matches found'; `--include=*.qmd` rejected | verified | `shellcheck.sh` | 'ls: *.csv: No such file'; 'zsh:1: no matches found: --include=*.qmd' [V] |
| A2-58 | shell:265-267 | zsh default from Catalina (2019) | verified | support.apple.com/en-us/102360 | 'Starting with macOS 10.15, your Mac uses zsh as the default login shell' [I] |
| A2-59 | shell:192-203 | `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE` stops activation | verified | renv `resources/activate.R` l.29-60; `?renv::config` | autoloader checks `RENV_CONFIG_AUTOLOADER_ENABLED` and returns FALSE; env-var form `RENV_CONFIG_<NAME>` documented [I] |
| A2-60 | 09:655-664 (CI, renv) | `setup-renv` relies on the project autoloader for later steps | verified | r-lib/actions HEAD `setup-renv/action.yaml` | steps run `renv::activate()` and `renv::restore()` in separate `Rscript` calls; later steps inherit only the `.Rprofile` [I] |
| A2-61 | 09 (CI) | `renv::status()` compares lockfile and library | verified | `?renv::status` | 'reports issues caused by inconsistencies across the project lockfile, library, and dependencies()' [V] |
| A2-62 | 10:688-701 | SWHID `swh:1:<type>:<hash>`, `cnt`, `dir`; 40-character intrinsic hash; same bytes, same id | verified | SoftwareHeritage/swh-model `docs/persistent-identifiers.rst` (GitHub mirror; docs.softwareheritage.org blocked the fetch) | object types snp, rel, rev, dir, cnt; '40 * <hex_digit>'; content id is the git blob SHA1 [I] |
| A2-63 | 10:684-687 | 'no depositor-facing mechanism to remove something once archived' | hedged | docs.softwareheritage.org `howto-process-takedown-requests.rst` | Software Heritage runs a staff takedown procedure (`swh alter remove`) [I] |
| A2-64 | 10:503-505 | Docker Hub free tier rate-limits pulls; one private repository | verified | docs.docker.com/docker-hub/usage | unauthenticated 100, Personal 200 pulls per 6 hours; 'Up to 1' private repository [I] |
| A2-65 | 10:1865-1866 | Docker Hub 'applies a retention policy to inactive repositories' | hedged | docs.docker.com usage page silent; current policy not found | policy announced 2020 and postponed; current enforcement unknown [U] |
| A2-66 | 10:551-555 | committed Dockerfile 'reconstructs an identical image' | corrected | 05:870-876 own text ('never compare image digests') | a rebuild yields an equivalent environment, not identical image bytes [I] |
| A2-67 | 10:736-742 | Whole Tale runs in the browser (present tense) | hedged | wholetale.org; dashboard.wholetale.org; GitHub whole-tale/girder_wholetale | site footer 2021, 'beta' dashboard; dashboard returns HTTP 404; server repository archived, last push 2024-06-24 [V, I] |
| A2-68 | 10:1133-1137 | rang historical versions installable from the CRAN archive or GitHub | verified | CRAN rang page; gesistsa/rang | archive link present; repository live (0.3.0) [I] |

## 2. Replacement blocks

Note: the A2-41 blocks contain a nested `dockerfile` fence; copy
the text between the outer OLD/NEW markers literally.

### A2-03 analysis/report/01-reproducibility-crisis.qmd
OLD:
```
layer, specifically the BLAS and LAPACK
implementation that performs the eigendecomposition
underlying `prcomp()`. Different implementations
```
NEW:
```
layer, specifically the BLAS and LAPACK
implementation that performs the singular value
decomposition underlying `prcomp()`. Different implementations
```

### A2-08 analysis/report/05-containers.qmd
OLD:
```
The likely culprit is `TZ`, the time zone. If the image
does not fix it, each container may inherit the host's
time zone, and an event recorded near midnight is
```
NEW:
```
The likely culprit is `TZ`, the time zone. If the image
does not fix it, the run can supply one: a `-e TZ=...`
flag, a mounted `/etc/localtime`, or Apptainer, which
binds the host's `/etc/localtime` by default. An event
recorded near midnight is then
```

### A2-10a analysis/report/05-containers.qmd
OLD:
```
image carries: `OPENBLAS_NUM_THREADS` for OpenBLAS,
`MKL_NUM_THREADS` for the Intel MKL, and `OMP_NUM_THREADS`
for the OpenMP-parallel sections. The `rocker/r-ver`
```
NEW:
```
image carries: `OPENBLAS_NUM_THREADS` for OpenBLAS (which
falls back to `OMP_NUM_THREADS` when it is unset),
`MKL_NUM_THREADS` for the Intel MKL, and `OMP_NUM_THREADS`
for the OpenMP-parallel sections. The `rocker/r-ver`
```

### A2-10b analysis/report/05-containers.qmd
OLD:
```
the single-threaded reference BLAS; in the image built
above, `sessionInfo()` reports
`openblas-pthread/libblas.so.3`. That is why the
Dockerfile sets `OPENBLAS_NUM_THREADS=1` alongside
`OMP_NUM_THREADS=1`. Setting the OpenMP and the BLAS
thread counts to one together, rather than either alone,
removes thread count as a source of variation in the
```
NEW:
```
the single-threaded reference BLAS; in the image built
above, `sessionInfo()` reports
`openblas-pthread/libblas.so.3`. That is why the
Dockerfile sets `OPENBLAS_NUM_THREADS=1` alongside
`OMP_NUM_THREADS=1`. OpenBLAS reads its own variable
first, so a stray `OPENBLAS_NUM_THREADS` would override
`OMP_NUM_THREADS=1`. Setting both to one together
removes thread count as a source of variation in the
```

### A2-10c analysis/report/05-containers.qmd
OLD:
```
Line (3) sets both thread counts, not
`OMP_NUM_THREADS` alone, because the `rocker/r-ver` image
links R against OpenBLAS, which `OPENBLAS_NUM_THREADS`
governs.
```
NEW:
```
Line (3) sets both thread counts, not
`OMP_NUM_THREADS` alone, because the `rocker/r-ver` image
links R against OpenBLAS, which reads
`OPENBLAS_NUM_THREADS` ahead of `OMP_NUM_THREADS`.
```

### A2-10d analysis/report/05-containers.qmd
OLD:
```
same every time on that image and CPU. Either variable
alone can leave the other source of threads in place.
```
NEW:
```
same every time on that image and CPU. Either variable
alone can leave a source of threads in place:
`OPENBLAS_NUM_THREADS` alone leaves other OpenMP code
threaded, and `OMP_NUM_THREADS` alone yields to any
`OPENBLAS_NUM_THREADS` set elsewhere.
```

### A2-13 analysis/report/05-containers.qmd
OLD:
```
container. Rocker's own image already points R
at a dated snapshot, one taken when the image was built,
which is why the `echo` line appends rather than
replaces: the later setting wins.
```
NEW:
```
container. Rocker's own image already points R at a
dated snapshot, fixed for each R version at the last
day that version was current (`2024-06-13` for 4.4.0),
which is why the `echo` line appends rather than
replaces: the later setting wins.
```

### A2-20 analysis/report/05-containers.qmd
OLD:
```
result silently: the random-number default that changed
in R 3.6.0, the `stringsAsFactors` default that flipped
```
NEW:
```
result silently: the `sample()` default that changed
in R 3.6.0, the `stringsAsFactors` default that flipped
```

### A2-21 analysis/report/05-containers.qmd
OLD:
```
motivation for the container. A lockfile records, for
every R package an analysis loaded, the exact version
```
NEW:
```
motivation for the container. A lockfile records, for
every R package the analysis code uses, the exact version
```

### A2-22 analysis/report/05-containers.qmd
OLD:
```
the subject of @marwick2018, whose `rrtools` first
combined a lockfile and a Dockerfile in a packaged
analysis.
```
NEW:
```
the subject of @marwick2018, whose `rrtools` pairs a
packaged analysis with a Dockerfile; its template has
restored an `renv` lockfile since 2022.
```

### A2-24a analysis/report/04-dependencies.qmd
OLD:
```
`simulate_cohort.R` contributes no rows because it calls only base R (`rnorm`, `sample`, `as.Date`), which the scan correctly does not count as a contributed-package dependency.'
```
NEW:
```
`simulate_cohort.R` contributes no rows because it calls base R functions (`rnorm`, `sample`, `as.Date`) without `library()` or a `::` prefix, so the scan finds no package name to report.'
```

### A2-24b analysis/report/04-dependencies.qmd
OLD:
```
packages bundled with every R installation rather than
contributed packages a lockfile needs to pin. The scan is working as intended. It
reports contributed-package dependencies, the ones whose
version can actually drift between machines. It correctly
stays silent about a script that happens to need nothing
beyond what R itself always provides.
```
NEW:
```
packages bundled with every R installation rather than
contributed packages a lockfile needs to pin. The scan is
working as intended. It reports the packages a file names,
through `library()`, `require()`, or `pkg::`, and this
script names none. A base package named that way would
appear, as `stats` and `utils` do for `R/cohort.R`, but
the lockfile would still record no entry for it.
```

### A2-24c analysis/report/04-dependencies.qmd
OLD:
```
| `renv::dependencies(files)` | Scans one or more files for contributed-package references, without touching the lockfile. |
```
NEW:
```
| `renv::dependencies(files)` | Scans one or more files for the packages they name (`library()`, `::`, and similar), base packages included, without touching the lockfile. |
```

### A2-26 analysis/report/04-dependencies.qmd
OLD:
```
For a compendium without a lockfile, `renv::init()`
followed by `renv::snapshot()`, and a commit of the
lockfile it writes, is the single step that lifts it from
```
NEW:
```
For a compendium without a lockfile, `renv::init()`,
which scans the code and writes the first lockfile, and a
commit of that lockfile, is the single step that lifts it from
```

### A2-28 analysis/report/04-dependencies.qmd
OLD:
```
Linux the binary path is more specific. Pre-compiled
binaries are served only from the distribution-codename
form of the URL, such as
`https://packagemanager.posit.co/cran/__linux__/noble/2026-06-29`,
whereas the plain dated path shown above delivers source
to be built.
```
NEW:
```
Linux the binary path is more specific. Pre-compiled
binaries are served from a distribution-specific form of
the URL, such as
`https://packagemanager.posit.co/cran/__linux__/noble/2026-06-29`,
and R may need to send its version in the HTTP user agent.
The plain dated path shown above should be expected to
deliver source to be built.
```

### A2-29 analysis/report/04-dependencies.qmd
OLD:
```
library governed by a lockfile is not new to R. The `packrat` package,
introduced in 2013, was the first widely adopted
```
NEW:
```
library governed by a lockfile is not new to R. The `packrat` package,
begun in 2013 and on CRAN from 2014, was the first widely adopted
```

### A2-35 analysis/report/06-backends-runtimes.qmd
OLD:
```
main `NixOS/nixpkgs` repository. The generated
`fetchTarball` usually carries no `sha256` of the
archive. The pin is only as fixed as that dated
branch is kept; replacing the date with a full commit
hash, and adding the archive's `sha256`, makes it
stricter.
```
NEW:
```
main `NixOS/nixpkgs` repository. Since version 0.18.3
the generated `fetchTarball` also carries the archive's
`sha256`, so a moved branch fails the build rather than
changing the environment; older versions omit it. A full
commit hash in place of the date is stricter still.
```

### A2-36 analysis/report/06-backends-runtimes.qmd
OLD:
```
that imports `nixpkgs`. In current versions of `rix` it is
a dated branch of the `rstats-on-nix/nixpkgs` fork, a URL
ending in a date such as `2024-10-01.tar.gz`, and it
usually carries no `sha256` of the fetched archive. Older
versions of `rix`, and hand-written declarations, may
instead name a commit of `NixOS/nixpkgs`. Whichever you
find, a full commit hash with a `sha256` is the stricter
pin, and a date is only as fixed as its branch is kept.
```
NEW:
```
that imports `nixpkgs`. In current versions of `rix` it is
a dated branch of the `rstats-on-nix/nixpkgs` fork, a URL
ending in a date (`2024-04-29.tar.gz` for R 4.4.0), and
from version 0.18.3 on it carries the archive's `sha256`.
Older versions of `rix` omit the `sha256`, and older
versions or hand-written declarations may instead name a
commit of `NixOS/nixpkgs`. A full commit hash with a
`sha256` is the strictest pin.
```

### A2-41 analysis/report/06-backends-runtimes.qmd
OLD:
```
Finally, when the paper is submitted, a reviewer wishes to
re-run the principal figure without installing anything.
The compendium carries a one-line `.binder/Dockerfile`
that starts from the same digest. This works only because
the group built `cohort-env` on a `rocker/binder` base,
so the image already serves Jupyter and RStudio:

```dockerfile
FROM ghcr.io/lab/cohort-env@sha256:9f2c...
```
```
NEW:
```
Finally, when the paper is submitted, a reviewer wishes to
re-run the principal figure without installing anything.
The compendium carries a short `.binder/Dockerfile` that
starts from the same digest and copies the repository into
the session's home directory, as Binder requires. This
works only because the group built `cohort-env` on a
`rocker/binder` base, so the image already serves Jupyter
and RStudio and has the required user:

```dockerfile
FROM ghcr.io/lab/cohort-env@sha256:9f2c...
COPY --chown=${NB_USER} . /home/${NB_USER}
```
```

### A2-42 analysis/report/06-backends-runtimes.qmd
OLD:
```
By default, Apptainer binds the user's `$HOME` as a
read-write mount and passes host environment variables
```
NEW:
```
By default, Apptainer binds the user's `$HOME` into the
container and passes host environment variables
```

### A2-44 analysis/report/06-backends-runtimes.qmd
OLD:
```
Runs the SIF with host environment variables cleared, the host `$HOME` unmounted, only the project directory bound, and no R startup file read;
```
NEW:
```
Runs the SIF with host environment variables cleared, the host `$HOME` unmounted, the project directory bound (Apptainer's system binds such as `/tmp` remain), and no R startup file read;
```

### A2-63 analysis/report/10-archiving-sharing.qmd
OLD:
```
more absolute for source code specifically. Its stated
mission is a permanent, universal archive of publicly
available source code, with no depositor-facing mechanism
to remove something once archived. The project's SWHID
```
NEW:
```
more absolute for source code specifically. Its stated
mission is a permanent, universal archive of publicly
available source code. A depositor cannot withdraw what
is archived; removal happens only through a takedown
procedure that the project's staff carry out. The project's SWHID
```

### A2-65 analysis/report/10-archiving-sharing.qmd
OLD:
```
Docker Hub applies a retention policy to inactive
repositories and the image is removed. Alternatively, the
```
NEW:
```
The registry removes the image under a retention policy
for inactive repositories. Alternatively, the
```

### A2-66 analysis/report/10-archiving-sharing.qmd
OLD:
```
restores from. That is a transparent, diffable, durable
recipe that reconstructs an identical image from pinned
inputs.
```
NEW:
```
restores from. That is a transparent, diffable, durable
recipe that reconstructs the same pinned environment,
though not byte-identical image layers, from pinned inputs.
```

### A2-67 analysis/report/10-archiving-sharing.qmd
OLD:
```
The Whole Tale platform, described by Brinckman and
colleagues, bundles code, data, and computational
environment into a single executable research object.
A reader can run it in the browser without local
installation [@brinckman2019], an ambition the
```
NEW:
```
The Whole Tale platform, described by Brinckman and
colleagues, bundled code, data, and computational
environment into a single executable research object
that a reader could run in the browser without local
installation [@brinckman2019]. Its public service did not
respond when we checked in November 2026. It remains an
ambition the
```

## 3. For the lead

- No new BibTeX entries are required. Every correction rests on
  a citation key already present or needs none.
- Repository file outside the chapters: `.devcontainer/devcontainer.json`
  uses `rocker/verse:4.4.0`, whose index has an `amd64` entry
  only [V, A2-11]. RSE recorded that a plain pull of such an index
  on Apple Silicon fails with 'no matching manifest'. Consider
  `"runArgs": ["--platform=linux/amd64"]`.
- R 4.6.2 was released on 2026-10-29 [I]. The book's 4.6.1 is a
  recorded lockfile value, not a 'current' claim, so no text is
  stale; any sentence added later should not call 4.6.1 current.
- A2-41: `${NB_USER}` is an `ENV` in `rocker/binder` (set to
  `rstudio`) [I]; it resolves only if `cohort-env` was built on
  that base, as the passage states. The two-line Dockerfile was
  not built.
- A2-08: the replacement splits one sentence; the next line of the
  file ('assigned to different calendar days in Berlin and San')
  continues it without change.

## 4. Not verified, and why

- Guix's R coverage (A2-38) and conda-forge `win-64` coverage
  (A2-39): no primary count was opened. Both sentences are already
  comparative and cautious; leave them as they are, or remove
  'with a smaller R ecosystem' if a source is required.
- Rootless Docker prerequisites (A2-49): not opened; the text is
  already hedged.
- GitHub's 100 MiB limit (A2-55): cited to `githublargefiles` in
  Phase 22; not reopened.
- Docker Hub retention (A2-65): docs.docker.com does not state a
  current policy, and the 2020 announcements were not opened, so
  the hedge names no vendor.
- Software Heritage pages on docs.softwareheritage.org and
  archive.softwareheritage.org were blocked by bot protection;
  SWHID syntax was read from the swh-model source on GitHub, and
  the takedown procedure from the docs `_sources` text file.
- No Docker build, Apptainer, Podman, Nix, rix, Binder, or Slurm
  run: none is available here, and the Docker daemon was stopped.
  The rix and Binder findings come from source and documentation.
- `chmod +x` adding execute for all three classes holds under the
  usual umask 022 [V]; not tested under other umasks.
- Phase 24's `crossprod`/BLAS sixth-decimal example was not run on
  two BLAS builds; only the dispatch (BLAS, LAPACK) was confirmed.
- Agent 1's items (SWHID ISO number, Peng and Trisovic wording,
  NAS) were not touched.

## Message to the lead

Report:
`/private/tmp/claude-501/-Users-zenn-prj-tch-12-reproducibility/f9ed43f0-6ace-465d-91f3-80dac2991f77/scratchpad/p25/agent2-report.md`.
There are 68 rows: 44 verified, 8 corrected, 12 hedged, and 4
not verified. Corrections that matter most:

- rix now writes a `sha256` (since 0.18.3), and the Ex 3 date is
  wrong for R 4.4.0.
- The one-line Binder Dockerfile omits the required copy into
  `$HOME`.
- Rocker's snapshot date is fixed per R version, not taken at
  build time.
- OpenBLAS falls back to `OMP_NUM_THREADS`, so the 'either alone'
  rationale needs rewording.
- `renv::dependencies()` does report base packages.
- `prcomp()` uses an SVD.
- rrtools adopted renv only in 2022.

Registry digests, git 2.56.0 messages, R 3.6.0 and 4.0.0 facts,
locale, `--vanilla`, the renv autoloader, `R CMD check` on a
directory, and the rang archival date (2026-08-22) all check out.
No BibTeX is needed.
