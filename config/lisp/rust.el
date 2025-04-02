;;; rust.el --- rust configuration
;;; Commentary:
;;; Code:

;; (require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook #'company-mode)
;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;; (setq company-tooltip-align-annotations t)

;; tmp fix, remove me
;; (setq racer-rust-src-path
;;       (let* ((sysroot (string-trim
;;                        (shell-command-to-string "rustc --print sysroot")))
;;              (lib-path (concat sysroot "/lib/rustlib/src/rust/library"))
;;               (src-path (concat sysroot "/lib/rustlib/src/rust/src")))
;;         (or (when (file-exists-p lib-path) lib-path)
;;             (when (file-exists-p src-path) src-path))))

;;; rust.el ends here
