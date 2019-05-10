;;; drag-stuff --- drag-stuff configuration:
;;; Commentary:
;;; Code:

(drag-stuff-global-mode t)
(setq drag-stuff-modifier '(meta shift))
(drag-stuff-define-keys)
(global-set-key (kbd "M-P") 'drag-stuff-up)
(global-set-key (kbd "M-N") 'drag-stuff-down)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; drag-stuff.el ends here
