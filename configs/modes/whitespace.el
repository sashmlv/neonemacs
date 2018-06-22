;;; whitespace --- whitespace configuration:
;;; Commentary:
;;; Code:

;; Whitespace mode
(require 'whitespace)
(setq whitespace-display-mappings
      '(
        (space-mark ?\ [?\u00B7] [?.]) ;; (space-mark ? [?\u00B7])
        (newline-mark ?\n [?\u2039 ?\n]) ;; u21DA, u00AB, ¶, u21B5, u25C0
        (tab-mark ?\t [?\u203A ?\t]) ;; u21DB, u00BB, u00BB
        ))
(setq whitespace-style '(face trailing tabs spaces newline space-mark tab-mark newline-mark))
(set-face-attribute 'whitespace-space nil
                    :background whitespace_background ;; "whitespace_background" in index.el
                    :foreground whitespace_foreground ;; "whitespace_foreground" in index.el
                    :weight whitespace_weight) ;; ultra-bold, extra-bold, bold, semi-bold, normal, semi-light, light, extra-light, ultra-light
(set-face-attribute 'whitespace-newline nil
                    :background whitespace_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight) ;; "whitespace_weight" in index.el
(set-face-attribute 'whitespace-tab nil
                    :background whitespace_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight)
(set-face-attribute 'whitespace-trailing nil
                    :background whitespace_trailing_background ;; "whitespace_trailing_background" in index.el
                    :foreground whitespace_trailing_foreground ;; "whitespace_trailing_foreground" in index.el
                    :weight whitespace_trailing_weight) ;; "whitespace_trailing_weight" in index.el
(setq whitespace-line nil) ;; disable a bug, that highlight long lines
(setq whitespace-empty nil) ;; disable a bug, that highlight last line
(global-whitespace-mode 1)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; whitespace.el ends here
