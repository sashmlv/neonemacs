;;; configs --- configs configuration:
;;; Commentary:
;;; Code:

;; "Fira Mono-9", "Andale Mono-9", "Liberation Mono-9", "Menlo-9", "Monaco-9", "Hack-9", "M+ 1m-9", "Anonymous Pro-9", "Source Code Pro-9", "DejaVu Sans Mono-9", "Iosevka-9", "Envy Code R-9"
(defconst current_font "Liberation Mono-9")
(defconst current_indent 3) ;; common indentation
(defconst indentation_background_color "#202020")
(defconst indentation_foreground_color "#555555")
(defconst indentation_current_line_color "#101010")

(defconst brackets_match_foreground "white")
(defconst brackets_match_background "blue3")
(defconst brackets_mismatch_foreground "white")
(defconst brackets_mismatch_background "red3")

(defconst whitespace_weight 'light)
(defconst whitespace_foreground "#333333")
(defconst whitespace_background nil)
(defconst whitespace_space_background "#070707")
(defconst whitespace_trailing_foreground "#ff2020")

(defconst cursor_color "green2")
(defconst background_color "#000")
(defconst hl_line_background "#151515")
(defconst hl_region_background "#202020")
(defconst hl_occurrences_color "chartreuse")
(defconst hl_search_occurrences_color "RoyalBlue3")

(defconst use_undo_tree_history_files t)

;; define theme for window
;; (set 'win-theme 'dracula) ;; sunburst, flatland-black, peacock
(set 'win-theme 'neon) ;; sunburst, flatland-black, peacock

;; define theme for terminal
(set 'term-theme 'dracula)

;; define directories
(defconst configs_dir (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(defconst base_dir
  (concat (file-name-as-directory (getenv "HOME"))
          (file-name-as-directory ".emacs.d")))
(defconst backups_dir (concat base_dir (file-name-as-directory "backups")))
(defconst themes_dir (concat configs_dir (file-name-as-directory "themes")))
(defconst undo_redo_dir (concat base_dir (file-name-as-directory "undo_redo"))) ;; undo-redo history dir
(defconst yasnippets_directory (concat configs_dir (directory-file-name "yasnippets")))

;; create config directories
(if(not(file-accessible-directory-p backups_dir))
   (make-directory backups_dir t))
(if(not(file-accessible-directory-p undo_redo_dir))
   (make-directory undo_redo_dir t))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; configs.el ends here
