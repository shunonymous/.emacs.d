;; Settings for programming, mainly C++

;; dashboard
(use-package dashboard
  :init
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 8)
			  (agenda . 5)
			  (registers . 5))))

;; If C++ mode, set indent mode as stroustrup
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "stroustrup")))

;; magit
(use-package magit
  :bind ("C-x g" . magit-status)
  :commands (magit-init))


;; Settings for company-mode
(use-package company
  :config
  (global-company-mode 1)
  ;;; No auto popup
  (setq company-idle-delay nil)

  ;;; Loop selection
  (setq company-selection-wrap-around t)

  ;;; Colors
  (set-face-attribute 'company-tooltip nil
		      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil
		      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil
		      :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil
		      :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil
		      :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil
		      :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil
		      :background "gray40")

  ;;; Keybinds
  ;;;; Wrapper for tab key
  ;;;; If completion candidate is exists, launch company-completion.
  ;;;; Otherwise, indent.
  (define-key company-mode-map (kbd "<tab>") 'company-indent-or-complete-common)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)

  ;;;; Select suggestions by C-n and C-p.
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous))


;;; Company Backends.
(use-package irony
  :hook c-mode-common
  :config
  (add-to-list 'company-backends 'company-irony)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
(use-package company-c-headers
  :hook c-mode-common
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/v1/"))
(use-package company-cmake
  :config (add-to-list 'company-backend 'company-cmake))

(use-package irony-eldoc
  :hook c-mode-common)

;; flycheck
(use-package flycheck
  :config (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  :hook prog-mode)

;; cmake-ide
(use-package cmake-ide
  :config (cmake-ide-setup)
  :hook prog-mode
  :bind ("C-S-b" . cmake-ide-compile))

(use-package rtags
  :bind ("<f12>" . rtags-find-symbol)
  :hook c-mode-common)

;;; realgud
(use-package realgud
  :hook prog-mode)
(use-package realgud-lldb
  :hook c-mode-common)

;; Indent guide
(use-package highlight-indent-guides
  :hook prog-mode
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-auto-character-face-perc 20)
  (setq highlight-indent-guides-auto-stack-character-face-perc 30)
  (setq highlight-indent-guides-auto-top-character-face-perc 40)
  (setq highlight-indent-guides-responsive 'stack)
  (setq highlight-indent-guides-delay 0))

;; Android
(use-package android-mode)

;; (defun setup-servers ()
;;  "Setup or update irony and rdm."
;;   (interactive)
;;   (if (eq system-type "windows-nt")
;;       (setq cmakeflags "")
;;     (setq cmakeflags "-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++"))
;;   (rtags-install nil cmakeflags)
;;   (irony-install-server))
