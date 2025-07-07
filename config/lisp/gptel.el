;;; gptel.el --- gptel configuration
;;; Commentary:
;;; Code:

(setq
 gptel-model   'test
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "127.0.0.1:8080"
                 :models '(qwen3-4b)))

;;; gptel.el ends here
