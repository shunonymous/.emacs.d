;; ;;; Settings for programming, mainly C++

;;; If C++ mode, set indent mode as stroustrup
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "stroustrup")))

;;; magit
(require 'magit)


;; ;;; Settings for company-mode
;; (require 'company)
;; ;(add-hook 'after-init-hook 'global-company-mode)
;; (global-company-mode 1)

;; ;;; No auto popup
;; (setq company-idle-delay nil)

;; ;;; Loop selection
;; (setq company-selection-wrap-around t)

;; ;;; Colors
;; (set-face-attribute 'company-tooltip nil
;;                     :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common nil
;;                     :foreground "black" :background "lightgrey")
;; (set-face-attribute 'company-tooltip-common-selection nil
;;                     :foreground "white" :background "steelblue")
;; (set-face-attribute 'company-tooltip-selection nil
;;                     :foreground "black" :background "steelblue")
;; (set-face-attribute 'company-preview-common nil
;;                     :background nil :foreground "lightgrey" :underline t)
;; (set-face-attribute 'company-scrollbar-fg nil
;;                     :background "orange")
;; (set-face-attribute 'company-scrollbar-bg nil
;;                     :background "gray40")

;; ;;; Keybinds
;; ;;; Wrapper for tab key
;; ;;; If completion candidate is exists, launch company-completion.
;; ;;; Otherwise, indent.
;; (define-key company-mode-map (kbd "<tab>") 'company-indent-or-complete-common)

;; (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
;; (define-key company-active-map (kbd "<backtab>") 'company-select-previous)

;; ;;; Select suggestions by C-n and C-p.
;; (define-key company-active-map (kbd "C-n") 'company-select-next)
;; (define-key company-active-map (kbd "C-p") 'company-select-previous)
;; (define-key company-search-map (kbd "C-n") 'company-select-next)
;; (define-key company-search-map (kbd "C-p") 'company-select-previous)

;; ;;; Backend for C++, using irony.
;; (require 'irony)
;; (require 'flycheck)
;; (require 'company-c-headers)
;; (require 'company-cmake)
;; (add-hook 'c-mode-common-hook 'irony-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; (add-to-list 'company-backends 'company-irony)
;; (add-to-list 'company-backends 'company-c-headers)
;; (add-to-list 'company-backend 'company-cmake)
;; (add-to-list 'company-c-headers-path-system "/usr/include/c++/v1/")

;; (require 'flycheck-rtags)
;; (add-hook 'c-mode-common-hook 'flycheck-mode)

;; (defun my-flycheck-rtags-setup ()
;;   (flycheck-select-checker 'rtags)
;;   (setq-local flycheck-highlighting-mode nil)
;;   (setq-local flycheck-check-syntax-automatically nil))

;; (add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

;; (cmake-ide-setup)
;; (global-set-key (kbd "C-S-b") 'cmake-ide-compile)

;; (defun setup-servers ()
;;   "Setup or update irony and rdm."
;;   (interactive)
;;   (if (eq system-type "windows-nt")
;;       (setq cmakeflags "")
;;     (setq cmakeflags "-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++"))
;;   (rtags-install nil cmakeflags)
;;   (irony-install-server))
