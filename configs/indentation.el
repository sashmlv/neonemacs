;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

;; * START - Disable tabs, set indentation *
(setq-default indent-tabs-mode nil)
(setq-default tab-width current_indent)

(defvaralias 'c-basic-offset 'current_indent)
(defvaralias 'cperl-indent-level 'current_indent)

(defvaralias 'php-mode-force-pear 'current_indent)

(defvaralias 'js-indent-level 'current_indent)

(defvaralias 'web-mode-markup-indent-offset 'current_indent)

(defvaralias 'web-mode-css-indent-offset  'current_indent)

(defvaralias 'web-mode-code-indent-offset 'current_indent)

(defvaralias 'css-indent-offset 'current_indent)



;; * END *

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
