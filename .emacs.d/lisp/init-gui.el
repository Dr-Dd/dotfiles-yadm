;;; init-gui.el --- Visual settings  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Gui related settings for Emacs.  Not necessarily related
;;; to only the "gui" way of spawning Emacs (gui is used in the
;;; true sense of the term), so it also applies for some terminal
;;; Emacs' settings.
;;; Code:

;; To fully separate emacs' responsibilities from
;; X11's
(setq inhibit-x-resources t)

;; Main font is Hack, via `default-frame-alist' in custom.el.
;; Use the color emoji font for emoji only.
(set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji") nil 'prepend)

;; Vim-style tilde on empty lines in the fringe
(defun my/set-fringe-vim-style ()
  "Show a tilde in the fringe for lines past the end of the buffer."
  (define-fringe-bitmap 'tilde [0 0 0 113 219 142 0 0] nil nil 'center)
  (setcdr (assq 'empty-line fringe-indicator-alist) 'tilde)
  (set-fringe-bitmap-face 'tilde 'font-lock-function-name-face))
(my/set-fringe-vim-style)

(provide 'init-gui)
;;; init-gui.el ends here
