;;; hooks --- hooks configuration:
;;; Commentary:
;;; Code:

;; highlight indentation
(setq highlight-indent-guides-method 'character)

;; enable common modes
(add-hook 'prog-mode-hook
          (lambda()
            (subword-mode t)
            (highlight-indentation-mode t) ;; (highlight-indent-guides-mode 1)
            (highlight-symbol-mode t) ;; highlight occurrences
            (highlight-80-mode t) ;; highlight 80 column rule
            (rainbow-delimiters-mode) ;; rainbow parentheses
            ))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.\\(ts\\|tsx\\)\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))
(add-to-list 'auto-mode-alist '("\\.\\(jade\\|pug\\)\\'" . pug-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\.pl$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . perl-mode))

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

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; hooks.el ends here
