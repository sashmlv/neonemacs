;;; grep.el --- grep configuration
;;; Commentary:
;;; Code:

;; grep skip these list
(eval-after-load "grep"
  '(progn
     ;; (add-to-list 'grep-find-ignored-files "*.tmp")
     (add-to-list 'grep-find-ignored-directories ".git")
     (add-to-list 'grep-find-ignored-directories "log")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "bower_components")))

;;; grep.el ends here
