;;; slime.el --- slime configuration
;;; Commentary:
;;; Code:

(setq inferior-lisp-program "sbcl")
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-to-list 'slime-contribs 'inferior-slime)
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
(add-hook 'window-configuration-change-hook
          (lambda()
            (if (equal 'lisp-mode major-mode)
                (unless (slime-connected-p)
                  (slime)))))
(add-hook 'slime-connected-hook
          (lambda()
            (if (< 1 (length (window-list)))
                (delete-window (get-buffer-window)))))

;;; slime.el ends here
