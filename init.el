;;; shunonymous's emacs init.el
;;; increase GC threshold
(setq gc-cons-threshold (* 256 1024 1024))

;;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; automatic install package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;; for diminish
(use-package diminish)

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

;;; ripgrep
(use-package rg
  :commands rg)

;;; visual-regexp
(use-package visual-regexp)
