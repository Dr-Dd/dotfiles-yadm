;;; init-flycheck.el --- Syntax checking  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Flycheck everywhere, except in eglot buffers, where eglot's own
;;; flymake reports the LSP diagnostics.
;;; Code:

(use-package flycheck
  :ensure t
  :demand t
  :bind (:map flycheck-mode-map
              ("C-c e j" . flycheck-next-error)
              ("C-c e k" . flycheck-previous-error)
              ("C-c e l" . flycheck-list-errors))
  :custom
  (flycheck-emacs-lisp-load-path 'inherit)
  :config
  (global-flycheck-mode 1))

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (when (bound-and-true-p flycheck-mode)
                (flycheck-mode (if (eglot-managed-p) -1 1))))))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
