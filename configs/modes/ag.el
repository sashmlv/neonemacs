;;; ag --- ag configuration:
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

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; ag.el ends here
