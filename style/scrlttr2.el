;;; scrlttr2.el --- AUCTeX style for scrlttr2.cls   -*- lexical-binding: t; -*-

;; Copyright (C) 2002--2026 Free Software Foundation

;; Author: Mark Trettin <Mark.Trettin@gmx.de>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2002-10-26
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

;; This file adds support for `scrlttr2.cls' v3.49.3 from 2026-10-19.

;; Since I just recently switched from `g-brief.cls' to the KOMA-Script
;; letter class *and* I don't really write many snailmails, there are
;; probably some superflous macros included and important ones left
;; out.  Comments appreciated.

;;; Code

(require 'tex)
(require 'latex)

;; Silence the compiler:
(declare-function font-latex-add-keywords "font-latex" (keywords class))
(defvar LaTeX-typearea-package-options-list)

(defvar LaTeX-scrlttr2-variables
  '("addresseeimage"
    "backaddress"
    "backaddressseparator"
    "ccseparator"
    "customer"
    "date"
    "emailseparator"
    "enclseparator"
    "faxseparator"
    "firstfoot"
    "firsthead"
    "fromaddress"
    "frombank"
    "fromemail"
    "fromfax"
    "fromlogo"
    "frommobilephone"
    "fromname"
    "fromphone"
    "fromurl"
    "fromzipcode"
    "invoice"
    "location"
    "myref"
    "nextfoot"
    "nexthead"
    "phoneseparator"
    "place"
    "placeseparator"
    "PPdatamatrix"
    "PPcode"
    "signature"
    "specialmail"
    "subject"
    "subjectseparator"
    "title"
    "toaddress"
    "toname"
    "yourmail"
    "yourref"
    "zipcodeseparator")
  "List of variables provided by scrlttr2 class.")

(defvar LaTeX-scrlttr2-plengths
  '("backaddrheight"
    "bfoldmarklength"
    "bfoldmarkvpos"
    "firstfoothpos"
    "firstfootvpos"
    "firstfootwidth"
    "firstheadhpos"
    "firstheadvpos"
    "firstheadwidth"
    "foldmarkhpos"
    "foldmarkvpos"
    "fromrulethickness"
    "fromrulewidth"
    "lfoldmarkhpos"
    "lfoldmarklength"
    "locheight"
    "lochpos"
    "locvpos"
    "locwidth"
    "mfoldmarklength"
    "mfoldmarkvpos"
    "pfoldmarklength"
    "PPdatamatrixvskip"
    "PPheadheight"
    "PPheadwidth"
    "refaftervskip"
    "refhpos"
    "refvpos"
    "refwidth"
    "sigbeforevskip"
    "sigindent"
    "specialmailindent"
    "specialmailrightindent"
    "subjectaftervskip"
    "subjectbeforevskip"
    "subjectvpos"
    "tfoldmarklength"
    "tfoldmarkvpos"
    "toaddrheight"
    "toaddrhpos"
    "toaddrindent"
    "toaddrvpos"
    "toaddrwidth")
  "List of pseudo lengths provided by the scrltt2 class.")

(defvar LaTeX-scrlttr2-font-elements
  '("addressee"
    "backaddress"
    "descriptionlabel"
    "enumeratelabel"
    "foldmark"
    "footnote"
    "footnotelabel"
    "footnotereference"
    "footnoterule"
    "fromaddress"
    "fromname"
    "fromrule"
    "itemizelabel"
    "labelenumi"
    "labelenumii"
    "labelenumiii"
    "labelenumiv"
    "labelinglabel"
    "labelingseparator"
    "labelitemi"
    "labelitemii"
    "labelitemiii"
    "labelitemiv"
    "pagefoot"
    "pagehead"
    "pageheadfoot"
    "pagenumber"
    "pagination"
    "placeanddate"
    "refname"
    "refvalue"
    "specialmail"
    "lettersubject"
    "lettertitle"
    "toaddress"
    "tomane")
  "List of scrlttr2 font elements.")

