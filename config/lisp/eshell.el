;;; eshell.el --- eshell configuration
;;; Commentary:
;;; Code:

(setq eshell-prompt-function
      (lambda nil
        (concat
         (eshell/pwd)
         " λ ")))

;;; eshell.el ends here
