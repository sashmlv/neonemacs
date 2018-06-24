;;; avy --- avy configuration:
;;; Commentary:
;;; Code:

;; avy - fast navigation https://github.com/abo-abo/avy/wiki
(setq avy-case-fold-search nil)
(global-set-key (kbd "C-;") 'avy-goto-char-2)
(global-set-key (kbd "C-'") 'avy-goto-line)
(global-set-key (kbd "M-g c") 'avy-goto-char)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g (") 'avy-goto-open-paren)
(global-set-key (kbd "M-g )") 'avy-goto-close-paren)
(global-set-key (kbd "M-g P") 'avy-pop-mark)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; avy.el ends here
