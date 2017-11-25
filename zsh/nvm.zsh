

# nvm start slow, load it manually
# init & upgrade
function nvm-up {
  if [ -z $NVM_DIR ]; then
    cat $HOME/.npmrc 2>/dev/null | grep taobao.org >/dev/null && export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
    . "$HOME/.nvm/nvm.sh"
  fi
  if [ -n "$1" ]; then
    nvm install $1 --reinstall-packages-from=node
  fi
}

# clear old nvm path
PATH=$(echo $PATH | sed 's/\(^\|:\)[^:]*\/.nvm\/versions\/[^:]*\:/\1/g')
local version=$(cat $HOME/.nvm/alias/default 2>/dev/null)
[ -n "$version" ] && PATH=$HOME/.nvm/versions/node/v$version/bin:$PATH
