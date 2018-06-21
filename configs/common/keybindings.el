;;; keybindings-setup --- keybindings configuration:
;;; Commentary:
;;; Code:

;; * Change bracket pairs from one type to another on current line or text selection *
(global-set-key (kbd "C-c `") (lambda()
                                (interactive)
                                (setq from (read-string "Enter replacement:"))
                                (setq to (read-string "Enter new value:"))
                                (xah-change-bracket-pairs from to)
                                )
                )

;; * Disable overwrite-mode with Insert key on keyboard *
(define-key global-map [(insert)] nil)
(define-key global-map [(control insert)] 'overwrite-mode)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; keybindings-setup.el ends here
