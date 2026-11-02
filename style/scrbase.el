;;; scrbase.el --- AUCTeX style for the KOMA-Script bundle.  -*- lexical-binding: t; -*-

;; Copyright (C) 2002--2026 Free Software Foundation, Inc.

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

;; This file adds support for the KOMA-Script bundle.  This file
;; contains the base definitions that work with all KOMA-Script classes
;; (scrarctl.cls, scrreprt.cls, scrbook.cls and scrlttr2.cls).  You need
;; this file since it's loaded from the class-styles via `scrkbase.el'.

;;; Code:

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))

(TeX-add-style-hook
 "scrbase"
 (lambda ()
   (TeX-add-symbols
    ;; 3.6. Text Markup
    "maybesffamily"
    '("textmaybesf" t)

    ;; 3.7. Document Titles
    "coverpagetopmargin"
    "coverpageleftmargin"
    "coverpagerightmargin"
    "coverpagebottommargin"
    '("maketitle" ["Page number"])
    '("extratitle" t)
    '("frontispiece" t)

    '("titlehead" t)
    '("subject" "Subject")
    '("subtitle" t)
    '("publishers" t)
    '("uppertitleback" t)
    '("lowertitleback" t)
    '("dedication" t)

    ;; 3.9. Table of Contents
    "parttocdepth"
    "sectiontocdepth"
    "subsectiontocdepth"
    "subsubsectiontocdepth"
    "paragraphtocdepth"
    "subparagraphtocdepth"

    ;; 3.12 Headers and Footers Using Predefined Page Styles
    "titlepagestyle"
    "partpagestyle"
    "chapterpagestyle"
    "indexpagestyle"
    '("cleardoublepageusingstyle" TeX-arg-pagestyle)
    "cleardoubleemptypage"
    "cleardoubleplainpage"
    "cleardoublestandardpage"
    "cleardoubleoddpage"
    '("cleardoubleoddpageusingstyle" TeX-arg-pagestyle)
    "cleardoubleoddemptypage"
    "cleardoubleoddplainpage"
    "cleardoubleoddstandardpage"
    "cleardoubleevenpage"
    '("cleardoubleevenpageusingstyle" TeX-arg-pagestyle)
    "cleardoubleevenemptypage"
    "cleardoubleevenplainpage"
    "cleardoubleevenstandardpage"

    ;; 3.14. Footnotes
    "multfootsep"
    "multiplefootnoteseparator"

    '("deffootnote"
      [TeX-arg-length "Mark width"]
      (TeX-arg-length "Indent")
      (TeX-arg-length "Paragraph indent")
      t)
    '("deffootnotemark")
    "thefootnotemark"
    '("setfootnoterule"
      [TeX-arg-length "Thickness"]
      (TeX-arg-length "Length"))
    "raggedfootnote"

    ;; 3.16. Document Structure
    "raggedpart" "raggedsection"
    "partformat"
    "sectionformat"
    "subsectionformat"
    "subsubsectionformat"
    "paragraphformat"
    "subparagraphformat"
    "autodot"

    "partnumdepth"
    "sectionnumdepth"
    "subsectionnumdepth"
    "subsubsectionnumdepth"
    "paragraphnumdepth"
    "subparagraphnumdepth"

    '("Ifnumbered"
      (TeX-arg-completing-read ("part" "chapter" "section" "subsection"
                                "subsubsection" "paragraph" "subparagraph")
                               "Section level")
      2)
    '("Ifunnumbered"
      (TeX-arg-completing-read ("part" "chapter" "section" "subsection"
                                "subsubsection" "paragraph" "subparagraph")
                               "Section level")
      2))

   ;; 3.16. Document Structure: Deal with macros here and not in
   ;; scrbook.el or scrreprt.el:
   (make-local-variable 'LaTeX-section-label)
   (when (cl-intersection '("scrbook" "scrreprt") (TeX-style-list)
                          :test #'string-equal)
     (LaTeX-section-list-add-locally '("addchap" 1))
     (add-to-list 'LaTeX-section-label '("addchap" . nil) t)
     (LaTeX-paragraph-commands-add-locally "addchap")

     (TeX-add-symbols
      "raggedchapter"
      "chapterformat"
      "chapternumdepth"
      '("setpartpreamble"
        [TeX-arg-completing-read ("l" "r" "c" "o" "u"
                                  "lo" "lu" "ro" "ru" "co" "cu")
                                 "Position"]
        [TeX-arg-length "Width"]
        t)
      '("setchapterpreamble"
        [TeX-arg-completing-read ("l" "r" "c" "o" "u"
                                  "lo" "lu" "ro" "ru" "co" "cu")
                                 "Position"]
        [TeX-arg-length "Width"]
        t))
     ;; Fontification
     (when (and (featurep 'font-latex)
                (eq TeX-install-font-lock 'font-latex-setup))
       (font-latex-add-keywords '(("addchap" "*[{"))
                                'sectioning-1)
       (font-latex-add-keywords '(("setpartpreamble"    "[[")
                                  ("setchapterpreamble" "[["))
                                'textual)) )

   ;; 3.16. Document Structure: These are defined in all classes:
   (LaTeX-section-list-add-locally '(("addpart" 0)
                                     ("addsec"  2)
                                     ("minisec" 7)))

   ;; nil as cdr in `LaTeX-section-label' means: No label insetion:
   (let ((list '(("addpart" . nil)
                 ("addsec" . nil)
                 ("minisec" . nil))))
     (dolist (elt list)
       (add-to-list 'LaTeX-section-label elt t)))
   (LaTeX-paragraph-commands-add-locally '("addpart" "addsec" "minisec"))

   (TeX-add-symbols
    ;; 3.17. Dicta
    '("dictum" ["Author"] t)
    "dictumwidth"
    "dictumauthorformat"
    "dictumrule"
    "raggeddictum"
    "raggeddictumtext"
    "raggeddictumauthor"

    '("captionbelow" ["Short caption"] "Caption")
    '("captionabove" ["Short caption"] "Caption")
    '("captionof"
      (TeX-arg-completing-read ("figure" "table") "Float type")
      ["Short caption"] "Caption")
    '("captionbelowof"
      (TeX-arg-completing-read ("figure" "table") "Float type")
      ["Short caption"] "Caption")
    '("captionaboveof"
      (TeX-arg-completing-read ("figure" "table") "Float type")
      ["Short caption"] "Caption")

    ;; 3.20. Floating Environments for Tables and Figures
    "captionformat"
    "figureformat"
    "tableformat"

    '("setcapindent"  (TeX-arg-length "Indent"))
    '("setcapindent*" (TeX-arg-length "Indent"))
    "setcaphanging"

    '("setcapwidth"
      [TeX-arg-completing-read ("l" "c" "r" "i" "o") "Justification"]
      (TeX-arg-length "Width"))
    '("setcapdynwidth"
      [TeX-arg-completing-read ("l" "c" "r" "i" "o") "Justification"]
      (TeX-arg-length "Width"))
    '("setcapmargin"
      [TeX-arg-length "Left margin"]
      (TeX-arg-length "Margin"))
    '("setcapmargin*"
      [TeX-arg-length "Inside margin"]
      (TeX-arg-length "Margin"))
    '("setcaptionalignment"
      [TeX-arg-completing-read ("figure" "table") "Float type"]
      (TeX-arg-completing-read ("l" "c" "r" "i" "o") "Alignment"))

    ;; 3.21. Marginal Notes
    '("marginline" "Text")

    ;; 3.23. Bibliography
    '("setbibpreamble" t)

    ;; 3.24. Index
    '("setindexpreamble" t) )

   (LaTeX-add-environments
    ;; 3.18. Lists
    '("labeling" LaTeX-env-item-args
      ["Delimiter"] "Widest pattern")

    '("addmargin" LaTeX-env-args
      [TeX-arg-length "Left indentation"]
      (TeX-arg-length "Indentation"))

    '("addmargin*" LaTeX-env-args
      [TeX-arg-length "Inner indentation"]
      (TeX-arg-length "Indentation"))

    ;; 3.20. Floating Environments for Tables and Figures
    '("figure-" LaTeX-env-figure)
    '("table-" LaTeX-env-figure)

    `("captionbeside" LaTeX-env-args
      ["Short caption"] "Caption"
      [TeX-arg-completing-read ("l" "r" "i" "o") "Placement"]
      [TeX-arg-length "Width"]
      [TeX-arg-length "Offset"]
      ,(lambda (_)
         (and (save-excursion
                (re-search-backward "\\(?:\\[[^]]*\\]\\)\\{3\\}"
                                    (line-beginning-position) t))
              (y-or-n-p "With optional star?: ")
              (insert "*"))))

    `("captionofbeside" LaTeX-env-args
      (TeX-arg-completing-read ("figure" "table") "Float type")
      ["Short caption"] "Caption"
      [TeX-arg-completing-read ("l" "r" "i" "o") "Placement"]
      [TeX-arg-length "Width"]
      [TeX-arg-length "Offset"]
      ,(lambda (_)
         (and (save-excursion
                (re-search-backward "\\(?:\\[[^]]*\\]\\)\\{3\\}"
                                    (line-beginning-position) t))
              (y-or-n-p "With optional star?: ")
              (insert "*")))))

   (add-to-list 'LaTeX-item-list '("labeling" . LaTeX-item-argument))
   (make-local-variable 'LaTeX-label-alist)
   (dolist (elt '(("figure-" . LaTeX-figure-label)
                  ("table-" . LaTeX-table-label)))
     (add-to-list 'LaTeX-label-alist elt t))

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("proportionalfigures" "{")
                                ("tabularfigures"      "{")
                                ("textfigures"         "{")
                                ("textmaybesf"         "{"))
                              'type-command)
     (font-latex-add-keywords '("maybesffamily")
                              'type-declaration)
     (font-latex-add-keywords '(("deffootnote"         "[{{{")
                                ("deffootnotemark"     "{")
                                ("setcapdynwidth"      "[{")
                                ("setcapindent"        "*{")
                                ("setcapmargin"        "*[{")
                                ("setcaptionalignment" "[{")
                                ("setcapwidth"         "[{")
                                ("setfootnoterule"     "[{"))
                              'function)
     (font-latex-add-keywords '("multiplefootnoteseparator"
                                "raggedfootnote"
                                "setbibpreamble"
                                "setcaphanging"
                                "setchapterpreamble"
                                "setindexpreamble"
                                "setpartpreamble")
                              'function-noarg)
     (font-latex-add-keywords '(("captionabove"   "[{")
                                ("captionaboveof" "{[{")
                                ("captionbelow"   "[{")
                                ("captionbelowof" "{[{")
                                ("captionof"      "{[{")
                                ("dediction"      "{")
                                ("dictum"         "[{")
                                ("extratitle"     "{")
                                ("frontispiece"   "{")
                                ("lowertitleback" "{")
                                ("maketitle"      "[")
                                ("publishers"     "{")
                                ("subject"        "{")
                                ("subtitle"       "{")
                                ("titlehead"      "{")
                                ("uppertitleback" "{"))
                              'textual)
     (font-latex-add-keywords '(("marginline" "{"))
                              'reference)
     (font-latex-add-keywords '("cleardoubleemptypage"
                                "cleardoubleevenemptypage"
                                "cleardoubleevenpage"
                                "cleardoubleevenpageusingstyle"
                                "cleardoubleevenplainpage"
                                "cleardoubleevenstandardpage"
                                "cleardoubleoddemptypage"
                                "cleardoubleoddpage"
                                "cleardoubleoddpageusingstyle"
                                "cleardoubleoddplainpage"
                                "cleardoubleoddstandardpage"
                                "cleardoublepageusingstyle"
                                "cleardoubleplainpage"
                                "cleardoublestandardpage")
                              'warning)
     (font-latex-add-keywords '(("addpart" "*[{"))
                              'sectioning-0)
     (font-latex-add-keywords '(("addsec"  "*[{"))
                              'sectioning-2)
     (font-latex-add-keywords '(("minisec" "{"))
                              'sectioning-4)))
 TeX-dialect)

;;; scrbase.el ends here
