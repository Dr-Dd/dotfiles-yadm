;;; init-drdefaults.el --- Built-in Emacs settings  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Init file for things already present in Emacs
;;; Code:

;; Move custom-set variables to separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

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
