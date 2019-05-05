;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

(require 'package)
(package-initialize)
(setq package-archives nil)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/") t)

(setq need_emacs_restart nil)

;; "Fira Mono-9", "Andale Mono-9", "Liberation Mono-9", "Menlo-9", "Monaco-9", "Hack-9", "M+ 1m-9", "Anonymous Pro-9", "Source Code Pro-9", "DejaVu Sans Mono-9", "Iosevka-9", "Envy Code R-9"
(defconst current_font "Liberation Mono-9")
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
(defconst hl_line_background "#151515")
(defconst hl_region_background "#202020")
(defconst hl_occurrences_color "chartreuse")
(defconst hl_search_occurrences_color "RoyalBlue3")

(defconst use_undo_tree_history_files t)

;; define theme for window
(set 'win-theme 'dracula) ;; sunburst, flatland-black, peacock

;; define theme for terminal
(set 'term-theme 'dracula)

(setq package-list
      '(restart-emacs ;; support only linux and windows
        ;; smex ;; minibuffer improvements
        ;; ido-vertical-mode
        undo-tree ;; undo-redo history
        multiple-cursors
        company ;; autocompletition
        company-statistics
        projectile ;; project management
        highlight-indentation ;; or highlight-indent-guides
        rainbow-delimiters ;; rainbow parentheses

        js2-mode js2-refactor typescript-mode less-css-mode php-mode
        pug-mode yaml-mode markdown-mode json-mode rjsx-mode dockerfile-mode
        haskell-mode rust-mode

        bongo volume ;; media player
        magit ;; git support
        highlight-symbol ;; highlight occurrences
        google-translate
        yasnippet ;; template system
        vimish-fold ;; fold-unfold library
        ;; wakatime-mode ;; time tracking
        xah-find
        avy
        indium ;; see for setup: https://indium.readthedocs.io/en/latest/setup.html
        expand-region ;; fast text selection
        dumb-jump ;; jump to variable definition
        smart-mode-line ;; status bar customization
        ;; highlight ;; highlight regex and other features

        bm ;; visible bookmarks
        syntax-subword ;; make word editing and motion more fine-grained
        smartscan ;; jumps between other symbols found at point
        goto-chg ;; goto-last-change
        helm ;; incremental completion and selection narrowing framework
        helm-projectile
        helm-swoop ;; peculiar buffer navigation
        dired-k ;; highlights dired buffer like k
        ))

;; install packages from list
;; check installed packages
(setq need_package_install nil)
(dolist (package package-list)
  (if(not(package-installed-p package))
      (setq need_package_install t)))
(if need_package_install ;; install packages if need
    (progn
      (package-refresh-contents) ;; fetch list of packages available in melpa
      (dolist (package package-list) ;; install the missing packages
        (unless (package-installed-p package)
          ;; (if (y-or-n-p (format "Package \"%s\" is missing. Do you want to install it? " package))
          (package-install package)
          ;; )
          ))))


(defun load-directory (path files)
  "Load files from a path, parameter \"path\" is a directory path and \"files\" is a file list."

  (if (and (stringp path) (not (null files)))
      (dolist (file files)
        (load (concat path file)))))

;; modes
(setq modes-list `(
                   "multiple-cursors"
                   ;; "smex"
                   ;; "ido-vertical"
                   "company"
                   "highlight-symbol"
                   "google-translate"
                   "markdown"
                   "xah-syntax-color-hex"
                   "xah-change-bracket-pairs"
                   "undo-tree"
                   "avy"
                   "vimish-fold"
                   "yasnippet"
                   ;; "wakatime"
                   "smart-mode-line"
                   "bm"
                   "perl-mode"
                   ,(concat (file-name-as-directory "column-marker") "highlight-80-mode")
                   ,(concat (file-name-as-directory "highlight") "highlight")
                   "hide-new-line"
                   "helm"
                   "base-setup" ;; load modes before this
                   ))

;; common configs
(setq common-list '("indentation" "hooks" "theme" "whitespace"))

;; define directories parameters
(defconst configs_dir "/media/user/disk/emacs-config/configs/")
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

;; load files
(load (concat configs_dir (file-name-as-directory "common") "projects")) ;; project specific params before
(load-directory (concat configs_dir (file-name-as-directory "modes")) modes-list)
(load-directory (concat configs_dir (file-name-as-directory "common")) common-list)

(if need_emacs_restart
    (if (or
         (string-equal system-type "gnu/linux")
         (string-equal system-type "windows-nt"))
        (restart-emacs)
      (kill-emacs))) ;; if no linux/windows

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; index.el ends here
