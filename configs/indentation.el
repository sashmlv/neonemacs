;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

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

;; * Highlight-indentation *
(highlight-indentation-mode 1)
(set-face-background 'highlight-indentation-face "#101010")
(set-face-background 'highlight-indentation-current-column-face "#101010")

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
