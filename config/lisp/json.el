;;; json.el --- json configuration
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

(add-hook 'json-mode-hook 'flycheck-mode)

;;; json.el ends here
