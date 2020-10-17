;;; hooks.el --- hooks
;;; Commentary:
;;; Code:

;; highlight indentation
(setq highlight-indent-guides-method 'character)

;; enable common modes
(add-hook 'prog-mode-hook
          (lambda()
            (syntax-subword-mode t)
            (smartscan-mode t)
            (highlight-indentation-mode t) ;; (highlight-indent-guides-mode t)
            (highlight-symbol-mode t) ;; highlight occurrences
            (highlight-100-mode t) ;; highlight 100 column rule
            (rainbow-delimiters-mode t) ;; rainbow parentheses
            (highlight-words)
            ))

(add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . js2-mode))
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-to-list 'auto-mode-alist '("\\.\\(ts\\|tsx\\)\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . svelte-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))
(add-to-list 'auto-mode-alist '("\\.\\(jade\\|pug\\)\\'" . pug-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\.pl$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.rest$" . restclient-mode))

;; highlight colors
(add-hook 'less-css-mode-hook 'xah-syntax-color-hex)
(add-hook 'css-mode-hook 'xah-syntax-color-hex)

;; enable highlight-indentation on yml mode
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)

;; php-mode indentation fix
(add-hook 'php-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)
            (setq c-basic-offset current_indent)))

;;; hooks.el ends here
