;;; auctex.el --- Integrated environment for *TeX*  -*- lexical-binding: t; -*-

;; Copyright (C) 2014-2024 Free Software Foundation, Inc.

;; Version: 14.0.6
;; URL: https://www.gnu.org/software/auctex/
;; Maintainer: auctex-devel@gnu.org
;; Notifications-To: auctex-diffs@gnu.org
;; Package-Requires: ((emacs "27.1"))
;; Keywords: TeX LaTeX Texinfo ConTeXt docTeX preview-latex

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; AUCTeX is a comprehensive customizable integrated environment for
;; writing input files for TeX, LaTeX, ConTeXt, Texinfo, and docTeX
;; using Emacs.  One component of AUCTeX is preview-latex which provides
;; true "What You See Is What You Get" experience in the sourcebuffer.

;;; Code:

;; This can be used for starting up AUCTeX, e.g., when not installed
;; from ELPA.  We have to set `no-byte-compile' to t otherwise the
;; compiler will eval the form during the compilation where
;; `load-file-name' is nil and things will go wrong.

(require 'tex-site
         (expand-file-name "tex-site.el"
                           (file-name-directory load-file-name)))
(provide 'auctex)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; auctex.el ends here
