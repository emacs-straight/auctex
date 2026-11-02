;;; typearea.el --- AUCTeX style for `typearea.sty' v3.49.2  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2026-10-26
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

;; This file adds support for `typearea.sty' (v3.49.2) from 2026-02-02.
;; `typearea.sty' is part of KOMA-Script bundle and TeXLive.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(defvar LaTeX-typearea-package-options-list
  (let ((bools '("true" "on" "yes" "false" "off" "no"))
        (len (mapcar (lambda (x) (concat TeX-esc (car x))) (LaTeX-length-list)))
        paper)
    (dolist (elt '("A" "B" "C" "D"))
      (dotimes (i 11)
        (push (concat elt (number-to-string i)) paper)))
    `(("version" ("first" "last"))
      ("BCOR")
      ("DIV" ("6" "7" "8" "9" "10" "11" "12" "13" "14" "15"
              "areaset" "calc" "classic" "current" "default" "last"))
      ("twoside" (,@bools "semi"))
      ("twocolumn" ,bools)
      ("headinclude" ,bools)
      ("footinclude" ,bools)
      ("mpinclude" ,bools)
      ("headlines")
      ("headheight" ,len)
      ("footlines")
      ("footheight" ,len)
      ("paper" ("letter" "legal" "executive" ,@paper
                "landscape" "seascape" "portrait"))
      ("pagesize" ("auto" "automedia" "false" "no" "off"
                   "dvipdfmx" "dvips" "pdftex" "luatex"))
      ("usegeometry" ,bools)))
  "Package options for the typearea package.")

(TeX-add-style-hook
 "typearea"
 (lambda ()
   (TeX-add-symbols
    ;; 2.6. Adjusting the Type Area and Page Layout
    '("typearea"
      [TeX-arg-completing-read ("current") "BCOR"]
      (TeX-arg-completing-read ("areaset" "calc" "classic" "current"
                                "default" "last")
                               "DIV"))
    '("areaset"
      [TeX-arg-completing-read ("current") "BCOR"]
      (TeX-arg-length "Width")
      (TeX-arg-length "Height"))

    "recalctypearea")

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '("recalctypearea")
                              'function-noarg)
     (font-latex-add-keywords '(("typearea" "[{")
                                ("areaset"  "[{{"))
                              'variable)))
 TeX-dialect)

(defun LaTeX-typearea-package-options ()
  "Read the typearea package options from the user."
  (TeX-read-key-val t LaTeX-typearea-package-options-list))

;;; typearea.el ends here
