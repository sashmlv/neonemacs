;;; pomodoro-setup.el --- pomodoro-setup configuration
;;; Commentary:
;;; Code:

;; https://github.com/baudtack/pomodoro.el
(load-file
 (concat
  (if load-file-name
      (file-name-directory load-file-name)
    default-directory)
  "pomodoro.el"))

;; redefine function from library to customize fonts
(defun pomodoro-add-to-mode-line ()
  (setq-default mode-line-format (cons '((:propertize pomodoro-mode-line-string face (:foreground "tomato" :weight bold))) mode-line-format)))

(setq-default pomodoro-play-sounds nil)
(pomodoro-add-to-mode-line)

;;; pomodoro-setup.el ends here
