;;; js2-refactor --- js2-refactor configuration:
;;; Commentary:
;;; Code:

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; js2-refactor.el ends here
