;;; hooks --- hooks configuration:
;;; Commentary:
;;; Code:

;; * START - Highlight indentation hook *
(add-hook 'prog-mode-hook 'highlight-indentation-mode)
(set-face-background 'highlight-indentation-face indentation-color) ;; param in index.el
(set-face-background 'highlight-indentation-current-column-face indentation-current-line-color) ;; param in index.el
;; * END *

;; js2-mode on js files
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; hooks.el ends here
