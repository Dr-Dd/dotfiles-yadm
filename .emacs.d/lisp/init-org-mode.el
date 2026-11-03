;;; init-org-mode.el --- Org mode  -*- lexical-binding: t; -*-
;;; Commentary:
;;; All settings related to org-mode
;;; Code:

(use-package org
  :defer t
  :preface
  (defun my/org-agenda-highlight ()
    "Highlight dates and block headers in the agenda buffer."
    (highlight-regexp "<[A-z]* [0-9]*>" 'org-date)
    (highlight-regexp
     "Urgenze\\|Eventi\\|Compleanni\\|Task\\|Progetti\\|Tabella\\|Esami"
     'org-warning))
  :bind (("C-c c" . org-capture))
  :hook (org-agenda-finalize . my/org-agenda-highlight)
  :custom
  (org-startup-indented t)
  (org-tags-column 0)
  (org-log-done 'time)
  (org-enforce-todo-dependencies t)
  (org-deadline-warning-days 7)
  (org-src-content-indentation 0)
  (org-src-preserve-indentation t)
  (org-todo-keywords '((sequence "TODO" "|" "DONE") (sequence "|" "CANCELED")))
  (org-todo-keyword-faces
   '(("CANCELED" . "black") ("TOLISTEN" . "gold2") ("TOREAD" . "gold2")
     ("TOMIX" . "gold2")))
  (org-habit-graph-column 68)
  (org-habit-show-habits-only-for-today nil)
  ;; Agenda
  (org-agenda-window-setup 'current-window)
  (org-agenda-dim-blocked-tasks 'invisible)
  (org-agenda-show-future-repeats 'next)
  (org-agenda-skip-deadline-if-done t)
  (org-agenda-prefix-format
   '((tags
      . " %-9(let ((timestamp (my/org-get-entry-time (point)))) (if timestamp (format-time-string \"<%b %d>\" timestamp) \"\"))")))
  (org-agenda-custom-commands
   '(("d" "Weekly agenda about urgencies"
      ((tags-todo "@urgent"
                  ((org-agenda-sorting-strategy '(timestamp-up))
                   (org-agenda-overriding-header
                    "Urgenze da portare a termine")))
       (tags "@exam+TIMESTAMP>=\"<today>\""
             ((org-agenda-sorting-strategy '(timestamp-up))
              (org-agenda-overriding-header "Esami futuri")))
       (tags "+@event+TIMESTAMP<=\"<+6m>\""
             ((org-agenda-sorting-strategy '(timestamp-up))
              (org-agenda-overriding-header "Eventi futuri")))
       (agenda ""
               ((org-agenda-start-on-weekday nil)
                (org-agenda-show-all-dates nil)))
       (tags "@birthday+TIMESTAMP>=\"<today>\""
             ((org-agenda-sorting-strategy '(timestamp-up))
              (org-agenda-overriding-header "Compleanni futuri")
              (org-agenda-max-entries 6))))
      ((org-agenda-compact-blocks nil)
       (org-agenda-tag-filter-preset '("-@work"))))))
  ;; Capture
  (org-capture-templates
   '(("r"
      "Routine di varia natura (TODO + repeating SCHEDULE/DEADLINE/Timestamp)"
      entry (file+headline "~/Sync/org-files/scheduled.org" "Routine")
      "* TODO %? :@routine:\n %^{Timestamp, SCHEDULED or DEADLINE?| |SCHEDULED:|DEADLINE:} %^t\n")
     ("e" "Eventi di varia importanza (Unset/[#A/B/C] + Timestamp)"
      entry (file+headline "~/Sync/org-files/scheduled.org" "Calendar")
      "* FUTURE %^{_ or [#A/B/C]?| |[#A]|[#B]|[#C]} %? :@event:\n %^t\n")
     ("w" "Obiettivi lavoro" entry (file "~/Sync/org-files/work.org")
      "* TODO %^{_ or [#A/B/C]?| |[#A]|[#B]|[#C]} %?\n %U\n")
     ("t" "Task lavoro (Event/Deadline/scheduled)" entry
      (file "~/Sync/org-files/work.org")
      "* TODO %^{_ or [#A/B/C]?| |[#A]|[#B]|[#C]} %? :@task:\n %^{Timestamp, SCHEDULED or DEADLINE?| |SCHEDULED:|DEADLINE:} %^t\n %u\n")
     ("j" "Aggiungi un nuovo job al report settimanale" entry
      (file+headline "~/Sync/org-files/work.org" "Report Settimanale")
      "* %?\n %U\n")
     ("p" "Progetti da iniziare a ragionare" entry
      (file "~/Sync/org-files/projects.org")
      "* TODO %? %^{@urgent or @utility?|:@urgent:|:@utility:}\n")
     ("s" "Lista della spesa per cibo mancante" entry
      (file "~/Sync/org-files/lista-spesa.org") "* TOBUY %?\n")
     ("f" "Film da vedere" entry (file "~/Sync/org-files/movies.org")
      "* TOWATCH %?\n")
     ("l" "Libri da leggere" entry (file "~/Sync/org-files/books.org")
      "* TOBUY %?\n")
     ("i" "Progetti informatici personali (TODO)" entry
      (file "~/Sync/org-files/compsci.org") "* TODO %?\n")
     ("m" "Album Musicali da ascoltare" entry
      (file+headline "~/Sync/org-files/music.org" "Albums")
      "* TOBUY %? :@album:\n")
     ("M" "Bei pezzi da ricordare" entry
      (file+headline "~/Sync/org-files/music.org" "Mix")
      "* %? :@mix:\n")
     ("h" "Passatempo di varia natura" entry
      (file "~/Sync/org-files/hobbies.org") "* TODO %? :_editme:\n")
     ("c" "File da riordinare/riorganizzare" entry
      (file "~/Sync/org-files/to-capture.org") "* TOCAPTURE %?\n")
     ("b" "Aggiungi la data di compleanno di qualcuno che ti è caro"
      entry
      (file+headline "~/Sync/org-files/scheduled.org" "Birthdays")
      "* Compleanno %? :@birthday:\n %^t\n")))
  ;; LaTeX export
  (org-latex-classes
   '(("beamer" "\\documentclass[presentation]{beamer}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("a4-article" "\\documentclass[11pt,a4paper]{article}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
  :config
  ;; Extra org modules, loaded together with org
  (require 'org-habit)
  (require 'org-mouse)

  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   `((C . t)
     (shell . t)
     (emacs-lisp . t)
     ,@(when (locate-library "ob-ledger") '((ledger . t)))))

  (defun my/org-get-entry-time (pom &optional inherit)
    "Return the time of the entry at POM, or nil if it has none.
Look at TIMESTAMP, SCHEDULED and DEADLINE, in this order.  INHERIT is
passed to `org-entry-get'."
    (let ((time (or (org-entry-get pom "TIMESTAMP" inherit)
                    (org-entry-get pom "SCHEDULED" inherit)
                    (org-entry-get pom "DEADLINE" inherit))))
      (when time
        (org-time-string-to-time time)))))

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode))

(use-package org-edna
  :ensure t
  :diminish org-edna-mode
  :after org
  :config
  (org-edna-mode 1))

(use-package htmlize
  :ensure t
  :defer t)

(provide 'init-org-mode)
;;; init-org-mode.el ends here
