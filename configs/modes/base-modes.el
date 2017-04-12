;;; base-modes --- available modes configuration:
;;; Commentary:
;;; Code:

;; * START - Install packages from list *
;; Check installed packages
(setq need-package-install nil)
(dolist (package package-list)
  (if(not(package-installed-p package))
      (setq need-package-install t)
 ))

;; install packages if needed
(if need-package-install
    (progn
      ;; Get melpa archive into list
      (catch 'get-archive-melpa
        (dolist (archive package-archives)
          (when (equal (car archive) "melpa")
            (progn
              (setq archives (list archive))
              (throw 'get-archive-melpa archives))
            )
        )
        nil
        )

      ;; Copy original archives
      (setq archives-copy package-archives)

      ;; Set package-archives to melpa archive
      (setq package-archives archives)

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

      ;; Rollback original archives
      (setq package-archives archives-copy)
      )
  )
;; * END *

;; * START - Save session *
(setq desktop-restore-eager 7) ;; how buffers restore immediately
(setq desktop-dirname base_dir)
(setq desktop-base-file-name "emacs.desktop")
(setq desktop-base-lock-name "lock")
(setq desktop-path (list desktop-dirname))
(setq desktop-restore-frames t)
(setq desktop-save t)
(desktop-save-mode t)
(desktop-read)
;; * END *

;; * Change "yes or no" to "y or n" *
(fset 'yes-or-no-p 'y-or-n-p)

;; * START - Disable GUI components *
(tooltip-mode      -1)
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(global-linum-mode -1)
;; * END *

;; * Display file name of the current buffer in the title *
(setq frame-title-format "%F: %f")

;; * START - Display file size/time in mode-line
(setq display-time-24hr-format t)
(display-time-mode             t)
(size-indication-mode          t)
;; * END *

;; * Set cursor type *
;;(setq-default cursor-type 'bar)

;; * START - Set theme [ for window or terminal ] *
(add-to-list 'custom-theme-load-path themes_dir)
(load-theme win-theme t)
(load-theme term-theme t)
(if(display-graphic-p)
    (enable-theme win-theme) ;; window theme
  (enable-theme term-theme)) ;; terminal theme
;; * END *

;; * Fringe-mode [ disable borders on left and right ] *
(set-fringe-mode 0)

;; * Set font *
(set-default-font current_font)

;; * Smooth scrolling *
(setq scroll-step          1
scroll-conservatively  10000)

;; * Delete selection [ Shift + d { delete selected text } ] *
(delete-selection-mode t)

;; * START - Backup files. *
(setq make-backup-files t)
;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
;; Save all backup file in this directory.
(setq backup-directory-alist (list (cons "." backups_dir))) ;; "backups_dir" in index.el
;; * END *

;; * Minibuffer autocompletition *
(require 'ido)
(ido-mode t)

;; * START - Smex [ M-x enhancement ] *
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; * END *

;; * Project management [ projectile ] *
(projectile-mode)
(setq projectile-switch-project-action 'projectile-dired)

;; * START - Highlight brackets *
(show-paren-mode 1)
(setq show-paren-delay 0)
(custom-set-faces
 `(show-paren-match ((t (:background ,brackets_match_background :foreground ,brackets_match_foreground)))) ;; "brackets_match_background", "brackets_match_foreground" in index.el
 `(show-paren-mismatch ((((class color)) (:background ,brackets_mismatch_background :foreground ,brackets_mismatch_foreground))))) ;; "brackets_mismatch_background", "brackets_mismatch_foreground" in index.el
;; * END *

;; * Disable word wrap *
(set-default 'truncate-lines t)

;; * START - Whitespace mode *
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
;; * END *

;; * START - Highlight current line *
(defface hl-line `((t (:background ,hl_line_background))) ;; "hl_line_background" in index.el
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t)
;; * END *

;; * Hightlight selection region *
(set-face-attribute 'region nil :background hl_region_background) ;; "hl_region_background" in index.el
;; (set-face-attribute 'region nil :box '(:color "black" :line-width -1))

;;Set cursor color
(set-cursor-color cursor_color) ;; "cursor_color" in index.el

;; * START - Duplicate line, hotkey to duplicate line ( Ctrl + c, d ) *
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
;; * END *

;; * START - Move selected  text up or down ( Alt + Shift + [ P || N ] ) *
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
;; * END *

;; * START undo-tree melpa plugin ( undo-redo ) setup *
(require 'undo-tree)

(global-undo-tree-mode t)

;; auto save history
(setq undo-tree-auto-save-history t)

;; set history directory
(setq undo-tree-history-directory-alist `(("." . ,undo_redo_dir)))

;; compress history
(defadvice undo-tree-make-history-save-file-name
    (after undo-tree activate)
  (setq ad-return-value (concat ad-return-value ".gz")))

;; START custom code
(setq is_allow_execute_load_history_file t) ;; label for allowing execute (allow execute first on emacs initialization -> "t")

(defun set_allow_execute_load_history_file (orig-fun &rest args)
  (setq is_allow_execute_load_history_file t) ;; set allow execute hook parameter
  (apply orig-fun args) ;; call original function
  )

(advice-add 'walk-windows :around #'set_allow_execute_load_history_file) ;; hook launch on switch buffer manually

;; set hook that load undo-tree history files, when switching buffers
(if use_undo_tree_history_files ;; "use_undo_tree_history_files" in index.el
    (progn
      (setq loaded_undo_tree_history_files nil) ;; list of loaded history files
      (setq last_buffer_from_previous_session (buffer-name (car (buffer-list)))) ;; restore last used buffer, from previous session, from buffer list
      (setq undo_tree_history_initialized nil) ;; is undo-tree initialized
      (add-hook 'window-configuration-change-hook ;; hook when current-buffer will has actual value
                (lambda()
                  (progn
                    (if (or undo_tree_history_initialized (eq (buffer-name (current-buffer)) last_buffer_from_previous_session)) ;; on first loading, if not initialized, and it is last used buffer, restore history file (in next times, in other cases, parameter "undo_tree_history_initialized" make execute code allways)
                        (progn
                          (if (and
                               (not (member (buffer-file-name (current-buffer)) loaded_undo_tree_history_files)) ;; if history file still not loaded and ... ( see below )
                               (eq (type-of (buffer-file-name (current-buffer))) 'string) ;; if file name string
                               (buffer-file-name (current-buffer)) ;; if current buffer has file, load this undo-tree history file.
                               is_allow_execute_load_history_file ;; is allow execute
                               )
                              (progn
                                (setq undo_tree_history_initialized t) ;; set undo-tree was initialized
                                (setq is_allow_execute_load_history_file nil) ;; set back disallow execute hook
                                (undo-tree-load-history nil t) ;; load "current-buffer" history file, with disabled error message on file not found
                                (add-to-list 'loaded_undo_tree_history_files (buffer-file-name (current-buffer))) ;; save to list loaded history file, for prevent load again
                                )
                            )
                          )
                      )
                    )
                  )
                )
      )
  )
;; END
;; * END *

;; * START - Multiple-cursors.el ( from elpa ) *
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
;; * END *

;; * Revert-buffer *
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-auto-revert-mode)

;; * START - Company mode [ autocomplete ] *
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-statistics)
(company-statistics-mode)
;; * END *

;; * Dired tries to guess a default target directory *
(setq dired-dwim-target t)

;; * START - Zip and unzip support *
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))
;; * END *

;; * Replase remove, by remove in trash *
(setq delete-by-moving-to-trash t)

;; * Enable debug *
(setq debug-on-error t)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; base-modes.el ends here