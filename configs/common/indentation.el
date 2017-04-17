;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

;; * START - configure indentation *
(setq-default indent-tabs-mode nil)
(setq-default tab-width current_indent)
(defvaralias 'c-basic-offset 'current_indent)
(defvaralias 'cperl-indent-level 'current_indent)
(defvaralias 'js-indent-level 'current_indent)
;; (setq web-mode-markup-indent-offset current_indent)
;; (setq web-mode-css-indent-offset current_indent)
;; (setq web-mode-code-indent-offset current_indent)
(defvaralias 'css-indent-offset 'current_indent)
;; * END *

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
