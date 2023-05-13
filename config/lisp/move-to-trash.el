;;; move-to-trash.el --- move-to-trash config
;;; Commentary:
;;; Code:

(setq delete-by-moving-to-trash t)
(defun system-move-file-to-trash (filename)
  "Use \"gio trash\" to move FILE to the system trash. Install \"gio\" for using it."
  (call-process (executable-find "gio") nil 0 nil "trash" filename))

;;; move-to-trash.el ends here
