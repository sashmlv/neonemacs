;;; ido-vertical-mode --- ido-vertical-mode configuration:
;;; Commentary:
;;; Code:

;; vertical list in minibuffer
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; ido-vertical-mode.el ends here
