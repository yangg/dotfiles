
local black=$fg[black]
local red=$fg[red]
local blue=$fg[blue]
local green=$fg[green]
local yellow=$fg[yellow]
local magenta=$fg[magenta]
local cyan=$fg[cyan]
local white=$fg[white]

local black_bold=$fg_bold[black]
local red_bold=$fg_bold[red]
local blue_bold=$fg_bold[blue]
local green_bold=$fg_bold[green]
local yellow_bold=$fg_bold[yellow]
local magenta_bold=$fg_bold[magenta]
local cyan_bold=$fg_bold[cyan]
local white_bold=$fg_bold[white]

local highlight_bg=$bg[red]


ZSH_THEME_GIT_PROMPT_PREFIX="%{$blue_bold%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

# ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$green_bold%}+"
ZSH_THEME_GIT_PROMPT_DELETED="%{$red_bold%}-"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$magenta_bold%}*"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$blue_bold%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$cyan_bold%}="
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$yellow_bold%}?"


function _current_dir {
  echo "%{$green%}${PWD/#$HOME/~}%{$reset_color%}"
}

function _user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$yellow%}$me%{$reset_color%}: "
  fi
}

function _git_prompt {
  if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    local git_status="$(git_prompt_status)"
    if [[ -n $git_status ]]; then
      git_status=" $git_status%{$reset_color%}"
    fi
    echo " ($(git_prompt_info)$git_status)"
  fi
}

function _git_origin_status {
  if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    set -- $(git rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)
    if [[ $1  -gt 0 ]]; then
      origin_status="$1↓"
    fi
    if [[ $2  -gt 0 ]]; then
      origin_status="${origin_status}$2↑"
    fi
    if [[ -n $origin_status ]]; then
      echo "%{$yellow_bold%}$origin_status%{$reset_color%}"
    fi
  fi
}

local _return_status="%{$red_bold%}%(?..✘ )%{$reset_color%}"

# The prompt
PROMPT='${_return_status}$(_user_host)$(_current_dir)$(_git_prompt) $ '
RPROMPT='$(_git_origin_status)'
preexec () {
  DATE=$(date +"%I:%M:%S %p ")
  C=$(($COLUMNS-${#DATE}-1))
  echo -e "\033[1A\033[${C}C ${DATE}"
}

# vim: ft=sh
