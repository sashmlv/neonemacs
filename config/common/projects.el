;;; projects.el --- project specific configuration
;;; Commentary:
;;; Code:

;; common projects settings
(set-language-environment 'UTF-8)
(defun neon-change-encoding( encoding )
  "Switch encoding."
  (prefer-coding-system encoding)
  (set-default-coding-systems encoding)
  (set-terminal-coding-system encoding)
  (set-keyboard-coding-system encoding))

;; set/reset indentation
(defun neon-set-indentation( indent )
  "Set indentation."
  (setq neon-indent indent)
  (setq-default js-indent-level indent)
  (setq-default css-indent-offset indent)
  (setq-default web-mode-markup-indent-offset indent)
  (setq-default web-mode-css-indent-offset indent)
  (setq-default web-mode-code-indent-offset indent))

;; ;; project specific configuration ( uncomment for changes )
;; (add-hook
;;  'buffer-list-update-hook
;;  (lambda()
;;    (neon-change-encoding 'utf-8) ;; default utf-8 encoding
;;    ;; first project config
;;    (if (string-match-p "\/disk\/project\/directory\/" default-directory)
;;        (progn
;;          (neon-change-encoding 'windows-1251)
;;          (neon-set-indentation 3)
;;          ))))

;;; projects.el ends here
