#!/usr/bin/env zsh
# shellcheck disable

# TODO: check more examples from
# https://blog.sebastian-daschner.com/entries/zsh-aliases

alias v='nvim'

alias dtf='dotbare'

alias dta='dotbare fadd'
alias dtc='dotbare commit -m '
alias dtg='dotbare fgrep'
alias dtl='dotbare flog'
alias dtp='dotbare pull'
alias dtP='dotbare push'
alias dtr='dotbare fcheckout'
alias dts='dotbare fstat'

alias ls='ls -v --color=auto --group-directories-first'
alias l='ls -ACFN'
alias ll='ls -hlqAFN'
alias lt='exa --tree --color=always --icons --all --git --level=2'

alias dte="GIT_DIR=$HOME/.dtf.git GIT_WORK_TREE=$HOME dotbare fedit"
alias dtm="GIT_DIR=$HOME/.dtf.git GIT_WORK_TREE=$HOME dotbare fedit --modified"
alias pre-dots-commit="GIT_DIR=$HOME/.dtf.git GIT_WORK_TREE=$HOME pre-commit"

alias lg='lazygit'
alias gu='gitui'

[ -e /etc/arch-release ] && alias -g paks='sudo pacman -S'

alias paux='ps aux | rg'
alias tk='tmux kill-server'

# insert relevant xkcd
alias archive='tar --create --gzip --verbose --file'

# workaround for interactive 'rm'
alias rm &>/dev/null && unalias rm

alias grep="grep --color"

alias -g MN='| bat --language man'
alias -g FZ='| fzf'

alias -g pipuninstall='pip uninstall -y -r <(pip freeze --user)'

alias -s {cpp,cxx,cc,c,hh,h,lua,vim,ts,js,yml,json,toml,ini,txt}="$EDITOR"
alias -s md="glow"
