;;; perl-mode.el --- perl-mode configuration
;;; Commentary:
;;; Code:

;; https://github.com/shibayu36/emacs/blob/master/emacs.d/inits/20-edit-mode-perl.el
(defalias 'perl-mode 'cperl-mode)

(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq-default indent-tabs-mode t) ;; tabs indentation
             ))

(custom-set-faces
 '(cperl-array-face ((t (:foreground "SteelBlue1" :weight normal))))
 '(cperl-hash-face ((t (:foreground "tomato" :weight normal)))))

(setq cperl-indent-level current_indent
      cperl-continued-statement-offset current_indent
      cperl-close-paren-offset (- current_indent)
      cperl-comment-column 40
      cperl-highlight-variables-indiscriminately t
      cperl-indent-parens-as-block t
      cperl-label-offset (- current_indent)
      cperl-tab-always-indent nil
      cperl-brace-offset (- current_indent)
      cperl-font-lock t
      cperl-hairy nil
      cperl-electric-parens nil)

;;; perl-mode.el ends here
