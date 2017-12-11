;;; Settings for company-mode
;(require 'company)
;(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode 1)

;;; No auto popup
(setq company-idle-delay nil)

;;; Loop selection
(setq company-selection-wrap-around t)

;;; Colors
(set-face-attribute 'company-tooltip nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")

;;; Keybinds
;;; Wrapper for tab key
;;; If completion candidate is exists, launch company-completion.
;;; Otherwise, indent.
(define-key company-mode-map (kbd "<tab>") 'company-indent-or-complete-common)

(define-key company-active-map "<tab>" 'company-select-next-if-tooltip-visible-or-complete-selection)
(define-key company-active-map "<backtab>" 'company-select-previous)

;;; Backend for C++, using irony.
(require 'irony)
(require 'flycheck)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony)

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)

(cmake-ide-setup)

;;;; Settings for auto-complete-mode
;(require 'auto-complete)
;(require 'auto-complete-config)
;(global-auto-complete-mode t)
;(setq ac-trigger-key "TAB")
;(setq ac-auto-start nil)
;
;;;; auto-complete-mode for English terms
;(defun my-ac-look ()
;  "Return output from look command as list"
;  (interactive)
;  (unless (executable-find "look")
;    (error "Look command was not found."))
;  (let ((search-word (thing-at-point 'word)))
;    (with-temp-buffer
;      (call-process-shell-command "look" nil t 0 search-word)
;      (split-string-and-unquote (buffer-string) "\n"))))
;
;(defun ac-complete-look ()
;  (interactive)
;  (let ((ac-menu-height 50)
;        (ac-candidate-limit t))
;    (auto-complete '(ac-source-look))))
;
;(defvar ac-source-look
;  '((candidates . my-ac-look)
;    (requires . 2)))
;
;(global-set-key (kbd "C-<tab>") 'ac-complete-look)

