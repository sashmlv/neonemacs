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

;; search colors
(custom-set-faces
 `(lazy-highlight
   ((t (:foreground nil :background ,hl_search_occurrences_color)))))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; theme.el ends here
