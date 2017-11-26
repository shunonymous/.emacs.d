;;; Settings for auto-complete-mode
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-trigger-key "TAB")
(setq ac-auto-start nil)

;;; auto-complete-mode for English terms
(defun my-ac-look ()
  "Return output from look command as list"
  (interactive)
  (unless (executable-find "look")
    (error "Look command was not found."))
  (let ((search-word (thing-at-point 'word)))
    (with-temp-buffer
      (call-process-shell-command "look" nil t 0 search-word)
      (split-string-and-unquote (buffer-string) "\n"))))

(defun ac-complete-look ()
  (interactive)
  (let ((ac-menu-height 50)
        (ac-candidate-limit t))
    (auto-complete '(ac-source-look))))

(defvar ac-source-look
  '((candidates . my-ac-look)
    (requires . 2)))

(global-set-key (kbd "C-<tab>") 'ac-complete-look)

