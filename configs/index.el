;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

;; * START - Params *
;; Package repositories
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq need_emacs_restart nil)
(defconst configs_dir "/media/user/disk/emacs-config/configs/")
(defconst base_dir (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".emacs.d")))
(defconst backups_dir (concat base_dir (file-name-as-directory "backups")))
(defconst themes_dir (concat configs_dir (file-name-as-directory "themes")))
(defconst undo_redo_dir (concat base_dir (file-name-as-directory "undo_redo"))) ;; save undo-redo history in this dir

;; is need use tern for javascript development
(defconst use_tern_mode t) ;; used in modes-setup/tern-mode-setup.el
(defconst tern_dir (concat base_dir (file-name-as-directory "tern"))) ;; tern files placed here
(defconst tern_file (concat tern_dir (file-name-as-directory "emacs") "tern.el")) ;; tern file
(if (and use_tern_mode (file-exists-p tern_file))
  (setq exec-path (cons (concat tern_dir "bin") exec-path)) ;; set environment path to tern binary
)

(defconst current_font "Menlo-9")
(defconst current_indent 3) ;; 3 spaces ;; used in common/indentation.el
(defconst indentation_color "#101010") ;; used in common/hooks.el
(defconst indentation_current_line_color "#101010") ;; used in common/hooks.el

(defconst brackets_match_foreground "white") ;; used in modes-setup/base-modes-setup.el
(defconst brackets_match_background "blue3") ;; used in modes-setup/base-modes-setup.el
(defconst brackets_mismatch_foreground "white") ;; used in modes-setup/base-modes-setup.el
(defconst brackets_mismatch_background "red3") ;; used in modes-setup/base-modes-setup.el

(defconst whitespace_foreground "#212121") ;; used in modes-setup/base-modes-setup.el
(defconst whitespace_background "#070707") ;; used in modes-setup/base-modes-setup.el
(defconst whitespace_weight 'light) ;; used in modes-setup/base-modes-setup.el

(defconst whitespace_trailing_foreground "#ff2020") ;; used in modes-setup/base-modes-setup.el
(defconst whitespace_trailing_background "#070707") ;; used in modes-setup/base-modes-setup.el
(defconst whitespace_trailing_weight 'light) ;; used in modes-setup/base-modes-setup.el

(defconst hl_line_background "#101010") ;; used in modes-setup/base-modes-setup.el
(defconst hl_region_background "#232323") ;; used in modes-setup/base-modes-setup.el

(defconst cursor_color "green2") ;; used in modes-setup/base-modes-setup.el

;; is need use undo-tree history files
(defconst use_undo_tree_history_files t) ;; used in modes-setup/base-modes-setup.el

;; define theme for window
(set 'win-theme 'sunburst)

;; define theme for terminal
(set 'term-theme 'sunburst)

;; Packages list
(setq package-list '(
                     restart-emacs ;; support only linux and windows
                     smex ;; minibuffer improvements
                     undo-tree ;; undo-redo history
                     multiple-cursors
                     company ;; autocompletition
                     company-statistics
                     projectile ;; project management
                     highlight-indentation
                     js2-mode less-css-mode web-mode php-mode pug-mode yaml-mode markdown-mode
                     bongo ;; media player
                     syntax-subword ;; subword navigation
                     magit ;; git support
                     idle-highlight-mode ;; highlight occurrences
                     google-translate
                     )
      )
(if use_tern_mode
    (add-to-list 'package-list 'company-tern)
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
(load (concat configs_dir (file-name-as-directory "modes-setup") "custom-modes-setup")) ;; 1 - setup custom modes
(load (concat configs_dir (file-name-as-directory "modes-setup") "base-modes-setup")) ;; 2 - setup available modes
(load (concat configs_dir (file-name-as-directory "modes-setup") "undo-tree-mode-setup")) ;; 3 - setup undo-tree
(load (concat configs_dir (file-name-as-directory "modes-setup") "tern-mode-setup")) ;; 4 - setup tern
(load (concat configs_dir (file-name-as-directory "common") "indentation")) ;; 5 - setup indentation
(load (concat configs_dir (file-name-as-directory "common") "hooks")) ;; 6 - setup hooks

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
