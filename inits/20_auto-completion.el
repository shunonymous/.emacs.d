;;; Settings for company-mode
(require 'company)
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
(global-set-key (kbd "<tab>") 'company-complete)
(define-key company-active-map (kbd "<tab>") 'company-select-next)

(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
    (setq candidate (substring-no-properties candidate))
    (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
        (insert (company-strip-prefix candidate))
      (if (equal company-prefix candidate)
          (company-select-next)
          (delete-region (- (point) (length company-prefix)) (point))
        (insert candidate))
      )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
    (if (and (not (cdr company-candidates))
             (equal company-common (car company-candidates)))
        (company-complete-selection)
      (company--insert-candidate2 company-common))))

(define-key company-active-map [tab] 'company-complete-common2)
(define-key company-active-map [backtab] 'company-select-previous)

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

