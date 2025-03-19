;;; shell.el --- eshell configuration
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.env\\'" . shell-script-mode))

(setq eshell-prompt-function
      (lambda nil
        (concat
         (eshell/pwd)
         " λ ")))

;;; shell.el ends here
