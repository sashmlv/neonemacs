;;; font.el --- font
;;; Commentary:
;;; Code:

;; Andale Mono, Anonymous Pro, Consolas, DejaVu Sans Mono, Envy Code R,
;; Fira Code, Fira Mono, Hack, IBM Plex Mono, Iosevka, JetBrains Mono, Liberation Mono, Lucida Console,
;; Lucida Sans, M+ 1m, Menlo, Monaco, PT Mono, Rec Mono Linear, Source Code Pro, Ubuntu Mono
;; DejaVu Sans Mono
(defun neon-get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(setq neon-font (font-get (face-attribute 'default :font) :name))
(setq neon-font-name-regex "[-\s][0-9]*$")
(setq neon-font-size-regex ".*[^0-9]+")
(setq neon-font-name (replace-regexp-in-string neon-font-name-regex "" neon-font))
(setq neon-font-size (replace-regexp-in-string neon-font-size-regex "" neon-font))
(setq neon-font-file (concat user-emacs-directory (directory-file-name "neon-font")))

(if (file-exists-p neon-font-file) ;; read font from file
    (progn
      (setq neon-font (neon-get-string-from-file neon-font-file))
      (setq neon-font-name (replace-regexp-in-string neon-font-name-regex "" neon-font))
      (setq neon-font-size (replace-regexp-in-string neon-font-size-regex "" neon-font))))

(if neon-font
    (set-frame-font neon-font)) ;; set font

(defun neon-switch-font-name()
  "Switch font name."
  (interactive)
  (setq neon-font-name
        (completing-read
         "Switch font name: "
         (delq nil (delete-dups (font-family-list)))
         nil t))
  (setq neon-font (format "%s-%s" neon-font-name neon-font-size))
  (set-frame-font neon-font)
  (write-region neon-font nil neon-font-file))

(defun neon-switch-font-size()
  "Switch font size."
  (interactive)
  (setq neon-font-size
        (completing-read
         "Switch font size: "
         '(("5")
           ("6")
           ("7")
           ("8")
           ("9")
           ("10")
           ("11")
           ("12"))
         nil t))
  (setq neon-font (format "%s-%s" neon-font-name neon-font-size))
  (set-frame-font neon-font)
  (write-region neon-font nil neon-font-file))

(defun neon-show-font()
  "Switch font size."
  (interactive)
  (message (font-get (face-attribute 'default :font) :name)))

;;; font.el ends here
