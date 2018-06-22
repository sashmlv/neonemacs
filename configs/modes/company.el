;;; company --- company configuration:
;;; Commentary:
;;; Code:

;; company mode [ autocomplete ]
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-statistics)
(company-statistics-mode)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; company.el ends here
