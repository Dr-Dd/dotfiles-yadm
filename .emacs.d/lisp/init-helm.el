;;; init-helm.el --- Minibuffer completion  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Helm for _minibuffer_ completion (not in-buffer like company-mode)
;;; Code:

(use-package helm
  :ensure t
  :demand t
  :diminish helm-mode
  :bind (([remap find-file] . helm-find-files)
         ([remap occur] . helm-occur)
         ([remap list-buffers] . helm-buffers-list)
         ([remap switch-to-buffer] . helm-mini)
         ([remap dabbrev-expand] . helm-dabbrev)
         ([remap execute-extended-command] . helm-M-x)
         ([remap apropos-command] . helm-apropos))
  :config
  (helm-mode 1))

(provide 'init-helm)
;;; init-helm.el ends here
