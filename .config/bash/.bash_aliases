#!/bin/bash
export EDITOR=nvim
export BASHRC=~/.bashrc     
export CDPATH='.:/repo/ekhhaga:~/local'
export DISPLAY='localhost:0.0'

alias where='type -a'
alias l='ls -CF --color=auto'
alias ls='ls -FhN --color=auto --group-directories-first'
alias la='ls -A --color=auto'
alias ll='ls -laFq --color=auto'
alias cls='clear'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rmd='rm -rd'
alias paux='ps aux | grep'
alias bashconfig="$EDITOR ~/.bashrc.user"
alias rcsrc=""
alias potm='git push origin HEAD:refs/for/master' # used as 'potm'
alias potd='git push origin HEAD:refs/drafts/master' # used as 'potd'
alias dtf='git --git-dir="$HOME/.dtf.git" --work-tree="$HOME"'
cf() { du -a ~/.config/* ~/.scripts/* | awk '{print $2}' | fzf | xargs -r $EDITOR ;}

alias f='find . -name'
alias ff='find . -maxdepth 1 -type f -name'
alias fd='find . -maxdepth 1 -type d -name'


# workaround for interactive 'rm'
if alias rm &> /dev/null
then
    unalias rm
fi

