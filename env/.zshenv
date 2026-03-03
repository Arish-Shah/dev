unsetopt GLOBAL_RCS

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export BUN_INSTALL="$XDG_DATA_HOME/bun"

export EDITOR="vi"

typeset -U path PATH
path=($BUN_INSTALL/bin $HOME/.local/bin $path)
