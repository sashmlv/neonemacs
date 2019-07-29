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
                (cursor       "green2")
                (builtin      "MediumPurple1")
                (keyword      "deep pink")
                (const        "#00e5ff")
                (comment      "#afafaf")
                (func         "SeaGreen1")
                (str          "yellow")
                (type         "#bd93f9")
                (var          "#f8f8f2")
                (warning      "#ff0000")
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
               (region :background ,str :foreground ,bg1)
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
