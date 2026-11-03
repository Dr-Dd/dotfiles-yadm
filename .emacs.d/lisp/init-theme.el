;;; init-theme.el --- Color theme  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Zenburn as the main theme.
;;; Code:

(use-package zenburn-theme
  :ensure t
  :demand t
  :config
  (load-theme 'zenburn t)
  ;; `user'-theme face settings override zenburn (`:custom-face' would
  ;; only change the default spec, which the theme shadows).
  (custom-set-faces
   '(org-level-1 ((t (:inherit default :foreground "#cb4b16" :height unspecified))))
   '(org-level-2 ((t (:inherit default :foreground "#859900" :height unspecified))))
   '(org-level-3 ((t (:inherit default :foreground "#268bd2" :height unspecified))))
   '(org-level-4 ((t (:inherit default :foreground "#b58900" :height unspecified))))))

(provide 'init-theme)
;;; init-theme.el ends here
