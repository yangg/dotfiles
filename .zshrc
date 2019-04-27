
DISABLE_AUTO_UPDATE=true
ZSH_THEME=brook
ZSH_CUSTOM=${DOTDIR:=~/.dotfiles}/zsh
# Online editor: https://geoff.greer.fm/lscolors/
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

export EDITOR=vim

# ENABLE_CORRECTION="true"
plugins=(
  git
  extract
  redis-cli
  # nvm
)
if [ $(uname) = Darwin ]; then
  plugins+=(
    osx
    httpie
  )
else
  plugins+=(
    systemd
    debian
  )
fi

autoload -Uz zmv
autoload -Uz zcalc

# ~/.oh-my-zsh/templates/zshrc.zsh-template
ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


# aliases
# enable sudo with aliases
# If the last character of the alias value is a space or tab character,
# then the next command word following the alias is also checked for alias expansion.
# http://www.gnu.org/software/bash/manual/bashref.html#Aliases
alias sudo='sudo '
alias gdiff='git diff --no-index'
alias zshrc='vim $DOTDIR/.zshrc'
alias chrome='open -a "Google Chrome"'


# command vs builtin https://unix.stackexchange.com/a/86269/17051
# http://zsh.sourceforge.net/Doc/Release/Parameters.html#index-TIMEFMT
TIMEFMT=$'real\t   %*E\nuser\t   %U\nsys\t   %S\ncpu\t   %P'
# disable -r time
# alias time='time -p'


function rds-del {
  redis-cli KEYS "$1" | xargs redis-cli DEL
}
alias rds-ls='redis-cli KEYS'

pwdg() {
  local chars="${2:A-Za-z0-9}"
  LC_ALL=C < /dev/urandom tr -dc "$chars" | head -c${1:18};echo;
}
