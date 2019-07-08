;;; smex --- smex configuration:
;;; Commentary:
;;; Code:

;; M-x enhancement
(smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; smex.el ends here
