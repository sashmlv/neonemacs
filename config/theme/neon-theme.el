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

(defun get-highlight-indentation-face-stipple ()
  "Return stipple for highlight indentation face."
  (list
   (frame-char-width (selected-frame))
   (frame-char-height (selected-frame))
   (apply 'string (make-list (* (frame-char-width (selected-frame)) (frame-char-height (selected-frame))) 8))))

(add-hook ;; fix face stipple for indentation
 'after-setting-font-hook
 (lambda () (set-face-attribute 'highlight-indentation-face nil :stipple (get-highlight-indentation-face-stipple))))

(let ((colors '((fg1               "#FFFFFF") ;; main font #F8F8F2
                (fg2               "#E2E2DC")
                (fg3               "#CCCCC7")
                (fg4               "#B6B6B2")
                (bg1               "#000000")
                (bg2               "#373844")
                (bg3               "#464752")
                (bg4               "#565761")
                (bg5               "#44475A")
                (cursor            "#00FF00")
                (builtin           "#FF1493")
                (keyword           "#FF00FF")
                (const             "#00FFFF")
                (comment           "#909090")
                (func              "#9612FF") ;; #9006FF, #8400FF
                (str               "#FFFF44")
                (type              "#BD93F9")
                (var               "#00FF28")
                (warning           "#FF0303")
                (region            "#109010")
                (whitespace-fg     "#272727")
                (whitespace-bg     "#000000")
                (whitespace-trfg   "#FF0000")
                (indentation-fg    "#303030")
                (hl-line-bg        "#151515")
                (hl-line-bg        "#151515")
                (dired-directory   "#009688")
                (dired-flagged     "#F44336")
                (dired-header      "#BC4873")
                (dired-mark        "#FFD600")
                (dired-marked      "#5C6BC0")
                (dired-perm-write  "#E57373")
                (dired-symlink     "#BDBDBD")
                (dired-warning     "#FF0303")
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
               (link :foreground ,const :underline t)
               (linum :slant italic :foreground ,bg4 :background ,bg1)
               (minibuffer-prompt :bold t :foreground ,keyword)
               (vertical-border :foreground ,bg2)
               (warning :foreground ,warning)
               (header-line :background ,bg1)
               ;; search occurrences
               (lazy-highlight :foreground nil :background "#3A5FCD")
               ;; parentheses
               (show-paren-match :foreground "#FFFFFF" :background "#0000CD")
               (show-paren-mismatch :foreground "#FFFFFF" :background "#CD0000")
               ;; syntax
               ;; background "black"
               ;; font-lock-doc-string-face
               ;; font-lock-comment-delimiter-face
               ;; font-lock-preprocessor-face
               ;; font-lock-regexp-grouping-backslash
               ;; font-lock-regexp-grouping-construct
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
               (whitespace-space :foreground ,whitespace-fg :background ,whitespace-bg :weight light)
               (whitespace-newline :foreground ,whitespace-fg :background nil :weight light)
               (whitespace-tab :foreground ,whitespace-fg :background nil :weight light)
               (trailing-whitespace :foreground ,whitespace-trfg :background ,whitespace-bg :weight light)
               (whitespace-trailing :inherit trailing-whitespace)
               (whitespace-line :foreground nil :background nil)
               ;; (whitespace-empty :foreground nil :background nil) ;; remove this ?
               ;; indentation
               (highlight-indentation-current-column-face :foreground nil :background nil)
               (highlight-indentation-face
                :foreground ,indentation-fg
                :background nil
                :stipple ,(get-highlight-indentation-face-stipple)
                :inherit nil
                )
               ;; region
               (region :foreground nil :background ,region :distant-foreground nil)
               ;; hl-line-mode
               (hl-line :foreground nil :background ,hl-line-bg)
               ;; auto-complete
               (ac-completion-face :underline t :foreground ,keyword)
               ;; js2-mode
               (js2-external-variable :foreground ,type)
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
               ;; dired
               (dired-directory :foreground ,dired-directory :weight normal)
               (dired-flagged :foreground ,dired-flagged)
               (dired-header :foreground ,dired-header :background ,bg1)
               (dired-ignored :inherit shadow) ;; ???
               (dired-mark :foreground ,dired-mark :weight bold)
               (dired-marked :foreground ,dired-marked :weight bold)
               (dired-perm-write :foreground ,dired-perm-write :underline nil)
               (dired-symlink :foreground ,dired-symlink :weight normal :slant italic)
               (dired-warning :foreground ,warning :underline t)
               ;; mode-line
               (mode-line :inverse-video nil :foreground ,fg1 :background ,bg1 :weight normal)
               (mode-line-inactive :inverse-video nil :foreground ,fg1 :background ,bg1 :weight normal)
               ;; vc-mode
               (vc-state-base :foreground "#FF1493")
               ;; highlight symbol face
               (highlight-symbol-face :background "#000000" :underline (:color "#7FFF00"))
               ;; (highlight-symbol-face :background "#7FFF00" :underline nil )
               ;; (highlight-symbol-face :background nil :box (:line-width -1 :color "#7FFF00"))
               ;; lsp-mode
               (lsp-face-highlight-read :background nil)
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
