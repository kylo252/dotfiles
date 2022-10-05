#!/usr/bin/env bash

systemctl --user restart \
  xdg-desktop-portal \
  xdg-desktop-portal-wlr \
  pipewire \
  pipewire-pulse \
  wireplumber

## original solution from the wiki

# sleep 4
# killall xdg-desktop-portal-wlr
# killall xdg-desktop-portal
#
# /usr/lib/xdg-desktop-portal-wlr &
# sleep 4
# /usr/lib/xdg-desktop-portal &
