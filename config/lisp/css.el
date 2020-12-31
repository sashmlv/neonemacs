;;; css.el --- css configuration
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

;; highlight colors
(add-hook 'less-css-mode-hook 'xah-syntax-color-hex)
(add-hook 'css-mode-hook 'xah-syntax-color-hex)

;;; css.el ends here
