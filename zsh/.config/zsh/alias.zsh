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
alias c-alt="$EDITOR ~/.config/alacritty/alacritty.yml"
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

# GOTO ALIAS
alias cdd="cd ~/.dot"
alias cdc="cd ~/.config"
alias cdn="cd ~/.config/nvim"
alias cdz="cd ~/.config/zsh"
alias cde="cd ~/.cache"
alias cds="cd ~/.local/bin"
alias cdl="cd ~/.local/share"
alias cdp="cd ~/Documents/pd"
alias cdm="cd ~/Music/pm"

# PIPE-VIEWER
alias msv="pipe-viewer --player=mpvv"
alias msc="pipe-viewer -n --player=mpvm"

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
    tmux split-window -h -p 25 && \
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

alias idvs=" \
    tmux split-window -h -p 50
"
