;;; base-modes-setup --- available modes configuration:
;;; Commentary:
;;; Code:

;; Install packages from list
;; Check installed packages
(setq need-package-install nil)
(dolist (package package-list)
  (if(not(package-installed-p package))
      (setq need-package-install t)
 ))

;; install packages if needed
(if need-package-install
    (progn

      ;; Fetch the list of packages available in melpa
      (package-refresh-contents)

      ;; Install the missing packages
      (dolist (package package-list)
        (unless (package-installed-p package)
          ;; (if (y-or-n-p (format "Package \"%s\" is missing. Do you want to install it? " package))
          (package-install package)
          ;; )
          )
        )
      )
  )

;; Save session
(setq desktop-restore-eager 12) ;; how buffers restore immediately
(setq desktop-dirname base_dir)
(setq desktop-base-file-name "emacs.desktop")
(setq desktop-base-lock-name "lock")
(setq desktop-path (list desktop-dirname))
(setq desktop-restore-frames t)
(setq desktop-save t)
(desktop-save-mode t)
(desktop-read)

;; Change "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; Disable GUI components
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(if (fboundp 'global-linum-mode) (global-linum-mode -1))

;; Display file name of the current buffer in the title
(setq frame-title-format "%F: %f")

;; Display file size/time in mode-line
(setq display-time-24hr-format t)
(display-time-mode             t)
(size-indication-mode          t)


;; * Set cursor type *
;;(setq-default cursor-type 'bar)

;; Set theme [ for window or terminal ] *
(add-to-list 'custom-theme-load-path themes_dir)
(load-theme win-theme t)
(load-theme term-theme t)
(if(display-graphic-p)
    (enable-theme win-theme) ;; window theme
  (enable-theme term-theme)) ;; terminal theme

;; Fringe-mode [ disable borders on left and right ]
(set-fringe-mode 0)

;; Set font
(set-default-font current_font)

;; Smooth scrolling
(setq scroll-step          1
scroll-conservatively  10000)

;; Delete selection [ Shift + d { delete selected text } ]
(delete-selection-mode t)

;; Backup files
(setq make-backup-files t)
;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
;; Save all backup file in this directory.
(setq backup-directory-alist (list (cons "." backups_dir))) ;; "backups_dir" in index.el

;; Change bracket pairs from one type to another on current line or text selection
(global-set-key (kbd "C-c `") (lambda()
                                (interactive)
                                (setq from (read-string "Enter replacement:"))
                                (setq to (read-string "Enter new value:"))
                                (xah-change-bracket-pairs from to)
                                )
                )

;; Disable overwrite-mode with Insert key on keyboard
(define-key global-map [(insert)] nil)
(define-key global-map [(control insert)] 'overwrite-mode)

;; Project management [ projectile ]
(projectile-mode)
(setq projectile-switch-project-action 'projectile-dired)

;; Highlight brackets
(show-paren-mode 1)
(setq show-paren-delay 0)
(custom-set-faces
 `(show-paren-match ((t (:background ,brackets_match_background :foreground ,brackets_match_foreground)))) ;; "brackets_match_background", "brackets_match_foreground" in index.el
 `(show-paren-mismatch ((((class color)) (:background ,brackets_mismatch_background :foreground ,brackets_mismatch_foreground))))) ;; "brackets_mismatch_background", "brackets_mismatch_foreground" in index.el

;; Disable word wrap
(set-default 'truncate-lines t)

;; Whitespace mode
(require 'whitespace)
(setq whitespace-display-mappings
      '(
        (space-mark ?\ [?\u00B7] [?.]) ;; (space-mark ? [?\u00B7])
        (newline-mark ?\n [?\u2039 ?\n]) ;; u21DA, u00AB, ¶, u21B5, u25C0
        (tab-mark ?\t [?\u203A ?\t]) ;; u21DB, u00BB, u00BB
        ))
(setq whitespace-style '(face trailing tabs spaces newline space-mark tab-mark newline-mark))
(set-face-attribute 'whitespace-space nil
                    :background whitespace_background ;; "whitespace_background" in index.el
                    :foreground whitespace_foreground ;; "whitespace_foreground" in index.el
                    :weight whitespace_weight) ;; ultra-bold, extra-bold, bold, semi-bold, normal, semi-light, light, extra-light, ultra-light
(set-face-attribute 'whitespace-newline nil
                    :background whitespace_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight) ;; "whitespace_weight" in index.el
(set-face-attribute 'whitespace-tab nil
                    :background whitespace_background
                    :foreground whitespace_foreground
                    :weight whitespace_weight)
(set-face-attribute 'whitespace-trailing nil
                    :background whitespace_trailing_background ;; "whitespace_trailing_background" in index.el
                    :foreground whitespace_trailing_foreground ;; "whitespace_trailing_foreground" in index.el
                    :weight whitespace_trailing_weight) ;; "whitespace_trailing_weight" in index.el
(setq whitespace-line nil) ;; disable a bug, that highlight long lines
(setq whitespace-empty nil) ;; disable a bug, that highlight last line
(global-whitespace-mode 1)

;; Highlight current line
(defface hl-line `((t (:background ,hl_line_background :underline nil :box nil))) ;; "hl_line_background" in index.el
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t)

;; Hightlight selection region
(set-face-attribute 'region nil :background hl_region_background) ;; "hl_region_background" in index.el
;; (set-face-attribute 'region nil :box '(:color "black" :line-width -1))

;; highlight-symbol
(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 1)
;; redefine highlight face attributes
(set-face-attribute 'highlight-symbol-face nil :background nil :underline `(:color ,hl_occurrences_color)) ;; "hl_occurrences_color" in index.el
;; (set-face-attribute 'highlight-symbol-face nil :background hl_occurrences_color :underline nil )
;; (set-face-attribute 'highlight-symbol-face nil :background nil :box `(:line-width -1 :color ,hl_occurrences_color )) ;; "hl_occurrences_color" in index.el

;;Set cursor color
(set-cursor-color cursor_color) ;; "cursor_color" in index.el

;; Duplicate line, hotkey to duplicate line ( Ctrl + c, d )
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
    With argument N, make N copies.
    With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region ;; Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;; Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1))) ;; Insert N times, or once if not specified
          (insert text))))
    (if use-region nil ;; Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;; Save column
        (if (> 0 n) ;; Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))
(global-set-key (kbd "C-c d") 'duplicate-line-or-region)

;; Move selected  text up or down ( Alt + Shift + [ P || N ] )
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))
(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))
(global-set-key (kbd "M-P") 'move-line-up)
(global-set-key (kbd "M-N") 'move-line-down)

;; Multiple-cursors.el ( from elpa )
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; Revert-buffer
(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-auto-revert-mode)

;; Company mode [ autocomplete ]
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-statistics)
(company-statistics-mode)

;; Dired tries to guess a default target directory
(setq dired-dwim-target t)

;; Zip and unzip support
;; Z - key compress-uncompress file
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

;; google translator
(require 'google-translate)
(require 'google-translate-default-ui)
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "ru")
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c T") 'google-translate-query-translate)
(global-set-key (kbd "C-c r") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c R") 'google-translate-query-translate-reverse)

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Require dockerfile-mode
(require 'dockerfile-mode)

;; yasnippet
(if (boundp 'yas-snippet-dirs) ;; first, set where our yasnippets are placed
    (setq yas-snippet-dirs (append `(,yasnippets_directory) yas-snippet-dirs)) ;; if yas-snippet-dirs defined add our directories to begin of list
  (setq yas-snippet-dirs `(,yasnippets_directory))) ;; otherwise define yas-snippet-dirs with our directories
(yas-global-mode 1) ;; second

;; disable newline at end
(setq mode-require-final-newline nil)

;; Vim-like text folding for Emacs
(global-set-key (kbd "C-c f") #'vimish-fold)
(global-set-key (kbd "C-c u") #'vimish-fold-delete)
(vimish-fold-global-mode 1)

;; find - replace
;;(require 'xah-find)

;; Enable ivy mode
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; (setq ivy-count-format "(%d/%d) ")

;; vertical list in minibuffer
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;; Minibuffer autocompletition
;; (require 'ido)
;; (ido-mode t)

;; Smex [ M-x enhancement ]
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; grep with exclude directories or files
(eval-after-load "grep"
  '(progn
    ;; (add-to-list 'grep-find-ignored-files "*.tmp")
    (add-to-list 'grep-find-ignored-directories ".git")
    (add-to-list 'grep-find-ignored-directories "node_modules")
    (add-to-list 'grep-find-ignored-directories "bower_components")))

;; wakatime mode for certain project paths ( do not forget create ~/.wakatime.cfg file with configs and api key )
;; all configs in ~/.wakatime.cfg
(custom-set-variables '(wakatime-cli-path "/usr/local/bin/wakatime")) ;; do not forget set path to wakatime binary ( shell command: which wakatime )
(global-wakatime-mode)

;; Replase remove, by remove in trash
(setq delete-by-moving-to-trash t)

;; Enable debug
(setq debug-on-error t)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; base-modes-setup.el ends here
