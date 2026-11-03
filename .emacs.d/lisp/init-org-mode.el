;;; init-org-mode.el --- Org mode  -*- lexical-binding: t; -*-
;;; Commentary:
;;; All settings related to org-mode
;;; Code:

(use-package org
  :defer t
  :bind (("C-c c" . org-capture))
  :config
  ;; Extra org modules, loaded together with org
  (require 'org-habit)
  (require 'org-mouse)

  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   `((C . t)
     (shell . t)
     (emacs-lisp . t)
     ,@(when (locate-library "ob-ledger") '((ledger . t)))))

  (defun my/org-get-entry-time (pom &optional inherit)
    "Return the time of the entry at POM, or nil if it has none.
Look at TIMESTAMP, SCHEDULED and DEADLINE, in this order.  INHERIT is
passed to `org-entry-get'."
    (let ((time (or (org-entry-get pom "TIMESTAMP" inherit)
                    (org-entry-get pom "SCHEDULED" inherit)
                    (org-entry-get pom "DEADLINE" inherit))))
      (when time
        (org-time-string-to-time time)))))

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode))

(use-package org-edna
  :ensure t
  :diminish org-edna-mode
  :after org
  :config
  (org-edna-mode 1))

(use-package htmlize
  :ensure t
  :defer t)

(provide 'init-org-mode)
;;; init-org-mode.el ends here
