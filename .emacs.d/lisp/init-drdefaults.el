;;; init-drdefaults.el --- Built-in Emacs settings  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Init file for things already present in Emacs
;;; Code:

;; Customize writes here (untracked); real settings live in the
;; `:custom' blocks of the init files.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(use-package emacs
  :hook ((before-save . delete-trailing-whitespace)
         (text-mode . flyspell-mode))
  :custom
  ;; Startup
  (inhibit-startup-screen t)
  (inhibit-startup-buffer-menu t)
  (initial-scratch-message nil)
  (load-prefer-newer t)
  ;; Backups and auto-saves
  (backup-by-copying t)
  (backup-directory-alist '((".*" . "~/.saves/")))
  (auto-save-file-name-transforms '((".*" "~/.saves/" t)))
  (version-control t)
  (delete-old-versions t)
  (kept-new-versions 6)
  (require-final-newline t)
  ;; UI
  (menu-bar-mode nil)
  (tool-bar-mode nil)
  (scroll-bar-mode nil)
  (blink-cursor-mode t)
  (column-number-mode t)
  (global-display-line-numbers-mode t)
  (display-line-numbers-type 'relative)
  (global-hl-line-mode t)
  (show-paren-mode t)
  (indicate-empty-lines t)
  (use-system-tooltips nil)
  (frame-resize-pixelwise t)
  (window-resize-pixelwise t)
  (split-height-threshold 33)
  (split-width-threshold 62)
  ;; Editing
  (electric-indent-mode t)
  (electric-pair-mode t)
  (global-auto-revert-mode t)
  (vc-follow-symlinks t)
  (xref-prompt-for-identifier
   '(not xref-find-definitions xref-find-definitions-other-window
         xref-find-definitions-other-frame xref-find-references))
  ;; History and state
  (savehist-mode t)
  (save-place-mode t)
  (history-delete-duplicates t)
  (midnight-mode t)
  (recentf-exclude
   '("/.emacs.d/.cache/treemacs-persist-at-last-error"
     "/.emacs.d/.cache/treemacs-persist" "/usr/share/emacs" "/.elfeed"
     "/Sync/org-files/"))
  ;; Misc
  (ispell-program-name "/usr/bin/hunspell")
  (calendar-latitude 41.890209)
  (calendar-longitude 12.492231)
  (tramp-use-connection-share nil)
  (tramp-use-ssh-controlmaster-options nil))

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook #'delete-other-windows)

(global-set-key (kbd "<mouse-6>") #'scroll-right)
(global-set-key (kbd "<mouse-7>") #'scroll-left)

;; recentf already saves on `kill-emacs-hook'; the timer also covers
;; daemon sessions that are never cleanly shut down.
(recentf-mode 1)
(run-at-time nil (* 5 60) #'recentf-save-list)

(provide 'init-drdefaults)
;;; init-drdefaults.el ends here
