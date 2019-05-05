;;; highlight-symbol --- highlight-symbol configuration:
;;; Commentary:
;;; Code:

(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 1)
(set-face-attribute
 'highlight-symbol-face nil
 :background background_color
 :underline `(:color ,hl_occurrences_color))
;; (set-face-attribute 'highlight-symbol-face nil :background hl_occurrences_color :underline nil )
;; (set-face-attribute 'highlight-symbol-face nil :background nil :box `(:line-width -1 :color ,hl_occurrences_color ))

;; navigate through occurrences
(global-set-key (kbd "M-}") 'highlight-symbol-next)
(global-set-key (kbd "M-{") 'highlight-symbol-prev)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; highlight-symbol.el ends here
