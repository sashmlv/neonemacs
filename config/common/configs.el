;;; configs.el --- configs
;;; Commentary:
;;; Code:

(defconst neon-indent 3) ;; common indentation
;; define directories
(defconst neon-config-dir (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(defconst neon-backup-dir (concat user-emacs-directory (file-name-as-directory "backup")))
(defconst neon-theme-dir (concat neon-config-dir (file-name-as-directory "theme")))
(defconst neon-yasnippet-dir (concat neon-config-dir (directory-file-name "yasnippet")))
(defconst neon-yasnippet-common-dir (concat neon-config-dir (file-name-as-directory "yasnippet") "common"))

;; create config directories
(if (not (file-accessible-directory-p neon-backup-dir))
   (make-directory neon-backup-dir t))

;;; configs.el ends here
