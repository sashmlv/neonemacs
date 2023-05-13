;;; ascii.el --- ascii
;;; Commentary:
;;; Code:

(defun neon-is-ascii-text()
  "Check is ascii text."
  (interactive)
  (if (string-match-p
       "^[[:ascii:]]+$"
       (if (region-active-p)
           (buffer-substring (region-beginning) (region-end))
         (thing-at-point 'symbol)))
      (message "ASCII")
    (message "NOT ASCII")))

(defun neon-has-ascii-text()
  "Check is text has ascii."
  (interactive)
  (if (string-match-p
       "[[:ascii:]]+"
       (if (region-active-p)
           (buffer-substring (region-beginning) (region-end))
         (thing-at-point 'symbol)))
      (message "HAS ASCII")
    (message "HAS NOT ASCII")))

;;; ascii.el ends here
