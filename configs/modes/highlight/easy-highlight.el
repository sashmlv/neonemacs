;;; easy-highlight.el --- Easy highlight word

;; Copyright (C) 2012 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-easy-highlight
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'hi-lock)
(require 'thingatpt)

(defgroup easy-highlight nil
  "Easy to use `hi-lock'"
  :group 'faces
  :prefix "easy-highlight:")

(defcustom easy-highlight:face-list (copy-list hi-lock-face-defaults)
  "Faces list"
  :type 'list
  :group 'easy-highlight)

(defvar easy-highlight:highlighted (make-hash-table))

(defun easy-highlight:next-face ()
  (when (null easy-highlight:face-list)
    (setq easy-highlight (copy-list hi-lock-face-defaults)))
  (pop easy-highlight:face-list))

;;;###autoload
(defun easy-highlight:regexp (regexp)
  (interactive
   (list
    (read-regexp "Regexp" (thing-at-point 'word))))
  (let ((face (easy-highlight:next-face)))
    (if (gethash regexp easy-highlight:highlighted)
        (error (format "'%s' is already highlighted" regexp))
      (puthash regexp t easy-highlight:highlighted))
    (hi-lock-face-buffer regexp face)))

;;;###autoload
(defun easy-highlight:words (words-str)
  (interactive
   (list
    (read-string "Highlighted Words: ")))
  (loop for word in (split-string words-str)
        do
        (easy-highlight:regexp word)))

(defun easy-highlight:highlighted-regexps ()
  (let ((regexps (loop for re being the hash-keys in easy-highlight:highlighted
                       collect re)))
    (unless regexps
      (error "No regexps highlighted"))
    regexps))

;;;###autoload
(defun easy-highlight:clear (str)
  (interactive
   (list
    (completing-read "Clear Regexp: "
                     (easy-highlight:highlighted-regexps) nil t
                     nil nil (thing-at-point 'word))))
  (hi-lock-unface-buffer str))

;;;###autoload
(defun easy-highlight:clear-all ()
  (interactive)
  (loop for re being the hash-keys in easy-highlight:highlighted
        do
        (hi-lock-unface-buffer re))
  (clrhash easy-highlight:highlighted))

(provide 'easy-highlight)

;;; easy-highlight.el ends here
