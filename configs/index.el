;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

;; TODO:
;; -

;; * START - Params *
(defconst root_dir "/media/user/disk/emacs-config/configs/")
(defconst base_dir "~/.emacs.d/")
(defconst config_dir (concat base_dir "configs/"))
(defconst backups_dir (concat base_dir "backups/"))
(defconst themes_dir (concat root_dir "themes/"))
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

(defconst hl_line_background "#101010" ) ;; used in base.el
(defconst hl_region_background "#232323" ) ;; used in base.el

(defconst cursor_color "green2" ) ;; used in base.el

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
                     )
      )
;; * END *

;; Load configs
(load (concat root_dir "base"))
(load (concat root_dir "indentation"))
(load (concat root_dir "hooks"))



;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; index.el ends here
