;;; init-eyebrowse.el --- Workspaces  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Eyebrowse for Emacs workspaces
;;; Code:

(use-package eyebrowse
  :ensure t
  :demand t
  :after evil
  :config
  (eyebrowse-mode 1)
  (eyebrowse-setup-opinionated-keys)
  ;; keep evil's "g c" (evil-commentary) instead of eyebrowse's binding
  (define-key evil-motion-state-map (kbd "g c") nil))

(provide 'init-eyebrowse)
;;; init-eyebrowse.el ends here
