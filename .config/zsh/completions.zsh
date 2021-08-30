#!/usr/bin/env zsh

# https://git-annex.branchable.com/bugs/zsh_completions_installed_to_location_not_in_fpath/
fpath=(
  /usr/share/zsh/vendor-completions
  /usr/share/zsh/site-functions
  "$ZDOTDIR"/modules
  $fpath
)
