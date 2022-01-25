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

(defun neon-buffer-path(&optional path-limit part-length)
  "Get active buffer path, with limit path length"
  (let ((path))
    (setq default-path-limit 50)
    (setq default-part-length 20)
    (setq curr-path (or buffer-file-name (directory-file-name (expand-file-name default-directory))))
    (or path-limit (setq path-limit default-path-limit))
    (cond ((not part-length)
           (setq path (list
                        (directory-file-name (file-name-directory (directory-file-name (file-name-directory curr-path)))) ;; grand parent
                        (concat "/" (file-name-nondirectory (directory-file-name (file-name-directory curr-path)))) ;; parent
                        (concat "/" (file-name-nondirectory curr-path))))) ;; file, dir
          (part-length
           (setq path (list
                              (mapconcat
                               'identity
                               (let ((result ()))
                                 (dolist (element (split-string curr-path "\\/"))
                                   (if (< part-length (length element))
                                       (push (substring element 0 part-length) result)
                                     (push element result)))
                                 (nreverse (nthcdr 2 result)))
                               "/")
                              (concat "/" (file-name-nondirectory (directory-file-name (file-name-directory curr-path)))) ;; file or dir parent name
                              (concat "/" (file-name-nondirectory curr-path)))))) ;; file or dir name
    (if (> (length (mapconcat 'identity path "")) path-limit)
        (progn
          (if (not part-length) (setq part-length (1+ default-part-length)))
          (setq part-length (1- part-length))
          (if (>= part-length 0)
              (setq path (neon-buffer-path path-limit part-length))))
      path)))

(defun mode-line-render (start-part end-part)
  "Return a string containing start-part, neon-buffer-path and end-part."
  (let* ((start-length (length start-part))
         (end-length (length end-part))
         (free-space-length (- (window-width) start-length end-length))
         (buffer-path-list (neon-buffer-path free-space-length)))
         (format "%s%s%s"
                 start-part
                 (format-mode-line (list '(:eval (propertize (let* ((path (format "%s%s%s"
                                                                                  (or (nth 0 buffer-path-list) "")
                                                                                  (or (nth 1 buffer-path-list) "")
                                                                                 (or (nth 2 buffer-path-list) ""))))
                                                               (setq path (replace-regexp-in-string "\\/\\{2,\\}" "/" path))
                                                               (if (equal path "") " " (format " %s " path)))
                                                             'face
                                                             '(:foreground "#64FFDA")))))
                 end-part)))

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
