

ZSH_THEME=brook
ZSH_CUSTOM=${DOTDIR:=~/.dotfiles}/zsh

export EDITOR=vim

plugins=(
  git
  extract
  # nvm
)
if [ $(uname) = Darwin ]; then
  plugins=($plugins osx)
else
  plugins=($plugins systemd)
fi

autoload -Uz zmv
autoload -Uz zcalc

# ~/.oh-my-zsh/templates/zshrc.zsh-template
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh


# aliases
alias gdiff='git diff --no-index'

