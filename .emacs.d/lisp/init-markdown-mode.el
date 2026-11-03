;;; init-markdown-mode.el --- Markdown  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Preview and edit Markdown
;;; Code:

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode))

(provide 'init-markdown-mode)
;;; init-markdown-mode.el ends here
