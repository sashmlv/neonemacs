;;; base-setup --- available modes configuration:
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
;; Enable versioning with default values (keep five last versions, I think.)
(setq version-control t)
;; Save all backup file in this directory.
(setq backup-directory-alist (list (cons "." backups_dir)))

;; Change bracket pairs from one type to another on current line or text selection
(global-set-key (kbd "C-c `") (lambda() (interactive) (setq from (read-string "Enter replacement:")) (setq to (read-string "Enter new value:")) (xah-change-bracket-pairs from to)))

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
 `(show-paren-match ((t (:background ,brackets_match_background :foreground ,brackets_match_foreground))))
 `(show-paren-mismatch ((((class color)) (:background ,brackets_mismatch_background :foreground ,brackets_mismatch_foreground)))))

;; Disable word wrap
(set-default 'truncate-lines t)

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

;; Revert-buffer
(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-auto-revert-mode)

;; Dired tries to guess a default target directory
(setq dired-dwim-target t)

;; Zip and unzip support
;; Z - key compress-uncompress file
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

;; disable newline at end
(setq mode-require-final-newline nil)

;; grep with exclude directories or files
(eval-after-load "grep"
  '(progn
    ;; (add-to-list 'grep-find-ignored-files "*.tmp")
    (add-to-list 'grep-find-ignored-directories ".git")
    (add-to-list 'grep-find-ignored-directories "node_modules")
    (add-to-list 'grep-find-ignored-directories "bower_components")))

;; Replase remove, by remove in trash
(setq delete-by-moving-to-trash t)

;; Enable debug
(setq debug-on-error t)

;; find - replace
(require 'xah-find)

;; Require dockerfile-mode
(require 'dockerfile-mode)

;; Enable ivy mode
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; (setq ivy-count-format "(%d/%d) ")

;; Minibuffer autocompletition
;; (require 'ido)
;; (ido-mode t)

;; expand-region for faster text selection
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; dumb-jump, variable definition jump
(dumb-jump-mode)

;; smart-mode-line
(setq sml/no-confirm-load-theme t) ;; do not ask load theme at startup
(setq sml/theme 'dark)
(sml/setup)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; base-setup.el ends here
