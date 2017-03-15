;;; base --- common configuration:
;;; Commentary:
;;; Code:

;; * START - Params *
;; "directory-root" defined in index.el
(defconst base-dir "~/.emacs.d/")
(defconst config-dir (concat base-dir "configs/"))
(defconst backups-dir (concat base-dir "backups/"))
(defconst themes-dir (concat directory-root "themes/")) ;; TODO: __need fix__
(defconst font "Menlo-9")
;; define theme for window
(set 'win-theme 'sunburst)
;; define theme for terminal
(set 'term-theme 'sunburst)
;; Packages list
(setq package-list '( smex undo-tree multiple-cursors company company-statistics projectile dtrt-indent))
;; * END *

;; * START - Prepare config directories *
(if(not(file-accessible-directory-p config-dir))
    (make-directory config-dir t)
  )
(if(not(file-accessible-directory-p backups-dir))
   (make-directory backups-dir t)
  )
(if(not(file-accessible-directory-p themes-dir))
   (make-directory themes-dir t)
  )
;; * END *

;; * START - Package repositories *
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; * END *

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
          (if (y-or-n-p (format "Package \"%s\" is missing. Do you want to install? " package))
              (package-install package)))
        )

      ;; Rollback original archives
      (setq package-archives archives-copy)
      )
  )
;; * END *

;; * START - Save session *
(setq desktop-dirname config-dir)
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

;; * Fringe-mode [ disable borders on left and right ] *
(set-fringe-mode 0)

;; * Display the name of the current buffer in the title *
(setq frame-title-format "%F: %f")

;; * START - Display file size/time in mode-line
(setq display-time-24hr-format t)
(display-time-mode             t)
(size-indication-mode          t)
;; * END *

;; * Set cursor type *
;;(setq-default cursor-type 'bar)

;; * START - Set theme [ for window or terminal ] *
(add-to-list 'custom-theme-load-path themes-dir)
(load-theme win-theme t)
(load-theme term-theme t)
(if(display-graphic-p)
    (enable-theme win-theme) ;; window theme
  (enable-theme term-theme)) ;; terminal theme
;; * END *

;; * Set font *
(set-default-font font)

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
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/"))) ;; TODO: __need fix__
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
 '(show-paren-match ((t (:background "#000296"))))
 '(show-paren-mismatch ((((class color)) (:background "red" :foreground "white")))))
;; * END *

;; * Disable word wrap *
(set-default 'truncate-lines t)

;; * Remove in trash *
(setq delete-by-moving-to-trash t)

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
                    :background "#070707"
                    :foreground "#212121"
                    :weight 'light) ;; ultra-bold, extra-bold, bold, semi-bold, normal, semi-light, light, extra-light, ultra-light
(set-face-attribute 'whitespace-newline nil
                    :background "#070707"
                    :foreground "#212121"
                    :weight 'light)
(set-face-attribute 'whitespace-tab nil
                    :background "#070707"
                    :foreground "#212121"
                    :weight 'light)
(set-face-attribute 'whitespace-trailing nil
                    :background "#070707"
                    :foreground "#ff2020"
                    :weight 'light)
(setq whitespace-line nil) ;; disable a bug, that highlight long lines
(global-whitespace-mode 1)
;; * END *

;; * START - Disable tabs, set indentation *
(setq-default indent-tabs-mode nil)
(setq tab-width 3)
(require 'dtrt-indent)
(dtrt-indent-mode 1)
;; * END *

;; * START - Highlight current line *
(defface hl-line '((t (:background "#101010")))
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t)
;; * END *

;; * Hightlight region *
(set-face-attribute 'region nil :background "#222222")

;;Set cursor color
(set-cursor-color "#0e0")
;;(set-mouse-color "goldenrod")

;; * START - Duplicate line, hotkey to duplicate line ( Ctrl + c, d ) *
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
    With argument N, make N copies.
    With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
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

;; * UNDO-REDO melpa plugin *
(require 'undo-tree)
(global-undo-tree-mode t)

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

;;; base.el ends here
