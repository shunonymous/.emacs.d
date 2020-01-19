;;; Settings fo Emacs lisp
(use-package lispxmp
  :bind ("C-c C-d" . lispxmp)
  :hook emacs-lisp-mode)

(use-package auto-async-byte-compile
  :hook emacs-lisp-mode
  :config
  (setq auto-async-byte-compile-exclude-files-regexp "/junk/\\|/.emacs.d/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  (setq eldoc-idle-delay 0.2))
