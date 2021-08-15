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

(defface buffer_path
  '((t :foreground "#FFFFFF" :weight normal))
  "Face for highlight current buffer path.")
(defface buffer_path_dir
  '((t :foreground "#B8F2FE" :weight normal))
  "Face for highlight directory of current buffer.")
(defface buffer_path_file
  '((t :foreground "#EDC9AF" :weight normal))
  "Face for highlight file of current buffer.")
(defface mode_line_position
  '((t :foreground "#FFFFFF" :weight normal))
  "Face for highlight cursor position.")
(defface mode_line_buffer_size
  '((t :foreground "#FFFFFF" :weight normal))
  "Face for highlight buffer size.")
(defface mode_line_modified
  '((t :foreground "#FFFFFF" :weight normal))
  "Face for highlight buffer modified.")
(defface mode_line_mode_name
  '((t :foreground "#FFFFFF" :weight normal))
  "Face for highlight mode name.")
(defface mode_line_minor_mode_alist
  '((t :foreground "#FFFFFF" :weight normal))
  "Face for highlight minor mode alist.")

(defun buffer_path(&optional path_limit part_length)
  "Get active buffer path, with limit path length"
  (let ((path))
    (setq default_path_limit 50)
    (setq default_part_length 20)
    (setq curr_path (or buffer-file-name (directory-file-name default-directory)))
    (or path_limit (setq path_limit default_path_limit))
    (cond ((not part_length)
           (setq path (format
                       "%s%s%s"
                       (propertize
                        (directory-file-name (file-name-directory (directory-file-name (file-name-directory curr_path))))
                        'face 'buffer_path) ;; grand parent
                       (propertize
                        (concat "/" (file-name-nondirectory (directory-file-name (file-name-directory curr_path))))
                        'face 'buffer_path_dir) ;; parent
                       (propertize
                        (concat "/" (file-name-nondirectory curr_path))
                        'face 'buffer_path_file)))) ;; file, dir
          (part_length
           (setq path (format
                       "%s%s%s"
                       (propertize (mapconcat
                         'identity
                         (let ((result ()))
                           (dolist (element (split-string curr_path "\\/"))
                             (if (< part_length (length element))
                                 (push (substring element 0 part_length) result)
                               (push element result)))
                           (nreverse (nthcdr 2 result)))
                         "/") 'face 'buffer_path)
                       (propertize (concat
                                    "/"
                                    (file-name-nondirectory (directory-file-name (file-name-directory curr_path))))
                                   'face 'buffer_path_dir) ;; file or dir parent name
                       (propertize (concat
                                    "/"
                                    (file-name-nondirectory curr_path))
                                   'face 'buffer_path_file))))) ;; file or dir name
    (if (> (length path) path_limit)
        (progn
          (if (not part_length) (setq part_length (1+ default_part_length)))
          (setq part_length (1- part_length))
          (if (>= part_length 0)
              (setq path (buffer_path path_limit part_length)))
            (replace-regexp-in-string "\\/\\{2,\\}" "" path))
      path)))

(defun mode-line-render (start_part end_part)
  "Return a string containing start_part, buffer_path and end_part."
  (let* ((start_length (length start_part))
         (end_length (length end_part))
         (free_space_length (- (window-width) start_length end_length))
         (buffer_path_string (buffer_path free_space_length)))
    (format "%s%s%s" start_part buffer_path_string end_part)))

(global-total-lines-mode) ;; `total-lines' variable in modeline

(setq mode-line-format
      '((:eval (mode-line-render
                (format-mode-line (list
                                   "%e"
                                   'mode-line-front-space
                                   '(:eval (propertize (format-time-string "%H:%M") 'face 'mode_line_position))
                                   " "
                                   '(:eval (propertize (format "%%l:%d:%%C" total-lines) 'face 'mode_line_position)) ;; line : total lines : column
                                   " "
                                   '(:propertize mode-line-remote face mode_line_position)
                                   " "))
                (format-mode-line (list
                                   " "
                                   '(:eval (propertize "%+" 'face 'mode_line_position)) ;; readonly, modified
                                   " "
                                   ;; (symbol-name (vc-state (buffer-file-name (current-buffer))))
                                   '(:eval (propertize (car (vc-git-branches)) 'face 'mode_line_position))
                                   " "
                                   '(:eval (propertize "%I" 'face 'mode_line_buffer_size)) ;; file size
                                   " "
                                   '(:eval (propertize (symbol-name buffer-file-coding-system) 'face 'mode_line_position))
                                   " "
                                   '(:propertize mode-name face mode_line_mode_name)
                                   '(:propertize minor-mode-alist face mode_line_minor_mode_alist)))))))

;;; mode-line.el ends here
