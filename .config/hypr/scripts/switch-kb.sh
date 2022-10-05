#!/usr/bin/env bash
set -eo pipefail

layout1="se"
layout2="us"

if hyprctl getoption input:kb_layout -j | jq -r '.str' | grep "$layout1"; then
  hyprctl keyword input:kb_layout "$layout2"
else
  hyprctl keyword input:kb_layout "$layout1"
fi
