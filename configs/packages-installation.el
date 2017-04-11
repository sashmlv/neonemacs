;;; packages-installation --- packages installation:
;;; Commentary:
;;; Code:

;; TODO:
;; set tern installation from github



;; * START - Package repositories *
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; * END *

;; * START - Install packages from list *
;; Check installed packages
(setq need-package-install nil)
(dolist (package package-list)
  (if(not(package-installed-p package))
      (setq need-package-install t)
 ))

;; install packages if needed
(if need-package-install
    (progn
      ;; Get melpa archive into list
      (catch 'get-archive-melpa
        (dolist (archive package-archives)
          (when (equal (car archive) "melpa")
            (progn
              (setq archives (list archive))
              (throw 'get-archive-melpa archives))
            )
        )
        nil
        )

      ;; Copy original archives
      (setq archives-copy package-archives)

      ;; Set package-archives to melpa archive
      (setq package-archives archives)

      ;; Fetch the list of packages available in melpa
      (package-refresh-contents)

      ;; Install the missing packages
      (dolist (package package-list)
        (unless (package-installed-p package)
          ;; (if (y-or-n-p (format "Package \"%s\" is missing. Do you want to install it? " package))
          (package-install package)
          ;; )
          )
        )

      ;; Rollback original archives
      (setq package-archives archives-copy)
      )
  )
;; * END *

;; * START tern installation *
;; (shell-command-to-string "/bin/echo hello")
(if use_tern
    (progn
      ;;
      ;;
      ;;
      )
  )
;; * END *

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; packages-installation.el ends here
