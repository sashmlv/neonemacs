;;; yasnippet.el --- yasnippet configuration
;;; Commentary:
;;; Code:

(if (boundp 'yas-snippet-dirs) ;; at first, where our yasnippets are placed

    ;; if yas-snippet-dirs defined add our directories to begin of list
    (setq yas-snippet-dirs (append `(,neon-yasnippet-common-dir) `(,neon-yasnippet-dir) yas-snippet-dirs))

  ;; otherwise define with our directories
  (setq yas-snippet-dirs (append `(,neon-yasnippet-common-dir) `(,neon-yasnippet-dir))))

;; (add-hook 'prog-mode-hook #'yas-minor-mode)
(yas-global-mode 1)
;;; yasnippet.el ends here
