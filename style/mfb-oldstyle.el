;;; mfb-oldstyle.el --- AUCTeX style for `mfb-oldstyle.sty' (v2.0)  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2026-10-15
;; Keywords: tex

;; This file is part of AUCTeX.

;; AUCTeX is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; either version 3, or (at your option) any
;; later version.

;; AUCTeX is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This file adds support for `mfb-oldstyle.sty' (v2.0) from 2026-10-14.
;; `mfb-oldstyle.sty' is part of TeXLive.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(TeX-add-style-hook
 "mfb-oldstyle"
 (lambda ()
   ;; Run style hooks for packages loaded by mfb-oldstyle:
   (if (or (memq TeX-engine '(xetex luatex))
           (LaTeX-provided-package-options-member "mfb-oldstyle" "dlig"))
       (TeX-run-style-hooks "fontspec")
     (TeX-run-style-hooks "figureversions"))

   ;; New symbols
   (TeX-add-symbols
    '("textsu" t)    ; superior figures
    '("sufigures" -1)
    '("textin" t)    ; inferior figures
    '("infigures" -1)
    '("textfrac" "Numerator" "Denominator"))

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("textsu" "{")
                                ("textin" "{"))
                              'type-command)
     (font-latex-add-keywords '("sufigures" "infigures")
                              'type-declaration)
     (font-latex-add-keywords '(("textfrac" "{{"))
                              'textual)))
 TeX-dialect)

(defvar LaTeX-mfb-oldstyle-package-options-list
  '(("scaled")
    ("scale")
    ("lining" ("true" "false"))
    ("lf" ("true" "false"))
    ("oldstyle" ("true" "false"))
    ("osf" ("true" "false"))
    ("proportional" ("true" "false"))
    ("tabular" ("true" "false"))
    ("superiors" ("all" "footnote"))
    ("nosuperiors")
    ("dlig")
    ("type1"))
  "Alist of package options for mfb-oldstyle package.")

(defun LaTeX-mfb-oldstyle-package-options ()
  "Prompt for package options for the mfb-oldstyle package."
  (TeX-read-key-val t LaTeX-mfb-oldstyle-package-options-list))

;;; mfb-oldstyle.el ends here
