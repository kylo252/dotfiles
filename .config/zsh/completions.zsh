#!/usr/bin/env zsh

# https://git-annex.branchable.com/bugs/zsh_completions_installed_to_location_not_in_fpath/
fpath=(
  /usr/share/zsh/vendor-completions
  /usr/share/zsh/site-functions
  "$ZDOTDIR"/modules
  $fpath
)

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
# add custom keybindings to fzf
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-space:accept'
# zstyle ':fzf-tab:*' accept-line ctr-enter
zstyle ':fzf-tab:*' print-query alt-enter


