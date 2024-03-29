# ZSH PROMPT
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

setopt prompt_subst
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
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
