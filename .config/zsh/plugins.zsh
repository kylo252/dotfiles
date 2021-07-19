#!/usr/bin/env zsh

# load custom modules
source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

# https://git-annex.branchable.com/bugs/zsh_completions_installed_to_location_not_in_fpath/
fpath=( 
  /usr/share/zsh/vendor-completions
  /usr/share/zsh/site-functions
  "$ZDOTDIR"/modules
  $fpath
)

LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"
[ -f "$LFCD" ] &&  source "$LFCD"

# zstyle ':znap:*' plugins-dir "$XDG_DATA_HOME/znap/sources"

source "$XDG_DATA_HOME/zsh/plugins/znap/znap.zsh"

znap source zsh-users/zsh-autosuggestions
# znap source zsh-users/zsh-completions

znap source zdharma/fast-syntax-highlighting

znap source romkatv/powerlevel10k

znap source kazhala/dotbare

znap source Aloxaf/fzf-tab


source <(fnm env --fnm-dir="$XDG_DATA_HOME/fnm" --shell=zsh)

eval "$(zoxide init zsh)"

# znap compdef dotbare "_dotbare_completion_cmd"
# znap compdef fd "_fd"

# znap eval pip-completion "source <(pip3 completion --zsh)"

# autoload -Uz compinit 

autoload -Uz kp 

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Colorize completions using default `ls` colors.
# zstyle ':completion:*' list-colors ''

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# # Categorize completion suggestions with headings:
# zstyle ':completion:*' group-name ''
# 
# # Enable keyboard navigation of completions in menu
# # (not just tab/shift-tab but cursor keys as well):
# zstyle ':completion:*' menu select

# expand alias just with <TAB> 
# TODO: keep a lookout for performance penalties or clashes with `autosuggestions`
zstyle ':completion:*' completer _expand_alias _complete _ignored

if command -v vivid >/dev/null; then
  export LS_COLORS="$(vivid -m 24-bit generate one-dark)"
fi

