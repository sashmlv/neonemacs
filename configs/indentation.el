;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

;; * START - Disable tabs, set indentation *
(setq-default indent-tabs-mode nil)
(setq-default tab-width space-indent)

(defvaralias 'c-basic-offset 'space-indent)
(defvaralias 'cperl-indent-level 'space-indent)

(defvaralias 'php-mode-force-pear 'space-indent)

(defvaralias 'js-indent-level 'space-indent)

(defvaralias 'web-mode-markup-indent-offset 'space-indent)

(defvaralias 'web-mode-css-indent-offset  'space-indent)

(defvaralias 'web-mode-code-indent-offset 'space-indent)

(defvaralias 'css-indent-offset 'space-indent)



;; * END *

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
