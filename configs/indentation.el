;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

;; * START - Highlight indentation on load *
(add-hook 'prog-mode-hook 'highlight-indentation-mode)
(set-face-background 'highlight-indentation-face indentation-color) ;; param in index.el
(set-face-background 'highlight-indentation-current-column-face indentation-current-line-color) ;; param in index.el
;; * END *

;; * START - Disable tabs, set indentation *
(setq-default indent-tabs-mode nil)
(setq tab-width indent)

(setq c-basic-offset indent)

(setq php-mode-force-pear indent)

(setq js-indent-level indent)

(setq web-mode-markup-indent-offset indent)
(setq web-mode-css-indent-offset indent)
(setq web-mode-code-indent-offset indent)

(setq css-indent-offset indent)
;; * END *

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
