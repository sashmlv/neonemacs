## AI
<!--
;; * Llama.cpp (Ubuntu) *
;; https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md
;; sudo apt install nvidia-cuda-toolkit libcurl4-openssl-dev
;; cd ~
;; git clone https://github.com/ggml-org/llama.cpp
;; cd llama.cpp
;; rm -rf ./build
;; ;; ;; cmake -B build -DCMAKE_CUDA_ARCHITECTURES="61" -DGGML_CUDA=ON
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

;; * Convert .safetensors to GGUF *
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
;; ;; pyenv update
;; pip --version
;; pyenv install 3.10
;; pyenv local 3.10
;; cd ~/llama.cpp
;; python3.10 -m pip install -r requirements.txt
;; pip install huggingface_hub
;; git clone https://huggingface.co/CodeGPTPlus/deepseek-coder-1.3b-typescript
;; python3.10 ./convert_hf_to_gguf.py deepseek-coder
;; python3.10 ./convert_hf_to_gguf.py chandra --mmproj
;; pyenv local system

;; * Podman *
;; sudo apt install conmon btrfs-progs gcc git golang-go go-md2man iptables libassuan-dev libbtrfs-dev libc6-dev libdevmapper-dev libglib2.0-dev libgpgme-dev libgpg-error-dev libprotobuf-dev libprotobuf-c-dev libseccomp-dev libselinux1-dev libsystemd-dev make netavark passt pkg-config runc uidmap libapparmor-dev fuse-overlayfs
;; cd ~
;; git clone https://github.com/containers/podman/
;; cd podman
;; git tag -l | sort -V
;; git checkout v5.8.2
;; make BUILDTAGS='selinux seccomp apparmor exclude_graphdriver_devicemapper cgo exclude_apiservices' PREFIX=/usr
;; sudo env PATH=$PATH make install PREFIX=/usr
;; ;; sudo env PATH=$PATH make uninstall PREFIX=/usr
;; * Podman-compose *
;; cd ~
;; git clone https://github.com/containers/podman-compose
;; cd podman-compose
;; git tag -l | sort -V
;; git checkout v1.5.0
;; pyenv install 3.13
;; pyenv local 3.13
;; python -m pip install -r requirements.txt
;; pip install --user .
;; * Podman GPU *
;; ;; https://podman-desktop.io/docs/podman/gpu
;; ;; https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
;; ;; [install and repead this steps after driver has been updated] https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html
;; * Podman llama cpp *
;; cd ~/llama.cpp/.devops
;; cp cuda.Dockerfile cuda-local.Dockerfile
;; vim cuda-local.Dockerfile
;; ;; replase line: cmake -B build -DGGML_NATIVE=OFF -DGGML_CUDA=ON -DGGML_BACKEND_DL=ON -DGGML_CPU_ALL_VARIANTS=ON -DLLAMA_BUILD_TESTS=OFF ${CMAKE_ARGS} -DCMAKE_EXE_LINKER_FLAGS=-Wl,--allow-shlib-undefined . && \
;; ;; with following: cmake -B build -DGGML_CCACHE=OFF -DGGML_CUDA_ENABLE_UNIFIED_MEMORY=OFF -DGGML_CPU_ALL_VARIANTS=OFF -DGGML_CUDA_FA_ALL_QUANTS=ON -DGGML_CUDA_FORCE_CUBLAS=OFF -DGGML_CUDA_FORCE_MMQ=OFF -DCMAKE_CUDA_ARCHITECTURES="61" -DGGML_CUDA=ON -DLLAMA_CURL=OFF -DGGML_NATIVE=ON -DGGML_AVX=ON -DGGML_AVX2=ON -DGGML_AVX512=OFF -DGGML_FMA=ON -DGGML_F16C=ON -DLLAMA_BUILD_TESTS=OFF ${CMAKE_ARGS} -DCMAKE_EXE_LINKER_FLAGS=-Wl,--allow-shlib-undefined . && \
;; podman build -t local/llama.cpp:full-cuda --target full -f .devops/cuda-local.Dockerfile .
;; ;; podman build -t local/llama.cpp:server-cuda --target server -f .devops/cuda-local.Dockerfile .
;; disable GPU usage in user programms: chromium, firefox, thunderbird, etc.
;; run: podman compose --file ./compose.yaml up

;; * Chrome Dev Tools*
;; ;; https://developer.chrome.com/docs/devtools/remote-debugging/local-server#port-forwarding
;; chromium --remote-debugging-port=9222 --user-data-dir=/home/$USER/snap/chromium/common/chromium/Testing-profile
;; sudo apt install openssh-server
;; sudo systemctl enable --now ssh
;; sudo systemctl status ssh
;; cd ~
;; ssh-keygen -t ed25519 -f ~/.ssh/id_rsa_chrome_dev_tools -N ""
;; Enter name: id_rsa_chrome_dev_tools
;; Run services: podman compose --file ./compose.yaml up
;; Run ssh agent for port forwarding:
;; ;; Add connnection config: vim ~/.ssh/config
;; ;; ;; Host 127.0.0.1
;; ;; ;;   User root
;; ;; ;;   Port 2222
;; ;; ;;   AddKeysToAgent yes
;; ;; ;;   IdentityFile ~/.ssh/id_rsa_chrome_dev_tools
;; ;; Run ssh tunnel on the host: ssh -p 2222 -N -R 9222:127.0.0.1:9222 root@127.0.0.1
;; ;; If container is upgraded, you need to remove the entry from known_hosts on the host machine (then run ssh tunnel as usual): ssh-keygen -R '[127.0.0.1]:2222'

;; * MCP inspector (debug mcp servers) *
;; npx @modelcontextprotocol/inspector

;; * Repomix *
;; https://github.com/yamadashy/repomix
;; npm i -g repomix
;; repomix --compress --remove-comments

;; MCP servers:
;; https://hub.docker.com/mcp
;; https://github.com/modelcontextprotocol/servers
-->
