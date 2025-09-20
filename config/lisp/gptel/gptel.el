;;; gptel.el --- gptel configuration
;;; Commentary:
;;; Code:

;; Llama.cpp (Ubuntu):
;; https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md
;; sudo apt install nvidia-cuda-toolkit libcurl4-openssl-dev ccache
;; cd ~
;; git clone https://github.com/ggml-org/llama.cpp
;; cd llama.cpp
;; ;; ;; GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 GGML_CCACHE=OFF GGML_CUDA_FA_ALL_QUANTS=ON GGML_CUDA_FORCE_CUBLAS=ON cmake -B build -DCMAKE_CUDA_ARCHITECTURES="61" -DGGML_CUDA=ON -DBUILD_SHARED_LIBS=OFF -DLLAMA_CURL=OFF -DGGML_NATIVE=ON -DGGML_AVX=OFF -DGGML_AVX2=OFF -DGGML_AVX512=OFF -DGGML_FMA=OFF -DGGML_F16C=OFF
;; GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 GGML_CCACHE=OFF cmake -B build -DCMAKE_CUDA_ARCHITECTURES="61" -DGGML_CUDA=ON
;; cmake --build build --config Release -j 12
;; vim ~/.bashrc
;; ;; # llama.cpp
;; ;; export PATH=$PATH:~/llama.cpp/build/bin
;; vim ~/.config/fish/config.fish
;; ;; # llama.cpp
;; ;; fish_add_path ~/llama.cpp/build/bin
;; llama-cli --version
;; llama-server --version
;; https://github.com/ggml-org/llama.cpp/blob/master/tools/main/README.md
;; https://huggingface.co/models?apps=llama.cpp&sort=downloads&search=code
;; llama-server -hf MaziyarPanahi/Yi-Coder-1.5B-Chat-GGUF:Q5_K_S
;; models paths:
;; ;; ll ~/.cache/llama.cpp/
;; ;; ;; ll ~/llama.cpp/granite-code
;; llama-server -c 65536 -m ~/llama.cpp/deepseek-coder-1.3b-typescript/deepseek-coder-1.3B-base-F16.gguf

;; Convert .safetensors to GGUF:
;; sudo apt install git-lfs
;; git lfs install
;; install: https://github.com/pyenv/pyenv
;; # Load pyenv automatically by appending the following to ~/.profile and ~/.bashrc:
;; ;; export PYENV_ROOT="$HOME/.pyenv"
;; ;; [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
;; ;; eval "$(pyenv init - bash)"
;; # Load pyenv-virtualenv automatically by adding the following to ~/.bashrc:
;; eval "$(pyenv virtualenv-init -)"
;; # Load pyenv in fish:
;; vim ~/.config/fish/config.fish
;; ;; set -Ux PYENV_ROOT $HOME/.pyenv
;; ;; fish_add_path $PYENV_ROOT/bin
;; ;; status is-interactive; and pyenv init - | source
;; pyenv --version
;; pip --version
;; pyenv install 3.10
;; pyenv local 3.10
;; cd ~/llama.cpp
;; python3.10 -m pip install -r requirements.txt
;; pip install huggingface_hub
;; git clone https://huggingface.co/CodeGPTPlus/deepseek-coder-1.3b-typescript
;; python3.10 ./convert_hf_to_gguf.py deepseek-coder-1.3b-typescript
;; pyenv local system

;; Podman:
;; podman pull ghcr.io/ggml-org/llama.cpp:server-cuda-b6408
;; compose.yaml
;;;; services:
;;;;   llamacpp-server:
;;;;     image: ghcr.io/ggml-org/llama.cpp:server-cuda-b6408
;;;;     ports:
;;;;       - 8080:8080
;;;;     volumes:
;;;;       - ./models/models:/models
;;;;     environment:
;;;;       LLAMA_ARG_MODEL: /models/jan-nano-4b-Q8_0.gguf
;;;;       LLAMA_ARG_PORT: 127.0.0.1
;;;;       LLAMA_ARG_PORT: 8080
;;;;       LLAMA_ARG_CTX_SIZE: 0
;;;;       LLAMA_ARG_JINJA: 1
;;;;       LLAMA_ARG_UBATCH: 2048
;;;;       LLAMA_ARG_BATCH: 2048
;;;;       LLAMA_ARG_N_CPU_MOE: 24
;;;;       LLAMA_ARG_ENDPOINT_METRICS: 1
;;;;   mcp-filesystem-server:
;;;;     image: ghcr.io/mark3labs/mcp-filesystem-server:latest
;;;;     container_name: mcp-filesystem-server
;;;;     stdin_open: true
;;;;     # tty: true
;;;;     command: /test
;;;;     volumes:
;;;;       - ./models/test:/test
;; Run: podman compose --file ./compose.yaml up

;; Repomix:
;; https://github.com/yamadashy/repomix
;; npm i -g repomix
;; repomix --compress --remove-comments

;; Models:
;; https://huggingface.co
;; https://huggingface.co/ggml-org/models
;; https://www.modelscope.cn
;; ;; deepseek-coder-v2 [https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct]
;; ;; deepseek-coder-v2 [https://huggingface.co/deepseek-ai/DeepSeek-Coder-V2-Instruct]
;; ;; codeqwen [https://huggingface.co/Qwen/Qwen3-Coder-480B-A35B-Instruct]
;; ;; magicoder [https://huggingface.co/ise-uiuc/Magicoder-S-CL-7B]
;; ;; codegemma [https://huggingface.co/google]
;; ;; opencoder [https://huggingface.co/infly]
;; ;; codegeex4 [https://huggingface.co/zai-org/codegeex4-all-9b]
;; ;; codeup [https://huggingface.co/juyongjiang/CodeUp-Llama-3-8B]
;; ;; phi4 [https://huggingface.co/microsoft]
;; ;; deepcoder [https://huggingface.co/agentica-org/DeepCoder-14B-Preview]
;; ;; starcoder2 [https://huggingface.co/bigcode]
;; ;; openthinker [https://huggingface.co/open-thoughts]
;; ;; qwen2.5-coder [https://huggingface.co/Qwen]
;; ;; qwq [https://huggingface.co/Qwen/QwQ-32B]
;; ;; wizardcoder [https://huggingface.co/WizardLMTeam/WizardCoder-33B-V1.1]
;; ;; codebooga [https://huggingface.co/oobabooga/CodeBooga-34B-v0.1]
;; ;; granite-code [https://huggingface.co/ibm-granite]
;; ;; codellama [https://huggingface.co/codellama]
;; ;; cogito [https://huggingface.co/deepcogito]

;; MCP servers:
;; https://hub.docker.com/mcp

(require 'gptel-integrations)

(use-package gptel
  :ensure t
  :config
  (setq
   gptel-model 'test
   gptel-backend (gptel-make-openai "llama-cpp"
                   :stream t
                   :protocol "http"
                   :host "127.0.0.1:8080"
                   :models '(LlamaCpp)))
  (setq gptel-use-tools t)
  (setq gptel-log-level 'debug)
  (setq gptel-expert-commands t)
  (setq gptel-confirm-tool-calls t)
  ;; (setq gptel-context-restrict-to-project-files t)
  (require 'mcp-hub)
  (setq mcp-hub-servers nil)
  ;; (setq mcp-hub-servers `(("mcp-servers" . (:command "podman-compose" :args ("--file" "compose.yaml" "up")))))
  (setq mcp-hub-servers `(
                          ("mcp-filesystem-server" . (:command "podman" :args ("attach" "mcp-filesystem-server")))
                          ))
  )

;;; gptel.el ends here
