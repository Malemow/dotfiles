# fzf
source <(fzf --zsh)

# zoxide (取代 cd)
eval "$(zoxide init zsh --cmd cd)"

# fnm (Node.js 管理)
eval "$(fnm env --use-on-cd)"
