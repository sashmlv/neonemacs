;;; tern-mode-setup --- tern installation and configuration:
;;; Commentary:
;;; Code:

;; * START tern installation *
;; (for setup: git, npm, node must be preinstalled)
(if (and use_tern_mode (not (file-exists-p tern_file))) ;; autoinstall if enabled, and not installed
    (if (eq system-type 'gnu/linux) ;; if linux
        (progn ;; go install tern
          (message "Wait a while, now installing 'tern'!")
          (setq shell_commands
                (format "
check_message=\"\"
hash git &> /dev/null
if [ $? -eq 1 ]; then
   check_message=\"$check_message Error: git must be installed!\"
fi

hash node &> /dev/null
if [ $? -eq 1 ]; then
   check_message=\"$check_message Error: node must be installed!\"
fi

hash npm &> /dev/null
if [ $? -eq 1 ]; then
   check_message=\"$check_message Error: npm must be installed!\"
fi

if [ -z \"$check_message\" ]; then
   cd %s
   git clone https://github.com/ternjs/tern.git
   cd %s
   npm install
   chmod +x %sbin/tern
else
   echo $check_message
fi
" base_dir tern_dir tern_dir)
                )
          (shell-command-to-string shell_commands) ;; execute installation
          (setq need_emacs_restart t) ;; "need_emacs_restart" in index.el
          (message "Tern installed successfully!")
          )
      (progn
        (setq use_tern_mode nil) ;; disable tern-mode parameter
        (message "Sorry, 'tern' autoinstallation as yet support only linux systems!")
        )
      )
  )

;; load tern
(if (and use_tern_mode (file-exists-p tern_file))
    (progn
      (add-to-list 'load-path (concat tern_dir (file-name-as-directory "emacs")))
      (autoload 'tern-mode tern_file nil t)
      )
  )
;; * END *

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; tern-mode-setup.el ends here
