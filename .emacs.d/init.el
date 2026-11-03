;;; init.el --- Just my init file  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Startup tuning lives in early-init.el.  Use M-x emacs-init-time
;;; to see how long startup took.
;;; Code:

(setq message-log-max 16384
      auto-window-vscroll nil)

;; Packages (package.el is initialized automatically before init.el)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)                  ; built in since Emacs 29

;; IN CASE OF A PACKAGE NOT INSTALLING, TRY TO RUN
;; <M-x>`package-refresh-contents`<RET> BEFORE DOING ANYTHING
;; STUPID

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-exec-path-from-shell)
(require 'init-my-vars-and-funcs)
(require 'init-diminish)
(require 'init-drdefaults)
(require 'init-eglot)
(require 'init-evil-mode)
(require 'init-eshell)
(require 'init-eyebrowse)
(require 'init-which-key)
(require 'init-magit)
(require 'init-flycheck)
(require 'init-tree-sitter)
(require 'init-org-mode)
(require 'init-markdown-mode)
(require 'init-undo-tree)
(require 'init-company-mode)
(require 'init-doom-modeline) ;; resizing problems
(require 'init-ace-window)
(require 'init-highlight-indent)
(require 'init-yasnippet)
(require 'init-helm)
(require 'init-projectile)
(require 'init-ledger)
(require 'init-drdashboard)
(require 'init-theme)
(require 'init-beacon)
(require 'init-gui)

;;; init.el ends here
