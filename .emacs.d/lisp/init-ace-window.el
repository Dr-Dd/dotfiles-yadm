;;; init-ace-window.el --- Window switching  -*- lexical-binding: t; -*-
;;; Commentary:
;;; sensible window switching and moving with ace-window
;;; Code:

(use-package ace-window
  :ensure t
  :bind (("M-o" . ace-window))
  :custom
  (aw-display-mode-overlay nil)
  (aw-scope 'frame))

(provide 'init-ace-window)
;;; init-ace-window.el ends here
