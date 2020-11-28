;;; indentation.el --- indentation
;;; Commentary:
;;; Code:

;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)
(setq-default tab-width current_indent)
(setq-default c-basic-offset current_indent)
(setq-default js-indent-level current_indent)
(setq-default css-indent-offset current_indent)
(setq-default typescript-indent-level current_indent)
(setq-default rust-indent-offset current_indent)
(setq-default web-mode-markup-indent-offset current_indent)
(setq-default web-mode-css-indent-offset current_indent)
(setq-default web-mode-code-indent-offset current_indent)
(setq-default sh-basic-offset current_indent)
(setq-default sh-indentation current_indent)
(setq-default yaml-indent-offset 2)
(setq-default nginx-indent-level 4)

;; html-mode indentation https://www.emacswiki.org/emacs/IndentingHtml
(setq-default sgml-basic-offset current_indent)
(defun html_mode_offset ()
  (progn
    (set (make-local-variable 'sgml-basic-offset) current_indent)
    ))
(remove-hook 'html-mode-hook 'html_mode_offset)
(add-hook 'html-mode-hook 'html_mode_offset)

;;; indentation.el ends here
