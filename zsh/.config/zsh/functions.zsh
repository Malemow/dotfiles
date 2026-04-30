# 自動建立快照並執行安裝 (以 pacman 為例)
pacman-sn() {
    sudo snapper -c root create --description "Pre-$1"
    sudo pacman -S "$@"
}

# 在 ~/.zshrc 或 ~/.bashrc 加入：
sn-pre() {
    local desc="${1:-Before task}"
    sudo snapper -c root create --description "$desc"
    echo "✅ Root snapshot created: $desc"
}
