
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
  echo "%(!.%{$red%}.%{$green%})%~%{$reset_color%}"
}

function _user_host() {
  if [[ -n $SSH_CONNECTION || -n $SSH_FORCE ]]; then # add SSH_FORCE=1 for sudo su
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
PROMPT='${_return_status}$(_user_host)$(_current_dir)$(_git_prompt) %(!.#.$) '
RPROMPT='$(_git_origin_status)'

local exec_names=(node npm npx pm2 tsc git python python3 go)
local show_node=(npm npx pm2 tsc)
_preexec_time () {
  local exec_name="${2/ *}" # replace anything after <space>
  local col_offset=-1
  local color_len="$cyan$reset_color"
  local proc_info=""
  if [ ${exec_names[(i)$exec_name]} != $(($#exec_names + 1)) ]; then
    local names=($exec_name)
    if [ ${show_node[(i)$exec_name]} != $(($#show_node + 1)) ]; then
      names=(node $names)
    fi
    local versions=()
    for name in $names; do
      local version="$($name --version 2>/dev/null)"
      if [ -n "$version" ]; then
        version="${version% \(*\)}" # strip ending quote for "git --version" on mac "git version 2.17.2 (Apple Git-113)"
        version="${version/#* }" # replace anything until <space>
        versions+=("$name: $cyan$version$reset_color")
        col_offset=$(($col_offset+${#color_len}))
      fi
    done
    proc_info="(${versions[@]}) "
  fi
  proc_info="$proc_info$(date +"%I:%M:%S %p ")"
  C=$(($COLUMNS-${#proc_info}+$col_offset))
  echo -e "\033[1A\033[${C}C ${proc_info}"
}
preexec_functions+=(_preexec_time)

# set LSCOLORS for mac
unset LSCOLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# do not use a regex literal with =~ https://stackoverflow.com/a/12696899/1063091
# vim: ft=sh
