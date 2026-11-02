;;; fontscale.el --- AUCTeX style for `fontscale.sty' (v5.0.1)  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2026-10-30
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

;; This file adds support for `fontscale.sty' v5.0.1 from 2026-10-27.
;; `fontscale.sty' is part of TeXLive.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(defvar LaTeX-fontscale-key-val-options
  (append
   (let ((sizes '("tiny"
                  "scriptsize"
                  "footnotesize"
                  "small"
                  "normalsize"
                  "large"
                  "Large"
                  "LARGE"
                  "huge"
                  "Huge"))
         (postfix '("size-normalsize-ratio"
                    "size"
                    "baselineskip-size-ratio"
                    "baselineskip")))
     (cl-loop for size in sizes
              collect (list size)
              append (mapcar (lambda (x) (list (concat size "/" x))) postfix)))
   '(("typographic-scale" ("classic" "musical"))
     ("classic")
     ("musical")
     ("classic/base" ("10" "11" "12"))
     ("classic/point" ("pt" "bp" "dd" "nd"))
     ("musical/base")
     ("musical/ratio")
     ("musical/notes")
     ("baselineskip-size-ratio")))
  "Key=val options for the macros from fontscale.sty.")

(TeX-add-style-hook
 "fontscale"
 (lambda ()
   (TeX-add-symbols
    ;; 3.1 Setting the keys
    '("fontscalesetup"  (TeX-arg-key-val LaTeX-fontscale-key-val-options))
    '("fontscalesetup*" (TeX-arg-key-val LaTeX-fontscale-key-val-options))

    ;; 3.3 More font size commands
    '("setfontsize"
      [TeX-arg-length "Baselineskip"]
      (TeX-arg-length "Fontsize"))

    ;; 3.3 More font size commands
    '("stepfontsize" "Step")

    ;; 3.4 Setting only the font baselineskip
    '("setfontbaselineskip" (TeX-arg-length "Skip"))

    ;; 3.5 Printing sample text
    '("printsampletext"  t)
    '("printsampletext*" t)
    "printfontsizecommand")

   ;; 3.2 Lengths
   (LaTeX-add-lengths "currentfontsize" "currentfontbaselineskip"
                      "currentnormalsize")

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("setfontsize"         "[{")
                                ("stepfontsize"        "{")
                                ("setfontbaselineskip" "{"))
                              'variable)
     (font-latex-add-keywords '("printfontsizecommand")
                              'function-noarg)
     (font-latex-add-keywords '(("fontscalesetup"      "*{")
                                ("printsampletext"     "*{"))
                              'function)))
 TeX-dialect)

(defvar LaTeX-fontscale-package-options nil
  "Package options for the fontscale package.")

;;; fontscale.el ends here
