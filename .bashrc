#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi
source ~/.git-prompt.sh

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'
alias vi='nvim'

color_1='\[\e[38;5;14m\]'
color_2='\[\e[38;5;33m\]'
git_ps1='$(__git_ps1 " (%s)")\[\e[m\] $ '

PS1="$color_1[\u@\h $color_2\W$color_1]$color_2$git_ps1"

export EDITOR='nvim'
export LC_ALL="en_US.UTF-8"

export GOPATH=$HOME/go/bin:/usr/local/go/bin
export SCRIPTS=$HOME/dotfiles/.config/scripts
export PATH="$PATH:$SCRIPTS:$HOME/.local/bin:$GOPATH"

# fix gray java applications
export _JAVA_AWT_WM_NONREPARENTING=1
