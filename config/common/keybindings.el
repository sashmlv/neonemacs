;;; keybindings.el --- keybindings
;;; Commentary:
;;; Code:

;; disable emacs exiting accidentally, use save-buffers-kill-terminal instead
(global-unset-key (kbd "C-x C-c"))

;; make Ctrl+z - new prefix key
(define-prefix-command 'ring-map)
(global-set-key (kbd "C-z") 'ring-map)

;; change bracket pairs from one type to another, on current line or text selection
(global-set-key
 (kbd "C-c `")
 (lambda()
   (interactive)
   (setq from (read-string "Enter replacement:"))
   (setq to (read-string "Enter new value:"))
   (xah-change-bracket-pairs from to)))

(global-set-key (kbd "C-c d")   'duplicate-line-or-region)
(global-set-key (kbd "C-c C-r") 'revert-buffer)

;; expand-region faster text selection
(global-set-key (kbd "C-=") 'er/expand-region)

;; goto-chg goto-last-change
(global-set-key (kbd "M-]") 'goto-last-change)
(global-set-key (kbd "M-[") 'goto-last-change-reverse)

;; avy - fast navigation https://github.com/abo-abo/avy/wiki
(global-set-key (kbd "C-;")   'avy-goto-char-2)
(global-set-key (kbd "C-'")   'avy-goto-line)
(global-set-key (kbd "M-g c") 'avy-goto-char)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g g") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g (") 'avy-goto-open-paren)
(global-set-key (kbd "M-g )") 'avy-goto-close-paren)
(global-set-key (kbd "M-g P") 'avy-pop-mark)

;; bookmarks https://github.com/joodland/bm
(global-set-key (kbd "C-x r t") 'bm-toggle) ;; set a bookmark
(global-set-key (kbd "C-x r n") 'bm-next) ;; jump to a next bookmark
(global-set-key (kbd "C-x r p") 'bm-previous) ;; jump to a previous bookmakr
(global-set-key (kbd "C-x r s") 'bm-show-all) ;; bookmarks show
(global-set-key (kbd "C-x r r") 'bm-remove-all-current-buffer) ;; delete bookmarks

(global-set-key (kbd "M-P") 'move-text-up)
(global-set-key (kbd "M-N") 'move-text-down)

;; navigate through occurrences
(global-set-key (kbd "M-}") 'highlight-symbol-next)
(global-set-key (kbd "M-{") 'highlight-symbol-prev)

;; ivy
(global-set-key (kbd "C-s")     'swiper)
(global-set-key (kbd "C-r")     'swiper)
(global-set-key (kbd "M-x")     'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; multiple-cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; (Define-key projectile-mode-map (kbd "C-z p") 'projectile-command-map)

(global-set-key "\C-z\ b" 'recentf-open-files)

;; (global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-c f") #'vimish-fold)
(global-set-key (kbd "C-c u") #'vimish-fold-delete)

;; undo-fu
;; (global-set-key (kbd "C-/") 'undo-fu-only-undo)
;; (global-set-key (kbd "C-?") 'undo-fu-only-redo)

(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-c j") 'webjump)
(global-set-key (kbd "C-c t") 'google_translate)

;; Redefine active window switcher
(global-set-key (kbd "M-o") 'other-window)

;;; keybindings.el ends here
