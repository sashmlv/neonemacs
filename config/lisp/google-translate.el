;;; google-translate.el --- google-translate configuration
;;; Commentary:
;;; Code:

(require 'google-translate)
(require 'google-translate-default-ui)
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "ru")
(setf google-translate-pop-up-buffer-set-focus t)

(defun neon-google-translate ()
  (interactive)
  (cond ((or(looking-at "[a-zA-Z]")
            (string-match "[a-zA-Z]" (string (char-before))))
         (google-translate-at-point))
        ((or(looking-at "[а-яА-Я]")
            (string-match "[а-яА-Я]" (string (char-before))))
         (google-translate-at-point-reverse))
        (t (google-translate-at-point))))

(defun google-translate--search-tkk ()
  "Search TKK."
  (list 430675 2721866130))

;;; google-translate.el ends here
