;;; gptel.el --- gptel configuration
;;; Commentary:
;;; Code:

;; https://huggingface.co/Mozilla
;; https://huggingface.co/models?other=llamafile&p=1&sort=modified
;; StarCoder2: https://huggingface.co/Mozilla/starcoder2-llamafile/resolve/main/starcoder2-15b.Q6_K.llamafile?download=true
;; -- wget https://huggingface.co/Mozilla/starcoder2-llamafile/resolve/main/starcoder2-15b.Q6_K.llamafile?download=true
;; -- mv starcoder2-15b.Q6_K.llamafile?download=true starcoder2-15b.Q6_K.llamafile
;; -- chmod +x ./starcoder2-15b.Q6_K.llamafile
;; -- ./starcoder2-15b.Q6_K.llamafile --server --nobrowser --log-disable
;; QwenCoder:
;; -- wget https://huggingface.co/Mozilla/Qwen2.5-Coder-14B-Instruct-llamafile/resolve/main/Qwen2.5-Coder-14B-Instruct-Q8_0.llamafile?download=true
;; -- mv Qwen2.5-Coder-14B-Instruct-Q8_0.llamafile?download=true Qwen2.5-Coder-14B-Instruct-Q8_0.llamafile
;; -- chmod +x ./Qwen2.5-Coder-14B-Instruct-Q8_0.llamafile
;; -- ./Qwen2.5-Coder-14B-Instruct-Q8_0.llamafile --server --v2 --log-disable
;; Gemma:
;; -- wget https://huggingface.co/Mozilla/gemma-3-12b-it-llamafile/resolve/main/google_gemma-3-12b-it-Q8_0.llamafile?download=true
;; -- mv google_gemma-3-12b-it-Q8_0.llamafile?download=true google_gemma-3-12b-it-Q8_0.llamafile
;; -- chmod +x ./google_gemma-3-12b-it-Q8_0.llamafile
;; -- ./google_gemma-3-12b-it-Q8_0.llamafile --server --v2 --log-disable

(setq
 gptel-model   'test
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "127.0.0.1:8080"
                 :models '(test)))

;;; gptel.el ends here
