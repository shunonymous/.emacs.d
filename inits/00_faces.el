;;; Theme
(load-theme 'cherry-blossom t)
;;; Override inactive line string color to improve visibility
(set-face-attribute 'mode-line-inactive nil
		    :foreground "gray35")

;;; Disable menu-bar and tool-bar (when GUI)
(tool-bar-mode 0)
(menu-bar-mode 0)

;;; Font set
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-10.5"))
(cond ((string-match "^23\." emacs-version)
       (cond (window-system
	      (set-frame-font "Ubuntu Mono-10.5")
	      (set-fontset-font
	       (frame-parameter nil 'font)
	       'japanese-jisx0208
	       '("TakaoExGothic-5" . "unicode-bmp"))
	      (set-fontset-font
	       (frame-parameter nil 'font)
	       'japanese-jisx0212
	       '("TakaoExGothic-10" . "unicode-bmp"))
	      (set-fontset-font
	       (frame-parameter nil 'font)
	       'mule-unicode-0100-24ff
	       '("TakaoExGothic-10" . "unicode-bmp"))
	      ))))

;;; highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

(global-hl-line-mode t)

;;; powerline
(require 'powerline)
(powerline-default-theme)

;;; Display time
(setq display-time-24hr-format t)
(display-time-mode t)

;;; Display line numbers
(global-display-line-numbers-mode t)

;;; Store recently opened files
(recentf-mode 1)

;;; hippie-expand
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

;;; Regexp grouping color
(set-face-background 'font-lock-regexp-grouping-backslash "green3")
(set-face-background 'font-lock-regexp-grouping-construct "green")

;;; modeline
(require 'diminish)
(eval-after-load "init" '(diminish 'undo-tree-mode))
(eval-after-load "init" '(diminish 'helm-mode))
(eval-after-load "init" '(diminish 'abbrev-mode))
(eval-after-load "init" '(diminish 'auto-revert-mode))
(eval-after-load "50_develop" '(diminish 'irony-mode))
(eval-after-load "50_develop" '(diminish 'eldoc-mode))
(eval-after-load "50_develop" '(diminish 'company-mode))
(eval-after-load "50_develop" '(diminish 'volatile-highlights-mode))

