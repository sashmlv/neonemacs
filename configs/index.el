;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

;; TODO:
;; - highlighted line whitespaces
;; - improve readme reference, write missing parameters and update
;; - fix lazy load undo tree
;; - directory separator
;; - need refactoring

;; * START - Params *
;; Package repositories
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq need_emacs_restart nil)
(defconst configs_dir "/media/user/disk/emacs-config/configs/")
(defconst base_dir (concat (getenv "HOME") "/.emacs.d/" ))
(defconst backups_dir (concat base_dir "backups/"))
(defconst themes_dir (concat configs_dir "themes/"))
(defconst undo_redo_dir (concat base_dir "undo_redo/")) ;; save undo-redo history in this dir

;; is need use tern for javascript development
(defconst use_tern_mode t) ;; used in packages-installation.el
(defconst tern_dir (concat base_dir "tern/")) ;; tern files placed here
(defconst tern_file (concat tern_dir "emacs/" "tern.el")) ;; tern file

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

;; define theme for window
(set 'win-theme 'sunburst)

;; define theme for terminal
(set 'term-theme 'sunburst)

;; Packages list
(setq package-list '(
                     restart-emacs ;; support only linux and windows
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
(if use_tern_mode
    (progn
      (add-to-list 'package-list 'company-tern)
   )
 )
;; * END *

;; Set some parameters
;; (set-background-color "#000")

;; * START - Prepare config directories *
(if(not(file-accessible-directory-p backups_dir))
   (make-directory backups_dir t)
  )
(if(not(file-accessible-directory-p undo_redo_dir))
   (make-directory undo_redo_dir t)
  )
(if(not(file-accessible-directory-p tern_dir))
   (make-directory tern_dir t)
  )
;; * END *

;; Load configs
(load (concat configs_dir "modes/custom-modes")) ;; 1 - setup custom modes
(load (concat configs_dir "modes/base-modes")) ;; 2 - setup available modes
(load (concat configs_dir "modes/tern-mode")) ;; 3 - setup tern
(load (concat configs_dir "common/indentation")) ;; 4 - setup indentation
(load (concat configs_dir "common/hooks")) ;; 5 - setup hooks

;; restart emacs if needed
(if need_emacs_restart
    (if (or (string-equal system-type "gnu/linux") (string-equal system-type "windows-nt")) ;; if linux or windows
        (restart-emacs)
      (kill-emacs) ;; on other type system
      )
  )

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; index.el ends here
