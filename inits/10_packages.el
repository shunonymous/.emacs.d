;;; Theme
(load-theme 'cherry-blossom t)

;;; Set Japanese IME
(require 'mozc)
(setq default-input-method "japanese-mozc")

;;; Enable rainbow-delimiters-mode
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;; sudo-edit
(require 'sudo-edit)
(global-set-key (kbd "C-c C-r") 'sudo-edit)

;;; helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

;;; Enable helm-projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;; magit
(require 'magit)

