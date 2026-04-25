# 基礎別名
alias c='clear'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias fastfetch="~/.config/fastfetch/random-logo.sh"

# eza - 取代 ls
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --git --group --header --octal-permissions'
alias lll='eza -l --icons --group-directories-first --git --group --header --octal-permissions --time-style=long-iso --modified --created --accessed'
alias lt='eza --tree --icons --level=2'

# 工具取代
alias vim='nvim'
alias vi='nvim'
alias cat='bat --paging=never'
alias bat='bat --style=plain --paging=never --color auto'
alias icat='kitten icat'
alias df='duf'

# 全域 --help 高亮
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain --paging=never --color always'
