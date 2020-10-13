;;; configs.el --- configs
;;; Commentary:
;;; Code:

;; "Fira Mono-9", "Andale Mono-9", "Liberation Mono-9", "Menlo-9", "Monaco-9", "Hack-9", "M+ 1m-9", "Anonymous Pro-9", "Source Code Pro-9", "DejaVu Sans Mono-9", "Iosevka-9", "Envy Code R-9"
(defconst current_font "Fira Mono-8")
(defconst current_indent 3) ;; common indentation

(defconst brackets_match_foreground "white")
(defconst brackets_match_background "blue3")
(defconst brackets_mismatch_foreground "white")
(defconst brackets_mismatch_background "red3")

(defconst hl_occurrences_color "chartreuse")
(defconst hl_search_occurrences_color "RoyalBlue3")

(defconst use_undo_tree_history_files t)

;; define directories
(defconst configs_dir (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(defconst base_dir
  (concat (file-name-as-directory (getenv "HOME"))
          (file-name-as-directory ".emacs.d")))
(defconst backups_dir (concat base_dir (file-name-as-directory "backups")))
(defconst theme_dir (concat configs_dir (file-name-as-directory "theme")))
(defconst undo_redo_dir (concat base_dir (file-name-as-directory "undo_redo"))) ;; undo-redo history dir
(defconst yasnippet_directory (concat configs_dir (directory-file-name "yasnippet")))
(defconst yasnippet_common_directory (concat configs_dir (file-name-as-directory "yasnippet") "common"))

;; create config directories
(if(not(file-accessible-directory-p backups_dir))
   (make-directory backups_dir t))

;;; configs.el ends here
