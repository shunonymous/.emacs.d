;;; shunonymous's emacs init.el

;;; Enable MELPA repository
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://www.mirrorservice.org/sites/melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'init-loader)
(init-loader-load)

;;; misc configurations
;;; Kill generating backups
(setq-default backup-inhibited t)

;;; Kill bells
(setq ring-bell-function 'ignore)

;;; Set Japanese IME
(require 'mozc)
(setq default-input-method "japanese-mozc")

;;; Make junk file
(require 'open-junk-file)
(global-set-key (kbd "C-x C-z") 'open-junk-file)

;;; sudo-edit
(require 'sudo-edit)
(global-set-key (kbd "C-c C-r") 'sudo-edit)

;;; helm
;;; Fix helm's f*ckin default behavior
(require 'helm)
(setq helm-use-frame-when-more-than-two-windows nil)

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

;;; Enable helm-projectile
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (highlight-indent-guides indent-guide diminish csharp-mode foreign-regexp company-go go-mode android-mode realgud dashboard flyspell-popup ivy helm-projectile helm powerline auto-async-byte-compile lispxmp open-junk-file flycheck-lilypond nhexl-mode markdown-mode markdown-mode+ markdown-preview-mode midi-kbd flycheck-irony irony-eldoc company-shell company company-c-headers company-emoji company-irony company-irony-c-headers flycheck-popup-tip flycheck flycheck-clang-analyzer cpputils-cmake cmake-font-lock cmake-ide cmake-mode cmake-project sudo-edit cherry-blossom-theme magit mozc mozc-im mozc-popup mozc-temp pkgbuild-mode projectile rainbow-delimiters undo-tree volatile-highlights init-loader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
