;;; org.el --- org-mode configuration
;;; Commentary:
;;; Code:

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (shell . t)))
;; add additional languages with '((language . t)))

;;; org.el ends here
