;;; js2-refactor.el --- js2-refactor configuration
;;; Commentary:
;;; Code:

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;;; js2-refactor.el ends here
