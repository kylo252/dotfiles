#!/usr/bin/env zsh

# XDG Base Directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export TCSH_MODULES="$MODULEPATH"

# XDG PATH
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GOPATH="$XDG_DATA_HOME/go"
export HOMEBREW_PREFIX="/local/workspace/share/linuxbrew"
export JUNEST_HOME="$XDG_DATA_HOME/junest"
export JUNEST_CORE_DIR="$XDG_DATA_HOME/junest-core"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZGEN_DIR="$XDG_DATA_HOME/zgenom"

# set X11 settings when not in ssh
if [ -z "$SSH_CONNECTION" ]; then
    # How to check if WSL1/2
    # https://github.com/microsoft/WSL/issues/4555#issuecomment-609908080
    if [ -d /run/WSL ]; then
        # How to set up working X11 forwarding on WSL2 
        # https://stackoverflow.com/a/61110604
        DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
    else
        DISPLAY=localhost:0
    fi
    export DISPLAY
    export LIBGL_ALWAYS_INDIRECT=1
fi

# set locale (for perl mostly)
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


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
# export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_COMMAND='fd --type f'
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


