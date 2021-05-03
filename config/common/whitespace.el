;;; whitespace.el --- whitespace configuration
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

(defun enable-whitespace ()
  (whitespace-mode t))

(add-hook 'prog-mode-hook #'enable-whitespace)
(add-hook 'org-mode-hook #'enable-whitespace)

;;; whitespace.el ends here
