;;; undo-tree --- undo-tree configuration:
;;; Commentary:
;;; Code:

;; undo-tree melpa plugin ( undo-redo ) setup
;; (setq undo-limit 5242880) ;; 5mb history size ( default: 80000 )
;; (setq undo-strong-limit 10485760) ;; 10mb history size ( default: 120000 )
;; (setq undo-outer-limit 20971520) ;; 20mb history size ( default: 12000000 )
(require 'undo-tree)
(global-undo-tree-mode t)

;; set hook that load undo-tree history files, when switching buffers
(if use_undo_tree_history_files ;; "use_undo_tree_history_files" in index.el
    (progn
      (remove-hook 'find-file-hook 'undo-tree-load-history-hook) ;; disable default
      (setq undo-tree-auto-save-history t) ;; auto save history
      (setq undo-tree-history-directory-alist `(("." . ,undo_redo_dir))) ;; set history directory
      (defadvice undo-tree-make-history-save-file-name ;; enable compress history
          (after undo-tree activate)
        (setq ad-return-value (concat ad-return-value ".gz")))

      (setq loaded_undo_tree_history_files nil) ;; define list of loaded history files
      (setq last_buffer_from_previous_session (buffer-name (car (buffer-list)))) ;; restore last buffer, from previous session, from buffer list
      (setq undo_tree_history_initialized nil) ;; is undo-tree initialized
      (setq allow_execute_load_undo_tree_history_file t) ;; prevent execute while lazy loading (allow execute on first time when emacs starting, so set to -> "t")
      (setq loading_history nil) ;; is loading file history now

      ;; wrapper for any original function, for disable load undo tree when it is not need, when function executing
      (defun set_allow_execute_load_undo_tree_history_file (orig-fun &rest args) ;; prevent execute while lazy load file for example
        (setq allow_execute_load_undo_tree_history_file nil) ;; start prevent
        (apply orig-fun args)
        (setq allow_execute_load_undo_tree_history_file t) ;; stop prevent
        )
      (advice-add 'desktop-lazy-create-buffer :around #'set_allow_execute_load_undo_tree_history_file) ;; hook on lazy load files

      (add-hook 'window-configuration-change-hook 'load_undo_tree_history_file ) ;; hook when current-buffer will be changed load history
      (defun load_undo_tree_history_file()
        (if (and
             (not loading_history) ;; one loading at once
             (or undo_tree_history_initialized (eq (buffer-name (current-buffer)) last_buffer_from_previous_session)) ;; on first load, when emacs not loaded completelly, and this is last used buffer, we restore history file. ( at next times, in other cases, parameter "undo_tree_history_initialized" make execute code allways )
             )
            (progn
              (setq loading_history t) ;; we load history now
              (if (and
                   (not (member (buffer-file-name (current-buffer)) loaded_undo_tree_history_files)) ;; if history file still not loaded and ... ( see next comment )
                   (eq (type-of (buffer-file-name (current-buffer))) 'string) ;; if file name string and ...
                   (buffer-file-name (current-buffer)) ;; if current buffer has file and ...
                   allow_execute_load_undo_tree_history_file ;; and load file allowed, so load this undo-tree history file
                   )
                  (progn
                    (if (undo-tree-load-history nil t) ;; load "current-buffer" history file, with disabled error message on file not found ( ... t) - at end
                        (progn
                          (undo-tree-save-history nil t) ;; touch history to ensure load, because bug on emacs has started
                          (add-to-list 'loaded_undo_tree_history_files (buffer-file-name (current-buffer))) ;; save to list loaded history file, for prevent load again
                          )
                      )
                    )
                )
              (setq loading_history nil)
              (setq undo_tree_history_initialized t) ;; set undo-tree initialized
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
