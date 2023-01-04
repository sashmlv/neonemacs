;;; base-setup.el --- modes configuration
;;; Commentary:
;;; Code:

;; save session
(setq desktop-restore-eager 100) ;; how much buffers restore immediately
(setq desktop-dirname user-emacs-directory)
(setq desktop-base-file-name "emacs.desktop")
(setq desktop-base-lock-name "lock")
(setq desktop-path (list desktop-dirname))
(setq desktop-restore-frames t)
(setq desktop-save t)
(desktop-save-mode t)

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

(setq scroll-step 1 scroll-conservatively  10000) ;; smooth scrolling

(delete-selection-mode t) ;; delete selection

(setq version-control t) ;; enable versioning
(setq delete-old-versions t)
(setq delete-by-moving-to-trash t)
(setq kept-new-versions 6)
(setq kept-old-versions 3)
(setq vc-make-backup-files t)

(setq make-backup-files t) ;; backup files
(setq backup-directory-alist (list (cons "." neon-backup-dir))) ;; backup directory

(defalias 'list-buffers 'ivy-switch-buffer) ;; make ibuffer default

;; vertical buffer split by default
;; (setq split-width-threshold 0)
;; (setq split-height-threshold nil)

(setq blink-cursor-blinks 0) ;; make cursor blinking always

;; highlight brackets
(show-paren-mode 1)
(setq show-paren-delay 0)

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

;; revert-buffer from file
(global-auto-revert-mode)

(setq mode-require-final-newline nil) ;; remove newline at end

;; (setq debug-on-error t)

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

;; undo limits
(setq undo-limit (* 3 undo-limit))
(setq undo-strong-limit (* 3 undo-strong-limit))

;; editorconfig
(editorconfig-mode 1)

;; isearch
(setq isearch-allow-scroll t)
(setq isearch-wrap-pause nil)

;;; base-setup.el ends here
