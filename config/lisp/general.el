;;; general.el --- general
;;; Commentary:
;;; Code:

(global-unset-key (kbd "C-x C-c")) ;; disable emacs exiting accidentally, use save-buffers-kill-terminal instead
(global-set-key (kbd "M-s M-w") (lambda()())) ;; disable search
(global-set-key (kbd "C-h n") (lambda()())) ;; disable news
(global-set-key (kbd "C-j") 'newline) ;; make C-j newline without indent

(general-define-key
 :prefix-command 'neon-prefix
 :prefix "C-z"
 "b" 'ibuffer ;; buffer list
 "d" 'duplicate-line-or-region
 "g" 'avy-goto-char-2 ;; avy - fast navigation https://github.com/abo-abo/avy/wiki
 "t" 'neon-google-translate
 "w" 'webjump)

;; ivy
(global-set-key (kbd "C-s") 'swiper)
(with-eval-after-load 'swiper (define-key swiper-map (kbd "C-<return>") 'swiper-isearch-thing-at-point))
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; bookmarks https://github.com/joodland/bm
(global-set-key (kbd "C-x r t") 'bm-toggle) ;; set a bookmark
(global-set-key (kbd "C-x r n") 'bm-next) ;; jump to a next bookmark
(global-set-key (kbd "C-x r p") 'bm-previous) ;; jump to a previous bookmakr
(global-set-key (kbd "C-x r s") 'bm-show-all) ;; bookmarks show
(global-set-key (kbd "C-x r r") 'bm-remove-all-current-buffer) ;; delete bookmarks

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(global-set-key (kbd "M-{") 'highlight-symbol-prev)

;; multiple-cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

(global-set-key (kbd "C-c f") #'vimish-fold)
(global-set-key (kbd "C-c u") #'vimish-fold-delete)

(global-set-key (kbd "C-x C-j") 'dired-jump)

;; Redefine active window switcher
(global-set-key (kbd "M-o") 'other-window)

;; scroll
(global-set-key (kbd "M-p")
                (lambda (n) (interactive "p") (previous-line n) (unless (eq (window-start) (point-min)) (scroll-down n))))
(global-set-key (kbd "M-n")
                (lambda (n) (interactive "p") (next-line n) (unless (eq (window-end) (point-max)) (scroll-up n))))
(global-set-key (kbd "M-P")
                (lambda (n) (interactive "p")
                  (when (not (region-active-p))
                    (setq-local transient-mark-mode (cons 'only (unless (eq transient-mark-mode 'lambda) transient-mark-mode)))
                    (push-mark nil nil t))
                  (previous-line n) (unless (eq (window-start) (point-min)) (scroll-down n))))
(global-set-key (kbd "M-N")
                (lambda (n) (interactive "p")
                  (when (not (region-active-p))
                    (setq-local transient-mark-mode (cons 'only (unless (eq transient-mark-mode 'lambda) transient-mark-mode)))
                    (push-mark nil nil t))
                  (next-line n) (unless (eq (window-end) (point-max)) (scroll-up n))))

;; isearch
(global-set-key (kbd "M-s s") 'isearch-forward-symbol-at-point)
(with-eval-after-load 'isearch
  (define-key isearch-mode-map (kbd "C-n") 'isearch-repeat-forward)
  (define-key isearch-mode-map (kbd "C-p") 'isearch-repeat-backward)
)

;;; general.el ends here
