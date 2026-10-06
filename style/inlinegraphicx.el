;;; inlinegraphicx.el --- AUCTeX style for `inlinegraphicx.sty'  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2024-11-07
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

;; This file adds support for `inlinegraphicx.sty' v0.20d from
;; 2026-10-03.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(TeX-add-style-hook
 "inlinegraphicx"
 (lambda ()

   (TeX-run-style-hooks "graphicx")

   (TeX-add-symbols
    '("inlinegraphics"
      [TeX-arg-key-val (("scale") ("strut"))]
      [TeX-arg-key-val (LaTeX-graphicx-key-val-options)
                       nil nil ?\s "<" ">"]
      LaTeX-arg-includegraphics)

    '("inlinegraphics*"
      [TeX-arg-key-val (("scale") ("strut"))]
      [TeX-arg-key-val (LaTeX-graphicx-key-val-options)
                       nil nil ?\s "<" ">"]
      LaTeX-arg-includegraphics)

    '("inlinegraphicspath" t)
    '("inlinegraphicxsetup"
      (TeX-arg-key-val (("searchpath" ("{}")) ("extensions" ("{}")))))
    '("safeincludegraphics"
      [TeX-arg-key-val (LaTeX-graphicx-key-val-options)
                       nil nil ?\s]
      LaTeX-arg-includegraphics))

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("inlinegraphics"      "*[<{")
                                ("safeincludegraphics" "[{"))
                              'reference)
     (font-latex-add-keywords '(("inlinegraphicspath"  "{")
                                ("inlinegraphicxsetup" "{"))
                              'function)))
 TeX-dialect)

(defvar LaTeX-inlinegraphicx-package-options
  '("inherit" "inherit=true" "inherit=false")
  "Package options for the inlinegraphicx package.")

;;; inlinegraphicx.el ends here
