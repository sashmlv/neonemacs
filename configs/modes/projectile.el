;;; projectile.el --- Projectile configuration
;;; Commentary:
;;; Code:

(projectile-mode)
(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-completion-system 'ivy)
(define-key projectile-mode-map (kbd "C-z p") 'projectile-command-map)

;;; projectile.el ends here