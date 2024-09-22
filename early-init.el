;;; init.el --- shunonymous's emacs configuration

;; Copyright (C) 2024 Shun Terabayashi

;; Author: Shun Terabayashi <shunonymous@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Emacs configuration

;;; Code:

(with-eval-after-load 'comp
  (setq native-comp-async-jobs-number (/ (num-processors) 2))
  (setq native-comp-speed 3))

;;; Disable menubar
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

;;; Improve LSP performance
(setenv "LSP_USE_PLISTS" "true")

(provide 'early-init)

;;; early-init.el ends here
