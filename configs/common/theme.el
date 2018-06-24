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

;; Highlight current line
(global-hl-line-mode 1) ;; this line first
(set-face-background 'hl-line hl_line_background) ;; background face of the current line
(set-face-foreground 'highlight nil) ;; to keep syntax highlighting

;; Hightlight selection region
(set-face-background 'region hl_region_background) ;; background face of the current line
(set-face-foreground 'region nil) ;; to keep syntax highlighting

;; Set cursor color
(set-cursor-color cursor_color)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; theme.el ends here
