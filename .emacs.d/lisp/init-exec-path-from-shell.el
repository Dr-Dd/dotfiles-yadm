;;; init-exec-path-from-shell.el --- Shell environment  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Import PATH and ssh-agent variables from the login shell when
;;; Emacs is started from a GUI launcher (pgtk/Wayland, X) or as a daemon.
;;; Code:

(use-package exec-path-from-shell
  :ensure t
  :if (or (daemonp) (memq window-system '(pgtk x ns mac)))
  :demand t
  :config
  (dolist (var '("SSH_AGENT_PID" "SSH_AUTH_SOCK"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(provide 'init-exec-path-from-shell)
;;; init-exec-path-from-shell.el ends here
