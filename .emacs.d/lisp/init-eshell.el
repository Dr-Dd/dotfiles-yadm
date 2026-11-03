;;; init-eshell.el --- Eshell helpers  -*- lexical-binding: t; -*-
;;; Commentary:
;;; eshell functions
;;; Code:

(with-eval-after-load 'evil
  (evil-set-initial-state 'eshell-mode 'emacs))

(defun my/eshell-buffer-working-dir ()
  "Open *eshell* in another window, switched to the current directory."
  (interactive)
  (let ((def-dir default-directory))
    (if (get-buffer "*eshell*")
        (progn (switch-to-buffer-other-window "*eshell*")
               (eshell-interrupt-process)
               (insert (concat "cd " (shell-quote-argument def-dir)))
               (eshell-send-input)
               (eshell/clear))
      (split-window-below)
      (other-window 1)
      (eshell))))

(global-set-key (kbd "C-c x") #'eshell-command)
;; C-c C-<letter> is reserved for major modes (and is an Org prefix).
(global-set-key (kbd "C-c X") #'my/eshell-buffer-working-dir)

(provide 'init-eshell)
;;; init-eshell.el ends here
