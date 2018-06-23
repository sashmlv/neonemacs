;;; avy --- avy configuration:
;;; Commentary:
;;; Code:

;; avy - fast navigation https://github.com/abo-abo/avy/wiki
(setq avy-case-fold-search nil)
(bind-key "C-;"    'avy-goto-char-2)
(bind-key "C-'"    'avy-goto-line)
(bind-key "M-g c"  'avy-goto-char)
(bind-key "M-g e"  'avy-goto-word-0)
(bind-key "M-g g"  'avy-goto-line)
(bind-key "M-g w"  'avy-goto-word-1)
(bind-key "M-g ("  'avy-goto-open-paren)
(bind-key "M-g )"  'avy-goto-close-paren)
(bind-key "M-g P"  'avy-pop-mark)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; avy.el ends here
