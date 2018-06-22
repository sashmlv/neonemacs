;;; wakatime-mode --- wakatime-mode configuration:
;;; Commentary:
;;; Code:

;; wakatime mode for certain project paths ( do not forget create ~/.wakatime.cfg file with configs and api key )
;; all configs in ~/.wakatime.cfg
(custom-set-variables '(wakatime-cli-path "/usr/local/bin/wakatime")) ;; do not forget set path to wakatime binary ( shell command: which wakatime )
(global-wakatime-mode)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; wakatime-mode.el ends here
