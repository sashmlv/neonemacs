;;; js2-mode --- js2-mode configuration:
;;; Commentary:
;;; Code:

;; change error highlight face
(custom-set-faces '(js2-error ((t (:foreground "coral")))))

;; turn off all warnings in js2-mode
(setq js2-mode-show-parse-errors t
      js2-mode-show-strict-warnings nil
      js2-strict-missing-semi-warning nil
      js2-strict-trailing-comma-warning nil)

;; Example:
;; {
;;    x: 123
;; }
(setq js-curly-indent-offset 0)

;; Example:
;; func()
;;   .then()
;;   .catch()
(setq js-expr-indent-offset 0)
;; (setq js-expr-indent-offset (- js-indent-level))

;; Example:
;; x.map( very =>
;;        very
;;      )
(setq js-indent-align-list-continuation t)

;; Example:
;; if(
;;      true
;;   )
(setq js-paren-indent-offset 0)

;; Example:
;; var x = [
;;    true
;; ];
(setq js-square-indent-offset 0)

;; Example:
;; switch (true) {
;; case variable:
(setq js-switch-indent-offset 10)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; js2-mode.el ends here
