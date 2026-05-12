;;; gptel.el --- gptel configuration
;;; Commentary:
;;; Code:

(require 'gptel-integrations)

(use-package gptel
  :ensure t
  :config
  (setq
   gptel-model 'LlamaCpp
   gptel-backend (gptel-make-openai "llama-cpp"
                   :stream t
                   :protocol "http"
                   :host "127.0.0.1:9001"
                   :models '(LlamaCpp)))
  (setq gptel-use-curl t)
  (setq gptel-use-tools t)
  (setq gptel-track-media t)
  (setq gptel-log-level 'debug)
  (setq gptel-expert-commands t)
  (setq gptel-confirm-tool-calls t)
  (setq gptel--system-message nil)
  (setq gptel-default-mode 'org-mode)
  (require 'mcp-hub)
  (setq mcp-hub-servers nil)
  (setq mcp-hub-servers `(
                          ("mcp-repomix" . (:command "podman" :args ("attach" "mcp-repomix")))
                          ("mcp-filesystem-server" . (:command "podman" :args ("attach" "mcp-filesystem-server")))
                          ("mcp-chrome-devtools" . (:command "podman" :args ("attach" "mcp-chrome-devtools")))
                          ("mcp-crystaldba-postgres" . (:command "podman" :args ("attach" "mcp-crystaldba-postgres")))
                          ("mcp-shell" . (:command "podman" :args ("attach" "mcp-shell")))
                          ))
  )

(gptel-make-preset 'sql
  :description "Preset for sql coding"
  :system nil
  :backend (gptel-make-openai "llama-cpp"
             :stream t
             :protocol "http"
             :host "127.0.0.1:9002"
             :models '(LlamaCpp))
  )

(gptel-make-preset 'ocr
  :description "Preset for ocr"
  :system nil
  :track-media t
  :model 'LlamaCpp
  :backend (gptel-make-openai "llama-cpp"
             :stream t
             :protocol "http"
             :host "127.0.0.1:9003"
             :models '((LlamaCpp
                        :capabilities (media json) ;; (media tool-use json url)
                        :mime-types ("image/png" "image/jpeg" "image/webp" "application/pdf"))))
  )

;;; gptel.el ends here
