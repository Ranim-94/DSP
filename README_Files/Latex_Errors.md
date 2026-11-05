# LaTeX Errors and Fixes

## Table of Contents

1. [Unknown message `caption-code-by-class-deactivated` (tocbasic)](#1-unknown-message-caption-code-by-class-deactivated-tocbasic)
2. [BibTeX: Repeated entry](#2-bibtex-repeated-entry)
3. [BibTeX: warnings about missing fields](#3-bibtex-warnings-about-missing-fields)
4. [Cleaning build files](#4-cleaning-build-files)

---

## 1. Unknown message `caption-code-by-class-deactivated` (tocbasic)

**Error**

```
! LaTeX Error: Unknown message 'caption-code-by-class-deactivated' for module 'tocbasic'.
```

**Cause**

`nomencl` loads the KOMA-Script package `tocbasic`, which patches `caption`. If `caption` is already loaded, `tocbasic` fails with this error.

**Fix**

In `1_Report_DSP/Files/Packages.tex`, load `nomencl` before `caption`:

```latex
\usepackage{nomencl} % must be loaded before caption (KOMA tocbasic conflict)
\usepackage{caption}
```

---

## 2. BibTeX: Repeated entry

**Error**

```
Repeated entry---line 27 of file Literature/Papers_Sampling.bib
 : @article{Sub_Nyquist_sampling
 :                              ,
I'm skipping whatever remains of this entry
```

**Cause**

The same key (`Sub_Nyquist_sampling`) was defined in both `Papers_Signal_Processing.bib` and `Papers_Sampling.bib`. All `.bib` files are read together, so keys must be unique.

**Fix**

Keep one copy and delete the other (the duplicate in `Papers_Sampling.bib` was removed).

---

## 3. BibTeX: warnings about missing fields

**Warnings**

```
Warning--empty booktitle in paper_aliasing_matlab_Sol_Neeman
Warning--missing publisher in books_digital_comm_fundamentals_Sklar
Warning--empty year in books_digital_comm_fundamentals_Sklar
```

**Causes and fixes**

- `books_digital_comm_fundamentals_Sklar` (`Communication_Systems.bib`): a stray `},` in the `series` field (`series={... \& E},},`) broke parsing, so `year` and `publisher` were lost. Removing the extra `},` fixes it.
- `paper_aliasing_matlab_Sol_Neeman` (`Papers_Sampling.bib`): an `@inproceedings` entry requires `booktitle`. A placeholder `booktitle={Proceedings}` was added; replace it with the real venue.

---

## 4. Cleaning build files

Use `1_Report_DSP/latex_clean.py` with the name of the main file:

```bash
python latex_clean.py 2_main_dsp_sim     # the .tex extension is optional
```

Only the build files of that main file (`.aux`, `.log`, `.toc`, ...) in `1_Report_DSP` are deleted. The `.tex` and `.pdf` files are kept.
