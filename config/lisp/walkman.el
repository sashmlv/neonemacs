;;; walkman.el --- HTTP requests in Org mode
;;; Commentary:
;;; Code:

(setq walkman-keep-headers t)
(define-key org-mode-map (kbd "C-c C-'") #'walkman-transient)
(define-key org-mode-map (kbd "C-c C-c") #'walkman-at-point)

;;; walkman.el ends here
