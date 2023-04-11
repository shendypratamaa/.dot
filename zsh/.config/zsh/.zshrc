# HISTORY FILE
export HISTSIZE=10000
export SAVEHIST=10000

# AUTOCD
setopt auto_cd
set -o ignoreeof

# COMPLETIONS
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)

# NVM
source $HOME/.local/share/nvm/nvm.sh

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

# CFG
alias c-zsh="$EDITOR ~/.config/zsh/.zshrc"
alias c-zpr="$EDITOR ~/.dotfiles/.zprofile"
alias c-tmux="$EDITOR ~/.config/tmux/tmux.conf"
alias c-alt="$EDITOR ~/.config/alacritty/alacritty.yml"
alias c-kitty="$EDITOR ~/.config/kitty/kitty.conf"
alias c-pipe="$EDITOR ~/.config/pipe-viewer/pipe-viewer.conf"

# BASIC ALIAS
alias src="exec $SHELL"
alias reboot="sudo reboot"
alias ls="exa -s Extension --icons -h"
alias la="exa -s Extension --icons -h -a"
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
alias ln="ln -v"
alias gst="git status"
alias glog="git log --graph"
alias btw="neofetch"
alias lg="lazygit"
alias vim="/usr/local/bin/nvim"
alias vi="/usr/bin/vim"
alias news="newsboat -q"
alias npml="npm list --location=global --depth=0"
alias ppath="echo $PATH | tr ':' '\n'"
alias gh="open \`git remote -v | grep fetch | awk '{print \$2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'\`| head -n1"

# GOTO ALIAS
alias cdd="cd ~/.dotfiles"
alias cdc="cd ~/.config"
alias cdn="cd ~/.config/nvim"
alias cdz="cd ~/.config/zsh"
alias cde="cd ~/.cache"
alias cds="cd ~/.local/bin"
alias cdl="cd ~/.local/share"

# PIPE-VIEWER
alias msv="pipe-viewer --player=mpvv"
alias msc="pipe-viewer -n --no-video-info --player=mpvm"

# ZSH PROMPT
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

setopt prompt_subst
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %B%{$fg[yellow]%}git:%{$fg[white]%}(%{$fg[red]%}%b%{$fg[white]%})"

_get_path() {
    current_path=${PWD/#$HOME/'~'}
    if [ "$current_path" = "~" ]; then
       echo $current_path
    else
       path_parent=${current_path%\/*}
       path_parent_short=`echo $path_parent | sed -r 's|/(..)[^/]*|/\1|g'`
       directory=${current_path##*\/}
       echo "$path_parent_short/$directory"
    fi
}

sysinfo=$(uname -a | awk '{print $1}')
icon=$(echo -n "%B%F{white}%{%G@%}")
user=$(whoami | sed 's/shendypratama/sShendy/')

PROMPT="%B%{$fg[white]%}[%{$fg[red]%}%${user}%{$fg[white]%}${icon}%{$fg[yellow]%}${sysinfo} %{$fg[blue]%}\$(_get_path)%{$fg[white]%}]"
PROMPT+="\$vcs_info_msg_0_ %(?:%{$fg[green]%}%{%Gﾒ%} :%{$fg[red]%}%{%Gﾒ%} )"

# VIMODE
bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M vicmd 'y' vi-yank-xclip

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q\033]12;#B48EAD\007'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q\033]12;#e3e3e3\007'
  fi
}

zle-line-init() {
    zle -K viins
    echo -ne "\e[1 q\033]12;#e3e3e3\007"
}

function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy
}

echo -ne '\e[1 q\033]12;#e3e3e3\007'

preexec() { echo -ne '\e[1 q\033]12;#e3e3e3\007' ;}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N vi-yank-xclip

# COMPLETIONS, KEYBINDING FZF
source $(brew --prefix)/opt/fzf/shell/completion.zsh
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh

# FZF USING FD SEARCH
export FZF_DEFAULT_COMMAND="fd -H -L --strip-cwd-prefix"

# FZF COMPLETIONS TRIGGER
export FZF_COMPLETION_TRIGGER="**"

# FZF DEFAULT OPTS
export FZF_DEFAULT_OPTS="\
--height=50% --margin=0,1 --reverse --border=sharp --inline-info --preview-window='border-sharp' \
--bind ctrl-f:preview-page-down,ctrl-b:preview-page-up \
"

# FZF OPTS EXCLUDE DIR
EXCLUDE_FZF="\
--exclude=.config/pipe-viewer/playlists --exclude=.config/pipe-viewer/watched.txt \
--exclude=.config/karabiner --exclude=Desktop --exclude=Documents --exclude=Downloads --exclude=Library \
--exclude=Movies --exclude=Music --exclude=Pictures --exclude=Public --exclude=.vscode \
"

# FZF PREVIEW WITH BAT
PREVBAT="bat --style=plain --color=always --line-range :500 {}"

# FZF_KEYBINDING CTRL_R
export FZF_CTRL_R_OPTS="
--prompt='FZF History > '
"

# FZF_KEYBINDING CTRL_T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND $EXCLUDE_FZF"
export FZF_CTRL_T_OPTS="
--prompt='FZF Find > '
--header 'CTRL-D: Directories / CTRL-F: Files'
--bind 'ctrl-d:change-prompt(Find Directories > )+reload($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -t d)'
--bind 'ctrl-f:change-prompt(Find Files > )+reload($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -t f)'
--preview '(highlight -O ansi -l {} 2> /dev/null || $PREVBAT || tree -C {}) 2> /dev/null | head -200'
"

# FZF_KEYBINDING ALT_C
export FZF_ALT_C_COMMAND="fd . -L -H -t d $EXCLUDE_FZF"
export FZF_ALT_C_OPTS="
--prompt='FZF Autocd > '
--preview '(highlight -O ansi -l {} 2> /dev/null || tree -C {}) 2> /dev/null | head -200'
"

# FZF_ ALT_C > CTRL_D
bindkey '\ec' ''
bindkey '^D' fzf-cd-widget

# FZF ALIAS
alias vd="
    cd ~ && cd \$($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -d 7 --type d |
        fzf --prompt='Select Directory > ' --preview 'tree -C {}' )
    "

alias vn="
    $FZF_DEFAULT_COMMAND $EXCLUDE_FZF -d 7 --type f |
        fzf --prompt='Select File > ' -m --preview '$PREVBAT' |
        xargs -r $EDITOR
    "

alias vs="
    fd . $HOME/.local/bin $HOME/.local/share/fzf-launcher $HOME/.local/share/sysutils |
        fzf --prompt='Select Script File > ' -m --preview '$PREVBAT' |
        awk '{print $2}' |
        xargs -r $EDITOR -c 'cd %:h'
    "

function gb() {
    git checkout $(git branch | fzf --prompt='Git Branch > ')
}

# TMUX
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'

# TMUX CREATE PANES
alias idh=" \
    tmux rename-window ide &&
    clear && figlet 'lets works' && \
    tmux split-window -h -p 35 && \
    tmux split-window -v -p 50 && \
    tmux select-pane -t 0
"

alias idv=" \
    tmux rename-window ide &&
    clear && figlet 'lets works' && \
    tmux split-window -v -p 35 && \
    tmux split-window -h -p 50 && \
    tmux select-pane -t 0
"

# LESS
export LESSHISTFILE="$XDG_DATA_HOME/less/lesshst"

# MANPAGE PREVIEW
export MANPAGER="sh -c 'col -bx | bat -l=man '"

# GOLANG
export GOPATH="$XDG_DATA_HOME/go"

# GNUPG
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# REPL
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"
