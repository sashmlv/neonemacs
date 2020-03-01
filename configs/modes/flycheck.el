;;; flycheck --- flycheck configuration:
;;; Commentary:
;;; Code:

(add-hook 'after-init-hook #'global-flycheck-mode)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; flycheck.el ends here
