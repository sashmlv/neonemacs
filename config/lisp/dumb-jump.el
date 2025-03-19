;;; dumb-jump.el --- dumb-jump configuration
;;; Commentary:
;;; Code:

(require 'dumb-jump)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(setq xref-show-definitions-function #'xref-show-definitions-completing-read)

;; (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
;; (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;; (setq xref-backend-functions (remq 'etags--xref-backend xref-backend-functions))
;; (add-to-list 'xref-backend-functions #'dumb-jump-xref-activate t)

;;; dumb-jump.el ends here
