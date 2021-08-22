;;; mode-line.el --- mode-line configuration
;;; Commentary:
;;; Code:

;; mode line configuration
(setq display-time-24hr-format t)
(display-time-mode t)
(line-number-mode t)
(size-indication-mode t)
(column-number-mode t)
(setq auto-revert-check-vc-info t)
(global-total-lines-mode) ;; `total-lines' variable in modeline

(defun buffer_path(&optional path_limit part_length)
  "Get active buffer path, with limit path length"
  (let ((path))
    (setq default_path_limit 50)
    (setq default_part_length 20)
    (setq curr_path (or buffer-file-name (directory-file-name (expand-file-name default-directory))))
    (or path_limit (setq path_limit default_path_limit))
    (cond ((not part_length)
           (setq path (list
                        (directory-file-name (file-name-directory (directory-file-name (file-name-directory curr_path)))) ;; grand parent
                        (concat "/" (file-name-nondirectory (directory-file-name (file-name-directory curr_path)))) ;; parent
                        (concat "/" (file-name-nondirectory curr_path))))) ;; file, dir
          (part_length
           (setq path (list
                              (mapconcat
                               'identity
                               (let ((result ()))
                                 (dolist (element (split-string curr_path "\\/"))
                                   (if (< part_length (length element))
                                       (push (substring element 0 part_length) result)
                                     (push element result)))
                                 (nreverse (nthcdr 2 result)))
                               "/")
                              (concat "/" (file-name-nondirectory (directory-file-name (file-name-directory curr_path)))) ;; file or dir parent name
                              (concat "/" (file-name-nondirectory curr_path)))))) ;; file or dir name
    (if (> (length (mapconcat 'identity path "")) path_limit)
        (progn
          (if (not part_length) (setq part_length (1+ default_part_length)))
          (setq part_length (1- part_length))
          (if (>= part_length 0)
              (setq path (buffer_path path_limit part_length))))
      path)))

(defun mode-line-render (start_part end_part)
  "Return a string containing start_part, buffer_path and end_part."
  (let* ((start_length (length start_part))
         (end_length (length end_part))
         (free_space_length (- (window-width) start_length end_length))
         (buffer_path_list (buffer_path free_space_length)))
         (format "%s%s%s"
                 start_part
                 (format-mode-line (list '(:eval (propertize (let* ((path (format "%s%s%s"
                                                                                  (or (nth 0 buffer_path_list) "")
                                                                                  (or (nth 1 buffer_path_list) "")
                                                                                  (or (nth 2 buffer_path_list) ""))))
                                                               (setq path (replace-regexp-in-string "\\/\\{2,\\}" "/" path))
                                                               (if (equal path "") " " (format " %s " path)))
                                                             'face
                                                             '(:foreground "#64FFDA")))))
                 end_part)))

(setq mode-line-format
      '((:eval (mode-line-render
                (format-mode-line (list
                                   "%e"
                                   'mode-line-front-space
                                   '(:eval (propertize (format-time-string "%H:%M ") 'face '(:foreground "#C6A6FF")))
                                   '(:eval (propertize (format "%%l:%d:%%C " total-lines) 'face '(:foreground "#C6A6FF"))) ;; line : total lines : column
                                   '(:eval (propertize (replace-regexp-in-string "(\\|)" "" (format "%s" mode-line-remote)) 'face '(:foreground "#64FFDA")))))
                (format-mode-line (list
                                   '(:eval (propertize "%+" 'face '(:foreground "#64FFDA"))) ;; readonly, modified
                                   '(:eval (propertize (if (and (buffer-file-name (current-buffer)) (vc-state (buffer-file-name (current-buffer))))
                                                           (format " %s " (vc-state (buffer-file-name (current-buffer))))
                                                         " ")
                                                       'face '(:foreground "#FF8CAC")))
                                   '(:eval (propertize (if (car (vc-git-branches))
                                                           (format "%s " (car (vc-git-branches)))
                                                         "") 'face '(:foreground "#FF8CAC")))
                                   '(:eval (propertize "%I" 'face '(:foreground "#C6A6FF"))) ;; file size
                                   '(:eval (propertize (format " %s " buffer-file-coding-system) 'face '(:foreground "#C6A6FF")))
                                   '(:propertize mode-name face (:foreground "#FF8CAC"))
                                   '(:propertize minor-mode-alist face (:foreground "#C6A6FF"))))))))
;;; mode-line.el ends here
