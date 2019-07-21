;;; pomodoro-setup --- pomodoro-setup configuration:
;;; Commentary:
;;; Code:

;; load column-marker from same directory
(load-file
 (concat
  (if load-file-name
      (file-name-directory load-file-name)
    default-directory)
  "pomodoro.el"))
  ;; "tomatohead.el"))

(pomodoro-add-to-mode-line)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; pomodoro-setup.el ends here
