;;; init.el --- shunonymous's emacs configuration

;; Copyright (C) 2021 Shun Terabayashi

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

;;; Increase GC threshold
(setq gc-cons-threshold (* 256 1024 1024))
;;; Increase the amount of data which Emacs reads from the process
(setq read-process-output-max (* 1024 1024))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;;; Always enable ensure
(custom-set-variables '(leaf-defaults '(:ensure t)))

(leaf leaf-tree)

;;; Kill generating backups
(setq-default backup-inhibited t)

;;; sudo-edit
(leaf sudo-edit
      :bind ("C-c C-r" . sudo-edit))

;;; ripgrep
(leaf rg
  :commands rg)

;;; visual-regexp
(leaf visual-regexp)


(provide 'init)

;;; init.el ends here
