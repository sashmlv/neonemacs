;;; whitespace --- whitespace configuration:
;;; Commentary:
;;; Code:

(setq whitespace-display-mappings
      '((space-mark ?\ [?\u00B7] [?.]) ;; (space-mark ? [?\u00B7])
        (newline-mark ?\n [?\u2039 ?\n]) ;; u21DA, u00AB, ¶, u21B5, u25C0
        (tab-mark ?\t [?\u203A ?\t]))) ;; u21DB, u00BB, u00BB

(setq whitespace-style
      '(face
        trailing
        tabs
        spaces
        newline
        space-mark
        tab-mark
        newline-mark))
(set-face-attribute 'whitespace-space nil
                    :background whitespace_space_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight)
(set-face-attribute 'whitespace-newline nil
                    :background whitespace_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight)
(set-face-attribute 'whitespace-tab nil
                    :background whitespace_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight)
(set-face-attribute 'whitespace-trailing nil
                    :background whitespace_space_background
                    :foreground whitespace_trailing_foreground
                    :weight whitespace_weight)
(setq whitespace-line nil) ;; disable highlight long lines
(setq whitespace-empty nil) ;; fix bug whith highlight last line
(global-whitespace-mode t)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; whitespace.el ends here
