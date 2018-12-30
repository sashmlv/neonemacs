;;; bm --- bm configuration:
;;; Commentary:
;;; Code:

(global-set-key (kbd "C-x r t") 'bm-toggle) ;; set a bookmark
(global-set-key (kbd "C-x r n") 'bm-next) ;; jump to a next bookmark
(global-set-key (kbd "C-x r p") 'bm-previous) ;; jump to a previous bookmakr
(global-set-key (kbd "C-x r s") 'bm-show-all) ;; bookmarks show
(global-set-key (kbd "C-x r r") 'bm-remove-all-current-buffer) ;; delete bookmarks

;; https://github.com/joodland/bm
;; make bookmarks persistent as default
(setq-default bm-buffer-persistence t)

;; Make sure the repository is loaded as early as possible
(setq bm-restore-repository-on-load t)
(require 'bm)

;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)

;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)

;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when Emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))

;; Update bookmark repository when saving the file.
(add-hook 'after-save-hook 'bm-buffer-save)

;; Restore bookmarks when buffer is reverted.
(add-hook 'after-revert-hook 'bm-buffer-restore)

;; make sure bookmarks is saved before check-in (and revert-buffer)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

;; set bookmark face
(setq  bm-persistent-face '(:foreground nil :background "#2a0946"))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; bm.el ends here
