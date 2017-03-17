;;; hooks --- hooks configuration:
;;; Commentary:
;;; Code:

;; * START - Highlight indentation hook *
(add-hook 'highlight-indentation-mode-hook (lambda()(setq highlight-indentation-offset space-indent))) ;; set indent size ;; "space-indent" param in index.el
(add-hook 'prog-mode-hook 'highlight-indentation-mode) ;; highlight indent on each buffer
(set-face-background 'highlight-indentation-face indentation-color) ;; "indentation-color" param in index.el
(set-face-background 'highlight-indentation-current-column-face indentation-current-line-color) ;; "indentation-current-line-color" param in index.el
;; * END *

;; js2-mode on js files
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; less-css-mode on less files
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

;; pug-mode on pug files
(add-to-list 'auto-mode-alist '("\\.\\(jade\\|pug\\)\\'" . pug-mode))



;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; hooks.el ends here
