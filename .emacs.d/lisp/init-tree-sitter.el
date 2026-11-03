;;; init-tree-sitter.el --- Built-in tree-sitter  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Use Emacs' built-in treesit.  Grammars are installed into
;;; ~/.emacs.d/tree-sitter/ on demand: visiting a file asks before
;;; downloading the grammar (`treesit-auto-install-grammar' = ask).
;;; Code:

(use-package treesit
  :if (treesit-available-p)
  :custom
  ;; Use a *-ts-mode whenever its grammar is available.
  (treesit-enabled-modes t)
  (treesit-auto-install-grammar 'ask)
  :config
  ;; Fallback sources for languages Emacs doesn't know a repo for.
  (dolist (src '((cmake "https://github.com/uyha/tree-sitter-cmake")
                 (elisp "https://github.com/Wilfred/tree-sitter-elisp")
                 (make "https://github.com/alemuller/tree-sitter-make")
                 (markdown "https://github.com/ikatyang/tree-sitter-markdown")
                 (toml "https://github.com/tree-sitter/tree-sitter-toml")
                 (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
    (unless (assq (car src) treesit-language-source-alist)
      (add-to-list 'treesit-language-source-alist src))))

(provide 'init-tree-sitter)
;;; init-tree-sitter.el ends here
