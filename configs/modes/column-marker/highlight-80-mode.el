;;; highlight-80-mode --- highlight-80-mode configuration:
;;; Commentary:
;;; Code:

;; load library from same directory
(load-file (concat (if load-file-name (file-name-directory load-file-name) default-directory) "column-marker.el"))

(define-minor-mode highlight-80-mode
 "Toggle highlight-80-mode."
 :init-value nil
 :lighter " Highlight-80"
 (if highlight-80-mode
     (column-marker-1 80)
   (column-marker-1 -1))
 )

;; highlight 80 column styles
(set-face-attribute 'column-marker-1 nil :background "#333" :foreground nil)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; highlight-80-mode.el ends here



