;;; configs.el --- configs
;;; Commentary:
;;; Code:

(defconst current_indent 3) ;; common indentation
;; define directories
(defconst configs_dir (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(defconst backups_dir (concat user-emacs-directory (file-name-as-directory "backups")))
(defconst theme_dir (concat configs_dir (file-name-as-directory "theme")))
(defconst undo_redo_dir (concat user-emacs-directory (file-name-as-directory "undo_redo"))) ;; undo-redo history dir
(defconst yasnippet_directory (concat configs_dir (directory-file-name "yasnippet")))
(defconst yasnippet_common_directory (concat configs_dir (file-name-as-directory "yasnippet") "common"))

;; create config directories
(if(not(file-accessible-directory-p backups_dir))
   (make-directory backups_dir t))

;;; configs.el ends here
