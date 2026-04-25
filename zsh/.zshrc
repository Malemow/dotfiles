fastfetch

# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh 設定
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  sudo
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
)

source "$ZSH/oh-my-zsh.sh"
# p10k 設定
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 載入模組
ZSH_MODS="$HOME/.config/zsh"
source "$ZSH_MODS/env.zsh"
source "$ZSH_MODS/aliases.zsh"
source "$ZSH_MODS/tools.zsh"
