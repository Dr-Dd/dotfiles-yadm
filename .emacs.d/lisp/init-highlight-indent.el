;;; init-highlight-indent.el --- Indentation guides  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Package to higlight indentation lines, could be better
;;; Code:

(use-package highlight-indentation
  :ensure t
  :diminish highlight-indentation-mode
  :hook (prog-mode . highlight-indentation-mode))

(provide 'init-highlight-indent)
;;; init-highlight-indent.el ends here
