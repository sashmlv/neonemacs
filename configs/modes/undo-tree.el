;;; undo-tree --- undo-tree configuration:
;;; Commentary:
;;; Code:

;; undo-tree melpa plugin ( undo-redo ) setup
(setq undo-limit 5242880) ;; 5mb history size
(setq undo-strong-limit 10485760) ;; 10mb history size
(setq undo-outer-limit 20971520) ;; 20mb history size
(require 'undo-tree)
(global-undo-tree-mode t)

;; set hook that load undo-tree history files, when switching buffers
(if use_undo_tree_history_files ;; "use_undo_tree_history_files" in index.el
    (progn
      ;; (insert (format "%s" undo-limit)) ;; default: 80000, current:
      ;; (insert (format "%s" undo-strong-limit)) ;; default: 120000, current:
      ;; (insert (format "%s" undo-outer-limit)) ;; default: 12000000, current:

      (remove-hook 'find-file-hook 'undo-tree-load-history-hook) ;; disable default
      (setq undo-tree-auto-save-history t) ;; auto save history
      (setq undo-tree-history-directory-alist `(("." . ,undo_redo_dir))) ;; set history directory
      (defadvice undo-tree-make-history-save-file-name ;; enable compress history
          (after undo-tree activate)
        (setq ad-return-value (concat ad-return-value ".gz")))

      (setq loaded_undo_tree_history_files nil) ;; list of loaded history files variable
      (setq last_buffer_from_previous_session (buffer-name (car (buffer-list)))) ;; restore last used buffer, from previous session, from buffer list
      (setq undo_tree_history_initialized nil) ;; is undo-tree initialized
      (setq allow_execute_load_undo_tree_history_file t) ;; prevent execute while lazy loading (allow execute on first time when emacs starting, so set -> "t")
      (setq loading_history nil) ;; is loading file history now

      ;; wrapper for any original function, for disabling load undo tree when not needed, when function executing
      (defun set_allow_execute_load_undo_tree_history_file (orig-fun &rest args) ;; prevent execute while lazy load file for example
        (setq allow_execute_load_undo_tree_history_file nil) ;; start prevent
        (apply orig-fun args)
        (setq allow_execute_load_undo_tree_history_file t) ;; stop prevent
        )
      (advice-add 'desktop-lazy-create-buffer :around #'set_allow_execute_load_undo_tree_history_file) ;; hook on lazy load files

      (add-hook 'window-configuration-change-hook 'load_undo_tree_history_file ) ;; hook when current-buffer will be changed load history
      (defun load_undo_tree_history_file()
        (progn
          (if (or undo_tree_history_initialized (eq (buffer-name (current-buffer)) last_buffer_from_previous_session)) ;; on first loading, when emacs not loaded completelly, and it is last used buffer, restore history file (in next times, in other cases, parameter "undo_tree_history_initialized" make execute code allways)
              (progn
                (if (and
                     (not (member (buffer-file-name (current-buffer)) loaded_undo_tree_history_files)) ;; if history file still not loaded and ... ( see next comment )
                     (eq (type-of (buffer-file-name (current-buffer))) 'string) ;; if file name string
                     (buffer-file-name (current-buffer)) ;; if current buffer has file, load this undo-tree history file.
                     allow_execute_load_undo_tree_history_file
                     )
                    (progn
                      (if (undo-tree-load-history nil t) ;; load "current-buffer" history file, with disabled error message on file not found (   t) - at end
                          (progn
                            (ignore-errors (undo-tree-redo)) ;; enshure history
                            (add-to-list 'loaded_undo_tree_history_files (buffer-file-name (current-buffer))) ;; save to list loaded history file, for prevent load again
                            )
                        )
                      )
                  )
                (setq undo_tree_history_initialized t) ;; set undo-tree was initialized
                )
            )
          )
        )

      (add-hook 'kill-buffer-hook 'unload_undo_tree_history_file) ;; when buffer will killed remove them from loaded buffers list
      (defun unload_undo_tree_history_file()
        (setq current_buffer_file_path (buffer-file-name (current-buffer))) ;; get file path of current buffer
        (if current_buffer_file_path ;; if killed buffer have file path, remove them from loaded list
            (setq loaded_undo_tree_history_files (delete current_buffer_file_path loaded_undo_tree_history_files)) ;; update loaded buffers file list
          )
        )
      )
  )

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; undo-tree.el ends here
