# VIMODE
bindkey -v

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

function zle-line-init() {
    zle -K viins
    echo -ne "\e[1 q\033]12;#e3e3e3\007"
}

function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy
}

echo -ne '\e[1 q\033]12;#e3e3e3\007'

function preexec() { echo -ne '\e[1 q\033]12;#e3e3e3\007' ;}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N vi-yank-xclip
