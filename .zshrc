export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

# Aliases
alias ll="eza -bghHliSU"
alias ls="eza -bghHliSU"
alias cat="bat"

# gpg
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent