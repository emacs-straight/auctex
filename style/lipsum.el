;;; lipsum.el --- AUCTeX style for `lipsum.sty'.  -*- lexical-binding: t; -*-

;; Copyright (C) 2013--2026 Free Software Foundation, Inc.

;; Maintainer: auctex-devel@gnu.org
;; Author: Mosè Giordano <giordano.mose@libero.it>
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

;; This file adds support for `lipsum.sty' (v2.7) from 2021-09-20.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(TeX-add-style-hook
 "lipsum"
 (lambda ()
   (TeX-add-symbols
    ;; 2.2 User Commands
    '("lipsum"  [ "Paragraph range (max: 150)" ] [ "Sentence range" ])
    '("lipsum*" [ "Paragraph range (max: 150)" ] [ "Sentence range" ])

    '("unpacklipsum"  [ "Paragraph range (max: 150)" ] [ "Sentence range" ])
    '("unpacklipsum*" [ "Paragraph range (max: 150)" ] [ "Sentence range" ])
    "lipsumexp"

    '("setlipsum" (TeX-arg-key-val LaTeX-lipsum-package-options-list))

    ;; 2.3 Other commands
    '("SetLipsumText" "Name")
    '("SetLipsumDefault" "Default paragraph range(max: 150)"))

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("lipsum" "*[["))
                              'textual)
     (font-latex-add-keywords '(("unpacklipsum"     "*[[")
                                ("lipsumexp"        "")
                                ("setlipsum"        "{")
                                ("SetLipsumText"    "{")
                                ("SetLipsumDefault" "{"))
                              'function)))
 TeX-dialect)

(defvar LaTeX-lipsum-package-options-list
  '(("nopar" ("true" "false"))
    ("text"  ("lipsum" "cicero" "lipsum-cs"))
    ("language")
    ("auto-lang" ("true" "false"))
    ("default-range"))
  "Package options for the lipsum package.")

(defun LaTeX-lipsum-package-options ()
  "Read the lipsum package options from the user."
  (TeX-read-key-val t LaTeX-lipsum-package-options-list))

;;; lipsum.el ends here
