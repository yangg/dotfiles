

ZSH_THEME=brook
ZSH_CUSTOM=${DOTDIR:=~/.dotfiles}/zsh

export EDITOR=vim

plugins=(
  git
  osx
  # nvm
)
# autoload -U zmv
# autoload -U zcalc

# ~/.oh-my-zsh/templates/zshrc.zsh-template
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh


# aliases
alias gdiff='git diff --no-index'

