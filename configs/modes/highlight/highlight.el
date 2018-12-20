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

(defface easy-highlight-face-r
  '((t :foreground "white"
       :background "#ad1457"
       :weight bold
       :underline t
       ))
  "Face for easy-highlight."
  :group 'easy-highlight-face )

(defface easy-highlight-face-g
  '((t :foreground "white"
       :background "#2e7d32"
       :weight bold
       :underline t
       ))
  "Face for easy-highlight."
  :group 'easy-highlight-face )

(defface easy-highlight-face-b
  '((t :foreground "white"
       :background "#1565c0"
       :weight bold
       :underline t
       ))
  "Face for easy-highlight."
  :group 'easy-highlight-face )

(global-font-lock-mode t)

(setq easy-highlight:face-list '("easy-highlight-face-r" "easy-highlight-face-g" "easy-highlight-face-b"))

;; for highlight.el library
;; (hlt-choose-default-face 'column-marker-3)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; highlight.el ends here
