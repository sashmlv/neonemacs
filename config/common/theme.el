;;; theme.el --- theme configuration
;;; Commentary:
;;; Code:

;; define theme for window
;; (set 'win-theme 'dracula) ;; sunburst, flatland-black, peacock
(set 'win-theme 'neon) ;; neon, cyberpunk, grandshell

;; define theme for terminal
(set 'term-theme 'dracula)

;; set theme for window or terminal
(add-to-list 'custom-theme-load-path theme_dir)
(load-theme win-theme t)
(load-theme term-theme t)
(if (display-graphic-p)
    (enable-theme win-theme) ;; window theme
  (enable-theme term-theme)) ;; terminal theme

;; whitespace
;; (require 'whitespace)
;; (set-face-attribute 'whitespace-space nil :foreground "#252525" :background nil :weight 'light)
;; (set-face-attribute 'whitespace-newline nil :foreground "#252525" :background nil :weight 'light)
;; (set-face-attribute 'whitespace-tab nil :foreground "#252525" :background nil :weight 'light)
;; (set-face-attribute 'trailing-whitespace nil :foreground "#FF0000" :background nil :weight 'light)
;; (set-face-attribute 'whitespace-trailing nil :inherit 'trailing-whitespace)
;; ;; indentation
;; (set-face-attribute 'highlight-indentation-face nil :foreground "#303030" :background "#101010")
;; (set-face-attribute 'highlight-indentation-current-column-face nil :foreground nil :background nil)
;; ;; region
;; (set-face-attribute 'region nil :foreground nil :background "#575757" :distant-foreground nil)

;; ;; hl-line-mode
;; (global-hl-line-mode 1) ;; highlight curent line
;; (set-face-attribute 'hl-line nil :foreground nil :background "#151515")

;;; theme.el ends here
