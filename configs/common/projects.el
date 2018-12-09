;;; projects --- project specific configuration:
;;; Commentary:
;;; Code:

;; common projects settings
(set-language-environment 'UTF-8)
(defun change_encoding( encoding )
  "Switch encoding."
  (prefer-coding-system encoding)
  (set-default-coding-systems encoding)
  (set-terminal-coding-system encoding)
  (set-keyboard-coding-system encoding))

;; project specific configuration ( uncomment for change )
;; (add-hook
;;  'buffer-list-update-hook
;;  (lambda()
;;    (change_encoding 'utf-8) ;; default utf-8 encoding
;;    ;; first project config
;;    (if (string-match-p "\/disk\/project\/directory\/" default-directory)
;;        (progn
;;          (change_encoding 'windows-1251))))) ;; windows-1251 encoding

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; projects.el ends here
