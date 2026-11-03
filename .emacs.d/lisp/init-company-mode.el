;;; init-company-mode.el --- In-buffer completion  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Company mode for _in buffer_ completion (not minibuffer like helm)
;;; Code:

(use-package company
  :ensure t
  :demand t
  :diminish
  :bind (("M-<SPC>" . company-complete))
  :custom
  (company-frontends
   '(company-pseudo-tooltip-unless-just-one-frontend
     company-echo-metadata-frontend
     company-preview-if-just-one-frontend))
  :config
  (global-company-mode 1))

(use-package company-c-headers
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends #'company-c-headers))

(provide 'init-company-mode)
;;; init-company-mode.el ends here
