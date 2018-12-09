;;; theme --- theme configuration:
;;; Commentary:
;;; Code:

;; set theme for window or terminal
(add-to-list 'custom-theme-load-path themes_dir)
(load-theme win-theme t)
(load-theme term-theme t)
(if (display-graphic-p)
    (enable-theme win-theme) ;; window theme
  (enable-theme term-theme)) ;; terminal theme

(set-background-color background_color) ;; background color

;; highlight curent line with face
(defface hl-line-face

  ;; foreground nil - to keep syntax highlighting
  `((t (:background ,hl_line_background :foreground nil)))
  "Face to use for `hl-line-face'." :group 'hl-line)

(setq hl-line-face 'hl-line-face)
(setq highlight-face 'hl-line-face)
(global-hl-line-mode t)

(set-face-background 'region hl_region_background) ;; hightlight region
(set-face-foreground 'region nil) ;; keep syntax highlighting
(set-face-attribute 'region nil :distant-foreground nil) ;; keep syntax highlighting

(set-cursor-color cursor_color) ;; set cursor color

;; search colors
(custom-set-faces
 `(lazy-highlight
   ((t (:foreground nil :background ,hl_search_occurrences_color)))))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; theme.el ends here
