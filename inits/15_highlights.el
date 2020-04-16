;;; Regexp grouping color
(set-face-background 'font-lock-regexp-grouping-backslash "green3")
(set-face-background 'font-lock-regexp-grouping-construct "green")

;; Indent guide
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-auto-character-face-perc 20)
  (setq highlight-indent-guides-auto-stack-character-face-perc 30)
  (setq highlight-indent-guides-auto-top-character-face-perc 40)
  (setq highlight-indent-guides-responsive 'stack)
  (setq highlight-indent-guides-delay 0))

;;; electric pair mode
(use-package elec-pair
  :config (electric-pair-mode t))

;;; Enable rainbow-delimiters-mode
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;; Highlight pare delimiters on cursor
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match nil
		    :background "white" :foreground "gray")
