;;; gptel.el --- gptel configuration
;;; Commentary:
;;; Code:

;; Llama.cpp (Ubuntu):
;; https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md
;; sudo apt install nvidia-cuda-toolkit libcurl4-openssl-dev
;; cd ~
;; git clone https://github.com/ggml-org/llama.cpp
;; cd llama.cpp
;; rm -rf ./build
;; cmake -B build -DGGML_CCACHE=OFF -DGGML_CUDA_ENABLE_UNIFIED_MEMORY=OFF -DGGML_CPU_ALL_VARIANTS=OFF -DGGML_CUDA_FA_ALL_QUANTS=ON -DGGML_CUDA_FORCE_CUBLAS=OFF -DGGML_CUDA_FORCE_MMQ=OFF -DCMAKE_CUDA_ARCHITECTURES="61" -DGGML_CUDA=ON -DLLAMA_CURL=OFF -DGGML_NATIVE=ON -DGGML_AVX=ON -DGGML_AVX2=ON -DGGML_AVX512=OFF -DGGML_FMA=ON -DGGML_F16C=ON -DLLAMA_BUILD_TESTS=OFF
;; cmake --build build --config Release -j 12 --clean-first
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
;; llama-server -hf Menlo/Jan-nano-128k-gguf
;; models paths:
;; ;; ll ~/.cache/llama.cpp/
;; ;; ;; ll ~/llama.cpp/granite-code
;; llama-server -m ~/llama.cpp/models/jan-nano-128k-iQ4_XS.gguf --n-cpu-moe 99 --n-gpu-layers 0 --threads 6 --batch-size 1024 --ubatch-size 2048 --no-op-offload --no-mmap --flash-attn 1 --temp 0.7 --top-p 0.8 --top-k 20 --min-p 0

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
;; https://podman-desktop.io/docs/podman/gpu
;; https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
;; [install and repead this steps after driver has been updated] https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html
;; cd ~/llama.cpp/.devops
;; cp cuda.Dockerfile cuda-local.Dockerfile
;; vim cuda-local.Dockerfile
;; ;; replase line: cmake -B build -DGGML_NATIVE=OFF -DGGML_CUDA=ON -DGGML_BACKEND_DL=ON -DGGML_CPU_ALL_VARIANTS=ON -DLLAMA_BUILD_TESTS=OFF ${CMAKE_ARGS} -DCMAKE_EXE_LINKER_FLAGS=-Wl,--allow-shlib-undefined . && \
;; ;; with following: cmake -B build -DGGML_CCACHE=OFF -DGGML_CUDA_ENABLE_UNIFIED_MEMORY=OFF -DGGML_CPU_ALL_VARIANTS=OFF -DGGML_CUDA_FA_ALL_QUANTS=ON -DGGML_CUDA_FORCE_CUBLAS=OFF -DGGML_CUDA_FORCE_MMQ=OFF -DCMAKE_CUDA_ARCHITECTURES="61" -DGGML_CUDA=ON -DLLAMA_CURL=OFF -DGGML_NATIVE=ON -DGGML_AVX=ON -DGGML_AVX2=ON -DGGML_AVX512=OFF -DGGML_FMA=ON -DGGML_F16C=ON -DLLAMA_BUILD_TESTS=OFF -DCMAKE_EXE_LINKER_FLAGS=-Wl,--allow-shlib-undefined . && \
;; podman build -t local/llama.cpp:full-cuda --target full -f .devops/cuda-local.Dockerfile .
;; disable GPU usage in user programms: chromium, firefox, thunderbird, etc.
;; run: podman compose --file ./compose.yaml up

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
;; https://github.com/modelcontextprotocol/servers
;; https://github.com/appcypher/awesome-mcp-servers
;; https://www.pulsemcp.com/servers

(require 'gptel-integrations)

(use-package gptel
  :ensure t
  :config
  (setq
   gptel-model 'LlamaCpp
   gptel-backend (gptel-make-openai "llama-cpp"
                   :stream t
                   :protocol "http"
                   :host "0.0.0.0:8080"
                   :models '(LlamaCpp)))
  (setq gptel-use-tools t)
  (setq gptel-log-level 'debug)
  (setq gptel-expert-commands t)
  (setq gptel-confirm-tool-calls t)
  ;; (setq gptel-context-restrict-to-project-files t)
  (require 'mcp-hub)
  (setq mcp-hub-servers nil)
  (setq mcp-hub-servers `(
                          ;; ("mcp-filesystem-server" . (:command "podman" :args ("attach" "mcp-filesystem-server")))
                          ;; ("mcp-sequentialthinking" . (:command "podman" :args ("attach" "mcp-sequentialthinking")))
                          ))
 )

;;; gptel.el ends here
