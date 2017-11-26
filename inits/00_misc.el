;;; Moving buffer by C-<Arrow-key>
(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)

;;; Highlight pare delimiters on cursor
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;;; If C++ mode, set indent mode as stroustrup
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "stroustrup")))

;;; Font set
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-10.5"))
(cond ((string-match "^23\." emacs-version)
       (cond (window-system
	      (set-default-font "Ubuntu Mono-10.5")
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

;;; Disable menu-bar and tool-bar (when GUI)
(tool-bar-mode 0)
(menu-bar-mode 0)

;;; Store recently opened files
(recentf-mode 1)

