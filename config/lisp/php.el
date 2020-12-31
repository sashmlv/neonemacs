;;; php.el --- php configuration
;;; Commentary:
;;; Code:

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;; php-mode indentation fix
(add-hook 'php-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)
            (setq c-basic-offset current_indent)))

;;; php.el ends here
