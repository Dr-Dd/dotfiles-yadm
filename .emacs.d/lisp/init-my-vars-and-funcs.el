;;; init-my-vars-and-funcs.el --- User variables and functions  -*- lexical-binding: t; -*-
;;; Commentary:
;;; User defined variables and functions
;;; Code:

;; Paths may not exist on every machine (e.g. org files are synced
;; only on some PCs); code using them should check `file-directory-p'.
(defvar my/user-org-files-directory "~/Sync/org-files/"
  "Directory holding my org files.")
(defvar my/emacs-workspace-directory "~/emacs-workspace/")
(defvar my/git-repos-directory "~/.git-repos/")
(defvar my/backup-directory "~/.saves/")

;; Add org files to the agenda only on machines where they exist.
(with-eval-after-load 'org
  (when (file-directory-p my/user-org-files-directory)
    (add-to-list 'org-agenda-files my/user-org-files-directory)))

;;https://emacs.stackexchange.com/questions/40539/find-all-customization-type-mismatches
(defun my-custom-variable-valid-p (variable)
  "Return non-nil if the value of VARIABLE matches its custom type."
  (ignore-errors
    (let ((w (widget-convert (custom-variable-type variable))))
      (widget-apply w :match (symbol-value variable)))))

(defun my-get-mismatched-variables ()
  "Return all custom variables whose value does not match their type."
  (let (ret)
    (mapatoms
     (lambda (x)
       (when (and (custom-variable-p x)
                  (not (my-custom-variable-valid-p x)))
         (push x ret))))
    ret))

(defun my-show-mismatched-variables ()
  "Show custom variables whose value does not match their type."
  (interactive)
  (help-setup-xref (list #'my-show-mismatched-variables)
                   (called-interactively-p 'interactive))
  (with-help-window (help-buffer)
    (dolist (var (sort (my-get-mismatched-variables)
                       (lambda (a b)
                         (apply #'string-lessp
                                (mapcar #'symbol-name (list a b))))))
      (princ "* ")
      (princ (symbol-name var))
      (with-current-buffer standard-output
        (save-excursion
          (re-search-backward "* \\(.*\\)" nil t)
          (help-xref-button 1 'help-variable var)))
      (princ "\n"))))

(defun my/org-set-subtree-timestamps-year (new-year)
  "Set the year of every timestamp in the current Org subtree to NEW-YEAR.
Only the year changes; month and day are kept.  Weekday names are
recomputed by Org."
  (interactive "nNew year: ")
  (require 'org)
  (save-excursion
    (org-back-to-heading t)
    (let ((end (copy-marker (save-excursion (org-end-of-subtree t t))))
          (count 0))
      (while (re-search-forward org-ts-regexp-both end t)
        (let* ((ts-end (copy-marker (match-end 0)))
               (year (string-to-number
                      (buffer-substring (1+ (match-beginning 0))
                                        (+ 5 (match-beginning 0)))))
               (delta (- new-year year)))
          (unless (zerop delta)
            (goto-char (+ (match-beginning 0) 2)) ; inside the year
            (org-timestamp-change delta 'year)
            (setq count (1+ count)))
          (goto-char ts-end)
          (set-marker ts-end nil)))
      (set-marker end nil)
      (message "Updated %d timestamp(s)" count))))

(provide 'init-my-vars-and-funcs)
;;; init-my-vars-and-funcs.el ends here
