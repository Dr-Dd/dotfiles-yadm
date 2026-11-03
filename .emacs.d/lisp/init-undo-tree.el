;;; init-undo-tree.el --- Undo tree  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Undo tree (also used as evil's undo system)
;;; Code:

(use-package undo-tree
  :ensure t
  :demand t
  :diminish
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :config
  (global-undo-tree-mode 1))

(provide 'init-undo-tree)
;;; init-undo-tree.el ends here
