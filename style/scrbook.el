;;; scrbook.el --- AUCTeX style for scrbook.cls  -*- lexical-binding: t; -*-

;; Copyright (C) 2002--2026 Free Software Foundation

;; Author: Mark Trettin <Mark.Trettin@gmx.de>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2002-09-26
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

;; This file adds support for `scrbook.cls'v3.49.3 from 2026-10-19.
;; This file needs `scrkbase.el'.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function LaTeX-KOMA-key-val-options "scrkbase")

(TeX-add-style-hook
 "scrbook"
 (lambda ()
   (LaTeX-largest-level-set "chapter")
   ;; Load basic definitons
   (TeX-run-style-hooks "scrkbase"))
 TeX-dialect)

(defun LaTeX-scrbook-class-options-list ()
  "Return an alist of options for the scrbook class."
  (TeX-load-style "typearea")
  (TeX-load-style "scrkbase")
  (append
   (LaTeX-KOMA-key-val-options)
   '(("leqno") ("fleqn") ("origlongtable"))))

(defun LaTeX-scrbook-class-options ()
  "Read the scrbook class options from the user."
  (TeX-read-key-val t (LaTeX-scrbook-class-options-list)))

;;; scrbook.el ends here
