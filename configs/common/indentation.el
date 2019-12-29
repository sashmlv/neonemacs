;;; indentation.el --- Indentation params
;;; Commentary:
;;; Code:

;; highlight indentation hook
(highlight-indentation-mode 1) ;; disable error

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
(setq-default yaml-indent-offset 2)

(defun highlight_indentation_offset ()
  (progn
    (setq highlight-indentation-offset current_indent) ;; set indent size
    (cond ((eq major-mode 'yaml-mode)
          (setq highlight-indentation-offset yaml-indent-offset)))
   ))
(remove-hook 'highlight-indentation-mode-hook 'highlight_indentation_offset)
(add-hook 'highlight-indentation-mode-hook 'highlight_indentation_offset)

;; html-mode indentation https://www.emacswiki.org/emacs/IndentingHtml
(setq-default sgml-basic-offset current_indent)
(defun html_mode_offset ()
  (progn
    (set (make-local-variable 'sgml-basic-offset) current_indent)
    ))
(remove-hook 'html-mode-hook 'html_mode_offset)
(add-hook 'html-mode-hook 'html_mode_offset)

;;; indentation.el ends here
