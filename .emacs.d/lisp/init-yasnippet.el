;;; init-yasnippet.el --- Snippets  -*- lexical-binding: t; -*-
;;; Commentary:
;;; snippets expansion via yasnippet
;;; Code:

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook ((prog-mode . yas-minor-mode)
         (latex-mode . yas-minor-mode))
  :bind (:map yas-minor-mode-map
              ([tab] . nil)
              ("TAB" . nil)
              ("M-p" . yas-expand)
              ("M-i" . yas-insert-snippet))
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
