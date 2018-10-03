;;; hooks --- hooks configuration:
;;; Commentary:
;;; Code:

;; Highlight indentation setup
(setq highlight-indent-guides-method 'character)

;; enable common modes
(add-hook
 'prog-mode-hook
 (lambda()
   (highlight-indent-guides-mode 1) ;; highlight indent in each buffer
   (syntax-subword-mode 1) ;; make word editing and motion more fine-grained
   (highlight-symbol-mode 1) ;; highlight occurrences
   )
 )

;; js2-mode on js files
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; js2-refactor-mode on js2-mode
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;; rjsx-mode on jsx files
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

;; typescript-mode on ts files
(add-to-list 'auto-mode-alist '("\\.\\(ts\\|tsx\\)\\'" . typescript-mode))

;; less-css-mode on less files
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))
;; highlight colors
(add-hook 'less-css-mode-hook 'xah-syntax-color-hex)
(add-hook 'css-mode-hook 'xah-syntax-color-hex)

;; pug-mode on pug files
(add-to-list 'auto-mode-alist '("\\.\\(jade\\|pug\\)\\'" . pug-mode))

;; yaml-mode on yml files
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;; enable highlight-indentation on yml mode
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)

;; json-mode on json files
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

;; php-mode on php files
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; php-mode indentation fix
(add-hook 'php-mode-hook (lambda() (progn
                                     (setq indent-tabs-mode nil)
                                     (setq c-basic-offset current_indent) ;; "current_indent" in index.el
                                     )))

;; dockerfile-mode on Dockerfile
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; hooks.el ends here
