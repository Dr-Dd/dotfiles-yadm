;;; init-magit.el --- Git front-end  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Magit git front-end
;;; Code:

(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status))
  :custom
  (magit-refresh-status-buffer nil))

(provide 'init-magit)
;;; init-magit.el ends here
