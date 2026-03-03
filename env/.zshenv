unsetopt GLOBAL_RCS

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

export BUN_INSTALL="$XDG_DATA_HOME/bun"

export EDITOR="vi"

typeset -U path PATH
path=($BUN_INSTALL/bin $XDG_BIN_HOME $path)
