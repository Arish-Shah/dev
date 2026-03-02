unsetopt GLOBAL_RCS

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export BUN_INSTALL="/opt/bun"

export EDITOR="vi"

typeset -U path PATH
path=($HOME/.local/bin $path)
