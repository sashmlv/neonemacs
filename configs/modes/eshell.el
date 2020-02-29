;;; eshell --- eshell configuration:
;;; Commentary:
;;; Code:

(setq eshell-prompt-function
      (lambda nil
        (concat
         (eshell/pwd)
         " λ ")))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; eshell.el ends here

