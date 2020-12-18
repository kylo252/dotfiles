#!/usr/bin/env zsh

export PATH=$HOME/local/bin;$HOME/.local/bin;$HOME/.scripts:$PATH

# XDG Base Directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# XDG PATH
export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_DATA_HOME/shell/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# set locale for perl
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export HISTFILESIZE=10000
export HISTIGNORE="ls:ps:history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

export EDITOR=nvim
export ZSHRC="$ZDOTDIR/.zshrc.user"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_PAGER="less -RF"

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse  --multi \
    --prompt='∼ ' --pointer='▶' --marker='✓' \
    --bind '?:toggle-preview' \
    --bind 'ctrl-a:select-all' \
    --bind 'ctrl-y:execute-silent(echo {+} | xcopy)' \
    --bind 'ctrl-e:execute(echo {+} | xargs -o vim)' \
    --bind 'ctrl-v:execute(code {+})' "
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_PREVIEW_COMMAND="([[ -f {} ]] && (bat --style=numbers --color=always {} ||  tree -C {} || echo {} 2> /dev/null | head -200"
export FZF_PREVIEW_DEFAULT_SETTING='--sync --height="80%" --preview-window="down:60%" --expect="ctrl-space" --header="C-Space: continue fzf completion"'

export DOTBARE_DIR="$HOME/.dtf.git"
export DOTBARE_TREE="$HOME"

# export NVM_NO_USE=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# zsh vim mode
export MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS"
export MODE_CURSOR_SEARCH="steady underline"
export MODE_CURSOR_VICMD="dark grey block"
export MODE_CURSOR_VIINS="blinking bar"
export MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
export MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#505050,italic,underline"
export ZSH_AUTOSUGGEST_USE_ASYNC="ON"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

