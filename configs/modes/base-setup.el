;;; base-setup --- available modes configuration:
;;; Commentary:
;;; Code:

;; save session
(setq desktop-restore-eager 12) ;; how much buffers restore immediately
(setq desktop-dirname base_dir)
(setq desktop-base-file-name "emacs.desktop")
(setq desktop-base-lock-name "lock")
(setq desktop-path (list desktop-dirname))
(setq desktop-restore-frames t)
(setq desktop-save t)
(desktop-save-mode t)
(desktop-read)

(fset 'yes-or-no-p 'y-or-n-p) ;; change "yes or no" to "y or n"

;; disable GUI components
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(if (fboundp 'global-linum-mode) (global-linum-mode -1))

(setq frame-title-format "%F: %f") ;; display current buffer file in the title

;; (setq-default cursor-type 'bar) ;; set cursor type

(set-fringe-mode 0) ;; disable borders

(set-default-font current_font) ;; set font

(setq scroll-step 1 scroll-conservatively  10000) ;; smooth scrolling

(delete-selection-mode t) ;; shift + d - delete selection

(setq make-backup-files t) ;; backup files

(setq version-control t) ;; enable versioning

(setq backup-directory-alist (list (cons "." backups_dir))) ;; backup directory

(defalias 'list-buffers 'ibuffer) ;; make ibuffer default

;; change bracket pairs from one type to another, on current line or text selection
(global-set-key
 (kbd "C-c `")
 (lambda()
   (interactive)
   (setq from (read-string "Enter replacement:"))
   (setq to (read-string "Enter new value:"))
   (xah-change-bracket-pairs from to)))

;; disable "insert" key ( which toggle overwrite-mode )
(define-key global-map [(insert)] nil)
(define-key global-map [(control insert)] 'overwrite-mode)

;; project management
(projectile-mode)
(setq projectile-switch-project-action 'projectile-dired)

;; highlight brackets
(show-paren-mode 1)
(setq show-paren-delay 0)
(custom-set-faces
 `(show-paren-match
   ((t (:background ,brackets_match_background :foreground ,brackets_match_foreground))))
 `(show-paren-mismatch
   ((((class color)) (:background ,brackets_mismatch_background :foreground ,brackets_mismatch_foreground)))))

(set-default 'truncate-lines t) ;; disable word wrap

;; duplicate line ( Ctrl + c, d )
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

;; up or down selected text ( Alt + Shift + [ P || N ] )
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

;; revert-buffer from file
(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-auto-revert-mode)

;; dired tries to guess a default target directory
(setq dired-dwim-target t)

;; zip/unzip, Z - key compress/uncompress
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

(setq mode-require-final-newline nil) ;; remove newline at end

;; grep skip these list
(eval-after-load "grep"
  '(progn
     ;; (add-to-list 'grep-find-ignored-files "*.tmp")
     (add-to-list 'grep-find-ignored-directories ".git")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "bower_components")))

(setq delete-by-moving-to-trash t) ;; replace remove, whith remove in trash

(setq debug-on-error t) ;; enable debug

;; enable ivy mode ;; also try install all-the-icons, all-the-icons-ivy
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; (setq ivy-count-format "(%d/%d) ")

;; minibuffer autocompletition
;; (require 'ido)
;; (ido-mode t)

;; expand-region faster text selection
(global-set-key (kbd "C-=") 'er/expand-region)

;; variable definition jump
(dumb-jump-mode)

;; make shortcuts working in russian layout
(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))
(cfg:reverse-input-method 'russian-computer)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; base-setup.el ends here
