;;; init-diminish.el --- Hide minor modes from the mode line  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Built-in minor modes are diminished here; package minor modes use
;;; `:diminish' in their own use-package declaration.
;;; Code:

(use-package diminish
  :ensure t
  :demand t
  :config
  (diminish 'auto-revert-mode)
  (diminish 'eldoc-mode)
  (diminish 'overwrite-mode))

(provide 'init-diminish)
;;; init-diminish.el ends here
