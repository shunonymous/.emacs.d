;;; electric pair mode
(use-package elec-pair
  :config (electric-pair-mode t))

;;; Enable rainbow-delimiters-mode
(use-package rainbow-delimiters-mode
  :hook prog-mode)

;;; Highlight pare delimiters on cursor
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match nil
		    :background "white" :foreground "gray")
