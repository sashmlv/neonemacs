;;; perl.el --- perl configuration
;;; Commentary:
;;; Code:

;; https://github.com/shibayu36/emacs/blob/master/emacs.d/inits/20-edit-mode-perl.el
(defalias 'perl-mode 'cperl-mode)

(add-to-list 'auto-mode-alist '("\\.pl$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . perl-mode))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq-default indent-tabs-mode t) ;; tabs indentation
             ))

(custom-set-faces
 '(cperl-array-face ((t (:foreground "SteelBlue1" :weight normal))))
 '(cperl-hash-face ((t (:foreground "tomato" :weight normal)))))

(setq cperl-indent-level neon-indent
      cperl-continued-statement-offset neon-indent
      cperl-close-paren-offset (- neon-indent)
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-label-offset (- neon-indent)
      cperl-tab-always-indent nil
      cperl-brace-offset (- neon-indent)
      cperl-font-lock t
      cperl-hairy nil
      cperl-electric-parens nil)

;;; perl.el ends here
