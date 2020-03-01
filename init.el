;;; shunonymous's emacs init.el
;;; increase GC threshold
(setq gc-cons-threshold (* 256 1024 1024))

;;; Setup cask
(require 'cask)
(cask-initialize)

(use-package initchart
  :config
  (initchart-record-execution-time-of load file)
  (initchart-record-execution-time-of require feature))

;;; misc configurations
(use-package init-loader)
(init-loader-load)

;;; Kill generating backups
(setq-default backup-inhibited t)

;;; Kill bells
(setq ring-bell-function 'ignore)

;;; Set Japanese IME
(use-package mozc
  :init (setq default-input-method "japanese-mozc"))

;;; Make junk file
(use-package open-junk-file
  :bind ("C-x C-z" . open-junk-file))

;;; sudo-edit
(use-package ivy
  :config (ivy-mode t))

;;; ivy
(use-package sudo-edit
  :bind ("C-c C-r" . sudo-edit))

(use-package ivy-rich
  :config (ivy-rich-mode t))

;;; undo-tree
(use-package undo-tree
  :init (global-undo-tree-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zzz-to-char org-plus-contrib yasnippet volatile-highlights use-package undo-tree sudo-edit smartparens rtags rg projectile powerline open-junk-file magit lispxmp ivy-rich irony-eldoc initchart init-loader highlight-indent-guides flycheck-cask esup diminish dashboard counsel company-irony company-c-headers cmake-ide cherry-blossom-theme cask auto-async-byte-compile android-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
