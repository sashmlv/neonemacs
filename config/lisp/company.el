;;; company.el --- company (autocompletition) configuration
;;; Commentary:
;;; Code:

(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay nil)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-code-ignore-case t)

(defun yas-expand-or-company-complete (&optional arg)
  "yas or complete"
  (interactive)
  (or (yas-expand) (company-indent-or-complete-common arg)))

(define-key prog-mode-map (kbd "<tab>") #'yas-expand-or-company-complete)

;;; company.el ends here
