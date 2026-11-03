;;; init-eglot.el --- LSP client  -*- lexical-binding: t; -*-
;;; Commentary:
;;; eglot LSP (built in)
;;; Code:

(use-package eglot
  :defer t
  :bind (:map eglot-mode-map
              ("C-c f" . xref-find-definitions)
              ("C-c b" . xref-go-back)
              ("C-c F" . xref-find-references)
              ("C-c r" . eglot-rename)
              ("C-c d" . eldoc-doc-buffer)
              ("C-c a" . eglot-code-actions)))

(provide 'init-eglot)
;;; init-eglot.el ends here
