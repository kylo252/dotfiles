#!/usr/bin/env zsh


source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

source "$XDG_DATA_HOME/zgenom/zgenom.zsh"

# if the init script doesn't exist
if ! zgenom saved; then

    zgenom load zsh-users/zsh-autosuggestions
    # zgenom load lukechilds/zsh-nvm
    zgenom load wfxr/forgit

    # completions
    zgenom load zsh-users/zsh-completions src

    # prompt
    zgenom load romkatv/powerlevel10k powerlevel10k

    zgenom load b4b4r07/enhancd
    zgenom load kazhala/dotbare
    zgenom load unixorn/autoupdate-zgen
    zgenom load zdharma/fast-syntax-highlighting
    zgenom load StackExchange/blackbox

    # ohmyzsh plugins
    zgenom ohmyzsh plugins/docker-compose
    zgenom ohmyzsh plugins/tmux

    # save all to init script
    zgenom save
fi

# enable completion for dotbare
# _dotbare_completion_cmd

# TMUX plugin
export ZSH_TMUX_AUTOSTART=true
export TERM=screen-256color
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"
