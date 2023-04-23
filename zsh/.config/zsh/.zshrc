# AUTOCD
setopt auto_cd
set -o ignoreeof

# ADD HOMEBREW COMPLETIONS
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

# COMPINIT -> ~/.j
autoload -U compinit
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zmodload zsh/complist

# ZSH UTILS
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -d "$HOME/.config/zsh/plugins/zsh-syntax-highlighting" ]]; then
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=124'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=048'
    ZSH_HIGHLIGHT_STYLES[global-alias]='fg=048'
    ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=048'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=048'
    ZSH_HIGHLIGHT_STYLES[command]='fg=048'
    ZSH_HIGHLIGHT_STYLES[function]='fg=048'
    ZSH_HIGHLIGHT_STYLES[command]='fg=048'
fi

# NVM
source $HOME/.local/share/nvm/nvm.sh

# COMPLETIONS, KEYBINDING FZF
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

# RESOURCES
source ~/.config/zsh/prompt.zsh
source ~/.config/zsh/export.zsh
source ~/.config/zsh/alias.zsh
source ~/.config/zsh/vimode.zsh
