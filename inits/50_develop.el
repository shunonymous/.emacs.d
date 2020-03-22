;; If C++ mode, set indent mode as stroustrup
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "stroustrup")))

;; flycheck
(use-package flycheck-mode
  :config (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
  :hook prog-mode)

;;; cmake-ide
(use-package rtags
  :hook ((c-mode c++-mode) . rtags-start-process-unless-running)
  :bind ("<f12>" . rtags-find-symbol))
(use-package cmake-ide
  :hook ((c-mode c++-mode) . cmake-ide-setup)
  :config (cmake-ide-maybe-run-cmake)
  :bind ("C-S-b" . cmake-ide-compile))


;; Android
(use-package android-mode)
