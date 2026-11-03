;;; init-drdashboard.el --- Start page  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Nice introduction page to manage common Emacs usage
;;; Code:

(use-package dashboard
  :ensure t
  :demand t
  :custom
  (dashboard-banner-logo-title (shell-command-to-string "fortune -as"))
  (dashboard-footer-messages '("Who the hell uses VIM anyway? Go Evil!"))
  (dashboard-items '((recents . 9)))
  (initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  :config
  (dashboard-setup-startup-hook))

(provide 'init-drdashboard)
;;; init-drdashboard.el ends here
