;;; init-drdashboard.el --- Start page  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Nice introduction page to manage common Emacs usage
;;; Code:

(use-package dashboard
  :ensure t
  :demand t
  :config
  (dashboard-setup-startup-hook))

(provide 'init-drdashboard)
;;; init-drdashboard.el ends here
