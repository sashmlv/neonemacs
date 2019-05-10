;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

;; highlight indentation hook
(highlight-indentation-mode 1) ;; disable error

(setq indent-tabs-mode nil)
(setq tab-width current_indent)
(setq c-basic-offset current_indent)
(setq js-indent-level current_indent)
(setq css-indent-offset current_indent)
(setq typescript-indent-level current_indent)
(setq rust-indent-offset current_indent)
(setq yaml-indent-offset 2)

(add-hook 'highlight-indentation-mode-hook
          (lambda()
            (setq highlight-indentation-offset current_indent) ;; set indent size
            (cond ((eq major-mode 'yaml-mode)
                   (setq highlight-indentation-offset yaml-indent-offset)))))

(set-face-background 'highlight-indentation-face
                     indentation_background_color)
(set-face-foreground 'highlight-indentation-face
                     indentation_foreground_color)
(set-face-background 'highlight-indentation-current-column-face
                     indentation_current_line_color)

;; html-mode indentation https://www.emacswiki.org/emacs/IndentingHtml
(setq sgml-basic-offset current_indent)
(add-hook 'html-mode-hook
          (lambda () (set (make-local-variable 'sgml-basic-offset) current_indent)))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
