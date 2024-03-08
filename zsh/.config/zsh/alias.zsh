# FIX TERMINFO ALACRITTY X TMUX-256COLORS
function update_terminfo () {
    local x ncdir terms
    ncdir="/opt/homebrew/opt/ncurses"
    terms=(alacritty-direct alacritty tmux tmux-256color)

    mkdir -p ~/.terminfo && cd ~/.terminfo

    if [ -d $ncdir ] ; then
        # sed : fix color for htop
        for x in $terms ; do
            $ncdir/bin/infocmp -x -A $ncdir/share/terminfo $x > ${x}.src &&
            sed -i '' 's|pairs#0x10000|pairs#32767|' ${x}.src &&
            /usr/bin/tic -x ${x}.src &&
            rm -f ${x}.src
        done
    else
        local url
        url="https://invisible-island.net/datafiles/current/terminfo.src.gz"
        if curl -sfLO $url ; then
            gunzip -f terminfo.src.gz &&
            sed -i '' 's|pairs#0x10000|pairs#32767|' terminfo.src &&
            /usr/bin/tic -xe ${(j:,:)terms} terminfo.src &&
            rm -f terminfo.src
        else
            echo "unable to download $url"
        fi
    fi
    cd - > /dev/null
}

# CFG
alias c-zsh="$EDITOR ~/.config/zsh/.zshrc"
alias c-zpr="$EDITOR ~/.zprofile"
alias c-tmux="$EDITOR ~/.config/tmux/tmux.conf"
alias c-alt="$EDITOR ~/.config/alacritty/alacritty.toml"
alias c-kitty="$EDITOR ~/.config/kitty/kitty.conf"
alias c-pipe="$EDITOR ~/.config/pipe-viewer/pipe-viewer.conf"
alias c-vim="vi ~/.vimrc"

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
alias news="newsboat -q"
alias npml="npm list --location=global --depth=0"
alias ppath="echo $PATH | tr ':' '\n'"
alias gh="open \`git remote -v | grep fetch | awk '{print \$2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'\`| head -n1"
alias vim="nvim"

# GOTO ALIAS
alias cdd="cd ~/.dot"
alias cdc="cd ~/.config"
alias cdn="cd ~/.config/nvim"
alias cdz="cd ~/.config/zsh"
alias cde="cd ~/.cache"
alias cds="cd ~/.local/bin"
alias cdl="cd ~/.local/share"
alias cdp="cd ~/Documents/pd"
alias cdm="cd ~/Music/self"
alias cm="cmus"
alias pn="pnpm"

# PIPE-VIEWER
alias msv="pipe-viewer --player=mpvv"
alias msc="pipe-viewer -n --player=mpvm"

# POMO
alias work="timer 60m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal && clear"

alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal && clear"

# FZF ALIAS
alias vd="
    cd ~ && cd \$($FZF_DEFAULT_COMMAND $EXCLUDE_FZF -d 7 --type d |
        fzf --reverse --prompt='Select Directory > ' --preview 'tree -C {}' )
    "

alias vn="
    $FZF_DEFAULT_COMMAND $EXCLUDE_FZF -d 7 --type f |
        fzf --reverse --prompt='Select File > ' -m --preview '$PREVBAT' |
        xargs -r $EDITOR
    "

alias vs="
    fd . $HOME/.local/bin $HOME/.local/share/fzf-launcher $HOME/.local/share/sysutils |
        fzf --reverse --prompt='Select Script File > ' -m --preview '$PREVBAT' |
        awk '{print $2}' |
        xargs -r $EDITOR -c 'cd %:h'
    "

alias fn="fd . $HOME/Documents/pd -d 2 --type f | fzf --reverse --prompt='Select > ' -m --preview '$PREVBAT' | xargs -r $EDITOR"

fzf-delete-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    local selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS-} -n2..,.. --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m --multi --bind 'enter:become(echo {+1})'" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected[*]" ]; then
      hist delete $selected[*]
    fi
    zle reset-prompt
    return $ret
}

zle     -N            fzf-delete-history-widget
bindkey -M emacs '^E' fzf-delete-history-widget
bindkey -M vicmd '^E' fzf-delete-history-widget
bindkey -M viins '^E' fzf-delete-history-widget

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
    tmux split-window -h -l 50 && \
    tmux split-window -v -l 20
"

alias idv=" \
    tmux rename-window ide &&
    clear && figlet 'lets works' && \
    tmux split-window -v -l 10 && \
    tmux split-window -h -l 80
"

alias idvs=" \
    tmux split-window -h -p 50
"
