[[ -d "$XDG_STATE_HOME/zsh" ]] || mkdir -p "$XDG_STATE_HOME/zsh"
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

export ZSH="$XDG_DATA_HOME/oh-my-zsh"

zstyle ":omz:plugins:nvm" lazy yes
zstyle ":omz:plugins:nvm" lazy-cmd vi

ZSH_THEME="robbyrussell"
VI_MODE_SET_CURSOR=true
KEYTIMEOUT=1
plugins=(git nvm vi-mode)

source $ZSH/oh-my-zsh.sh

bindkey -s "^f" "sessionizer^M"
