;; If C++ mode, set indent mode as stroustrup
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "stroustrup")))

;; Disallow tab
(setq indent-tabs-mode nil)

;; flycheck
(use-package flycheck-mode
  :config (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  :hook prog-mode)

;;; cmake-ide
(use-package cmake-ide
  :hook ((c-mode c++-mode cmake-mode) . cmake-ide-setup)
  :config (cmake-ide-maybe-run-cmake)
  :bind ("C-S-b" . cmake-ide-compile))

;;; lsp-mode
(use-package lsp-mode
  :hook (prog-mode . lsp)
  :commands lsp)
(use-package lsp-ui
  :commands lsp-ui-mode)
(use-package lsp-ivy
  :after lsp-mode)

;;; dap-mode
(use-package dap-mode
  :hook prog-mode
  :config
  (dap-mode t))
(use-package dap-ui
  :after dap-mode
  :config
  (dap-ui-mode t)
  (dap-ui-controls-mode t))

;; Company Backends.
(use-package company-lsp
  :requires (company lsp)
  :commands company-lsp
  :config (add-to-list 'company-backends 'company-lsp))

;; Android
(use-package android-mode)
