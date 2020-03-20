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

(use-package multiple-cursors)

;;; Kill generating backups
(setq-default backup-inhibited t)

;;; Kill bells
(setq ring-bell-function 'ignore)

;;; Set Japanese IME
(use-package mozc
  :custom (default-input-method "japanese-mozc"))

;;; Make junk file
(use-package open-junk-file
  :bind ("C-x C-z" . open-junk-file))

;;; sudo-edit
(use-package sudo-edit
  :bind ("C-c C-r" . sudo-edit))

;;; undo-tree
(use-package undo-tree
  :init (global-undo-tree-mode t)
  :bind
  ("C-x u" . undo-tree-visualize)
  ("C-/" . undo-tree-undo)
  ("C-S-/" . undo-tree-redo))
