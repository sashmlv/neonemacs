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

;; redefine function from library to customize fonts
(defun pomodoro-add-to-mode-line ()
  (setq-default mode-line-format (cons '((:propertize pomodoro-mode-line-string face (:foreground "tomato" :weight bold))) mode-line-format)))

(pomodoro-add-to-mode-line)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; pomodoro-setup.el ends here
