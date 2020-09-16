;;; wakatime.el --- wakatime-mode configuration
;;; Commentary:
;;; Code:

;; wakatime mode for certain projects
;; need create ~/.wakatime.cfg file with config and api key
;; also set path to wakatime binary
(custom-set-variables '(wakatime-cli-path "/usr/local/bin/wakatime"))
(global-wakatime-mode)

;;; wakatime.el ends here
