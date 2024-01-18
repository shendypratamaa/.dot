# PREVENT DUPLICATED PATH
typeset -U PATH

# XDG
export XDG_RUNTIME_DIR="/tmp"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# HOMEBREW
eval $(/opt/homebrew/bin/brew shellenv)

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export SHELL_SESSIONS_DISABLE=1

# EDITOR
export EDITOR="nvim"

# TERMINAL
export TERMINAL="alacritty"

# BROWSER
export BROWSER="chrome"

# TERMINFO
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# LOCAL BIN
[[ "$PATH" =~ "$HOME/.local/bin" ]] || PATH="$HOME/.local/bin:$PATH"
[[ "$PATH" =~ "$HOME/.local/share/nvim/mason/bin" ]] || PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.local/share/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PYENV
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
[[ "$PATH" =~ "$PYENV_ROOT/shims" ]] || PATH="$PYENV_ROOT/shims:$PATH"
eval $(pyenv init --path)

# POSTGRESQL
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# TMUX SESSION
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t || tmux new -s
fi

