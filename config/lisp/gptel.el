;;; gptel.el --- gptel configuration
;;; Commentary:
;;; Code:

;; Llama.cpp (Ubuntu):
;; https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md
;; sudo apt install nvidia-cuda-toolkit libcurl4-openssl-dev ccache
;; cd ~
;; git clone https://github.com/ggml-org/llama.cpp
;; cd llama.cpp
;; GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 GGML_CCACHE=OFF cmake -B build -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES="61"
;; cmake --build build --config Release -j 8
;; vim ~/.bashrc, add:
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

;; llama-server -m ~/llama.cpp/model/gemma-3-1b-pt_full_sft_TypeScript_data_12K/gemma-3-1B-pt_full_sft_TypeScript_data_12K-F16.gguf
;; llama-server -c 65536 -m ~/llama.cpp/model/DeepSeek-Coder-V2-Lite-Instruct/DeepSeek-Coder-V2-Lite-64x1.5B-Instruct-F16.gguf

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

;; Ollama:
;; -- https://github.com/ollama/ollama/blob/main/docs/linux.md
;; -- curl -LO https://ollama.com/download/ollama-linux-amd64.tgz
;; -- sudo tar -C /usr -xzf ollama-linux-amd64.tgz
;; -- GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 ollama serve
;; -- ollama -v
;; Uninstall:
;; -- sudo rm $(which ollama)
;; -- sudo rm -r /usr/share/ollama
;; -- sudo userdel ollama
;; -- sudo groupdel ollama
;; -- sudo rm -rf /usr/local/lib/ollama

;; Models:
;; https://huggingface.co
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
;; ;; Ghenwy/AliaDev5 [https://ollama.com/Ghenwy/AliaDev5]
;; ;; dolphincoder [https://ollama.com/library/dolphincoder]
;; ;; starcoder2 [https://huggingface.co/bigcode]
;; ;; starcoder [https://ollama.com/library/starcoder]
;; ;; codestral [https://ollama.com/library/codestral]
;; ;; devstral [https://ollama.com/library/devstral]
;; ;; openthinker [https://huggingface.co/open-thoughts]
;; ;; deepseek-r1 [https://ollama.com/library/deepseek-r1]
;; ;; qwen2.5-coder [https://huggingface.co/Qwen]
;; ;; qwq [https://huggingface.co/Qwen/QwQ-32B]
;; ;; wizardcoder [https://huggingface.co/WizardLMTeam/WizardCoder-33B-V1.1]
;; ;; codebooga [https://huggingface.co/oobabooga/CodeBooga-34B-v0.1]
;; ;; granite-code [https://huggingface.co/ibm-granite]
;; ;; codellama [https://huggingface.co/codellama]
;; ;; cogito [https://huggingface.co/deepcogito]

(gptel-make-ollama "Ollama"
  :host "127.0.0.1:11434"
  :stream t
  :models '(deepseek-r1:32b
            devstral:24b
            codestral:22b
            dolphincoder:15b
            starcoder:15b
            Ghenwy/AliaDev5:Pro14b))

(setq
 gptel-model 'test
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "127.0.0.1:8080"
                 :models '(LlamaCpp)))

;;; gptel.el ends here
