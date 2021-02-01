#!/usr/bin/env zsh

source "$XDG_DATA_HOME/zgenom/zgenom.zsh"

# if the init script doesn't exist
if ! zgenom saved; then

    # bulk load
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load kazhala/dotbare
    zgenom load lukechilds/zsh-nvm
    zgenom load b4b4r07/enhancd
    # zgenom load unixorn/autoupdate-zgen
    zgenom load wfxr/forgit
    zgenom load zdharma/fast-syntax-highlighting

    zgenom load junegunn/fzf shell/completion.zsh 
    zgenom load junegunn/fzf shell/key-bindings.zsh 

    # completions
    zgenom load zsh-users/zsh-completions src

    # prompt
    zgenom load romkatv/powerlevel10k powerlevel10k

    # save all to init script
    zgenom save

    zgenom compile "$HOME/.zshenv"
    zgenom compile "$XDG_CONFIG_HOME/zsh"
    zgenom compile "$XDG_DATA_HOME/zsh/generated"
fi

# quick modules
fpath=("$ZDOTDIR/modules" "${fpath[@]}")

# load modules
autoload -Uz kp

# enable completion for dotbare
_dotbare_completion_cmd
# _dotbare_completion_git

autoload -U compinit

# Initialize the completion system with a cache time of 24 hours.
typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"
typeset -g comp_files=($zcompdump(Nm-24))

if (( $#comp_files )) {
  compinit -i -C -d $zcompdump
} else {
  compinit -i -d $zcompdump
}

unset zcompdump
unset comp_files
# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
# zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__WINCENT[ITALIC_ON]%}--- %d ---%{$__WINCENT[ITALIC_OFF]%}%b%f

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select
