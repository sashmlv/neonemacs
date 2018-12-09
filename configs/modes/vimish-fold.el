;;; vimish-fold --- vimish-fold configuration:
;;; Commentary:
;;; Code:

(global-set-key (kbd "C-c f") #'vimish-fold)
(global-set-key (kbd "C-c u") #'vimish-fold-delete)
(vimish-fold-global-mode 1)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; vimish-fold.el ends here
