;;; midnight-mode --- Midnight mode
;;; Commentary:
;;; Code:

;; https://www.emacswiki.org/emacs/MidnightMode
;; https://www.emacswiki.org/emacs/CleanBufferList
(midnight-mode 1)
(add-hook 'midnight-hook 'clean-buffer-list)
(setq clean-buffer-list-delay-general 33) ;; days
(setq clean-buffer-list-delay-special (* 9 3600)) ;; 3600 - one hour
;; (midnight-delay-set 'midnight-delay "4:30am")
;; (midnight-delay-set 'midnight-delay 16200) ;; (eq (* 4.5 60 60) "4:30am")
;; (setq midnight-period 7200) ;; (eq (* 2 60 60) "2 hours")

;;; midnight-mode.el ends here
