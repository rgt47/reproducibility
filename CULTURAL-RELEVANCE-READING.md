# Cultural Relevance: A Reading Pass
*2026-09-08 18:59 PDT*

## What this is, and what it is not

`REFACTOR-PLAN.md` routed cultural relevance to a human reading pass,
on the grounds that it is the second-weakest criterion in the Belikov
and McLure corpus of 954 open-textbook reviews (66.6% positive) and
that no grep can assess it. This document is that pass, performed by
reading the book's scenarios, examples, personas, and stated
assumptions rather than by counting.

**It does not close the item.** The criterion asks whether students
see themselves in a book, and that question belongs to readers from
the communities in question. A close reading can find what is present,
what is absent, and what is assumed; it cannot report how the book
lands on a reader it is not. Treat what follows as a survey that
narrows the question for the people who should answer it, not as an
answer.

The Open Textbook Library rubric phrases the criterion as whether a
text is free of insensitivity and whether it includes examples
inclusive of a variety of races, ethnicities, and backgrounds.

## Summary

The book is not insensitive. There is nothing in it a reader would
find othering, no stereotyped example, and no assumption that the
reader is wealthy, American, or working in a well-resourced
institution. On the negative half of the criterion it does well, and
better than most technical texts.

On the affirmative half it is close to empty. Across roughly 94,000
words the book names **one** specific human population, uses **four**
gendered personas out of many dozens, and contains **no named
individuals at all** among its examples. Its people are almost
entirely roles: a colleague, a reviewer, an analyst, a
biostatistician.

That is a defensible authorial choice and it is also precisely the
gap the criterion names. The guidance asks affirmatively for
diversified names, contexts, and photographs, and a book of unnamed
roles supplies none of the three.

## What the reading found

### The one named population

There is exactly one place where the book names a specific group of
people. In the compendium chapter, describing the scholarly-manuscript
archetype:

> A representative deployment is a study of the comorbidity of PTSD,
> depression, and diabetes among Black women drawn from a
> trauma-study cohort, using variable selection, multiple imputation,
> and causal mediation analysis.

This is handled well. The population is named specifically rather than
euphemistically, the research question is a serious one in health
disparities, and the passage treats the study as an ordinary example
of the archetype rather than as a special case or an illustration of
diversity. It is doing exactly what the criterion asks. It is also
alone.

### The personas are roles, not people

Counting persona references across the book: 21 'a reviewer', 25 'a
colleague', 13 'a collaborator', 4 'a biostatistician', 2 'a student',
and similar. Not one is named.

Gendered pronouns are nearly absent and, where present, lean female in
the technical role: 9 'her' and 4 'she' against 4 'his' and no 'he' in
a persona sense, with 'they' and 'them' carrying the rest. Where a
woman appears she is the competent analyst whose collaborator's
machine fails her, not the person being helped. That is a small,
real, positive signal.

But the dominant register is roleless. The effect is a book in which
computational work is done by nobody in particular, which is
consistent and clean, and which forgoes every opportunity the
criterion is about.

### The clinical contexts are narrow

The substantive contexts are: hospital readmission after heart
failure, incident diabetes from a registry, diabetic retinopathy, a
multi-site clinical trial, PTSD and depression comorbidity, and
generic 'registry study'. Twice, replication studies in psychology and
preclinical oncology are cited as evidence.

There is no global-health example anywhere in the book: no HIV, no
tuberculosis, no malaria, no maternal mortality, no work situated
outside a high-income health system. For a book aimed at public
health, that is a conspicuous absence rather than a neutral one, and
it is the single easiest thing to change.

### Resource assumptions are handled unusually well

This is the book's clearest strength on the criterion, and it is not
accidental. The text repeatedly declines to assume money or
institutional privilege:

- A laboratory forbidden from licensing Docker Desktop is treated as
  an ordinary constraint, and Podman as the ordinary answer.
- A cluster where the reader is *not an administrator* is the
  motivating case for Apptainer.
- A reviewer who must run a figure *with no local installation* gets
  Binder.
