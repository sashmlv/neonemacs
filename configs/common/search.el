;;; search.el --- search configuration
;;; Commentary:
;;; Code:

(defun switch-search()
  "Switch search method for C-s, C-r keybindings."
  (interactive)
  (setq search_method
        (completing-read
         "Switch search method for C-s, C-r:"
         '(("swiper") ("isearch"))
         nil t))
  (cond ((equal search_method "swiper")
         (global-set-key (kbd "C-s") 'swiper)
         (global-set-key (kbd "C-r") 'swiper))
        ((equal search_method "isearch")
         (global-set-key (kbd "C-s") 'isearch-forward)
         (global-set-key (kbd "C-r") 'isearch-backward))
        (t (global-set-key (kbd "C-s") 'swiper)
           (global-set-key (kbd "C-r") 'swiper))))

;;; search.el ends here
