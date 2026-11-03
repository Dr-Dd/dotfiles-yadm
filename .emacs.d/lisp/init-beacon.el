;;; init-beacon.el --- Cursor highlight  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Flash the cursor position when scrolling or switching windows.
;;; Code:

(use-package beacon
  :ensure t
  :demand t
  :custom
  (beacon-blink-duration 0.01)
  (beacon-color "chartreuse")
  :config
  (beacon-mode 1))

(provide 'init-beacon)
;;; init-beacon.el ends here
