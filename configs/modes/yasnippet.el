;;; yasnippet --- yasnippet configuration:
;;; Commentary:
;;; Code:

;; yasnippet
(if (boundp 'yas-snippet-dirs) ;; first, set where our yasnippets are placed
    (setq yas-snippet-dirs (append `(,yasnippets_directory) yas-snippet-dirs)) ;; if yas-snippet-dirs defined add our directories to begin of list
  (setq yas-snippet-dirs `(,yasnippets_directory))) ;; otherwise define yas-snippet-dirs with our directories
(yas-global-mode 1) ;; second

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; yasnippet.el ends here
