;;; slime.el --- slime configuration
;;; Commentary:
;;; Code:

(setq inferior-lisp-program "sbcl")
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-hook 'slime-mode-hook (lambda ()
                             (unless (slime-connected-p)
                               (save-excursion (slime)))))
(slime-setup '(slime-fancy slime-company))

;;; slime.el ends here
