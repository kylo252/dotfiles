# Fix module path taken from /app/arc/2.4/profiles/arc.bashrc
#unset MODULEPATH
#export MODULEPATH=$MODULEPATH_TCSH

# https://www.reddit.com/r/Fedora/comments/37n9vi/vte/
# unset PROMPT_COMMAND
PATH=~/bin:$PATH
PATH=~/local/bin:$PATH
PATH=~/local//homebrew/bin:$PATH
PATH=~/.local/bin:$PATH # python/pip
export PATH 

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"

[ -z "$HISTFILE" ] && export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"

[ -z "$ZDOTDIR" ] && export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

[ -z "$BASDOTDIR" ] && export BASHDOTDIR="$XDG_CONFIG_HOME/bash"

[ -z "$NVM_DIR" ] && export NVM_DIR="$XDG_CONFIG_HOME/nvm"

[ -z "$NPM_CONFIG_USERCONFIG" ] && export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
