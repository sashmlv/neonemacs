;;; yasnippet.el --- yasnippet configuration
;;; Commentary:
;;; Code:

(if (boundp 'yas-snippet-dirs) ;; at first, where our yasnippets are placed

    ;; if yas-snippet-dirs defined add our directories to begin of list
    (setq yas-snippet-dirs (append `(,yasnippets_common_directory) `(,yasnippets_directory) yas-snippet-dirs))

  ;; otherwise define with our directories
  (setq yas-snippet-dirs (append `(,yasnippets_common_directory) `(,yasnippets_directory))))

(yas-global-mode 1) ;; at second

;;; yasnippet.el ends here
