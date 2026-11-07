;;; moreverb.el --- AUCTeX style for `moreverb.sty'  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2026-11-04
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

;; This file adds support for `moreverb.sty' v2.3b from 2026-11-02.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))
(declare-function font-latex-set-syntactic-keywords "font-latex")

(TeX-add-style-hook
 "moreverb"
 (lambda ()
   (TeX-add-symbols
    '("verbatimtabinput"
      ["Tab width"]
      (lambda (optional)
        (TeX-argument-insert
         (file-relative-name
          (read-file-name (TeX-argument-prompt optional nil "File"))
          (TeX-master-directory))
         optional)))

    "verbatimtabsize"
    "listinglabel"

    '("listinginput"
      ["Interval"] "Start line"
      (lambda (optional)
        (TeX-argument-insert
         (file-relative-name
          (read-file-name (TeX-argument-prompt optional nil "File"))
          (TeX-master-directory))
         optional))))

   (LaTeX-add-environments
    '("verbatimtab" ["Tab width"])
    '("listing"     ["Interval"] "Start line")
    '("listing*"    ["Interval"] "Start line")
    '("listingcont")
    '("listingcont*")
    '("verbatimwrite" "File")
    '("boxedverbatim"))

   ;; Filling
   (make-local-variable 'LaTeX-indent-environment-list)
   (let ((envs '("verbatimtab" "verbatimwrite" "boxedverbatim"
                 "listing"     "listing*"
                 "listingcont" "listingcont*")))
     (dolist (env envs)
       (add-to-list 'LaTeX-verbatim-environments-local env)
       (add-to-list 'LaTeX-indent-environment-list `(,env current-indentation) t)))

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("verbatimtabinput" "[{")
                                ("listinginput"     "[{{"))
                              'reference))

   ;; Tell font-lock about the update
   (font-latex-set-syntactic-keywords))
 TeX-dialect)

(defvar LaTeX-moreverb-package-options nil
  "Package options for the moreverb package.")

;;; moreverb.el ends here
