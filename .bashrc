#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[96m\][\u@\h \W] \[\e[m\]$ '

[ -f "/home/gear/.ghcup/env" ] && source "/home/gear/.ghcup/env" # ghcup-env