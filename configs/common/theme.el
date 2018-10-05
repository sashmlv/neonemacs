;;; theme --- theme configuration:
;;; Commentary:
;;; Code:

;; Set theme [ for window or terminal ] *
(add-to-list 'custom-theme-load-path themes_dir)
(load-theme win-theme t)
(load-theme term-theme t)
(if(display-graphic-p)
    (enable-theme win-theme) ;; window theme
  (enable-theme term-theme)) ;; terminal theme

;; Background color
(set-background-color background_color)

;; Highlight curent line with face
(defface hl-line-face `((t (:background ,hl_line_background :foreground nil))) ;; foreground nil - to keep syntax highlighting
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line-face)
(setq highlight-face 'hl-line-face)
(global-hl-line-mode t)

;; Hightlight region
(set-face-background 'region hl_region_background)
(set-face-foreground 'region nil) ;; to keep syntax highlighting
(set-face-attribute 'region nil :distant-foreground nil) ;; to keep syntax highlighting

;; Set cursor color
(set-cursor-color cursor_color)

;; Set search
(custom-set-faces
 `(lazy-highlight ((t (:foreground nil :background ,hl_search_occurrences_color)))))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; theme.el ends here
