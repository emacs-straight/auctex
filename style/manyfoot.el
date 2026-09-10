;;; manyfoot.el --- AUCTeX style for `manyfoot.sty' (v1.10)  -*- lexical-binding: t; -*-

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

;; This file adds support for the `manyfoot.sty' (v1.10) from
;; 2005-09-11.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

;; Setup for \DeclareNewFootnote:
(TeX-auto-add-type "manyfoot-DeclareNewFootnote" "LaTeX")

(defvar LaTeX-manyfoot-DeclareNewFootnote-regexp
  '("\\\\DeclareNewFootnote\\(?:\\[[^]]*\\]\\)?[ \t\n\r%]*{\\([^}]+\\)}"
    1 LaTeX-auto-manyfoot-DeclareNewFootnote)
  "Matches the argument of `\\DeclareNewFootnote' from `manyfoot' package.")

(defun LaTeX-manyfoot-cleanup-DeclareNewFootnote ()
  "Parse new footnotes and add them to AUCTeX."
  (when (LaTeX-manyfoot-DeclareNewFootnote-list)
    (let ((with-bigfoot (member "bigfoot" (TeX-style-list))))
      (dolist (elt (mapcar #'car (LaTeX-manyfoot-DeclareNewFootnote-list)))
        (unless (string= elt "default")
          (TeX-add-symbols
           `(,(concat "Footnote"     elt) "Marker" t)
           `(,(concat "Footnotemark" elt) "Marker")
           `(,(concat "Footnotetext" elt) "Marker" t)
           `(,(concat "footnote"     elt)
             (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
             t)
           `(,(concat "footnotemark" elt)
             (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil))
           `(,(concat "footnotetext" elt)
             (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
             t))
          (when with-bigfoot
            (TeX-add-symbols
             `(,(concat "footnote" elt "+")
               (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
               t)
             `(,(concat "footnote" elt "++")
               (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
               t)
             `(,(concat "footnote" elt "-")
               (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
               t)
             `(,(concat "footnote" elt "--")
               (TeX-arg-conditional TeX-arg-footnote-number-p ([ "Number" ]) nil)
               t)))
          ;; Add the newly defined LaTeX-counter:
          (LaTeX-add-counters (concat "footnote" elt))
          ;; Cater for fontification:
          (when (and (featurep 'font-latex)
                     (eq TeX-install-font-lock 'font-latex-setup))
            (font-latex-add-keywords `((,(concat "Footnote"     elt) "{{")
                                       (,(concat "Footnotemark" elt) "{")
                                       (,(concat "Footnotetext" elt) "{{")
                                       (,(concat "footnote"     elt) "++--[{")
                                       (,(concat "footnotemark" elt) "[")
                                       (,(concat "footnotetext" elt) "[{"))
                                     'reference)))))))

(defun LaTeX-manyfoot-auto-prepare ()
  "Clear `LaTeX-auto-manyfoot-DeclareNewFootnote' before parsing."
  (setq LaTeX-auto-manyfoot-DeclareNewFootnote nil))

(defun LaTeX-manyfoot-auto-cleanup ()
  "Process parsed elements."
  (LaTeX-manyfoot-cleanup-DeclareNewFootnote))

(add-hook 'TeX-auto-prepare-hook #'LaTeX-manyfoot-auto-prepare t)
(add-hook 'TeX-auto-cleanup-hook #'LaTeX-manyfoot-auto-cleanup t)
(add-hook 'TeX-update-style-hook #'TeX-auto-parse t)

(TeX-add-style-hook
 "manyfoot"
 (lambda ()

   ;; Add manyfoot to the parser.
   (TeX-auto-add-regexp LaTeX-manyfoot-DeclareNewFootnote-regexp)

   (TeX-add-symbols
    ;; 1 User Interface
    "extrafootnoterule"
    "defaultfootnoterule"

    '("Footnotemark" "Marker")
    '("Footnotetext" "Marker" t)
    '("Footnote"     "Marker" t)

    ;; 2 Declaring New Footnotes
    '("DeclareNewFootnote"
      [TeX-arg-completing-read
       (lambda ()
         (if (or (member "bigfoot" (TeX-style-list))
                 (LaTeX-provided-package-options-member "manyfoot" "para")
                 (LaTeX-provided-package-options-member "manyfoot" "para*"))
             '("plain" "para")
           '("plain")))]
      (TeX-arg-conditional (member "bigfoot" (TeX-style-list))
          ((TeX-arg-completing-read ("default") "Suffix"))
        ("Suffix"))
      [TeX-arg-completing-read ("arabic" "roman" "Roman" "alph" "Alph")
                               "Enumeration style"]
      (lambda (_)
        (save-excursion
          (when (re-search-backward (car LaTeX-manyfoot-DeclareNewFootnote-regexp)
                                    (line-beginning-position -3) t)
            (LaTeX-add-manyfoot-DeclareNewFootnotes (match-string-no-properties 1))
            (LaTeX-manyfoot-cleanup-DeclareNewFootnote)))))

    ;; 3 Custom Footnote Rules
    '("SelectFootnoteRule"
      ["Priority"]
      (TeX-arg-completing-read ("default") "Rule name")
      (TeX-arg-conditional (y-or-n-p "With optional Action argument?")
          ([t])
        ()))

    "footnoterulepriority"
    "extrafootnoterule"

    ;; 4 Add Hooks at the Beginning of Footnotes
    '("SetFootnoteHook" t)

    ;; 6 Splitting of Para-Footnotes
    "SplitNote"

    ;; 9 Add Extra Skip for Para-Footnotes
    '("ExtraParaSkip" TeX-arg-length) )

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("DeclareNewFootnote" "[{[")
                                ("SelectFootnoteRule" "[{[")
                                ("SetFootnoteHook"    "")
                                ("SplitNote"          "")
                                ("ExtraParaSkip"      "{"))
                              'function)
     (font-latex-add-keywords '(("Footnotemark" "{")
                                ("Footnotetext" "{{")
                                ("Footnote"     "{{"))
                              'reference)))
 TeX-dialect)

(defvar LaTeX-manyfoot-package-options
  '("para" "para*" "ruled" "perpage")
  "Package options for the manyfoot package.")

;;; manyfoot.el ends here
