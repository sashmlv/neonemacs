;;; highlight-symbol --- highlight-symbol configuration:
;;; Commentary:
;;; Code:

;; highlight-symbol
(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 1)
;; redefine highlight face attributes
(set-face-attribute 'highlight-symbol-face nil :background background_color :underline `(:color ,hl_occurrences_color))
;; (set-face-attribute 'highlight-symbol-face nil :background hl_occurrences_color :underline nil )
;; (set-face-attribute 'highlight-symbol-face nil :background nil :box `(:line-width -1 :color ,hl_occurrences_color ))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; highlight-symbol.el ends here
