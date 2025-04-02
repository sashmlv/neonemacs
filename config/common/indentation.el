;;; indentation.el --- indentation
;;; Commentary:
;;; Code:

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)
(setq-default tab-width neon-indent)
(setq-default c-basic-offset neon-indent)
(setq-default js-indent-level neon-indent)
(setq-default css-indent-offset neon-indent)
(setq-default typescript-indent-level neon-indent)
(setq-default rust-indent-offset neon-indent)
(setq-default web-mode-markup-indent-offset neon-indent)
(setq-default web-mode-css-indent-offset neon-indent)
(setq-default web-mode-code-indent-offset neon-indent)
(setq-default sh-basic-offset neon-indent)
(setq-default sh-indentation neon-indent)
(setq-default yaml-indent-offset 2)
(setq-default nginx-indent-level 4)
(setq-default electric-indent-mode nil)

;; html-mode indentation https://www.emacswiki.org/emacs/IndentingHtml
(setq-default sgml-basic-offset neon-indent)
(defun neon-html-mode-offset ()
  (progn
    (set (make-local-variable 'sgml-basic-offset) neon-indent)
    ))
(remove-hook 'html-mode-hook 'neon-html-mode-offset)
(add-hook 'html-mode-hook 'neon-html-mode-offset)

;;; indentation.el ends here
