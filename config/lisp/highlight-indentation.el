;;; highlight-indentation.el --- highlight-indentation configuration
;;; Commentary:
;;; Code:

;; highlight indentation hook
(highlight-indentation-mode t)
(setq highlight-indentation-offset neon-indent) ;; set indent size

;; set "neon-indent" equal to value from ".editorconfig" file and refresh highlight indentation
(setq neon-indent-original neon-indent)
(defun set-neon-indent-from-editorconfig (props)
  (cond ((gethash 'indent_size props)
         (setq neon-indent (string-to-number (gethash 'indent_size props))))
        (t
         (setq neon-indent neon-indent-original)))
  (neon-highlight-indentation-offset))
(add-hook 'editorconfig-hack-properties-functions 'set-neon-indent-from-editorconfig)

;; set "highlight-indentation-offset" value for modes
(defun neon-highlight-indentation-offset ()
  (cond ((eq major-mode 'yaml-mode)
         (setq highlight-indentation-offset yaml-indent-offset))
        (t
         (setq highlight-indentation-offset neon-indent))))
(add-hook 'highlight-indentation-mode-hook 'neon-highlight-indentation-offset)

;; enable highlight-indentation for yml mode
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)

;;; highlight-indentation.el ends here
