;;; org-mode --- org-mode configuration:
;;; Commentary:
;;; Code:

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))
;; add additional languages with '((language . t)))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; org.el ends here
