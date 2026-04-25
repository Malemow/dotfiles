# fzf
source <(fzf --zsh)

# zoxide (取代 cd)
eval "$(zoxide init zsh)"

# fnm (Node.js 管理)
eval "$(fnm env --use-on-cd)"
