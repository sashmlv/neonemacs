;;; js2-mode --- js2-mode configuration:
;;; Commentary:
;;; Code:

;; change error highlight face
(custom-set-faces '(js2-error ((t (:foreground "coral")))))

;; turn off all warnings in js2-mode
(setq-default js2-mode-show-parse-errors t
      js2-mode-show-strict-warnings t
      js2-strict-missing-semi-warning t
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
;; x.map( val =>
;;        val
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
(setq-default js-switch-indent-offset current_indent)

;; Example:
;;   var o = {
;;       foo: 3
;;   },
;;       bar = 2;
(setq-default js-indent-first-init 'dynamic) ;; 'dynamic, nil, t

;; Example:
;; let x = svg.mumble()
;;            .chained;
(setq-default js-chain-indent 0)

;; Example:
;; function x(arg1,
;;            arg2,
;;            arg3)
(setq-default js-indent-align-list-continuation nil)

;; Fix variables indentation
;; From:
;;   let a = 1,
;;       b = 2,
;;       c = 3;
;; To:
;;   let a = 1,
;;     b = 2,
;;     c = 3;
(defconst fix_variables_indentation t)
(when fix_variables_indentation

  ;; Fix indentation for multiline variables names declarations
  ;; see emacs source - js.el, at end of function: js--multi-line-declaration-indentation
  ;; ( when returns value, rollback goto-char and return current-column with indentation )
  ;; Example:
  ;; let name_a = 1,
  ;;   name_b = 2,
  ;;   name_c = 3;
  (defun fix_var_name_indent (orig-fun &rest args)
    (when (apply orig-fun args)
      (goto-char (match-beginning 0))
      (+ (current-column) js-indent-level)))

  ;; init fix
  (advice-add #'js--multi-line-declaration-indentation :around #'fix_var_name_indent)
  ;; (advice-remove #'js--maybe-goto-declaration-keyword-end #'fix_var_name_indent)

  ;; Fix indentation at begining variable declaration
  ;; see emacs source - js.el, at part where 'dynamic and t conditions: js--maybe-goto-declaration-keyword-end
  ;; ( for 'dynamic and t value: replace function result into current-column with indentation )
  ;; Example:
  ;;     let a = {
  ;; -->     x: 1,
  ;; -->   },
  ;;       b = {
  ;;         y: 2,
  ;;       };
  (defun fix_var_indent_begining (orig-fun &rest args)
    (cond

     ;; 'dynamic
     ((eq js-indent-first-init 'dynamic)
      (apply 'dynamic_part_replacer_of_js--maybe-goto-declaration-keyword-end args))

     ;; t
     ((eq js-indent-first-init t)
      (when (looking-at js--declaration-keyword-re)
        (goto-char (1+ (+ (current-column) js-indent-level)))))

     ;; otherwise
     (t (apply orig-fun args))))

  ;; init fix
  (when (or (eq js-indent-first-init 'dynamic) (eq js-indent-first-init t))
    (advice-add #'js--maybe-goto-declaration-keyword-end :around #'fix_var_indent_begining))
  ;; (advice-remove #'js--maybe-goto-declaration-keyword-end #'fix_var_indent_begining)

  (defun dynamic_part_replacer_of_js--maybe-goto-declaration-keyword-end (parse-status)
    (let ((bracket (nth 1 parse-status))
          declaration-keyword-end
          at-closing-bracket-p
          forward-sexp-function ; Use Lisp version.
          comma-p)
      (when (looking-at js--declaration-keyword-re)
        (setq declaration-keyword-end (match-end 0))
        (save-excursion
          (goto-char bracket)
          (setq at-closing-bracket-p
                (condition-case nil
                    (progn
                      (forward-sexp)
                      t)
                  (error nil)))
          (when at-closing-bracket-p
            (while (forward-comment 1))
            (setq comma-p (looking-at-p ","))))
        (when comma-p
          (goto-char (1+ (+ (current-column) js-indent-level)))
          ))))
  )

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; js2-mode.el ends here
