#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi
source ~/.git-prompt.sh

#if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#    tmux attach || tmux >/dev/null 2>&1
#fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias tree='tree -C'
alias vi='nvim'
alias vim='nvim'

PS1='\[\e[38;5;14m\][\u@\h \[\e[38;5;33m\]\W\[\e[38;5;14m\]]\[\e[38;5;68m\]$(__git_ps1 " (%s)")\[\e[m\] $ '

export LC_ALL="en_US.UTF-8"
export GOPATH=$HOME/go
export PATH="$PATH:/$HOME/.local/bin/:/usr/local/go/bin/:$GOPATH/bin"
