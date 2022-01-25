;;; js-typescript.el --- js-typescript configuration
;;; Commentary:
;;; Code:

;; change error highlight face
(custom-set-faces '(js2-error ((t (:foreground "coral")))))

;; warnings in js2-mode
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
(setq-default js-switch-indent-offset neon-indent)

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
(defconst neon-fix-variables-indentation t)
(when neon-fix-variables-indentation

  ;; Fix indentation for multiline variables names declarations
  ;; see emacs source - js.el, at end of function: js--multi-line-declaration-indentation
  ;; ( when returns value, rollback goto-char and return current-column with indentation )
  ;; Example:
  ;; let name_a = 1,
  ;;   name_b = 2,
  ;;   name_c = 3;
  (defun neon-fix-var-name-indent (orig-fun &rest args)
    (when (apply orig-fun args)
      (goto-char (match-beginning 0))
      (+ (current-column) js-indent-level)))

  ;; init fix
  (advice-add #'js--multi-line-declaration-indentation :around #'neon-fix-var-name-indent)
  ;; (advice-remove #'js--maybe-goto-declaration-keyword-end #'neon-fix-var-name-indent)

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
  (defun neon-fix-var-indent-begining (orig-fun &rest args)
    (cond

     ;; 'dynamic
     ((eq js-indent-first-init 'dynamic)
      (apply 'neon-dynamic-part-replacer-of-js--maybe-goto-declaration-keyword-end args))

     ;; t
     ((eq js-indent-first-init t)
      (when (looking-at js--declaration-keyword-re)
        (goto-char (1+ (+ (current-column) js-indent-level)))))

     ;; otherwise
     (t (apply orig-fun args))))

  ;; init fix
  (when (or (eq js-indent-first-init 'dynamic) (eq js-indent-first-init t))
    (advice-add #'js--maybe-goto-declaration-keyword-end :around #'neon-fix-var-indent-begining))
  ;; (advice-remove #'js--maybe-goto-declaration-keyword-end #'neon-fix-var-indent-begining)

  (defun neon-dynamic-part-replacer-of-js--maybe-goto-declaration-keyword-end (parse-status)
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

;; JS2-MODE
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . js2-mode))
;; (add-hook 'js2-mode-hook #'js2-refactor-mode)
;; (add-to-list 'auto-mode-alist '("\\.\\(ts\\|tsx\\)\\'" . typescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
;; JS2-MODE

;; JS-MODE
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . js-mode))
;; (add-to-list 'auto-mode-alist '("\\.\\(ts\\|tsx\\)\\'" . typescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-mode))
;; (add-hook 'js2-mode-hook #'js2-refactor-mode)
;; (add-hook 'js-mode-hook 'js2-minor-mode)
;; JS-MODE

;; ;; TIDE
;; ;; JavaScript, TypeScript
;; (require 'tide)
;; (require 'flycheck)
;; (require 'web-mode)

;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . js2-mode))
;; ;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
;; (add-hook 'js2-mode-hook #'js2-refactor-mode)
;; (js2r-add-keybindings-with-prefix "C-c C-m")

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   ;; company is an optional dependency. You have to
;;   ;; install it separately via package-install
;;   ;; `M-x package-install [ret] company`
;;   (company-mode +1))

;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; ;; always show documentation for the symbol at point
;; (setq tide-always-show-documentation t)

;; ;; JavaScript
;; (add-hook 'js2-mode-hook #'setup-tide-mode)
;; ;; configure javascript-tide checker to run after your default javascript checker
;; (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

;; ;; JSX
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "jsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))
;; ;; configure jsx-tide checker to run after your default jsx checker
;; (flycheck-add-mode 'javascript-eslint 'web-mode)
;; (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

;; ;; TypeScript
;; ;; formats the buffer before saving
;; ;; (add-hook 'before-save-hook 'tide-format-before-save)
;; (add-hook 'typescript-mode-hook #'setup-tide-mode)

;; ;; TSX
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))

;; ;; enable typescript-tslint checker
;; (flycheck-add-mode 'typescript-tslint 'web-mode)
;; ;; TIDE

;; LSP mode, DAP mode
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . typescript-mode))
(setq lsp-keymap-prefix "C-z")
(add-hook 'typescript-mode-hook #'lsp-deferred)
;; (add-hook 'js2-mode-hook #'lsp-deferred)
(setq flycheck-checker 'lsp)
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-completion-provider :none)
(setq gc-cons-threshold 100000000) ;; 100mb
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)
(setq lsp-log-io nil)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-completion-provider nil)
(setq lsp-enable-on-type-formatting nil)
(setq lsp-enable-indentation nil)
;; LSP mode, DAP mode

;; EGLOT
;; (require 'eglot)
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.\\(js\\|mjs\\|cjs\\)\\'" . js2-mode))
;; (add-to-list 'eglot-server-programs '((typescript-mode js2-mode) "typescript-language-server" "--stdio"))
;; (add-hook 'typescript-mode-hook 'eglot-ensure)
;; (add-hook 'js2-mode-hook 'eglot-ensure)
;; (with-eval-after-load 'eglot
;;   (set-face-attribute 'eglot-highlight-symbol-face nil :inherit nil))
;; EGLOT

;;; js-typescript.el ends here
