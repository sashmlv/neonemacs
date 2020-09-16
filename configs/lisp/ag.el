;;; ag.el --- ag configuration
;;; Commentary:
;;; Code:

;; The Silver Searcher
(setq ag-reuse-window 't)
(setq ag-reuse-buffers 't)
(setq ag-ignore-list
      '(".git"
        "log"
        "node_modules"
        "bower_components"))

;;; ag.el ends here
