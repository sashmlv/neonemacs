;;; whitespace.el --- whitespace configuration
;;; Commentary:
;;; Code:

(require 'whitespace)
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

(setq whitespace-line nil) ;; disable highlight long lines
(setq whitespace-empty nil) ;; fix bug whith highlight last line
(global-whitespace-mode t)

;;; whitespace.el ends here
