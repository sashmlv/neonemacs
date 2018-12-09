;;; company --- company configuration:
;;; Commentary:
;;; Code:

;; autocompletition
(add-hook 'after-init-hook 'global-company-mode)
(company-statistics-mode)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; company.el ends here
