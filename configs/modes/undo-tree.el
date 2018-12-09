;;; undo-tree --- undo-tree configuration:
;;; Commentary:
;;; Code:

;; (setq undo-limit 5242880) ;; 5mb history size ( default: 80000 )
;; (setq undo-strong-limit 10485760) ;; 10mb history size ( default: 120000 )
;; (setq undo-outer-limit 20971520) ;; 20mb history size ( default: 12000000 )
(global-undo-tree-mode t)

;; set hook to load undo-tree history, with buffer switching
(if use_undo_tree_history_files
    (progn
      (remove-hook 'find-file-hook 'undo-tree-load-history-hook) ;; remove default
      (setq undo-tree-auto-save-history t) ;; auto save history
      (setq undo-tree-history-directory-alist `(("." . ,undo_redo_dir))) ;; set history directory
      (defadvice undo-tree-make-history-save-file-name ;; enable compress history
          (after undo-tree activate)
        (setq ad-return-value (concat ad-return-value ".gz")))
      (setq loaded_undo_tree_history_files nil) ;; list of loaded history files
      (setq last_buffer_from_previous_session ;; restore last buffer, from previous session, from buffer list
            (buffer-name (car (buffer-list))))
      (setq undo_tree_history_initialized nil) ;; is undo-tree initialized
      (setq loading_history nil) ;; is history loading now

      ;; wrapper for any original function,
      ;; for disable load undo tree when it is not need, when original function executing
      (defun prevent_execute_load_undo_tree_history_file
          (orig-fun &rest args) ;; prevent execute while lazy load file
        (remove-hook 'window-configuration-change-hook 'load_undo_tree_history_file ) ;; remove before function
        (apply orig-fun args)
        (add-hook 'window-configuration-change-hook 'load_undo_tree_history_file )) ;; add after function

      (advice-add 'desktop-lazy-create-buffer
                  :around #'prevent_execute_load_undo_tree_history_file) ;; hook on lazy load files

      ;; load history when current-buffer will changed
      (add-hook 'window-configuration-change-hook 'load_undo_tree_history_file )

      (defun load_undo_tree_history_file()
        (if (and
             (not loading_history)

             ;; on first load, when emacs not loaded,
             ;; and this is last used buffer, we doing restore history file.
             ;; ( in other cases, parameter "undo_tree_history_initialized" make execute code allways )
             (or
              undo_tree_history_initialized
              (eq (buffer-name (current-buffer)) last_buffer_from_previous_session)))
            (progn
              (setq loading_history t)
              (if (and

                   ;; if history file not loaded and ... ( see next comment )
                   (not (member (buffer-file-name (current-buffer)) loaded_undo_tree_history_files))

                   ;; if file name string and ...
                   (eq (type-of (buffer-file-name (current-buffer))) 'string)

                   ;; if current buffer has file
                   (buffer-file-name (current-buffer)))
                  (progn

                    ;; load "current-buffer" history file,
                    ;; without error message on file, if not found ( ... t) - at end
                    (if (undo-tree-load-history nil t)
                        (progn

                          ;; touch history to ensure load ( bug when emacs started, but history not loaded )
                          ;; (undo-tree-save-history nil t)

                          ;; add to list loaded history file, avoid load again
                          (add-to-list 'loaded_undo_tree_history_files
                                       (buffer-file-name (current-buffer)))))))
              (setq loading_history nil)
              (setq undo_tree_history_initialized t)))) ;; undo-tree initialized

      ;;  kill buffer remove it from list
      (add-hook 'kill-buffer-hook 'unload_undo_tree_history_file)

      (defun unload_undo_tree_history_file()

        ;; current buffer file path
        (setq current_buffer_file_path (buffer-file-name (current-buffer)))

        ;; if dead buffer have file path, remove from active list
        (if current_buffer_file_path

            ;; update active buffers file list
            (setq loaded_undo_tree_history_files
                  (delete current_buffer_file_path loaded_undo_tree_history_files))))))

;; * Disable error on free variables *
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; undo-tree.el ends here
