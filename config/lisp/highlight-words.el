;;; highlight-words.el --- highlight-words configuration
;;; Commentary:
;;; Code:

(defun highlight-words ()
  ;; "Highlight words in code"
  (font-lock-add-keywords
   nil
   '(("\\(TODO:?\\)"   1 '(:foreground "#FF5500") prepend)
     ("\\(NEXT:?\\)"   1 '(:foreground "#FF5500") prepend)
     ("\\(DONT:?\\)"   1 '(:foreground "#FF5500") prepend)
     ("\\(FIXME:?\\)"  1 '(:foreground "#FF5500") prepend)
     ("\\(FAIL:?\\)"   1 '(:foreground "#FF5500") prepend)
     ("\\(KEEP:?\\)"   1 '(:foreground "#FF5500") prepend)
     ("\\(NOTE:?\\)"   1 '(:foreground "#00FF55") prepend)
     ("\\(INFO:?\\)"   1 '(:foreground "#00FF55") prepend)
     ("\\(DONE:?\\)"   1 '(:foreground "#00FF55") prepend)
     ("\\(TEMP:?\\)"   1 '(:foreground "#0055FF") prepend)
     ("\\(HACK:?\\)"   1 '(:foreground "#0055FF") prepend))))

;;; highlight-words.el ends here
