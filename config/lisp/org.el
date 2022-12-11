;;; org.el --- org-mode configuration
;;; Commentary:
;;; Code:

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (shell . t)))
;; add additional languages with '((language . t)))

;; "verb" HTTP requests
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

;; (require 'walkman)
;; (setq walkman-keep-headers t)
;; (define-key org-mode-map (kbd "C-c C-'") #'walkman-transient)
;; (define-key org-mode-map (kbd "C-c C-c") #'walkman-at-point)

;;; org.el ends here
