#!/usr/bin/env zsh

# XDG Base Directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export TCSH_MODULES="$MODULEPATH"

# XDG PATH
export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GOPATH="$XDG_DATA_HOME/go"
export HISTFILE="$XDG_DATA_HOME/shell/history"
export HOMEBREW_PREFIX="/local/workspace/share/linuxbrew"
export JUNEST_HOME="$XDG_DATA_HOME/junest"
export JUNEST_CORE_DIR="$XDG_DATA_HOME/junest-core"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# set X11 settings when not in ssh
if [ -z "$SSH_CONNECTION" ]; then
    export DISPLAY=localhost:0.0
fi

# set locale (for perl mostly)
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export HISTFILESIZE=10000
export HISTIGNORE="ls:ps:history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

export EDITOR=nvim

export BAT_PAGER="less -RF"
# https://github.com/sharkdp/bat/issues/652
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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

# interactive search when using three dots
export ENHANCD_DOT_ARG='...'

# don't use system cURL
export HOMEBREW_FORCE_BREWED_CURL="1"

# export NVM_NO_USE=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,italic,underline"
export ZSH_AUTOSUGGEST_USE_ASYNC="ON"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

