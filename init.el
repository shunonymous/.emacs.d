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

(leaf performance
  :doc "Configuration for increase performance"
  :ensure nil
  :config
  ;;; Increase GC threshold
  (setq gc-cons-threshold (* 256 1024 1024))
  ;;; Increase the amount of data which Emacs reads from the process
  (setq read-process-output-max (* 1024 1024))
  )

(leaf backups
  :doc "Kill generating backups"
  :ensure nil
  :custom (backup-inhibited . t))

(leaf leaf
  :doc "Always enable ensure"
  :custom (leaf-defaults . '(:ensure t))
  :config (leaf leaf-tree))

(leaf ivy
  :blackout t
  :leaf-defer nil
  :custom ((ivy-use-virtual-buffers . t)
	   (enable-recursive-minibuffers . t))
  :global-minor-mode t
  :config
  (leaf swiper
    :bind (("C-s" . swiper-isearch)))
  (leaf counsel
    :global-minor-mode t
    :bind (("C-x C-f" . counsel-find-file)
	   ("C-x C-r" . counse-recentf)
	   ("M-x" . counsel-M-x)
	   ("M-y" .  counsel-yank-pop)))
  (leaf ivy-rich
    :global-minor-mode t
    :init (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
    :config
    (leaf all-the-icons-ivy-rich
      :global-minor-mode t
      :custom ((all-the-icons-ivy-rich-icon-size . 0.8)))))

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
