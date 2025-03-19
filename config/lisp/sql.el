;;; sql.el --- sql configuration
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.sql$" . sql-mode))
(add-hook 'sql-mode-hook
          (lambda ()
            (sqlind-minor-mode t)
            (whitespace-mode t)))

;;; sql.el ends here
