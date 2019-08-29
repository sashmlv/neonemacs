;;; neon-theme.el --- Neon Theme

;; Copyright 2019-present, All rights reserved
;;
;; Code licensed under the MIT license

;; Author: sashmlv
;; Version: 0.0.1
;; Package-Requires: ((emacs "24"))

;;; Commentary:

;;; Code:

(deftheme neon)

(let ((colors '((fg1               "#f8f8f2")
                (fg2               "#e2e2dc")
                (fg3               "#ccccc7")
                (fg4               "#b6b6b2")
                (bg1               "#000000")
                (bg2               "#373844")
                (bg3               "#464752")
                (bg4               "#565761")
                (bg5               "#44475a")
                (cursor            "#00EE00")
                (builtin           "#FF1493")
                (keyword           "#FF00FF")
                (const             "#00FFFF")
                (comment           "#909090")
                (func              "#8400FF")
                (str               "#FFFF00")
                (type              "#bd93f9")
                (var               "#00FF28")
                (warning           "#ff0303")
                (region            "#109010")
                (whitespace_fg     "#252525")
                (whitespace_bg     "#000000")
                (whitespace_trfg   "#FF0000")
                (indentation_fg    "#303030")
                (indentation_bg    "#101010")
                (hl_line_bg        "#151515")
                ))
      (faces '(;; default
               (cursor :background ,cursor)
               (default :background ,bg1 :foreground ,fg1)
               (default-italic :italic t)
               (ffap :foreground ,fg4)
               (fringe :background ,bg1 :foreground ,fg4)
               (highlight :foreground ,fg3 :background ,bg3)
               (info-quoted-name :foreground ,builtin)
               (info-string :foreground ,str)
               (lazy-highlight :foreground ,fg2 :background ,bg3)
               (link :foreground ,const :underline t)
               (linum :slant italic :foreground ,bg4 :background ,bg1)
               (minibuffer-prompt :bold t :foreground ,keyword)
               (show-paren-match-face :background ,warning)
               (vertical-border :foreground ,bg2)
               (warning :foreground ,warning)
               (header-line :background ,bg1)
               ;; syntax
               (font-lock-builtin-face :foreground ,builtin)
               (font-lock-comment-face :foreground ,comment)
               (font-lock-constant-face :foreground ,const)
               (font-lock-doc-face :foreground ,comment)
               (font-lock-function-name-face :foreground ,func :bold t)
               (font-lock-keyword-face :bold t :foreground ,keyword)
               (font-lock-negation-char-face :foreground ,const)
               (font-lock-reference-face :foreground ,const)
               (font-lock-string-face :foreground ,str)
               (font-lock-type-face :foreground ,type )
               (font-lock-variable-name-face :foreground ,var)
               (font-lock-warning-face :foreground ,warning :background ,bg2)
               ;; whitespace
               (whitespace-space :foreground ,whitespace_fg :background ,whitespace_bg :weight light)
               (whitespace-newline :foreground ,whitespace_fg :background nil :weight light)
               (whitespace-tab :foreground ,whitespace_fg :background nil :weight light)
               (trailing-whitespace :foreground ,whitespace_trfg :background ,whitespace_bg :weight light)
               (whitespace-trailing :inherit trailing-whitespace)
               ;; indentation
               (highlight-indentation-face :foreground ,indentation_fg :background ,indentation_bg)
               (highlight-indentation-current-column-face :foreground nil :background nil)
               ;; region
               (region :foreground nil :background ,region :distant-foreground nil)
               ;; hl-line-mode
               (hl-line :foreground nil :background ,hl_line_bg)
               ;; auto-complete
               (ac-completion-face :underline t :foreground ,keyword)
               ;; js2-mode
               (js2-external-variable :foreground ,type  )
               (js2-function-param :foreground ,const)
               (js2-jsdoc-html-tag-delimiter :foreground ,str)
               (js2-jsdoc-html-tag-name :foreground ,fg4)
               (js2-jsdoc-value :foreground ,str)
               (js2-private-function-call :foreground ,const)
               (js2-private-member :foreground ,fg3)
               ;; js3-mode
               (js3-error-face :underline ,warning)
               (js3-external-variable-face :foreground ,var)
               (js3-function-param-face :foreground ,fg4)
               (js3-instance-member-face :foreground ,const)
               (js3-jsdoc-tag-face :foreground ,keyword)
               (js3-warning-face :underline ,keyword)
               ;; mode-line
               (mode-line :foreground nil :background ,bg3 :box ,bg3)
               (mode-line-inactive :foreground ,fg1 :background ,bg1 :box ,bg1)
               ;; web-mode
               (web-mode-builtin-face :inherit ,font-lock-builtin-face)
               (web-mode-comment-face :inherit ,font-lock-comment-face)
               (web-mode-constant-face :inherit ,font-lock-constant-face)
               (web-mode-doctype-face :inherit ,font-lock-comment-face)
               (web-mode-function-name-face :inherit ,font-lock-function-name-face)
               (web-mode-html-attr-name-face :foreground ,type)
               (web-mode-html-attr-value-face :foreground ,func)
               (web-mode-html-tag-face :foreground ,keyword :bold t)
               (web-mode-keyword-face :foreground ,keyword)
               (web-mode-string-face :foreground ,str)
               (web-mode-type-face :inherit ,font-lock-type-face)
               (web-mode-warning-face :inherit ,font-lock-warning-face)
               )))

  (apply #'custom-theme-set-faces
         'neon
         (let ((color-names (mapcar #'car colors))
               (graphic-colors (mapcar #'cadr colors))
               (tty-colors (mapcar #'car (mapcar #'last colors))))
           (cl-flet* ((expand-for-tty (spec) (cl-progv color-names tty-colors
                                               (eval `(backquote ,spec))))
                      (expand-for-graphic (spec) (cl-progv color-names graphic-colors
                                                   (eval `(backquote ,spec)))))
             (cl-loop for (face . spec) in faces
                      collect `(,face
                                ((((type tty))
                                  ,(expand-for-tty spec))
                                 (((type graphic))
                                  ,(expand-for-graphic spec)))))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'neon)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; neon-theme.el ends here
