;;; hooks --- hooks configuration:
;;; Commentary:
;;; Code:

;; Highlight indentation hook setup
(highlight-indentation-mode 1) ;; for disable error
(add-hook 'highlight-indentation-mode-hook (lambda()(setq highlight-indentation-offset current_indent))) ;; set indent size ;; "current_indent" in index.el
(set-face-background 'highlight-indentation-face indentation_color) ;; "indentation-color" in index.el
(set-face-background 'highlight-indentation-current-column-face indentation_current_line_color) ;; "indentation-current-line-color" in index.el

;; enable common modes
(add-hook
 'prog-mode-hook
 (lambda()
   (highlight-indentation-mode 1) ;; highlight indent on each buffer
   (syntax-subword-mode 1) ;; make word editing and motion more fine-grained
   (highlight-symbol-mode 1) ;; highlight occurrences
   )
 )

;; js2-mode on js files
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; rjsx-mode on jsx files
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

;; typescript-mode on ts files
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

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

;; html-mode on html files
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))

;; dockerfile-mode on Dockerfile
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; hooks.el ends here
