;;; org.el --- org-mode configuration
;;; Commentary:
;;; Code:

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (shell . t)
   (python . t)
   (js . t)))
;; add additional languages with '((language . t)))

;; "verb" HTTP requests
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map)
  ;;(define-key org-mode-map (kbd "C-c r") #'verb-send-request-on-point-other-window-stay)
  (define-key org-mode-map (kbd "C-c r") #'verb-send-request-on-point-other-window)
  (define-key org-mode-map (kbd "C-c q") #'verb-kill-all-response-buffers)
  (define-key org-mode-map (kbd "C-j") #'newline)
)
(with-eval-after-load 'verb
  (define-key verb-response-body-mode-map (kbd "q") #'verb-kill-response-buffer-and-window)
  (define-key verb-response-body-mode-map (kbd "r")
    (lambda () (interactive) (verb-toggle-show-headers) (other-window 1) (beginning-of-buffer)))
  (define-key verb-response-headers-mode-map (kbd "q") #'verb-kill-response-buffer-and-window))
(setq verb-auto-kill-response-buffers t)
;; "verb" HTTP requests

(setq org-indent-mode t)
;; ? (setq org-src-tab-acts-natively  t)
;; ? (setq org-src-preserve-indentation t)
;; ? (setq org-src-fontify-natively t)


;; walkman
;; (require 'walkman)
;; (setq walkman-keep-headers t)
;; (define-key org-mode-map (kbd "C-c C-'") #'walkman-transient)
;; (define-key org-mode-map (kbd "C-c C-c") #'walkman-at-point)
;; walkman

;;; org.el ends here
