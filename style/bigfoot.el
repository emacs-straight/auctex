;;; bigfoot.el --- AUCTeX style for `bigfoot.sty' (v2.1)  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2026-08-31
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

;; This file adds support for the bigfoot package.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(TeX-add-style-hook
 "bigfoot"
 (lambda ()

   (TeX-run-style-hooks "perpage" "manyfoot")

   ;; Option management:
   (when (LaTeX-provided-package-options-member "bigfoot" "ruled")
     (TeX-add-to-alist 'LaTeX-provided-package-options '(("manyfoot" "ruled"))))

   (TeX-add-symbols
    '("footnote+"
      (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
      t)
    '("footnote++"
      (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
      t)

    '("footnote-"
      (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
      t)
    '("footnote--"
      (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
      t))

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("footnote" "++--[{"))
                              'reference)))
 TeX-dialect)

(defvar LaTeX-bigfoot-package-options
  '("para*" "ruled" "robust" "fragile" "verbose")
  "Package options for the bigfoot package.")

;;; bigfoot.el ends here
