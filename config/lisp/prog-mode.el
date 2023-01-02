;;; prog-mode.el --- prog-mode configuration
;;; Commentary:
;;; Code:

;; enable common modes
(add-hook 'prog-mode-hook
          (lambda()
            (syntax-subword-mode t)
            ;;(smartscan-mode t)
            (highlight-indentation-mode t) ;; (highlight-indent-guides-mode t)
            (highlight-symbol-mode t) ;; highlight occurrences
            (highlight-100-mode t) ;; highlight 100 column rule
            (rainbow-delimiters-mode t) ;; rainbow parentheses
            (highlight-words)
            ))

;;; prog-mode.el ends here