- Docker Hub's free tier is named as rate-limiting pulls and
  permitting one private repository, 'constraints that a small
  laboratory reaches quickly'.
- The recommended tools are free: git, GitHub, Zenodo, Posit Package
  Manager, Netlify's free tier.
- An institution that forbids public forges and self-hosts GitLab is
  treated as normal, not deviant.

A reader at a under-resourced institution will not meet a passage
assuming they have money. That is more than most technical books
manage.

### The prerequisites may exclude more than intended

The stated assumptions are R at a working level, comfort at the
command line, and basic git. The intended reader is 'a graduate
student or working analyst in public health, biostatistics,
epidemiology, or a related quantitative health science'.

Command-line comfort is the load-bearing one. It correlates with prior
access to computing environments and mentorship rather than with
aptitude, and it is the assumption most likely to exclude a capable
reader from a program that never taught it. The book builds Docker,
containers, CI and Nix from first principles but treats the shell as
given. Whether that line is in the right place is worth a deliberate
decision rather than an inherited one.

### Language and idiom

The prose is formal academic English, US spelling, with a
pre-render gate enforcing it. Sentences are long and subordinate.
There is no slang, no sport or military metaphor, and no
culture-specific idiom that would puzzle a reader who learned English
outside an anglophone country. Two mild idioms appear ('doorstop',
'works on my machine'), both transparent in context.

This is a genuine accessibility strength for an international
readership, and it is worth noting that the register was probably
chosen for scholarliness rather than for that reason.

### The bibliography

Fifty-seven distinct first authors. The literature of reproducible
research in R is what it is, and the citation list reflects a field
whose prominent figures are predominantly white, male, and based in
North America and western Europe. This is not a defect of the book,
which cites the work that exists. It is worth naming only because a
reader forms a picture of who does this work partly from whose names
recur, and no amount of editing the citation list fixes an upstream
distribution.

The one clear opportunity: `credits.qmd` and the epigraphs are places
where the book chooses whom to quote, and choices there are less
constrained than citations.

## What I would change, in order

1. **Add two or three global-health examples.** The absence is the
   most concrete finding here and the cheapest to fix. A cohort study
   in a low-resource setting, an analysis constrained by intermittent
   connectivity, or a multi-country collaboration would each also
   strengthen the resource-constraint material the book already does
   well. This is a change to scenarios, not to structure.

2. **Name a few of the personas.** Not all of them; the roleless
   register is part of the book's voice. But the recurring
   collaborators in the version-control and archiving chapters, where
   the same people appear across several paragraphs, could carry
   names, and names drawn from more than one naming tradition. The
   synthetic cohort generator added in Phase 5 already does this: its
   invented surnames span Achebe, Bianchi, Chen, Diallo, Eriksson,
   Mwangi, Nakamura, Okonkwo, Rahman, Tran. The prose could match the
   data.

3. **Revisit whether command-line comfort must be a prerequisite**, or
   whether a short appendix would let the book keep its scope while
   widening its door.

4. **Leave the PTSD and diabetes example exactly as it is.** It is the
   best thing in the book on this criterion.

## Limits of this pass, stated plainly

- I am not a member of the communities the criterion concerns, and no
  reading by one reader substitutes for review by the people a book
  is meant to include.
- I read the scenarios, personas, prerequisites, resource
  assumptions, idiom, and bibliography. I did not read all 94,000
  words line by line.
- 'Free of insensitivity' is the half of the criterion a close
  reading can assess with most confidence, and the book passes it.
  'Includes examples inclusive of a variety of backgrounds' is the
  half that needs the readers themselves, and it is the half where
  the book has the most room.
- The recommendations above are editorial suggestions from a
  reviewer, not findings with evidence behind them. The evidence base
  supports the *criterion*; it does not tell an author which examples
  to write.

---
*Rendered on 2026-09-08 at 18:59 PDT.*<br>
*Source: ~/prj/tch/12-reproducibility/CULTURAL-RELEVANCE-READING.md*
