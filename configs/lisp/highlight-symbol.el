;;; highlight-symbol.el --- highlight-symbol configuration
;;; Commentary:
;;; Code:

(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 1)
(set-face-attribute
 'highlight-symbol-face nil
 :background "#000000"
 :underline `(:color ,hl_occurrences_color))
;; (set-face-attribute 'highlight-symbol-face nil :background hl_occurrences_color :underline nil )
;; (set-face-attribute 'highlight-symbol-face nil :background nil :box `(:line-width -1 :color ,hl_occurrences_color ))

;;; highlight-symbol.el ends here
