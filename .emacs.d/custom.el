;;; custom.el --- Custom settings  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Custom "custom.el" file
;;; Code:

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit default :foreground "#cb4b16" :height unspecified))))
 '(org-level-2 ((t (:inherit default :foreground "#859900" :height unspecified))))
 '(org-level-3 ((t (:inherit default :foreground "#268bd2" :height unspecified))))
 '(org-level-4 ((t (:inherit default :foreground "#b58900" :height unspecified)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-item-indent 0)
 '(TeX-auto-save t)
 '(TeX-master nil)
 '(TeX-parse-self t)
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi")
     (output-pdf "Zathura") (output-html "xdg-open")))
 '(auto-save-file-name-transforms '((".*" "~/.saves/" t)))
 '(aw-display-mode-overlay nil)
 '(aw-scope 'frame)
 '(backup-by-copying t)
 '(backup-directory-alist '((".*" . "~/.saves/")))
 '(beacon-blink-duration 0.01)
 '(beacon-color "chartreuse")
 '(before-save-hook '(delete-trailing-whitespace))
 '(blink-cursor-mode t)
 '(calendar-latitude 41.890209)
 '(calendar-longitude 12.492231)
 '(column-number-mode t)
 '(company-backends
   '((company-auctex-macros company-auctex-symbols
			    company-auctex-environments)
     company-auctex-bibs company-auctex-labels company-auctex
     company-c-headers company-semantic company-cmake
     company-capf company-clang company-files
     (company-dabbrev-code company-gtags company-etags
			   company-keywords)
     company-oddmuse company-dabbrev))
 '(company-frontends
   '(company-pseudo-tooltip-unless-just-one-frontend
     company-echo-metadata-frontend
     company-preview-if-just-one-frontend))
 '(connection-local-criteria-alist
   '(((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile
      tramp-flatpak-connection-local-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile
      tramp-connection-local-default-shell-profile)
     ((:application eshell) eshell-connection-default-profile)))
 '(connection-local-profile-alist
   '((tramp-flatpak-connection-local-default-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin"
			 "/usr/bin" "/sbin" "/usr/sbin"
			 "/usr/local/bin" "/usr/local/sbin"
			 "/local/bin" "/local/freeware/bin"
			 "/local/gnu/bin" "/usr/freeware/bin"
			 "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin"
			 "/opt/sbin" "/opt/local/bin"))
     (tramp-kubernetes-connection-local-default-profile
      (tramp-config-check . tramp-kubernetes--current-context-data)
      (tramp-extra-expand-args 97
			       (tramp-kubernetes--container
				(car tramp-current-connection))
			       104
			       (tramp-kubernetes--pod
				(car tramp-current-connection))
			       120
			       (tramp-kubernetes--context-namespace
				(car tramp-current-connection))))
     (tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin"
			 "/usr/bin" "/sbin" "/usr/sbin"
			 "/usr/local/bin" "/usr/local/sbin"
			 "/local/bin" "/local/freeware/bin"
			 "/local/gnu/bin" "/usr/freeware/bin"
			 "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin"
			 "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
					"pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"-o" "state=abcde" "-o"
					"ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number)
					  (euid . number)
					  (user . string)
					  (egid . number) (comm . 52)
					  (state . 5) (ppid . number)
					  (pgrp . number)
					  (sess . number)
					  (ttname . string)
					  (tpgid . number)
					  (minflt . number)
					  (majflt . number)
					  (time . tramp-ps-time)
					  (pri . number)
					  (nice . number)
					  (vsize . number)
					  (rss . number)
					  (etime . tramp-ps-time)
					  (pcpu . number)
					  (pmem . number) (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o"
					"pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"-o" "stat=abcde" "-o"
					"ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format (pid . number)
					  (user . string)
					  (group . string) (comm . 52)
					  (state . 5) (ppid . number)
					  (pgrp . number)
					  (ttname . string)
					  (time . tramp-ps-time)
					  (nice . number)
					  (etime . tramp-ps-time)
					  (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
					"pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"-o"
					"state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number)
					  (euid . number)
					  (user . string)
					  (egid . number)
					  (group . string) (comm . 52)
					  (state . string)
					  (ppid . number)
					  (pgrp . number)
					  (sess . number)
					  (ttname . string)
					  (tpgid . number)
					  (minflt . number)
					  (majflt . number)
					  (time . tramp-ps-time)
					  (pri . number)
					  (nice . number)
					  (vsize . number)
					  (rss . number)
					  (etime . number)
					  (pcpu . number)
					  (pmem . number) (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh") (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":") (null-device . "/dev/null"))
     (eshell-connection-default-profile (eshell-path-env-list))))
 '(custom-safe-themes
   '("d97ac0baa0b67be4f7523795621ea5096939a47e8b46378f79e78846e0e4ad3d"
     default))
 '(dashboard-banner-logo-title (shell-command-to-string "fortune -as"))
 '(dashboard-footer-messages '("Who the hell uses VIM anyway? Go Evil!"))
 '(dashboard-items '((recents . 9)))
 '(dashboard-navigator-buttons
   '((("" "init.el" "" (lambda (&rest _) (message "flag")) default "["
       "]"))))
 '(default-frame-alist '((font . "Hack-18")))
 '(delete-old-versions t)
 '(display-line-numbers-type 'relative)
 '(doom-modeline-icon t)
 '(electric-indent-mode t)
 '(electric-pair-mode t)
 '(elfeed-feeds
   '(("https://www.linuxjournal.com/news/feed" linux cs)
     ("https://www.rfc-editor.org/rfcrss.xml" rfc cs)
     ("https://www.kernel.org/feeds/all.atom.xml" linux cs)
     ("https://www.kernel.org/feeds/kdist.xml" linux cs)
     ("https://www.reddit.com/r/linux/rising/.rss" cs reddit)
     ("https://www.reddit.com/r/emacs/rising/.rss" cs reddit)
     ("https://lwn.net/headlines/rss" cs blog linux)
     ("https://www.phoronix.com/rss.php" cs blog)
     ("https://hackaday.com/blog/feed/" cs blog)
     ("https://www.darkreading.com/rss_simple.asp" cs blog)
     ("https://feeds.feedburner.com/TheHackersNews" cs blog)
     ("https://lobste.rs/rss" cs aggregator)
     ("https://hnrss.org/frontpage" cs aggregator)
     ("https://feeds.feedburner.com/arstechnica/index" tech)
     ("https://www.anandtech.com/rss/" tech)
     ("https://gizmodo.com/rss" tech)
     ("http://rss.slashdot.org/Slashdot/slashdotMain" tech)
     ("https://www.engadget.com/rss.xml" tech)
     ("https://feeds.feedburner.com/GamasutraNews/" games blog)
     ("https://www.wired.com/feed/rss" tech)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=TheEconomist&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=nytimes&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=AJWasahi&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=BBCBreaking&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=guardian&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=AJENews&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=washingtonpost&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=nytimes&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Reuters&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=fattoquotidiano&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=sole24ore&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Agenzia_Ansa&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Agenzia_Italia&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news italy twitter)
     ("http://localhost/?action=display&bridge=Twitter&context=By+username&u=Corriere&norep=on&noretweet=on&nopinned=on&nopic=on&noimg=on&format=Atom"
      news italy twitter)
     ("https://boards.4channel.org/g/index.rss" 4chan)
     ("https://feeds.simplecast.com/aU_RzZ7j" podcast)
     ("https://feeds.feedburner.com/themega64podcast" podcast)
     ("https://superbestfriendcast.libsyn.com/rss" podcast)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCOgaIuQYGr6ow_jbote4BKA"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCpmNJI_KhjkpXw1UPmtC3-Q"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCM7A1ATNTeqi8Lk-8mYAJSQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UClQVIpFHy14FehFeEXdOKwQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVsmYrE8-v3VS7XWg3cXp9g"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC3jdnIP2u5hCJpVZ-TuDrCg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCjNErCQgCndSOl6t33m1-nQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyOJzQzyDGihKpTO3-zyhYg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCKJtYrlWaF3G0LIneEKoPew"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCKTehwyGCKF-b2wo0RKwrcg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0M0rxSz3IF0CsSour1iWmw"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC21uZkfXpT8rPY-gPgMiCwA"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2Qw1dzXDBAZPwS7zm37g8g"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYZtp0YIxYOipX15v_h_jnA"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCsD9nSAjE6uq1EPYlCORS9w"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCL6JmiMXKoXS6bpP1D3bk8g"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCNSMdQtn1SuFzCZjfK2C7dQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCbWcXB0PoqOsAvAdfzWMf0w"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCR1D15p_vdP3HkrH8wgjQRw"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyhnYIvIKK_--PiJXCMKxQQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UClcE-kVhqyiHCcjYwcpfj9w"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UClOGLGPOqlAiLmOvXW5lKbw"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCiP_FwGyJQ_6P8k5ON5mncQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCb_sF2m3-2azOqeNEdMwQPw"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCSdma21fnJzgmPodhC9SJ3g"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4eYXhJI4-7wSWc8UNRwD4A"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCo1pShh6dtg-T_ZZkgi_JDQ"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCD6VugMZKRhSyzWEWA9W2fg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWqr2tH3dPshNhPjV5h1xRw"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtGoikgbxP4F3rgI9PldI9g"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCt7fwAhXDy3oNFTAzF2o8Pw"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCBa659QWEk1AI4Tg--mrJ2A"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCllm3HivMERwu2x2Sjz5EIg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCsvn_Po0SmunchJYOWpOxMg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCzORJV8l3FWY4cFO8ot-F2w"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCIPsK5xspHC3-ZFNPTx2X_w"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCdJdEguB1F1CiYe7OEi3SBg"
      youtube)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWqr2tH3dPshNhPjV5h1xRw"
      youtube)))
 '(elfeed-search-filter "@0-days-ago--1-day-ago +unread")
 '(elfeed-search-title-max-width 130)
 '(erc-autojoin-channels-alist nil)
 '(erc-fill-mode t)
 '(erc-fill-prefix "    ")
 '(erc-hide-list '("JOIN" "PART" "QUIT"))
 '(erc-rename-buffers t)
 '(eshell-scroll-to-bottom-on-input 'all)
 '(evil-emacs-state-modes
   '(benchmark-init/tree-mode haskell-interactive-mode help-mode
			      xref--xref-buffer-mode
			      inferior-python-mode
			      tuareg-interactive-mode shell-mode
			      haskell-interactive-mode dashboard-mode
			      5x5-mode archive-mode
			      biblio-selection-mode blackbox-mode
			      bookmark-bmenu-mode
			      bookmark-edit-annotation-mode
			      browse-kill-ring-mode bs-mode
			      bubbles-mode bzr-annotate-mode calc-mode
			      cfw:calendar-mode completion-list-mode
			      Custom-mode custom-theme-choose-mode
			      debugger-mode delicious-search-mode
			      desktop-menu-blist-mode
			      desktop-menu-mode doc-view-mode dun-mode
			      dvc-bookmarks-mode dvc-diff-mode
			      dvc-info-buffer-mode dvc-log-buffer-mode
			      dvc-revlist-mode dvc-revlog-mode
			      dvc-status-mode dvc-tips-mode ediff-mode
			      ediff-meta-mode efs-mode
			      Electric-buffer-menu-mode
			      emms-browser-mode emms-mark-mode
			      emms-metaplaylist-mode
			      emms-playlist-mode ess-help-mode
			      etags-select-mode fj-mode gc-issues-mode
			      gdb-breakpoints-mode
			      gdb-disassembly-mode gdb-frames-mode
			      gdb-locals-mode gdb-memory-mode
			      gdb-registers-mode gdb-threads-mode
			      gist-list-mode git-rebase-mode
			      gomoku-mode
			      google-maps-static-mode ibuffer-mode
			      jde-javadoc-checker-report-mode
			      magit-cherry-mode magit-diff-mode
			      magit-log-mode magit-log-select-mode
			      magit-popup-mode
			      magit-popup-sequence-mode
			      magit-process-mode magit-reflog-mode
			      magit-refs-mode magit-revision-mode
			      magit-stash-mode magit-stashes-mode
			      magit-status-mode
			      monky-mode mpuz-mode
			      occur-mode package-menu-mode
			      pdf-outline-buffer-mode pdf-view-mode
			      proced-mode rcirc-mode rebase-mode
			      recentf-dialog-mode
			      reftex-select-bib-mode
			      reftex-select-label-mode reftex-toc-mode
			      sldb-mode slime-inspector-mode
			      slime-thread-control-mode
			      slime-xref-mode snake-mode
			      solitaire-mode sr-buttons-mode sr-mode
			      sr-tree-mode sr-virtual-mode tar-mode
			      tetris-mode tla-annotate-mode
			      tla-archive-list-mode tla-bconfig-mode
			      tla-bookmarks-mode tla-branch-list-mode
			      tla-browse-mode tla-category-list-mode
			      tla-changelog-mode
			      tla-follow-symlinks-mode
			      tla-inventory-file-mode
			      tla-inventory-mode tla-lint-mode
			      tla-logs-mode tla-revision-list-mode
			      tla-revlog-mode tla-tree-lint-mode
			      tla-version-list-mode twittering-mode
			      urlview-mode vc-annotate-mode
			      vc-dir-mode vc-git-log-view-mode
			      vc-hg-log-view-mode vc-svn-log-view-mode
			      vm-mode vm-summary-mode w3m-mode
			      wab-compilation-mode xgit-annotate-mode
			      xgit-changelog-mode xgit-diff-mode
			      xgit-revlog-mode xhg-annotate-mode
			      xhg-log-mode xhg-mode xhg-mq-mode
			      xhg-mq-sub-mode xhg-status-extra-mode
			      inferior-emacs-lisp-mode timer-list-mode
			      flycheck-error-list-mode special-mode
			      elfeed-search-mode elfeed-show-mode))
 '(evil-ex-search-case 'insensitive)
 '(flycheck-emacs-lisp-load-path 'inherit)
 '(frame-resize-pixelwise t)
 '(global-auto-revert-mode t)
 '(global-display-line-numbers-mode t)
 '(global-hl-line-mode t)
 '(gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
 '(history-delete-duplicates t)
 '(indicate-empty-lines t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice '(lambda nil (get-buffer-create "*dashboard*")))
 '(initial-scratch-message nil)
 '(ispell-program-name "/usr/bin/hunspell")
 '(jiralib-update-issue-fields-exclude-list '(components priority))
 '(jiralib-url "https://cooltech.atlassian.net")
 '(kept-new-versions 6)
 '(ledger-report-use-strict t)
 '(ledger-reports
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
     ("account" "%(binary) -f %(ledger-file) reg %(account)")))
 '(load-prefer-newer t)
 '(lsp-completion-provider :capf)
 '(lsp-managed-mode-hook '(lsp-diagnostics-modeline-mode))
 '(lsp-mode-hook '(lsp-enable-which-key-integration))
 '(magit-refresh-status-buffer nil)
 '(menu-bar-mode nil)
 '(midnight-mode t)
 '(org-agenda-custom-commands
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
 '(org-agenda-dim-blocked-tasks 'invisible)
 '(org-agenda-finalize-hook
   '((lambda nil
       (progn
	 (highlight-regexp "<[A-z]* [0-9]*>" 'org-date)
	 (highlight-regexp
	  "Urgenze\\|Eventi\\|Compleanni\\|Task\\|Progetti\\|Tabella\\|Esami"
	  'org-warning)))))
 '(org-agenda-prefix-format
   '((tags
      . " %-9(let ((timestamp (my/org-get-entry-time (point)))) (if timestamp (format-time-string \"<%b %d>\" timestamp) \"\"))")))
 '(org-agenda-show-future-repeats 'next)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-window-setup 'current-window)
 '(org-capture-templates
   '(("r"
      "Routine di varia natura (TODO + repeating SCHEDULE/DEADLINE/Timestamp)"
      entry (file+headline "~/Sync/org-files/scheduled.org" "Routine")
      "* TODO %? :@routine:\12 %^{Timestamp, SCHEDULED or DEADLINE?| |SCHEDULED:|DEADLINE:} %^t\12")
     ("e" "Eventi di varia importanza (Unset/[#A/B/C] + Timestamp)"
      entry
      (file+headline "~/Sync/org-files/scheduled.org" "Calendar")
      "* FUTURE %^{_ or [#A/B/C]?| |[#A]|[#B]|[#C]} %? :@event:\12 %^t\12")
     ("w" "Obiettivi lavoro" entry (file "~/Sync/org-files/work.org")
      "* TODO %^{_ or [#A/B/C]?| |[#A]|[#B]|[#C]} %?\12 %U\12")
     ("t" "Task lavoro (Event/Deadline/scheduled)" entry
      (file "~/Sync/org-files/work.org")
      "* TODO %^{_ or [#A/B/C]?| |[#A]|[#B]|[#C]} %? :@task:\12 %^{Timestamp, SCHEDULED or DEADLINE?| |SCHEDULED:|DEADLINE:} %^t\12 %u\12")
     ("j" "Aggiungi un nuovo job al report settimanale" entry
      (file+headline "~/Sync/org-files/work.org" "Report Settimanale")
      "* %?\12 %U\12")
     ("p" "Progetti da iniziare a ragionare" entry
      (file "~/Sync/org-files/projects.org")
      "* TODO %? %^{@urgent or @utility?|:@urgent:|:@utility:}\12")
     ("s" "Lista della spesa per cibo mancante" entry
      (file "~/Sync/org-files/lista-spesa.org") "* TOBUY %?\12")
     ("f" "Film da vedere" entry (file "~/Sync/org-files/movies.org")
      "* TOWATCH %?\12")
     ("l" "Libri da leggere" entry (file "~/Sync/org-files/books.org")
      "* TOBUY %?\12")
     ("i" "Progetti informatici personali (TODO)" entry
      (file "~/Sync/org-files/compsci.org") "* TODO %?\12")
     ("m" "Album Musicali da ascoltare" entry
      (file+headline "~/Sync/org-files/music.org" "Albums")
      "* TOBUY %? :@album:\12")
     ("M" "Bei pezzi da ricordare" entry
      (file+headline "~/Sync/org-files/music.org" "Mix")
      "* %? :@mix:\12")
     ("h" "Passatempo di varia natura" entry
      (file "~/Sync/org-files/hobbies.org") "* TODO %? :_editme:\12")
     ("c" "File da riordinare/riorganizzare" entry
      (file "~/Sync/org-files/to-capture.org") "* TOCAPTURE %?\12")
     ("b" "Aggiungi la data di compleanno di qualcuno che ti è caro"
      entry
      (file+headline "~/Sync/org-files/scheduled.org" "Birthdays")
      "* Compleanno %? :@birthday:\12 %^t\12")))
 '(org-deadline-warning-days 7)
 '(org-enforce-todo-dependencies t)
 '(org-habit-graph-column 68)
 '(org-habit-show-habits-only-for-today nil)
 '(org-latex-classes
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
 '(org-log-done 'time)
 '(org-msg-signature
   "\12#+begin_signature\12--\12#+INCLUDE: ~/Sync/cool-tech-signature.html export html\12#+end_signature")
 '(org-src-content-indentation 0)
 '(org-src-preserve-indentation t)
 '(org-startup-indented t)
 '(org-tags-column 0)
 '(org-todo-keyword-faces
   '(("CANCELED" . "black") ("TOLISTEN" . "gold2") ("TOREAD" . "gold2")
     ("TOMIX" . "gold2")))
 '(org-todo-keywords '((sequence "TODO" "|" "DONE") (sequence "|" "CANCELED")))
 '(package-selected-packages
   '(ace-window beacon company-c-headers dashboard diminish
		doom-modeline evil-commentary evil-org evil-surround
		exec-path-from-shell eyebrowse flycheck helm
		highlight-indentation htmlize ledger-mode magit
		markdown-mode org-edna org-superstar projectile
		typescript-mode undo-tree yasnippet yasnippet-snippets
		zenburn-theme))
 '(projectile-tags-command "gtags")
 '(recentf-exclude
   '("/.emacs.d/.cache/treemacs-persist-at-last-error"
     "/.emacs.d/.cache/treemacs-persist" "/usr/share/emacs" "/.elfeed"
     "/Sync/org-files/"))
 '(require-final-newline t)
 '(safe-local-variable-values
   '((TeX-command-extra-options . "--shell-escape")
     (ispell-local-dictionary . italiano)
     (ispell-local-dictionary . it-IT)
     (ispell-local-dictionary . italian)
     (ispell-local-dictionary . it_IT)))
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(split-height-threshold 33)
 '(split-width-threshold 62)
 '(text-mode-hook '(flyspell-mode text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(tramp-use-connection-share nil)
 '(tramp-use-ssh-controlmaster-options nil)
 '(undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
 '(use-system-tooltips nil)
 '(vc-follow-symlinks t)
 '(version-control t)
 '(warning-suppress-types '((lsp-mode) (comp) (:warning)))
 '(window-resize-pixelwise t)
 '(xref-prompt-for-identifier
   '(not xref-find-definitions xref-find-definitions-other-window
	 xref-find-definitions-other-frame xref-find-references)))

;;; custom.el ends here
