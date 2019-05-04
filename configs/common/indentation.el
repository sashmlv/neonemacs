;;; indentation --- indentation configuration:
;;; Commentary:
;;; Code:

;; highlight indentation hook
(highlight-indentation-mode 1) ;; disable error
(add-hook 'highlight-indentation-mode-hook
          (lambda()
            (setq highlight-indentation-offset current_indent))) ;; set indent size

(set-face-background 'highlight-indentation-face
                     indentation_background_color)
(set-face-foreground 'highlight-indentation-face
                     indentation_foreground_color)
(set-face-background 'highlight-indentation-current-column-face
                     indentation_current_line_color)

(setq-default indent-tabs-mode nil)
(setq-default tab-width current_indent)
(setq c-basic-offset current_indent)
(setq cperl-indent-level current_indent)
(setq js-indent-level current_indent)
(setq css-indent-offset current_indent)
(setq yaml-indent-offset current_indent)
(setq typescript-indent-level current_indent)

;; html-mode indentation https://www.emacswiki.org/emacs/IndentingHtml
(setq sgml-basic-offset current_indent)
(add-hook 'html-mode-hook
          (lambda () (set (make-local-variable 'sgml-basic-offset) current_indent)))

;; https://www.emacswiki.org/emacs/IndentingPerl
(setq cperl-indent-level current_indent
      cperl-close-paren-offset (- current_indent)
      cperl-continued-statement-offset current_indent
      cperl-indent-parens-as-block t
      cperl-tab-always-indent t)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; indentation.el ends here
