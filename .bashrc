
__script_path=$(dirname "${BASH_SOURCE[0]}")
source $__script_path/.aliases
source $__script_path/.functions

# https://github.com/git/git/tree/master/contrib/completion
if [ ! -f "$HOME/.git-prompt.sh" ]; then
    echo 'Downloading git completion files...'
    curl -so ~/.git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
    curl -so ~/.git-prompt.sh https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
    echo 'Done!'
fi
GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-completion.bash
source ~/.git-prompt.sh

shopt -s histappend
shopt -s cdspell
shopt -s autocd 2> /dev/null

# Bash Color Chart http://www.arwin.net/tech/bash.php
PS1='\u@\h: \[\e[32m\]\w\[\e[0m\] $(__git_ps1 "(\[\e[1;34m\]%s\[\e[0m\])")\$ '

HISTIGNORE='ls:exit'

# complete -W "$(sed -E 's/[, ].*//' ~/.ssh/known_hosts)" ssh
[ -e ~/.ssh/config ] && complete -o nospace -W "$(perl -ne 'print "$1 " if /^Host (.+)$/' ~/.ssh/config)" ssh
complete -o nospace -W 'allfile desktop ext' show
complete -o nospace -W 'addr gw ip ipr' showme
_complete_upto() {
    local IFS=$'\n'
    local word=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(echo ${PWD#/} | sed 's|/|\n|g' | grep -i "^$word" | sed -e 's| |\\ |g'))
}
complete -o nospace -F _complete_upto upto
