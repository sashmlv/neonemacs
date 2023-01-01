;;; company.el --- company (autocompletition) configuration
;;; Commentary:
;;; Code:

(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay nil)
(setq company-dabbrev-downcase nil)
(setq company-dabbrev-code-ignore-case t)

(defun fix-prog-mode-company (&optional arg)
  (interactive)
  (or (yas-expand)
      (if (string-match-p "[^[:space:]\n]" (string (preceding-char)))
          (company-indent-or-complete-common arg)
        (indent-for-tab-command))))

;; (defun fix-restclient-mode-company (&optional arg)
;;   (interactive)
;;   (or (yas-expand)
;;       (if (string-match-p "[^[:space:]\n]" (string (preceding-char)))
;;           (company-indent-or-complete-common arg)
;;         (restclient-toggle-body-visibility-or-indent))))
;; (with-eval-after-load 'company (add-to-list 'company-backends 'company-restclient))

(define-key prog-mode-map (kbd "<M-tab>") #'company-complete)
(define-key prog-mode-map (kbd "<tab>") #'fix-prog-mode-company)
;; (with-eval-after-load 'restclient (define-key restclient-mode-map (kbd "<tab>") #'fix-restclient-mode-company))

;;; company.el ends here
