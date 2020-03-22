;;; Theme
(use-package cherry-blossom-theme
  :init (load-theme 'cherry-blossom t)
  ;;; Override inactive line string color to improve visibility
  :config (set-face-attribute 'mode-line-inactive nil
			      :foreground "gray35"))


;;; Font set
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-10.5"))
(set-fontset-font t 'japanese-jisx0208 "TakaoPGothic")

;;; highlights
(use-package volatile-highlights
  :config
  (volatile-highlights-mode t)
  (global-hl-line-mode t))
