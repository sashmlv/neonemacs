;;; aidermacs.el --- aidermacs configuration
;;; Commentary:
;;; Code:

(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  :config
  (setenv "OLLAMA_API_BASE" "http://127.0.0.1:11434")
  ;; (setenv "OLLAMA_CONTEXT_LENGTH" "8192")
  ;; (setenv "OLLAMA_CONTEXT_LENGTH" "32768")
  (setenv "OLLAMA_CONTEXT_LENGTH" "65536")
  (setenv "OPENAI_API_KEY" "")
  (setenv "OPENAI_API_BASE" "http://127.0.0.1:8080")
  :custom
  (aidermacs-default-chat-mode 'code)
  ;; (aidermacs-default-model "ollama/deepseek-r1:32b")
  (aidermacs-default-model "openai/DeepSeek Coder V2 Lite Instruct") ;; llama.cpp - llama-server: model name from cli log, property - "general.name"
  )

;; Run llama server example: llama-server -c 65536 -m ~/llama.cpp/model/DeepSeek-Coder-V2-Lite-Instruct/DeepSeek-Coder-V2-Lite-64x1.5B-Instruct-F16.gguf
;; Run aider example: OPENAI_API_KEY="" OPENAI_API_BASE=http://127.0.0.1:8080 aider --model "openai/DeepSeek Coder V2 Lite Instruct"

;;; aidermacs.el ends here
