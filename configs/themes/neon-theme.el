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

(let ((colors '((fg1          "#f8f8f2")
                (fg2          "#e2e2dc")
                (fg3          "#ccccc7")
                (fg4          "#b6b6b2")
                (bg1          "#000000")
                (bg2          "#373844")
                (bg3          "#464752")
                (bg4          "#565761")
                (bg5          "#44475a")
                (cursor       "#00EE00")
                (builtin      "#5973FF" )
                ;; (builtin      "#00A693" )
                (keyword      "#FF00FF" )
                (const        "#00FFF6" )
                ;; (const        "#5F2DFF" )
                (comment      "#9E9E9E")
                (func         "#00FF28" )
                ;; (func         "#54ff9f" )
                (str          "#FFFF00" )
                (type         "#bd93f9")
                (var          "#8400FF" )
                ;; (var          "#9573FF" )
                (warning      "#ff0303")
                (region       "#242424")
                ))
      (faces '(;; default
               (cursor :background ,cursor)
               (default :background ,bg1 :foreground ,fg1)
               (default-italic :italic t)
               (ffap :foreground ,fg4)
               (fringe :background ,bg1 :foreground ,fg4)
               (highlight :foreground ,fg3 :background ,bg3)
               (hl-line :background  ,bg5)
               (info-quoted-name :foreground ,builtin)
               (info-string :foreground ,str)
               (lazy-highlight :foreground ,fg2 :background ,bg3)
               (link :foreground ,const :underline t)
               (linum :slant italic :foreground ,bg4 :background ,bg1)
               (minibuffer-prompt :bold t :foreground ,keyword)
               (region :foreground nil :background ,region)
               (show-paren-match-face :background ,warning)
               (trailing-whitespace :foreground ,warning :background ,bg1)
               (vertical-border :foreground ,bg2)
               (warning :foreground ,warning)
               (whitespace-trailing :inherit trailing-whitespace)
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
