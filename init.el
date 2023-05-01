;;; init.el --- shunonymous's emacs configuration

;; Copyright (C) 2021-2023 Shun Terabayashi

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
  :custom ((ring-bell-function . 'ignore))
  :config
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (leaf powerline
    :config (powerline-default-theme))
  (leaf display-time-mode
    :ensure nil
    :global-minor-mode t
    :custom ((display-time-format . "%I:%M:%S")
	     (display-time-interval . 1)))
  (leaf global-display-line-numbers-mode
    :ensure nil
    :global-minor-mode t)
  (leaf modus-themes
    ;; :config (load-theme 'dracula t)
    :custom
    ((modus-themes-italic-constructs . t)
     (modus-themes-bold-constructs . t)
     (modus-themes-mixed-fonts . nil)
     (modus-themes-tabs-accented . t)
     (modus-themes-region . '(bg-only no-extend)))
    :config
    (modus-themes-select 'modus-vivendi)
    ))

(leaf mozc
  :custom ((default-input-method . "japanese-mozc"))
  :config
  (leaf mozc-temp
    :bind (("M-\\" . mozc-temp-convert))))

(leaf fonts
  :ensure nil
  :if window-system
  :config
  (create-fontset-from-ascii-font
   "Ubuntu Mono-12.0:weight=normal:slant=normal"
   nil
   "Ubuntu")
  (set-fontset-font
   "fontset-Ubuntu"
   'japanese-jisx0208
   "TakaoExGothic:regular")
  (set-fontset-font
   "fontset-Ubuntu"
   '(#x1F000 . #x1FAFF)
   "Noto Color Emoji")
  (add-to-list 'default-frame-alist '(font . "fontset-Ubuntu")))

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
    :defvar company-backends
    :config
    (leaf company-c-headers
      :defvar company-c-headers-path-system
      :config
      (add-to-list 'company-backends 'company-c-headers)
      :defer-config
      (add-to-list 'company-c-headers-path-system "/usr/include/c++/v1"))
    (leaf company-box
      :hook (company-mode . company-box))
    (leaf company-quickhelp
      :config (company-quickhelp-mode))
    (leaf hippie-expand
      :ensure nil
      :custom
      ((hippie-expand-try-functions-list . '(try-complete-file-name-partially
					     try-complete-file-name
					     try-expand-dabbrev
					     try-expand-dabbrev-all-buffers
					     try-expand-dabbrev-from-kill))))))

(leaf yasnippet
  :global-minor-mode yas-global-mode
  :blackout yas-minor-mode
  :bind
  ((:yas-minor-mode-map
    ("<tab>" . nil)
    ("TAB" . nil)))
  :custom
  ((yas-snippet-dirs . '("~/.emacs.d/snippets" "~/Documents/snippets")))
  :config
  (leaf yasnippet-snippets)
  (leaf yatemplate
    :defun yatemplate-fill-alist
    :config
    (leaf autoinsert
      :config (auto-insert-mode 1))
    (yatemplate-fill-alist))
  (leaf auto-yasnippet))

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
  (leaf rust-mode)
  (leaf cargo)
  (leaf cargo-mode)
  (leaf android-mode)
  (leaf android-env)
  (leaf gradle-mode)
  (leaf kotlin-mode)
  (leaf cmake-mode)
  (leaf yaml-mode)
  (leaf pkgbuild-mode)
  (leaf c-mode-common
    :ensure nil
    :custom ((c-default-style . "bsd")
	     (c-tab-width . 4)))
  (leaf dtrt-indent
    :hook prog-mode-hook)
  (leaf lsp-mode
    :hook (((
	     c-mode-common-hook
	     rust-mode-hook
	     python-mode-hook
	     csharp-mode-hook
	     go-mode-hook
	     shell-mode-hook
	     java-mode-hook
	     cmake-mode-hook) . lsp)
	   (lsp-mode-hook . lsp-enable-which-key-integration)
	   ;; (before-save-hook . lsp-format-buffer)
	   (lsp-rust-rustfmt-path . "/usr/bin/rustfmt"))
  :custom ((lsp-keymap-prefix . "C-M-l")
	   (lsp-idle-delay . 0.5)
	   (lsp-log-io . nil)
	   (lsp-completion-enable . t)
	   (lsp-prefer-capf . t)
	   (lsp-iedit-highlights))
  :defun lsp lsp-format-buffer
  :config
  (leaf lsp-ui)
  (leaf lsp-ivy)
  (leaf lsp-treemacs
    :config (lsp-treemacs-sync-mode 1))
  (leaf dap-mode
    :bind ("C-S-d" . dap-hydra)
    :custom ((dap-auto-configure-features . '(sessions locals controls tooltip)))
    :commands (dap-debug dap-debug-edit-template)
    :config
    (leaf dap-lldb
      :ensure nil)
    (leaf dap-go
      :ensure nil)
    (leaf dap-python
      :ensure nil)
    (leaf dap-java
      :ensure nil)
    (leaf dap-cpptools
      :ensure nil))))

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
    :defvar ivy-format-functions-alist
    :defun ivy-format-function-line
    :init (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
    :config
    (leaf all-the-icons-ivy-rich
      :global-minor-mode t
      :custom ((all-the-icons-ivy-rich-icon-size . 0.8))))
  (leaf ivy-yasnippet
    :bind (("C-c y" . ivy-yasnippet))))

(leaf ace-window
  :bind (("C-S-f" . hydra-ace-window/body)
         ("C-S-<RET>" . other-frame))
  :init (windmove-default-keybindings '(shift control))
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
	   ("k" delete-frame)
           ("q" nil "quit" :color blue))))

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
    :global-minor-mode global-git-gutter-mode))

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
  ("C-S-/" . undo-tree-redo)
  :custom (undo-tree-auto-save-history . nil))

(leaf volatile-highlights
  :blackout t
  :global-minor-mode t
  :custom (vhl/install-extension . 'undo-tree)
  :custom-face
  (vhl/default-face . '((nil (:background "cyan")))))

(leaf org
  :ensure nil
  :custom ((org-agenda-files . '("~/Documents/Todo.org"))
           (org-log-done . 'time))
  :bind (("C-c a" . org-agenda)))

(leaf highlight-indent-guides
  :hook (prog-mode-hook . highlight-indent-guides-mode)
  ;; :global-minor-mode t
  :config
  (set-face-foreground 'highlight-indent-guides-character-face "HotPink")
  :custom
  ((highlight-indent-guides-auto-enabled . t)
   (highlight-indent-guides-responsible . t)
   (highlight-indent-guides-method . 'character)
   (highlight-indent-guides-auto-character-face-perc . 20)
   (highlight-indent-guides-auto-stack-character-face-perc . 30)
   (highlight-indent-guides-auto-top-character-face-perc . 40)
   (highlight-indent-guides-responsive . 'stack)
   (highlight-indent-guides-delay . 0.5))
  ;; :custom-face
  ;; (highlight-indent-guides-character-face . '((nil (:foreground "HotPink"))))
  )

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
