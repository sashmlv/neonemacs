;;; aider.el --- aider configuration
;;; Commentary:
;;; Code:

(use-package aider
  :config
  (setq aider-args '("--model" "openai/Jan nano" "--analytics-disable" "--no-auto-commits"))
  (setenv "OLLAMA_API_BASE" "http://127.0.0.1:11434")
  ;; (setenv "OLLAMA_CONTEXT_LENGTH" "8192")
  ;; (setenv "OLLAMA_CONTEXT_LENGTH" "32768")
  (setenv "OLLAMA_CONTEXT_LENGTH" "65536")
  (setenv "OPENAI_API_KEY" "")
  (setenv "OPENAI_API_BASE" "http://127.0.0.1:8080")
  (global-set-key (kbd "C-c a") 'aider-transient-menu)
  (aider-magit-setup-transients)
  (global-auto-revert-mode 1)
  (auto-revert-mode 1))

;; "openai/DeepSeek Coder V2 Lite Instruct" ;; llama.cpp - llama-server: model name from cli log, property - "general.name"
;; Run llama server example: llama-server -c 0 -m ~/llama.cpp/model/DeepSeek-Coder-V2-Lite-Instruct/DeepSeek-Coder-V2-Lite-64x1.5B-Instruct-F16.gguf
;; Run aider example: OPENAI_API_KEY="" OPENAI_API_BASE=http://127.0.0.1:8080 aider --model "openai/DeepSeek Coder V2 Lite Instruct"

;; Remove aider:
;; python -m pip uninstall aider-install
;; uv tool uninstall aider-chat
;; rm -rf ~/.aider
;; rm ~/.pyenv/shims/aider-install
;; uv cache clean

;;; aider.el ends here
