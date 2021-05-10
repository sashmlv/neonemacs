;;; font.el --- font
;;; Commentary:
;;; Code:

;; Andale Mono, Anonymous Pro, Consolas, DejaVu Sans Mono, Envy Code R, Fira Code, Fira Mono,
;; Hack, IBM Plex Mono, Iosevka, JetBrains Mono, Liberation Mono, Lucida Console, Lucida Sans,
;; M+ 1m, Menlo, Monaco, Monospace, PT Mono, Rec Mono Linear, Source Code Pro, Ubuntu Mono
(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(setq current_font (font-get (face-attribute 'default :font) :name))
(setq current_font_name_regex "[-\s][0-9]*$")
(setq current_font_size_regex ".*[^0-9]+")
(setq current_font_name (replace-regexp-in-string current_font_name_regex "" current_font))
(setq current_font_size (replace-regexp-in-string current_font_size_regex "" current_font))
(setq current_font_file (concat user-emacs-directory (directory-file-name "current-font")))

(if (file-exists-p current_font_file) ;; read font from file
    (progn
      (setq current_font (get-string-from-file current_font_file))
      (setq current_font_name (replace-regexp-in-string current_font_name_regex "" current_font))
      (setq current_font_size (replace-regexp-in-string current_font_size_regex "" current_font))))

(if current_font
    (set-frame-font current_font)) ;; set font

(defun switch-font-name()
  "Switch font name."
  (interactive)
  (setq current_font_name
        (completing-read
         "Switch font name: "
         (delq nil (delete-dups (font-family-list)))
         nil t))
  (setq current_font (format "%s-%s" current_font_name current_font_size))
  (set-frame-font current_font)
  (write-region current_font nil current_font_file))

(defun switch-font-size()
  "Switch font size."
  (interactive)
  (setq current_font_size
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
  (setq current_font (format "%s-%s" current_font_name current_font_size))
  (set-frame-font current_font)
  (write-region current_font nil current_font_file))

(defun show-current-font()
  "Switch font size."
  (interactive)
  (message (font-get (face-attribute 'default :font) :name)))

;;; font.el ends here
