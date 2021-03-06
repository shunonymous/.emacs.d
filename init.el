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

(leaf leaf
  :doc "Always enable ensure"
  :custom (leaf-defaults . '(:ensure t))
  :config (leaf leaf-tree))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :ensure nil
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf performance
  :doc "Configuration for increase performance"
  :ensure nil
  :config
  ;;; Increase GC threshold
  (setq gc-cons-threshold (* 256 1024 1024))
  ;;; Increase the amount of data which Emacs reads from the process
  (setq read-process-output-max (* 1024 1024)))

(leaf interface
  :doc "Change interface of Emacs"
  :ensure nil
  :custom ((ring-bell-function. 'ignore))
  :config
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (leaf powerline
    :config (powerline-default-theme))
  (leaf display-time-mode
    :ensure nil
    :global-minor-mode t
    :custom ((display-time-24hr-format . t)))
  (leaf global-display-line-numbers-mode
    :ensure nil
    :global-minor-mode t)
  (leaf doom-themes
    :config (load-theme 'doom-outrun-electric t)))

(leaf japanese
  :ensure nil
  :config
  (leaf mozc
    :custom ((default-input-method . "japanese-mozc")))
  (leaf fonts
    :ensure nil
    :if window-system
    :config
    (create-fontset-from-ascii-font
     "Ubuntu Mono-10.5:regular"
     nil
     "Ubuntu")
    (set-fontset-font
     "fontset-Ubuntu"
     'japanese-jisx0208
     "TakaoExGothic:regular")
    (add-to-list 'default-frame-alist '(font . "fontset-Ubuntu"))))

(leaf kill-backups
  :doc "Kill generating backups"
  :ensure nil
  :custom ((backup-inhibited . t)))

(leaf completion
  :ensure nil
  :config
  (leaf company
    :blackout t
    :global-minor-mode global-company-mode
    :custom
    ((company-idle-delay . 1.0)
     (company-selection-wrap-around . t))
    :custom-face
    ((company-tooltip . '((nil (:foreground "black" :background "lightgrey"))))
     (company-tooltip-common . '((nil (:foreground "black" :background "lightgrey"))))
     (company-tooltip-common-selection . '((nil (:foreground "white" :background "steelblue"))))
     (company-tooltip-selection . '((nil (:foreground "black" :background "steelblue"))))
     (company-preview-common . '((nil (:background nil :foreground "lightgrey" :underline t))))
     (company-scrollbar-fg . '((nil (:background "orange"))))
     (company-scrollbar-bg . '((nil (:background "gray40")))))
    :bind
    ((company-mode-map
      ("<tab>" . company-indent-or-complete-common))
     (company-active-map
      ("<tab>" . company-complete-common-or-cycle)
      ("<backtab>" . company-select-previous)
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous))
     (company-search-map
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous)))
    :config
    (leaf company-c-headers
      :hook c-mode-common-hook
      :defvar company-backends
      :config (add-to-list 'company-backends 'company-c-headers))
  (leaf hippie-expand
    :ensure nil
    :custom
    ((hippie-expand-try-functions-list . '(try-complete-file-name-partially
					   try-complete-file-name
					   try-expand-dabbrev
					   try-expand-dabbrev-all-buffers
					   try-expand-dabbrev-from-kill))))))

(leaf develop
  :ensure nil
  :config
  (leaf multi-vterm)
  (leaf projectile)
  (leaf iedit
    :bind (("C-;" . iedit-mode)))
  (leaf flycheck
    :hook prog-mode-hook)
  (leaf go-mode
    :hook (before-save-hook . gofmt-before-save)
    :config
    (leaf gotest)
    (leaf go-imports))
  (leaf json-mode)
  (leaf csharp-mode)
  (leaf android-mode)
  (leaf kotlin-mode)
  (leaf cmake-mode)
  (leaf yaml-mode)
  (leaf pkgbuild-mode)
  (leaf dtrt-indent
    :hook prog-mode-hook)
  (leaf lsp-mode
    :hook ((c-mode-common-hook . lsp)
	   (python-mode-hook . lsp)
	   (csharp-mode-hook . lsp)
	   (go-mode-hook . lsp)
	   (shell-mode-hook . lsp)
	   (java-mode-hook . lsp)
	   (cmake-mode-hook . lsp))
    :custom ((lsp-keymap-prefix . "C-M-l")
	     (lsp-idle-delay . 0.5)
	     (lsp-log-io . nil)
	     (lsp-completion-enable . t)
	     (lsp-iedit-highlights))
    :config
    (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
    (leaf lsp-ui)
    (leaf lsp-ivy)
    (leaf lsp-treemacs
      :config (lsp-treemacs-sync-mode 1))
    (leaf dap-mode
      :bind ("s-d" . dap-hydra)
      :custom ((dap-auto-configure-features . '(sessions locals controls tooltip)))
      :commands (dap-debug dap-debug-edit-template)
      :config
      (leaf dap-lldb
        :ensure nil
        :hook c-mode-common-hook)
      (leaf dap-go
        :ensure nil
        :hook go-mode-hook)
      (leaf dap-python
        :ensure nil
        :hook python-mode-hook)
      (leaf dap-java
        :ensure nil
        :hook java-mode-hook))))

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
	   ("C-x C-r" . counsel-recentf)
	   ("M-x" . counsel-M-x)
	   ("M-y" .  counsel-yank-pop)))
  (leaf ivy-rich
    :global-minor-mode t
    :init (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
    :config
    (leaf all-the-icons-ivy-rich
      :global-minor-mode t
      :custom ((all-the-icons-ivy-rich-icon-size . 0.8)))))

(leaf ace-window
  :bind ("s-f" . hydra-ace-window/body)
  :init (windmove-default-keybindings)
  :hydra ((hydra-ace-window
           (:hint nil)
           "
Window:
<left> windmove-left       x delete-window          0 text-scale-adjust          
<right> windmove-right     i ace-window             v split-window-vertically    
<up> windmove-up           s ace-swap-window        h split-window-horizontally  
<down> windmove-down       + text-scale-increase    o delete-other-window        
<RET> other-frame          - text-scale-decrease    m make-frame		        
			   			    k delete-frame	      
"
           ("<left>" windmove-left)
           ("<right>" windmove-right)
           ("<up>" windmove-up)
           ("<down>" windmove-down)
           ("<RET>" other-frame)
           ("x" delete-window)
	   ("i" ace-window)
	   ("s" ace-swap-window)
	   ("+" text-scale-increase)
	   ("-" text-scale-decrease)
	   ("0" text-scale-adjust)
	   ("v" split-window-vertically)
	   ("h" split-window-horizontally)
	   ("o" delete-other-windows)
	   ("m" make-frame)
	   ("k" delete-frame))))

(leaf presentation
  :commands presentation-mode)

(leaf git
  :ensure nil
  :config
  (leaf magit
    :bind ("C-x g" . magit-status)
    :commands (magit-init)
    :custom ((magit-diff-refine-hunk . 'all)))
  (leaf git-gutter
    :blackout t
    :global-minor-mode t))

(leaf dashboard
  :custom
  ((dashboard-items '((recents . 5)
		      (bookmark . 5)
		      (projects . 8)
		      (agenda . 5)
		      (registers . 5))))
  :config (dashboard-setup-startup-hook))

(leaf undo-tree
  :blackout t
  :init (global-undo-tree-mode t) ; global-minor-mode not worked
  :bind
  ("C-x u" . undo-tree-visualize)
  ("C-/" . undo-tree-undo)
  ("C-S-/" . undo-tree-redo))

(leaf volatile-highlights
  :blackout t
  :global-minor-mode t
  :config (vhl/install-extension 'undo-tree)
  :custom-face
  (vhl/default-face . '((nil (:background "cyan")))))

(leaf org
  :ensure nil
  :custom ((org-agenda-files . '("~/Documents/Todo.org"))
           (org-log-done . 'time))
  :bind (("C-c a" . org-agenda)))

(leaf highlight-indent-guides
  :hook prog-mode-hook
  :custom
  ((highlight-indent-guides-method . 'character)
   (highlight-indent-guides-auto-character-face-perc . 20)
   (highlight-indent-guides-auto-stack-character-face-perc . 30)
   (highlight-indent-guides-auto-top-character-face-perc . 40)
   (highlight-indent-guides-responsive . 'stack)
   (highlight-indent-guides-delay . 0.5)))

(leaf elec-pair
  :hook (prog-mode-hook . electric-pair-mode))

(leaf show-paren
  :global-minor-mode t
  :ensure nil
  :custom ((show-paren-style . 'mixed)
	   (show-paren-delay . 0.5))
  :custom-face
  ((show-paren-match . '((nil (:background "cyan" :foreground "HotPink"))))))

(leaf rainbow-delimiters
  :hook prog-mode-hook)

(leaf edit-server
  :config (edit-server-start))

(leaf neotree
  :bind ("<f8>" . neotree-toggle)
  :custom ((neotree-theme . 'icons)))

(leaf which-key
  :blackout t
  :hook after-init-hook
  :config
  (leaf which-key-posframe
    :global-minor-mode t))

(leaf amx)

(leaf sudo-edit
  :bind ("C-c C-r" . sudo-edit))

(leaf rg
  :commands rg)

;;; visual-regexp
(leaf visual-regexp)

(leaf open-junk-file
  :bind ("C-x C-z" . open-junk-file))

(provide 'init)

;;; init.el ends here
