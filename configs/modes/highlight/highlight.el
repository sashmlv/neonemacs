;;; highlight --- highlight configuration:
;;; Commentary:
;;; Code:

;; for easy-highlight.el library
;; load easy-highlight.el from same directory
(load-file
 (concat
  (if load-file-name
      (file-name-directory load-file-name)
    default-directory)
  "easy-highlight.el"))

(global-font-lock-mode t)
(setq easy-highlight:face-list '("match"))

;; for highlight.el library
;; (hlt-choose-default-face 'column-marker-3)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; highlight.el ends here
