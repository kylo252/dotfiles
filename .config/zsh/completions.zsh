#!/usr/bin/env zsh

# https://git-annex.branchable.com/bugs/zsh_completions_installed_to_location_not_in_fpath/
extra_paths=(
  /usr/share/zsh/vendor-completions
  /usr/share/zsh/site-functions
  /opt/homebrew/share/zsh/site-functions
  "$ZDOTDIR/modules"
)

for extra in "${extra_paths[@]}"; do
  [ -d "$extra" ] && fpath+=($extra)
done

