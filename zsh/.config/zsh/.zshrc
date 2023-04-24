# AUTOCD
setopt auto_cd
set -o ignoreeof

# ADD HOMEBREW COMPLETIONS
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

# COMPINIT -> ~/.cache/zsh
autoload -U compinit
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zmodload zsh/complist

# LOAD UTILS
source ~/.config/zsh/utils.zsh

# SOURCE FILE
zsh_add_file "prompt.zsh"
zsh_add_file "export.zsh"
zsh_add_file "alias.zsh"
zsh_add_file "vimode.zsh"

# PLUGINS
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# NVM
source $HOME/.local/share/nvm/nvm.sh

# FZF
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
