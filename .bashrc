#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\[\e[38;5;14m\][\u@\h \[\e[38;5;33m\]\W\[\e[38;5;14m\]] \[\e[m\]$ '

# Ghcup
[ -f "/home/gear/.ghcup/env" ] && source "/home/gear/.ghcup/env" # ghcup-env

export PATH="$PATH:/$HOME/.local/bin/"
