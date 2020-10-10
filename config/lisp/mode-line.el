;;; mode-line.el --- mode-line configuration
;;; Commentary:
;;; Code:

;; mode line configuration
(setq display-time-24hr-format t)
(display-time-mode t)
(line-number-mode t)
(size-indication-mode t)
(column-number-mode t)

(setq mode-line-format
      (list
       "%e"
       'mode-line-front-space
       "%+" ;; readonly, modified
       " "
       'mode-line-mule-info
       " "
       '(:eval (format-time-string "%H.%M"))
       " "
       "%l:%C" ;; line, column
       " "
       "%P"
       " "
       "%I" ;; file size
       " "
       'mode-line-client
       'mode-line-remote
       " "
       '(:eval (format "%s/%s/%s"
               (mapconcat
                'identity
                (let ((result ()))
                  (dolist (element (split-string (buffer-file-name) "\\/"))
                    (if (< 3 (length element))
                        (push (substring element 0 3) result)
                      (push element result)))
                  (nreverse (nthcdr 2 result))) "/")
               (file-name-nondirectory (directory-file-name (file-name-directory buffer-file-name)))
               (file-name-nondirectory buffer-file-name)))
       " "
       'mode-line-frame-identification
       '(vc-mode vc-mode)
       'mode-line-modes
       'mode-line-end-spaces
       ))

;;; mode-line.el ends here
