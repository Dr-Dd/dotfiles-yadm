;;; early-init.el --- Pre-init settings  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Loaded before package.el and the first frame are initialized.
;;; Code:

(setq native-comp-jit-compilation t
      native-compile-prune-cache t)

;; Faster startup: suspend GC and file handlers, restored after init.
(defvar my/file-name-handler-alist-old file-name-handler-alist)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist my/file-name-handler-alist-old
                  gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

;; Avoid flashing UI elements before custom.el turns them off.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;;; early-init.el ends here
