;;; slime.el --- slime configuration
;;; Commentary:
;;; Code:

(setq inferior-lisp-program "sbcl")
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-to-list 'slime-contribs 'inferior-slime)
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; (add-hook 'slime-mode-hook
;;           (lambda ()
;;             (unless (slime-connected-p)
;;               (save-excursion (slime)))
;;             ))

;;; slime.el ends here
