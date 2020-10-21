;; If C++ mode, set indent mode as stroustrup
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "stroustrup")))

;; Disallow tab
(setq indent-tabs-mode nil)

;; projectile
(use-package projectile)

;; flycheck
(use-package flycheck
  :hook (prog-mode . flycheck-mode))

;;; cmake-ide
(use-package cmake-ide
  :hook ((c-mode c++-mode cmake-mode) . cmake-ide-setup)
  :config (cmake-ide-maybe-run-cmake)
  :bind ("C-S-b" . cmake-ide-compile))

;;; lsp-mode
(use-package lsp-mode
  :hook (prog-mode . lsp)
  :init
  (setq lsp-keymap-prefix "C-M-l")
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :commands lsp)
(use-package lsp-ui
  :commands lsp-ui-mode)
(use-package lsp-ivy
  :after lsp-mode)

;;; dap-mode
(use-package dap-mode
  ;; :hook (prog-mode . dap-mode)
  :bind ("s-d" . dap-hydra)
  ;; :requires (hydra dap-hydra)
  :commands (dap-debug dap-debug-edit-template)
  :config
  (add-hook 'dap-stopped-hook (lambda (arg) (call-interactively #'dap-hydra)))
  (dap-mode t)
  (dap-ui-mode t)
  (dap-ui-controls-mode t)
  (require 'dap-lldb)
  (require 'dap-go)
  (require 'dap-chrome)
  (require 'dap-python))

;; Company Backends.
(use-package company-lsp
  :requires (company lsp)
  :commands company-lsp
  :config (add-to-list 'company-backends 'company-lsp))

;; misc
(use-package go-mode)
(use-package android-mode)
(use-package cmake-mode)
(use-package dtrt-indent
  :config (dtrt-indent-global-mode t))
