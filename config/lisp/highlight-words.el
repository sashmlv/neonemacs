;;; hl-todo.el --- hl-todo configuration
;;; Commentary:
;;; Code:

(defun highlight-words ()
  ;; "Highlight words in code"
  (font-lock-add-keywords
   nil
   '(("\\(TODO:\\)"  1 '(:foreground "#FF5500") prepend)
     ("\\(NOTE:\\)"  1 '(:foreground "#00FF55") prepend)
     ("\\(TEMP:\\)"  1 '(:foreground "#0055FF") prepend)
   )))

;;; hl-todo.el ends here
