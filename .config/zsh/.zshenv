#!/usr/bin/env zsh

function __setup_defaults(){
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"

    PATH=$HOME/.local/bin:$PATH
    PATH=$HOME/local/bin:$PATH
    PATH=$GOPATH/bin:$PATH
    export PATH 

    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8

    export EDITOR=nvim

    export ZDOTDIR="$HOME/.config/zsh"

    export DOTBARE_DIR="$HOME/.dtf.git"
    export DOTBARE_TREE="$HOME"
    
    export ZGEN_SOURCE="$XDG_DATA_HOME/zgenom"

    SHELL="$(command -v zsh)"
    export SHELL
}

function __setup_xdg(){
    export CARGO_HOME="$XDG_DATA_HOME/cargo"
    export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"
    export GEM_HOME="$XDG_DATA_HOME/gem"
    export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
    export GNUPGHOME="$XDG_DATA_HOME/gnupg"
    export GOPATH="$XDG_DATA_HOME/go"
    export HOMEBREW_PREFIX="/local/workspace/share/linuxbrew"
    export JUNEST_HOME="$XDG_DATA_HOME/junest"
    export JUNEST_CORE_DIR="$XDG_DATA_HOME/junest-core"
    export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
    export NVM_DIR="$XDG_DATA_HOME/nvm"
    export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
    export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
}

function __setup_history() {
    export HISTFILE="$XDG_DATA_HOME/zsh/history"
    export HISTSIZE=100000                       # History size in memory
    export SAVEHIST=1000000                      # The number of histsize
    export LISTMAX=50                            # The size of asking history
}

function __setup_x11(){
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
}

function __setup_fzf(){
    export FZF_DEFAULT_OPTS="--layout=reverse  --multi \
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
}



__setup_functions=(
    __setup_defaults
    __setup_xdg
    __setup_history
    __setup_x11
    __setup_fzf
) 

for func in "${__setup_functions[@]}"; do
    "$func"; unset -f "$func"
done
unset __setup_functions

export BAT_PAGER="less -RF"
# https://github.com/sharkdp/bat/issues/652
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# interactive search when using three dots
export ENHANCD_DOT_ARG='...'

# don't use system cURL
export HOMEBREW_FORCE_BREWED_CURL="1"

# export NVM_NO_USE=true
# export NVM_COMPLETION=true
# export NVM_LAZY_LOAD=true
# export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,italic,underline"
export ZSH_AUTOSUGGEST_USE_ASYNC="ON"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20


