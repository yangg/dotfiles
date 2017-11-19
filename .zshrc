

ZSH_THEME=brook
ZSH_CUSTOM=${DOTDIR:=~/.dotfiles}/zsh

export EDITOR=vim

if [ -z "$plugins" ]; then
  plugins=(
    git
    # nvm
  )
fi
# autoload -U zmv
# autoload -U zcalc

# ~/.oh-my-zsh/templates/zshrc.zsh-template
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh


# aliases
alias gdiff='git diff --no-index'

