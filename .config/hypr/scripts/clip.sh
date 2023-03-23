#!/usr/bin/env bash

# grim -g "$(slurp)" - | wl-copy
env USE_WAYLAND_GRIM=true XDG_CURRENT_DESKTOP=Sway flameshot gui
