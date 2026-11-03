;;; init-doom-modeline.el --- Mode line  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Doom modeline for nicer looking modeline gui, non-essential.
;;; Icons come from nerd-icons (font: Hack Nerd Font / Symbols Nerd Font).
;;; Code:

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-icon t))

(provide 'init-doom-modeline)
;;; init-doom-modeline.el ends here
