(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
             ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq package-selected-packages '(lsp-mode flycheck which-key))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(require 'lsp-mode)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp-deferred)
(add-hook 'c++-mode-hook 'lsp-deferred)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

(setq lsp-clients-clangd-args '("--all-scopes-completion"
  "--background-index"
  "--pch-storage=memory"
  "--log=info"
  "--enable-config"
  "--clang-tidy"
  "--completion-style=detailed"
  "--offset-encoding=utf-16"))
