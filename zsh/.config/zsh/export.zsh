# HISTORY FILE
export HISTFILE=$XDG_CACHE_HOME/zsh/zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export KEYTIMEOUT=1

# FZF USING FD SEARCH
export FZF_DEFAULT_COMMAND="fd -H -L --strip-cwd-prefix"

# FZF COMPLETIONS TRIGGER
export FZF_COMPLETION_TRIGGER="**"

# FZF DEFAULT OPTS
export FZF_DEFAULT_OPTS="\
--margin=1,2 --border=sharp --inline-info --preview-window='border-sharp' \
--bind ctrl-f:preview-page-down,ctrl-b:preview-page-up \
"

# FZF OPTS EXCLUDE DIR
export EXCLUDE_FZF="\
--exclude=.config/pipe-viewer/playlists --exclude=.config/pipe-viewer/watched.txt \
--exclude=.config/karabiner --exclude=Desktop --exclude=Documents --exclude=Downloads --exclude=Library \
--exclude=Movies --exclude=Music --exclude=Pictures --exclude=Public --exclude=.vscode \
"

# FZF PREVIEW WITH BAT
export PREVBAT="bat --style=plain --color=always --line-range :500 {}"

# FZF_KEYBINDING CTRL_R
export FZF_CTRL_R_OPTS="
--reverse --prompt='FZF History > '
"

# FZF_KEYBINDING CTRL_T
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND $EXCLUDE_FZF"
export FZF_CTRL_T_OPTS="
--reverse --prompt='FZF Find > '
--header 'CTRL-D: Directories / CTRL-F: Files'
--bind 'ctrl-d:change-prompt(Find Directories > )+reload($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -t d)'
--bind 'ctrl-f:change-prompt(Find Files > )+reload($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -t f)'
--preview '(highlight -O ansi -l {} 2> /dev/null || $PREVBAT || tree -C {}) 2> /dev/null | head -200'
"

# FZF_KEYBINDING ALT_C
export FZF_ALT_C_COMMAND="fd . -L -H -t d $EXCLUDE_FZF"
export FZF_ALT_C_OPTS="
--reverse --prompt='FZF Autocd > '
--preview '(highlight -O ansi -l {} 2> /dev/null || tree -C {}) 2> /dev/null | head -200'
"

# FZF ALT_C > CTRL_D
bindkey '\ec' ''
bindkey '^D' fzf-cd-widget

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
