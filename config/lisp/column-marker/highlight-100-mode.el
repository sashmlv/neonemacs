;;; highlight-100-mode.el --- highlight-100-mode configuration
;;; Commentary:
;;; Code:

;; load column-marker from same directory
(load-file
 (concat
  (if load-file-name
      (file-name-directory load-file-name)
    default-directory)
  "column-marker.el"))

(define-minor-mode highlight-100-mode
  "Toggle highlight-100-mode."
  :init-value nil
  :lighter " Highlight-100"
  (if highlight-100-mode
      (column-marker-1 100)
    (column-marker-1 -1)))

;; highlight styles
(set-face-attribute 'column-marker-1 nil
                    :background "#373737"
                    :foreground nil)

;;; highlight-100-mode.el ends here
