;;; index.el --- configuration loader
;;; Commentary:
;;; Code:

(require 'package)
(package-initialize)
(setq package-archives nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
;;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;;(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/") t)

(setq package-list
      '(restart-emacs ;; support only linux and windows
        ;; ido-vertical-mode
        multiple-cursors
        company ;; autocompletition
        ;; projectile ;; project management
        highlight-indentation ;; or highlight-indent-guides
        rainbow-delimiters ;; rainbow parentheses
        js2-mode js2-refactor rjsx-mode vue-mode svelte-mode
        js-comint ;; js repl
        typescript-mode
        tide ;; JS, TS, - IDE
        lsp-mode dap-mode ;; JS, TS, - IDE
        eglot ;; JS, TS, - IDE
        less-css-mode php-mode
        pug-mode yaml-mode markdown-mode json-mode dockerfile-mode
        haskell-mode web-mode
        eslint-fix ;; fix current file using ESLint
        bongo volume ;; media player
        magit ;; git support
        highlight-symbol ;; highlight occurrences
        google-translate
        yasnippet ;; template system
        yasnippet-snippets
        ivy-yasnippet
        vimish-fold ;; fold-unfold library
        ;; wakatime-mode ;; time tracking
        avy
        expand-region ;; fast text selection
        bm ;; visible bookmarks
        syntax-subword ;; make word editing and motion more fine-grained
        ivy ;; completion for Emacs
        counsel ;;  Ivy-enhanced versions of common Emacs commands
        swiper ;; Ivy-enhanced alternative to isearch
        smex ;; for counsel M-x cache
        diff-hl ;; git highlights
        move-text ;; move text up down
        ;; restclient ;; rest client
        ;; company-restclient ;; restclient completions
        verb ;; HTTP requests in Org mode
        ;; walkman ;; HTTP requests in Org mode
        popup-kill-ring ;; kill ring menu
        ;; trr ;; type-writing trainer
        ;; speed-type ;; practice touch/speed typing in emacs
        flycheck ;; syntax checking
        undo-propose ;; stage undo’s in a temporary buffer
        ;; undo-fu ;; linear undo with redo
        ag ;; search using ag (the silver searcher)
        rg ;; search using ripgrep
        editorconfig ;; editorconfig plugin
        ob-mongo ;; mongodb support for org-mode
        slime ;; common lisp
        slime-company
        d-mode
        rust-mode racer
        total-lines ;; buffer's total number of lines in mode-line
        ))

;; install packages from list
;; check installed packages
(setq neon-want-package-install nil)
(setq neon-want-emacs-restart nil) ;; change while initialization
(dolist (package package-list)
  (if(not(package-installed-p package))
      (setq neon-want-package-install t)))
(if neon-want-package-install ;; install packages if need
    (progn
      (package-refresh-contents) ;; fetch list of packages available in melpa
      (dolist (package package-list) ;; install the missing packages
        (unless (package-installed-p package)
          ;; (if (y-or-n-p (format "Package \"%s\" is missing. Do you want to install it? " package))
          (package-install package)
          ;; )
          ))
      (setq neon-want-emacs-restart t))) ;; restart emacs for "eglot" package installed

(defun load-directory (path files)
  "Load files from a path, parameter \"path\" is a directory path and \"files\" is a file list."

  (if (and (stringp path) (not (null files)))
      (dolist (file files)
        (load (concat path file)))))

;; lisp files (configs, params)
(setq lisp-list ;; "doom-modeline" "highlight-indent-guides" "ido-vertical" "wakatime"
      `(
        "ag" "avy" "bm" "font"
        ,(concat (file-name-as-directory "column-marker") "highlight-100-mode")
        "company" "css" "dockerfile" "eshell" "flycheck" "google-translate"
        "grep" "haskell" "hide-new-line" "highlight-indentation" "highlight-symbol" "highlight-words"
        "ivy" "json" "js-typescript" "markdown" "midnight-mode" "mode-line" "org" "perl" "php"
        ,(concat (file-name-as-directory "pomodoro") "pomodoro-setup")
        "pug" "recentf-mode" "slime" "d" "rust" "svelte" "vimish-fold" "webjump"
        "xah-change-bracket-pairs" "xah-syntax-color-hex" "yaml" "yasnippet" "dired"
        "prog-mode" "base-setup" ;; last modes
        ))

;; common configs
(setq common-list '("indentation" "theme" "whitespace" "keybindings" "search"))

(load (concat (file-name-directory load-file-name) (file-name-as-directory "common") "configs")) ;; load configs file ( see for params )

;; load files
(load (concat neon-config-dir (file-name-as-directory "common") "projects")) ;; project specific params before
(load-directory (concat neon-config-dir (file-name-as-directory "lisp")) lisp-list)
(load-directory (concat neon-config-dir (file-name-as-directory "common")) common-list)

(if neon-want-emacs-restart
    (if (or
         (string-equal system-type "gnu/linux")
         (string-equal system-type "windows-nt"))
        (restart-emacs)
      (kill-emacs))) ;; if no linux/windows

;;; index.el ends here
