;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

;; TODO:
;; - rethink project structure
;; - highlighted line whitespaces
;; - improve readme reference
;; - setup tern
;; - fix lazy load undo tree
;; - fix dir names

;; * START - Params *
(defconst configs_dir "/media/user/disk/emacs-config/configs/")
(defconst base_dir "~/.emacs.d/")
(defconst backups_dir (concat base_dir "backups/"))
(defconst undo_redo__dir (concat base_dir "undo_redo/")) ;; save undo-redo history in this dir
(defconst themes_dir (concat configs_dir "themes/"))
(defconst current_font "Menlo-9")
(defconst current_indent 3) ;; 3 spaces ;; used in indentation.el
(defconst indentation_color "#101010") ;; used in hooks.el
(defconst indentation_current_line_color "#101010") ;; used in hooks.el

(defconst brackets_match_foreground "white") ;; used in base.el
(defconst brackets_match_background "blue3") ;; used in base.el
(defconst brackets_mismatch_foreground "white") ;; used in base.el
(defconst brackets_mismatch_background "red3") ;; used in base.el

(defconst whitespace_foreground "#212121") ;; used in base.el
(defconst whitespace_background "#070707") ;; used in base.el
(defconst whitespace_weight 'light) ;; used in base.el

(defconst whitespace_trailing_foreground "#ff2020") ;; used in base.el
(defconst whitespace_trailing_background "#070707") ;; used in base.el
(defconst whitespace_trailing_weight 'light) ;; used in base.el

(defconst hl_line_background "#101010") ;; used in base.el
(defconst hl_region_background "#232323") ;; used in base.el

(defconst cursor_color "green2") ;; used in base.el

;; is need use undo-tree history files
(defconst use_undo_tree_history_files t) ;; used in base.el

;; is need use tern for javascript
(defconst use_tern_mode t) ;; used in packages-installation.el

;; define theme for window
(set 'win-theme 'sunburst)

;; define theme for terminal
(set 'term-theme 'sunburst)

;; Packages list
(setq package-list '(
                     smex
                     undo-tree
                     multiple-cursors
                     company
                     company-statistics
                     projectile
                     js2-mode
                     highlight-indentation
                     less-css-mode
                     web-mode
                     pug-mode
                     yaml-mode
                     )
      )
;; * END *

;; Set some parameters
;; (set-background-color "#000")

;; * START - Prepare config directories *
(if(not(file-accessible-directory-p backups_dir))
   (make-directory backups_dir t)
  )
(if(not(file-accessible-directory-p undo_redo__dir))
   (make-directory undo_redo__dir t)
  )
;; * END *

;; Load configs
(load (concat configs_dir "base"))
(load (concat configs_dir "packages-installation"))
(load (concat configs_dir "indentation"))
(load (concat configs_dir "custom-modes"))
(load (concat configs_dir "hooks"))



;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; index.el ends here
