;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

;; Package repositories
(require 'package)
(package-initialize)
(setq package-archives nil)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/") t)

(setq need_emacs_restart nil)
(defconst configs_dir "/media/user/disk/emacs-config/configs/")
(defconst base_dir (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".emacs.d")))
(defconst backups_dir (concat base_dir (file-name-as-directory "backups")))
(defconst themes_dir (concat configs_dir (file-name-as-directory "themes")))
(defconst undo_redo_dir (concat base_dir (file-name-as-directory "undo_redo"))) ;; save undo-redo history in this dir

(defconst current_font "Fira Mono-9") ;; or font "Menlo-9"
(defconst current_indent 3)
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
(defconst hl_line_background "#191919")
(defconst hl_region_background "#252525")
(defconst hl_occurrences_color "chartreuse")
(defconst hl_search_occurrences_color "RoyalBlue3")

;; is need use undo-tree history files
(defconst use_undo_tree_history_files t)

;; yasnippets directory
(defconst yasnippets_directory (concat configs_dir (directory-file-name "yasnippets")))

;; define theme for window
;; (set 'win-theme 'sunburst) ;; flatland-black, peacock
(set 'win-theme 'dracula)

;; define theme for terminal
(set 'term-theme 'dracula)

;; Packages list
(setq package-list '(
                     restart-emacs ;; support only linux and windows
                     smex ;; minibuffer improvements
                     undo-tree ;; undo-redo history
                     multiple-cursors
                     company ;; autocompletition
                     company-statistics
                     projectile ;; project management
                     highlight-indentation ;; or highlight-indent-guides ;; highlight indentation
                     js2-mode js2-refactor typescript-mode less-css-mode php-mode pug-mode yaml-mode markdown-mode json-mode rjsx-mode
                     bongo volume ;; media player
                     syntax-subword ;; subword navigation
                     magit ;; git support
                     highlight-symbol ;; highlight occurrences
                     google-translate
                     dockerfile-mode
                     yasnippet ;; template system
                     vimish-fold ;; fold-unfold library
                     wakatime-mode ;; for time tracking
                     xah-find
                     ido-vertical-mode
                     avy
                     indium ;; see for setup: https://indium.readthedocs.io/en/latest/setup.html
                     expand-region ;; expand-region for fast text selection
                     dumb-jump ;; jump to variable definition
                     smart-mode-line ;; status bar customization
                     )
      )

;; Prepare config directories *
(if(not(file-accessible-directory-p backups_dir))
   (make-directory backups_dir t)
  )
(if(not(file-accessible-directory-p undo_redo_dir))
   (make-directory undo_redo_dir t)
  )

;; Load files
(load (concat configs_dir (file-name-as-directory "modes") "multiple-cursors"))
(load (concat configs_dir (file-name-as-directory "modes") "smex"))
(load (concat configs_dir (file-name-as-directory "modes") "ido-vertical"))
(load (concat configs_dir (file-name-as-directory "modes") "company"))
(load (concat configs_dir (file-name-as-directory "modes") "highlight-symbol"))
(load (concat configs_dir (file-name-as-directory "modes") "google-translate"))
(load (concat configs_dir (file-name-as-directory "modes") "markdown"))
(load (concat configs_dir (file-name-as-directory "modes") "xah-syntax-color-hex"))
(load (concat configs_dir (file-name-as-directory "modes") "xah-change-bracket-pairs"))
(load (concat configs_dir (file-name-as-directory "modes") "undo-tree"))
(load (concat configs_dir (file-name-as-directory "modes") "avy"))
(load (concat configs_dir (file-name-as-directory "modes") "vimish-fold"))
(load (concat configs_dir (file-name-as-directory "modes") "yasnippet"))
;; (load (concat configs_dir (file-name-as-directory "modes") "wakatime"))
(load (concat configs_dir (file-name-as-directory "modes") "smart-mode-line"))
(load (concat configs_dir (file-name-as-directory "modes") (file-name-as-directory "column-marker") "highlight-80-mode"))
(load (concat configs_dir (file-name-as-directory "modes") "base-setup")) ;; we must load modes before, then change parameters
(load (concat configs_dir (file-name-as-directory "common") "indentation"))
(load (concat configs_dir (file-name-as-directory "common") "hooks"))
(load (concat configs_dir (file-name-as-directory "common") "theme"))
(load (concat configs_dir (file-name-as-directory "common") "whitespace"))
(load (concat configs_dir (file-name-as-directory "common") "projects"))

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
