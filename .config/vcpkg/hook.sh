#!/usr/bin/env bash

function __setup_vcpkg() {
  while IFS=$'-' read -r arch _ os _; do
    arch=${arch//x86_64/x64}
    os=${os//darwin*/osx}
    export VCPKG_DEFAULT_TRIPLET="${arch}-${os}"
  done < <(clang -print-target-triple 2>/dev/null)
  export VCPKG_ROOT="$XDG_DATA_HOME/vcpkg"
  # shellcheck disable=1091
  source "$VCPKG_ROOT/scripts/vcpkg_completion.zsh" 2>/dev/null
}

__setup_vcpkg
