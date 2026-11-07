;;; xr-hyper.el --- AUCTeX style for `xr-hyper.sty'  -*- lexical-binding: t; -*-

;; Copyright (C) 2021--2026 Free Software Foundation, Inc.

;; Author: Arash Esbati <arash@gnu.org>
;; Maintainer: auctex-devel@gnu.org
;; Created: 2021-10-05
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

;; This file adds support for `xr-hyper.sty' v7.01t from 2026-11-03.
;; `xr-hyper.sty' is now deprecated, it simply loads the `xr' package.

;;; Code:

(require 'tex)

(TeX-add-style-hook
 "xr-hyper"
 (lambda ()
   (TeX-run-style-hooks "xr"))
 TeX-dialect)

(defvar LaTeX-xr-hyper-package-options nil
  "Package options for the xr-hyper package.")

;;; xr-hyper.el ends here
