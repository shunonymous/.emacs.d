;;; undo-tree
(use-package undo-tree
  :diminish undo-tree-mode
  :init (global-undo-tree-mode t)
  :bind
  ("C-x u" . undo-tree-visualize)
  ("C-/" . undo-tree-undo)
  ("C-S-/" . undo-tree-redo))

;;; Store recently opened files
(recentf-mode 1)

;;; Set Japanese IME
(use-package mozc
  :custom (default-input-method "japanese-mozc"))

(use-package multiple-cursors)

;; magit
(use-package magit
  :bind ("C-x g" . magit-status)
  :commands (magit-init)
  :custom (magit-diff-refine-hunk 'all))

;;; git-gutter
(use-package git-gutter
  :diminish git-gutter-mode
  :config (global-git-gutter-mode t))
