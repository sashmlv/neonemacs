;;; wakatime-mode --- wakatime-mode configuration:
;;; Commentary:
;;; Code:

;; wakatime mode for certain projects
;; need create ~/.wakatime.cfg file with config and api key
;; also set path to wakatime binary
(custom-set-variables '(wakatime-cli-path "/usr/local/bin/wakatime"))
(global-wakatime-mode)

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; wakatime-mode.el ends here
