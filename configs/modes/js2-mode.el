;;; js2-mode --- js2-mode configuration:
;;; Commentary:
;;; Code:

;; change error highlight face
(custom-set-faces '(js2-error ((t (:foreground "coral")))))

;; turn off all warnings in js2-mode
(setq-default js2-mode-show-parse-errors t
      js2-mode-show-strict-warnings nil
      js2-strict-missing-semi-warning nil
      js2-strict-trailing-comma-warning nil)

;; Example:
;; {
;;    x: 123
;; }
(setq-default js-curly-indent-offset 0)

;; Example:
;; func()
;;   .then()
;;   .catch()
(setq-default js-expr-indent-offset 0)
;; (setq-default js-expr-indent-offset (- js-indent-level))

;; Example:
;; x.map( very =>
;;        very
;;      )
(setq-default js-indent-align-list-continuation t)

;; Example:
;; if(
;;      true
;;   )
(setq-default js-paren-indent-offset 0)

;; Example:
;; var x = [
;;    true
;; ];
(setq-default js-square-indent-offset 0)

;; Example:
;; switch (true) {
;; case variable:
(setq-default js-switch-indent-offset 0)

;; Example:
;;   var o = {
;;       foo: 3
;;   },
;;       bar = 2;
(setq-default js-indent-first-init nil) ;; 'dynamic, nil, t

;; Example:
;; let x = svg.mumble()
;;            .chained;
(setq-default js-chain-indent 0)

;; Example:
;; function x(arg1,
;;            arg2,
;;            arg3)
(setq-default js-indent-align-list-continuation nil)

;; Fix indentation for multiline variable declaration
;; see emacs source - js.el, at end of function: js--multi-line-declaration-indentation
;; ( when returns value, rollback goto-char and return current-column with indentation )
(defun fix_vars_indent (orig-fun &rest args)
  (when (apply orig-fun args)
    (goto-char (match-beginning 0))
    (+ (current-column) js-indent-level)))

(advice-add #'js--multi-line-declaration-indentation :around #'fix_vars_indent)
;; for disable fix run this:
;; (advice-remove #'js--multi-line-declaration-indentation #'fix_vars_indent)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; js2-mode.el ends here
