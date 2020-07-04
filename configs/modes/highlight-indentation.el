;;; highlight-indentation --- highlight-indentation configuration:
;;; Commentary:
;;; Code:

;; highlight indentation hook
(highlight-indentation-mode t)

;; set current_indent value from .editorconfig file
(defun set_current_indent_from_editorconfig (props)
   (progn
      (if (gethash 'indent_size props)
         (setq current_indent (string-to-number (gethash 'indent_size props))))))
(add-hook 'editorconfig-after-apply-functions 'set_current_indent_from_editorconfig)

(defun highlight_indentation_offset ()
   (progn
      (setq highlight-indentation-offset current_indent) ;; set indent size
      (cond ((eq major-mode 'yaml-mode)
               (setq highlight-indentation-offset yaml-indent-offset)))
      ))
(add-hook 'highlight-indentation-mode-hook 'highlight_indentation_offset)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; highlight-indentation.el ends here
