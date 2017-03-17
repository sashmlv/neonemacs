;;; index --- configuration loader:
;;; Commentary:
;;; Code:
;; * Parameters and loading other config files *

;; TODO:
;; - enable js2-mode on js

;; * START - Params *
(setq directory-root "/media/user/disk/emacs-config/configs/")
(defconst base-dir "~/.emacs.d/")
(defconst config-dir (concat base-dir "configs/"))
(defconst backups-dir (concat base-dir "backups/"))
(defconst themes-dir (concat directory-root "themes/"))
(defconst font "Menlo-9")
(defconst indent 3) ;; 3 spaces ;; used in indentation.el
(defconst indentation-color "#101010") ;; used in indentation.el
(defconst indentation-current-line-color "#101010") ;; used in indentation.el

;; define theme for window
(set 'win-theme 'sunburst)

;; define theme for terminal
(set 'term-theme 'sunburst)

;; Packages list
(setq package-list '(
                     smex
                     undo-tree
                     multiple-cursors
                     company
                     company-statistics
                     projectile
                     js2-mode
                     highlight-indentation
                     )
      )
;; * END *

;; Load configs
(load (concat directory-root "base"))
(load (concat directory-root "indentation"))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; index.el ends here
