;;; init-theme.el --- Color theme  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Zenburn as the main theme.
;;; Code:

(use-package zenburn-theme
  :ensure t
  :demand t
  :config
  (load-theme 'zenburn t))

(provide 'init-theme)
;;; init-theme.el ends here
