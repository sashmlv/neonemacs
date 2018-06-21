;;; custom-modes-setup --- custom modes configuration:
;;; Commentary:
;;; Code:

;; xah-syntax-color-hex mode [ Highlight colors ]
(defun xah-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
Version 2017-03-12"
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[[:xdigit:]]\\{3\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background
                      (let* (
                             (ms (match-string-no-properties 0))
                             (r (substring ms 1 2))
                             (g (substring ms 2 3))
                             (b (substring ms 3 4)))
                        (concat "#" r r g g b b))))))
     ("#[[:xdigit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-flush))

;; Change bracket pairs from one type to another on current line or text selection
(defun xah-change-bracket-pairs ( *from-chars *to-chars)
  "Change bracket pairs from one type to another on current line or text selection.
For example, change all parenthesis () to square brackets [].

When called in lisp program, *from-chars or *to-chars is a string of bracket pair. eg \"(paren)\",  \"[bracket]\", etc.
The first and last characters are used.
If the string contains “,2”, then the first 2 chars and last 2 chars are used, for example  \"[[bracket,2]]\".
If *to-chars is equal to string “delete brackets”, the brackets are deleted.

 If the string has length greater than 2, the rest are ignored.
URL `http://ergoemacs.org/emacs/elisp_change_brackets.html'
Version 2017-05-17"
  (interactive
   (let ((-bracketsList
          '("(paren)"
            "{brace}"
            "[square]"
            "<greater>"
            "`emacs'"
            "`markdown`"
            "~tilde~"
            "=equal="
            "\"ascii quote\""
            "[[double square,2]]"
            "“curly quote”"
            "‘single quote’"
            "‹angle quote›"
            "«double angle quote»"
            "「corner」"
            "『white corner』"
            "【LENTICULAR】"
            "〖white LENTICULAR〗"
            "〈angle bracket〉"
            "《double angle bracket》"
            "〔TORTOISE〕"
            "⦅white paren⦆"
            "〚white square〛"
            "⦃white curly bracket⦄"
            "〈angle bracket〉"
            "⦑ANGLE BRACKET WITH DOT⦒"
            "⧼CURVED ANGLE BRACKET⧽"
            "⟦math square⟧"
            "⟨math angle⟩"
            "⟪math DOUBLE ANGLE BRACKET⟫"
            "⟮math FLATTENED PARENTHESIS⟯"
            "⟬math WHITE TORTOISE SHELL BRACKET⟭"
            "❛HEAVY SINGLE QUOTATION MARK ORNAMENT❜"
            "❝❞"
            "❨❩"
            "❪❫"
            "❴❵"
            "❬❭"
            "❮❯"
            "❰❱"
            "delete brackets"
            )))
     (list
      (ido-completing-read "Replace this:" -bracketsList )
      (ido-completing-read "To:" -bracketsList ))))
  (let ( -begin -end )
    (if (use-region-p)
        (setq -begin (region-beginning) -end (region-end))
      (setq -begin (line-beginning-position) -end (line-end-position)))
    (save-excursion
      (save-restriction
        (narrow-to-region -begin -end)
        (let ( (case-fold-search nil)
               -fromLeft
               -fromRight
               -toLeft
               -toRight)
          (cond
           ((string-match ",2" *from-chars  )
            (progn
              (setq -fromLeft (substring *from-chars 0 2))
              (setq -fromRight (substring *from-chars -2))))
           (t
            (progn
              (setq -fromLeft (substring *from-chars 0 1))
              (setq -fromRight (substring *from-chars -1)))))
          (cond
           ((string-match ",2" *to-chars)
            (progn
              (setq -toLeft (substring *to-chars 0 2))
              (setq -toRight (substring *to-chars -2))))
           ((string-match "delete brackets" *to-chars)
            (progn
              (setq -toLeft "")
              (setq -toRight "")))
           (t
            (progn
              (setq -toLeft (substring *to-chars 0 1))
              (setq -toRight (substring *to-chars -1)))))
          (cond
           ((string-match "markdown" *from-chars)
            (progn
              (goto-char (point-min))
              (while
                  (re-search-forward "`\\([^`]+?\\)`" nil t)
                (overlay-put (make-overlay (match-beginning 0) (match-end 0)) 'face 'highlight)
                (replace-match (concat -toLeft "\\1" -toRight ) "FIXEDCASE" ))))
           ((string-match "tilde" *from-chars)
            (progn
              (goto-char (point-min))
              (while
                  (re-search-forward "~\\([^~]+?\\)~" nil t)
                (overlay-put (make-overlay (match-beginning 0) (match-end 0)) 'face 'highlight)
                (replace-match (concat -toLeft "\\1" -toRight ) "FIXEDCASE" ))))
           ((string-match "ascii quote" *from-chars)
            (progn
              (goto-char (point-min))
              (while
                  (re-search-forward "\"\\([^\"]+?\\)\"" nil t)
                (overlay-put (make-overlay (match-beginning 0) (match-end 0)) 'face 'highlight)
                (replace-match (concat -toLeft "\\1" -toRight ) "FIXEDCASE" ))))
           ((string-match "equal" *from-chars)
            (progn
              (goto-char (point-min))
              (while
                  (re-search-forward "=\\([^=]+?\\)=" nil t)
                (overlay-put (make-overlay (match-beginning 0) (match-end 0)) 'face 'highlight)
                (replace-match (concat -toLeft "\\1" -toRight ) "FIXEDCASE" ))))
           (t (progn
                (progn
                  (goto-char (point-min))
                  (while (search-forward -fromLeft nil t)
                    (overlay-put (make-overlay (match-beginning 0) (match-end 0)) 'face 'highlight)
                    (replace-match -toLeft "FIXEDCASE" "LITERAL")))
                (progn
                  (goto-char (point-min))
                  (while (search-forward -fromRight nil t)
                    (overlay-put (make-overlay (match-beginning 0) (match-end 0)) 'face 'highlight)
                    (replace-match -toRight "FIXEDCASE" "LITERAL")))))))))))



;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; custom-modes-setup.el ends here
