;;; hl-todo.el --- hl-todo configuration
;;; Commentary:
;;; Code:

(global-hl-todo-mode t)
(setq hl-todo-keyword-faces
      '(("TODO" . "#FF5500")
        ("NOTE" . "#00FF55")
        ("TEMP" . "#0055FF")))

;;; hl-todo.el ends here