(defvar LaTeX-scrlttr2-key-val-options
  (let ((bools '("true" "on" "yes" "false" "off" "no")))
    `(("draft" ,bools)
      ("overfullrule" ,bools)
      ;; 4.8. Choosing the Document Font Size
      ("fontsize" ("10pt" "11pt" "12pt"))
      ;; 4.9. Text Markup
      ("sfdefaults" ,bools)
      ;; 4.10.1. Fold Marks
      ("foldmarks" ("B" "H" "L" "M" "P" "T" "V"
                    "b" "h" "l" "m" "p" "t" "v"))
      ;; 4.10.2. Letterhead
      ("firsthead" ,bools)
      ("fromalign" ("center" "centered" "middle"
                    "false" "off" "no"
                    "left"
                    "locationleft" "leftlocation"
                    "locationright" "rightlocation" "location"
                    "right"))
      ("fromrule" ("afteraddress" "below" "aftername" ,@bools))
      ("symbolicnames" ("marvosym" "fontawesome" ,@bools))
      ("fromphone" ,bools)
      ("frommobilephone" ,bools)
      ("fromfax" ,bools)
      ("fromemail" ,bools)
      ("fromurl" ,bools)
      ("fromlogo" ,bools)
      ;; 4.10.3. Addressee
      ("addrfield" ("backgroundimage" "PPbackgroundimage" "PPBackgroundImage"
                    "PPBackGroundImage" "ppbackgroundimage" "ppBackgroundImage"
                    "ppBackGroundImage"
                    "image" "Image" "PPimage" "PPImage" "ppimage" "ppImage"
                    "PP" "pp" "PPexplicite" "PPExplicite" "ppexplicite" "ppExplicite"
                    "topaligned" "alignedtop"
                    ,@bools))
      ("backaddress" ("underlined" "plain" ,@bools))
      ("priority" ("B" "b" "economy" "Economy" "ECONOMY" "B-ECONOMY"
                   "B-Economy" "b-economy"
                   "A" "a" "priority" "Priority" "PRIORITY" "A-Priority"
                   "A-priority" "a-priority"
                   "manual" ,@bools))
      ;; 4.10.4. Extra Sender Information
      ("locfield" ("narrow" "wide"))
      ;; 4.10.5. Reference Line
      ("numericaldate" ,bools)
      ("refline" ("dateleft" "dateright" "narrow" "nodate" "wide"))
      ;; 4.10.6. Subject
      ("subject" ("afteropening" "beforeopening"
                  "centered" "left" "right"
                  "titled" "underlined" "untitled"))
      ;; 4.10.8. Letterhead Page Footer
      ("shrinkfirstpage" ,bools)
      ("enlargefirstpage" ,bools)
      ("firstfoot" ,bools)
      ;; 4.11. Marking Paragraphs
      ("parskip" (,@bools "full" "full-" "full+" "full*"
                          "half" "half-" "half+" "half*" "never"))
      ;; 4.13. Headers and Footers with the Default Page Style
      ("headsepline" ,bools)
      ("footsepline" ,bools)
      ("pagenumber" ("bot" "foot"
                     "botcenter" "botcentered" "botmittle"
                     "footcenter" "footcentered" "footmiddle"
                     "botleft" "footleft"
                     "botright" "footright"
                     "center" "centered" "middle"
                     "head" "top"
                     "headcenter" "headcentered" "headmiddle" "topcenter"
                     "topcentered" "topmiddle"
                     "headleft" "topleft"
                     "headright" "topright"
                     "left" "right"
                     ,@bools))
      ;; 4.15. Footnotes
      ("footnotes" ("multiple" "nomultiple"))))
  "Key=val options for macros from scrlttr2.cls.")

(defun LaTeX-scrlttr2-key-val-options ()
  "Return key=val options for macros from scrlttr2.cls."
  (append
   `(("cleardoublepage" ("current" ,@(mapcar #'car (LaTeX-pagestyle-list)))))
   LaTeX-typearea-package-options-list
   LaTeX-scrlttr2-key-val-options))

(defvar LaTeX-scrltt2-lco-files nil
  "List of Letter Class Option Files for scrlttr2 package.")

;; Add the variable to `TeX-normal-mode-reset-list':
(add-to-list 'TeX-normal-mode-reset-list 'LaTeX-scrltt2-lco-files)

(defun LaTeX-scrltt2-lco-files ()
  "Set list of Letter Class Option Files for scrlttr2 package."
  (or LaTeX-scrltt2-lco-files
      (let ((TeX-file-extensions '("lco")))
        (prog2
            (message "Searching for letter class option files...")
            (setq LaTeX-scrltt2-lco-files
                  (TeX-search-files-by-type 'texinputs 'global t t))
          (message "Searching for letter class option files...done")))))

(TeX-add-style-hook
 "scrlttr2"
 (lambda ()

   (TeX-run-style-hooks "typearea")

   (TeX-add-symbols
    ;; 4.1. Early or Late Selection of Options
    '("KOMAoptions"
      (TeX-arg-key-val (LaTeX-scrltt2-key-val-options)))

    `("KOMAoption"
      (TeX-arg-completing-read (LaTeX-scrlttr2-key-val-options) "Key")
      (TeX-arg-completing-read
       ,(lambda ()
          (let ((key (save-excursion
                       (re-search-backward "\\\\KOMAoption{\\([^}]+\\)}"
                                           (line-beginning-position) t)
                       (match-string-no-properties 1))))
            (when key
              (cadr (assoc key (LaTeX-scrlttr2-key-val-options))))))
       "Value"))

    ;; 4.5. Variables
    '("setkomavar"
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name")
      [ "Description" ] t)
    '("setkomavar*"
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name")
      "Description")

    '("usekomavar"
      [TeX-arg-macro]
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name"))
    '("usekomavar*"
      [TeX-arg-macro]
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name"))

    '("Ifkomavar"
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name") 2)
    '("Ifkomavarempty"
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name") 2)
    '("Ifkomavarempty*"
      (TeX-arg-completing-read LaTeX-scrlttr2-variables "Variable name") 2)

    ;; 4.6. Pseudo-lengths
    '("newplenght" "Name")
    '("Ifplength"
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length") 2)
    '("useplength"
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length"))
    '("setplength"
      ["Factor"]
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length")
      "Value")
    '("addtoplength"
      ["Factor"]
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length")
      "Value")
    '("setplengthtowidth"
      ["Factor"]
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length")
      "Content")
    '("setplengthtoheight"
      ["Factor"]
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length")
      "Content")
    '("setplengthtodept"
      ["Factor"]
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length")
      "Content")
    '("setplengthtototalheight"
      ["Factor"]
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length")
      "Content")
    '("setlengthtoplength"
      ["Factor"]
      (TeX-arg-length "Length")
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length"))
    '("addtolengthplength"
      ["Factor"]
      (TeX-arg-length "Length")
      (TeX-arg-completing-read LaTeX-scrlttr2-plenghts "Pseudo length"))

    ;; 4.7. General Structure of Letter Documents
    '("AtBeginLetter" t)
    '("AtEndLetter" t)
    "thisletter"
    "letterlastpage"
    '("opening" "Opening")
    '("closing" "Closing Phrase")
    "ps"
    '("cc" t)
    '("encl" t)

    ;; 4.9. Text Markup
    "maybesffamily"
    '("textmaybesf" t)

    '("setkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element")
      (TeX-arg-font-switches "Commands"))
    '("addtokomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element")
      (TeX-arg-font-switches "Commands"))
    '("usekomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))
    '("usefontofkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))
    '("useencodingofkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))
    '("usesizeofkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))
    '("usefamilyofkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))
    '("useseriesofkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))
    '("useshapeofkomafont"
      (TeX-arg-completing-read LaTeX-scrlttr2-font-elements "Element"))

    ;; 4.10.7. Closing
    "raggedsignature"
    "sigalign"
    "sigspace"

    ;; 4.12. Detecting Odd and Even Pages
    '("Ifthispageodd" 2)

    ;; 4.13. Headers and Footers with the Default Page Style
    "letterpagestyle"

    ;; 4.14. Interleaf Pages
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

    ;; 4.15. Footnotes
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

    ;; 4.19. Marginal Notes
    '("marginline" "Text")

    ;; 4.20. Letter Class Option Files
    '("LoadLetterOption"
      (TeX-arg-completing-read (LaTeX-scrltt2-lco-files) "LCO file"))
    '("LoadLetterOptions"
      (TeX-arg-completing-read-multiple (LaTeX-scrltt2-lco-files) "LCO files"))

    ;; 4.21. Address Files and Form Letters
    '("adrentry" "Lastname" "Firstname" "Address" "Telephone"
      "F1" "F2" "Comment" "Key")
    '("addrentry" "Lastname" "Firstname" "Address" "Telephone"
      "F1" "F2" "F3" "F4" "Key")
    '("adrchar" "Initial letter")
    '("addrchar" "Initial letter") )

   (LaTeX-add-environments
    '("letter" LaTeX-env-args
      [TeX-arg-key-val (LaTeX-scrlttr2-key-val-options)]
      "Recipient")

    ;; 4.16. Lists
    '("labeling" LaTeX-env-item-args
      ["Delimiter"] "Widest pattern")

    '("addmargin" LaTeX-env-args
      [TeX-arg-length "Left indentation"]
      (TeX-arg-length "Indentation"))

    '("addmargin*" LaTeX-env-args
      [TeX-arg-length "Inner indentation"]
      (TeX-arg-length "Indentation")) )

   (LaTeX-add-counters "letter")
   (add-to-list 'LaTeX-item-list '("labeling" . LaTeX-item-argument))

   ;; Definitions for font-latex
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (font-latex-add-keywords '(("addrentry" "{{{{{{{{{")
                                ("adrentry"  "{{{{{{{{")
                                ("cc"        "{")
                                ("closing"   "{")
                                ("encl"      "{")
                                ("opening"   "{"))
                              'textual)
     (font-latex-add-keywords '(("AtBeginLetter"      "")
                                ("AtEndLetter"        "")
                                ("KOMAoption"         "{{")
                                ("KOMAoptions"        "{")
                                ("LoadLetterOption"   "{")
                                ("LoadLetterOptions"  "{")
                                ("addrchar"           "{")
                                ("adrchar"            "{")
                                ("deffootnote"        "[{{{")
                                ("deffootnotemark"    "{")
                                ("newplenght"         "{")
                                ("setfootnoterule"     "[{"))
                              'function)
     (font-latex-add-keywords '("letterpagestyle"
                                "ps"
                                "raggedfootnote"
                                "raggedsignature"
                                "sigalign"
                                "sigspace")
                              'function-noarg)
     (font-latex-add-keywords '(("addtokomafont"      "{{")
                                ("addtoplength"       "[{{")
                                ("addtoreffields"     "{")
                                ("newkomavar"         "*[{")
                                ("setkomafont"        "{{")
                                ("setkomavar"         "*{[{")
                                ("setplength"         "[{{")
                                ("useplength"         "{"))
                              'variable)
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
     (font-latex-add-keywords '(("marginline"  "{"))
                              'reference)
     (font-latex-add-keywords '("maybesffamily")
                              'type-declaration)
     (font-latex-add-keywords '(("textmaybesf" "{"))
                              'type-command)))
 TeX-dialect)

(defun LaTeX-scrlttr2-class-options-list ()
  "Return an alist of options for the scrlttr2 class."
  (TeX-load-style "typearea")
  (TeX-load-style "scrkbase")
  (append
   `(("cleardoublepage" ("current" ,@(mapcar #'car (LaTeX-pagestyle-list)))))
   LaTeX-typearea-package-options-list
   LaTeX-scrlttr2-key-val-options))

(defun LaTeX-scrlttr2-class-options ()
  "Read the scrlttr2 class options from the user."
  (TeX-read-key-val t (LaTeX-scrlttr2-class-options-list)))

;;; scrlttr2.el ends here
