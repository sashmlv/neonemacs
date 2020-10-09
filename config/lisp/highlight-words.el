;;; highlight-words.el --- highlight-words configuration
;;; Commentary:
;;; Code:

(defun highlight-words ()
  ;; "Highlight words in code"
  (font-lock-add-keywords
   nil
   '(("\\(TODO:?\\)"  1 '(:foreground "#FF5500" :background "#151515") prepend)
     ("\\(NOTE:?\\)"  1 '(:foreground "#00FF55" :background "#151515") prepend)
     ("\\(TEMP:?\\)"  1 '(:foreground "#0055FF" :background "#151515") prepend))))

;;; highlight-words.el ends here
