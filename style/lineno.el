;;; lineno.el --- AUCTeX style for `lineno.sty' (v5.9)  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2026-06-05
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

;; This file adds support for `lineno.sty' (v5.9) from 2026-03-08.
;; `lineno.sty' is part of TeXLive.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(TeX-add-style-hook
 "lineno"
 (lambda ()
   (TeX-add-symbols
    ;; 3.2 How to turn on line numbering
    '("linenumbers" ["Number"])
    '("linenumbers*")

    ;; 3.3 How to turn off line numbering
    "nolinenumbers"

    ;; 4.1 Running line numbers
    "setrunninglinenumbers"

    ;; 4.1.1 Reseting or setting the line number
    '("resetlinenumber"    ["Number"])

    '("runninglinenumbers" ["Number"])
    '("runninglinenumbers*" )

    ;; 4.2 Pagewise line numbers
    "setpagewiselinenumbers"
    "pagewiselinenumbers"

    ;; 4.2.1 Margin switching
    "switchlinenumbers"
    "switchlinenumbers*"

    ;; 4.2.2 Running mode with margin switching1
    "runningpagewiselinenumbers"
    "realpagewiselinenumbers"

    ;; 4.3 Margin selection
    "leftlinenumbers" "leftlinenumbers*"
    "rightlinenumbers" "rightlinenumbers*"

    ;; 4.6 Numbering only one in five lines
    '("modulolinenumbers" ["Number"])

    ;; 4.7 How the line numbers look like
    "linenumberfont"
    "thelinenumber"

    ;; 5 Line number references
    '("linelabel" TeX-arg-define-label))

   (LaTeX-add-environments
    ;; 3.2 How to turn on line numbering
    '("linenumbers" ["Number"])
    '("linenumbers*")

    ;; 4.1 Running line numbers
    '("runninglinenumbers" ["Number"])
    '("runninglinenumbers*")

    ;; 4.2 Pagewise line numbers
    '("pagewiselinenumbers"))

   ;; 4.7 How the line numbers look like
   (LaTeX-add-lengths "linenumbersep")

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("linenumbers"        "*[")
                                ("resetlinenumber"    "[")
                                ("runninglinenumbers" "*[")
                                ("switchlinenumbers"  "*")
                                ("leftlinenumbers"    "*")
                                ("rightlinenumbers"   "*")
                                ("modulolinenumbers"  "["))
                              'function)
     (font-latex-add-keywords '("nolinenumbers"
                                "setrunninglinenumbers"
                                "setpagewiselinenumbers"
                                "pagewiselinenumbers"
                                "runningpagewiselinenumbers"
                                "realpagewiselinenumbers")
                              'function-noarg)
     (font-latex-add-keywords '(("linelabel" "{"))
                              'reference)))
 TeX-dialect)

(defvar LaTeX-lineno-package-options
  '("left" "right" "switch" "switch*" "pagewise" "running"
    "modulo" "mathline" "displaymath")
  "Package options for the lineno package.")

;;; lineno.el ends here
