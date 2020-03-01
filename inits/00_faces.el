;;; Theme
(use-package cherry-blossom-theme
  :init (load-theme 'cherry-blossom t)
  ;;; Override inactive line string color to improve visibility
  :config (set-face-attribute 'mode-line-inactive nil
			      :foreground "gray35"))

;;; ivy
(use-package ivy
  :ensure t
  :init (ivy-mode t))
(use-package counsel
  :ensure t)
(use-package ivy-posframe
  :ensure t
  :init
  (setq ivy-posframe-display-functions-alist
	'((t . ivy-posframe-display-at-point)))
  (setq ivy-posframe-parameters
	'((left-fringe . 8)
	  (right-fringe . 8)))
  (ivy-posframe-mode t)
  :config
  (set-face-attribute 'ivy-posframe nil :background "gray5"))
(use-package all-the-icons-ivy-rich
  :ensure t
  :init
  (all-the-icons-ivy-rich-mode t)
  (setq all-the-icons-ivy-rich-icon-size 0.8))
(use-package ivy-rich
  :ensure t
  :after (all-the-icons-ivy-rich)
  :init
  (ivy-rich-mode t)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))
(use-package counsel
  :ensure t
  :bind
  ("C-x C-f" . counsel-find-file)
  ("M-x" . counsel-M-x))
(use-package swiper
  :ensure t
  :bind
  ("C-s" . swiper-isearch)
  ("C-r" . swiper-backword))

(use-package hydra)
(use-package ivy-hydra
  :after (ivy hydra))

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
(use-package volatile-highlights
  :config
  (volatile-highlights-mode t)
  (global-hl-line-mode t))

;;; powerline
(use-package powerline
  :config (powerline-default-theme))

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
(use-package diminish
  :config
  (eval-after-load "init" '(diminish 'undo-tree-mode))
  (eval-after-load "init" '(diminish 'helm-mode))
  (eval-after-load "init" '(diminish 'abbrev-mode))
  (eval-after-load "init" '(diminish 'auto-revert-mode))
  (eval-after-load "50_develop" '(diminish 'irony-mode))
  (eval-after-load "50_develop" '(diminish 'eldoc-mode))
  (eval-after-load "50_develop" '(diminish 'company-mode))
  (eval-after-load "50_develop" '(diminish 'volatile-highlights-mode))
  )
