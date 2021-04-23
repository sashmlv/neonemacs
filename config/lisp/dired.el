;;; dired.el --- dired configuration
;;; Commentary:
;;; Code:

;; dired tries to guess a default target directory
(setq dired-dwim-target t)

;; zip/unzip, Z - key compress/uncompress
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

;; human readable file size
(setq-default dired-listing-switches "-alFh") ;; default: "-al"

(defun add-left-fringe ()
  (setq left-fringe-width 7
        right-fringe-width 0))

(add-hook 'dired-mode-hook 'add-left-fringe)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

;; ;; dired-k
;; ;; You can use dired-k alternative to revert-buffer
;; (require 'dired-k)
;; (define-key dired-mode-map (kbd "g") 'dired-k)
;; (add-hook 'dired-initial-position-hook 'dired-k)
;; ;; always execute dired-k when dired buffer is opened
;; ;; (add-hook 'dired-initial-position-hook 'dired-k)
;; ;; (add-hook 'dired-after-readin-hook #'dired-k-no-revert)

;;; dired.el ends here
