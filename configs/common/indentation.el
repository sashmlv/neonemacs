;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

(setq-default indent-tabs-mode nil)
(setq-default tab-width current_indent)
(setq c-basic-offset current_indent)
(setq cperl-indent-level current_indent)
(setq js-indent-level current_indent)
(setq css-indent-offset current_indent)

;; yaml-mode indentation
(setq yaml-indent-offset current_indent)

;; typescript indentation mode
(setq typescript-indent-level current_indent)

;; html-mode indentation https://www.emacswiki.org/emacs/IndentingHtml
(setq sgml-basic-offset current_indent)
(add-hook 'html-mode-hook (lambda () (set (make-local-variable 'sgml-basic-offset) current_indent)))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
