;;; mode-line.el --- mode-line configuration
;;; Commentary:
;;; Code:

;; mode line configuration
(setq display-time-24hr-format t)
(display-time-mode t)
(line-number-mode t)
(size-indication-mode t)
(column-number-mode t)

(defun buffer_path(&optional path_limit part_length)
  "Get active buffer path, with limit path length"
  (let ((path))
    (setq default_path_limit 50)
    (setq default_part_length 10)
    (setq curr_path (or buffer-file-name (directory-file-name default-directory)))
    (or path_limit (setq path_limit default_path_limit))
    (cond ((not part_length)
           (setq path curr_path))
          (part_length
           (setq path (format
                       "%s/%s/%s"
                       (mapconcat
                        'identity
                        (let ((result ()))
                          (dolist (element (split-string curr_path "\\/"))
                            (if (< part_length (length element))
                                (push (substring element 0 part_length) result)
                              (push element result)))
                          (nreverse (nthcdr 2 result)))
                        "/")
                       (file-name-nondirectory (directory-file-name (file-name-directory curr_path))) ;; file/dir parent
                       (file-name-nondirectory curr_path)))))
    (if (> (length path) path_limit)
        (progn
          (if (not part_length) (setq part_length (1+ default_part_length)))
          (setq part_length (1- part_length))
          (if (>= part_length 0)
              (setq path (buffer_path path_limit part_length))
            (replace-regexp-in-string "\\/\\{2,\\}" "" path)))
      path)))

(setq-default mode-line-format
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
               'mode-line-frame-identification
               '(:eval (buffer_path))
               " "
               '(vc-mode vc-mode)
               " "
               'mode-line-modes
               'mode-line-end-spaces
               ))

;;; mode-line.el ends here
