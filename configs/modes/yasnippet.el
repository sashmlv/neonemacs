;;; yasnippet --- yasnippet configuration:
;;; Commentary:
;;; Code:

(if (boundp 'yas-snippet-dirs) ;; at first, where our yasnippets are placed

    ;; if yas-snippet-dirs defined add our directories to begin of list
    (setq yas-snippet-dirs (append `(,yasnippets_common_directory) `(,yasnippets_directory) yas-snippet-dirs))

  ;; otherwise define with our directories
  (setq yas-snippet-dirs (append `(,yasnippets_common_directory) `(,yasnippets_directory))))

(yas-global-mode 1) ;; at second

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; yasnippet.el ends here
