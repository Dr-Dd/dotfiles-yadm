;;; init-ledger.el --- Ledger accounting  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Setup and config for my emacsen ledger-3 environment
;;; Code:

(use-package ledger-mode
  :ensure t
  :defer t
  :custom
  (ledger-report-use-strict t)
  (ledger-reports
   '(("current week register"
      "%(binary) -f %(ledger-file) --period \"this week\" register")
     ("current week balance"
      "%(binary) -f %(ledger-file) --period \"this week\" balance")
     ("last week register"
      " %(binary) -f %(ledger-file) --period \"last week\" register")
     ("last week balance"
      "%(binary) -f %(ledger-file) --period \"last week\" balance")
     ("current month register"
      "%(binary) -f %(ledger-file) --period \"this month\" register ")
     ("current month balance"
      "%(binary) -f %(ledger-file) --period \"this month\" balance ")
     ("last month register"
      "%(binary) -f %(ledger-file) --period \"last month\" register ")
     ("last month balance"
      "%(binary) -f %(ledger-file) --period \"last month\" balance ")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)"))))

(provide 'init-ledger)
;;; init-ledger.el ends here
