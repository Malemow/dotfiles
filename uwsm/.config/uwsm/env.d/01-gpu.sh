# GPU 偵測與優化
cmd_exists() { command -v "$1" >/dev/null 2>&1; }
detect_nvidia() { if cmd_exists nvidia-smi || lsmod | grep -q 'nvidia'; then echo 1; else echo 0; fi; }

if [ "$(detect_nvidia)" = "1" ]; then
    export LIBVA_DRIVER_NAME=nvidia
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __GL_VRR_ALLOWED=1
    export NVD_BACKEND=direct
fi
