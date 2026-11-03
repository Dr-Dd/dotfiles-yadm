;;; init-evil-mode.el --- Vim emulation  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Evil mode for vim-like command emulation
;;; Code:

(use-package evil
  :ensure t
  :demand t
  :custom
  (evil-undo-system 'undo-tree)
  (evil-ex-search-case 'insensitive)
  :config
  (dolist (mode '(benchmark-init/tree-mode
                  dashboard-mode
                  elfeed-search-mode elfeed-show-mode
                  flycheck-error-list-mode
                  haskell-interactive-mode
                  help-mode
                  inferior-emacs-lisp-mode
                  inferior-python-mode
                  shell-mode
                  special-mode
                  timer-list-mode
                  tuareg-interactive-mode
                  xref--xref-buffer-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  (evil-set-initial-state 'org-agenda-mode 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'magit-mode 'emacs)
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :after evil
  :diminish
  :config
  (evil-commentary-mode 1))

;; org mode fix
(use-package evil-org
  :ensure t
  :after (evil org)
  :hook ((org-mode . evil-org-mode)
         (evil-org-mode . evil-org-set-key-theme))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(provide 'init-evil-mode)
;;; init-evil-mode.el ends here
