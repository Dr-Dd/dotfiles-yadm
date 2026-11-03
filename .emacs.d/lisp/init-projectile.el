;;; init-projectile.el --- Project management  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Projectile, with its command map on C-c p.
;;; Code:

(use-package projectile
  :ensure t
  :demand t
  :diminish
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-mode 1))

(provide 'init-projectile)
;;; init-projectile.el ends here
