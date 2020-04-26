;;; ivy
(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))
(use-package counsel
  :bind (("C-x C-f" . counsel-find-file)
	 ("M-x" . counsel-M-x)))
(use-package swiper
  :bind (("C-s" . swiper-isearch)
	 ("C-r" . swiper-backword)))
(use-package ivy-posframe
  :diminish ivy-posframe-mode
  :after (ivy)
  :init
  (setq ivy-posframe-display-functions-alist
	'((t . ivy-posframe-display-at-point)))
  (setq ivy-posframe-parameters
	'((left-fringe . 8)
	  (right-fringe . 8)))
  :config
  (ivy-posframe-mode t)
  (set-face-attribute 'ivy-posframe nil :background "gray5"))
(use-package all-the-icons-ivy-rich
  :after (ivy ivy-posframe)
  :init
  (all-the-icons-ivy-rich-mode t)
  (setq all-the-icons-ivy-rich-icon-size 0.8))
(use-package ivy-rich
  :after (all-the-icons-ivy-rich)
  :init
  (ivy-rich-mode t)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package hydra)
(use-package ivy-hydra
  :after (ivy hydra))

;;; Disable menu-bar and tool-bar (when GUI)
(tool-bar-mode 0)
(menu-bar-mode 0)

;;; powerline
(use-package powerline
  :config (powerline-default-theme))

;;; Display time
(setq display-time-24hr-format t)
(display-time-mode t)

;;; Display line numbers
(global-display-line-numbers-mode t)

;; dashboard
(use-package dashboard
  :init
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 8)
			  (agenda . 5)
			  (registers . 5))))

;;; neotree
(use-package neotree
  :bind ("<f8>" . neotree-toggle)
  :custom (neo-theme 'icons))

;;; which-key
(use-package which-key
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

;;; amx
(use-package amx)

;;; Kill bells
(setq ring-bell-function 'ignore)
