;;; drag-stuff --- drag-stuff configuration:
;;; Commentary:
;;; Code:

(drag-stuff-global-mode t)
(setq drag-stuff-modifier '(meta shift))
(drag-stuff-define-keys)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; drag-stuff.el ends here
