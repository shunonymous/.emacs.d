;;; shunonymous's emacs init.el
;;; increase GC threshold
(setq gc-cons-threshold (* 256 1024 1024))

;;; Setup cask
(require 'cask)
(cask-initialize)

;; (use-package initchart
;;   :config
;;   (initchart-record-execution-time-of load file)
;;   (initchart-record-execution-time-of require feature))

;;; misc configurations
(use-package init-loader)
(init-loader-load)

;;; Kill generating backups
(setq-default backup-inhibited t)

;;; Make junk file
(use-package open-junk-file
  :bind ("C-x C-z" . open-junk-file))

;;; sudo-edit
(use-package sudo-edit
  :bind ("C-c C-r" . sudo-edit))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(neo-theme 'icons t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
