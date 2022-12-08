#!/usr/bin/env bash

env_vars=(
  DISPLAY DBUS_SESSION_BUS_ADDRESS WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
)

systemctl --user import-environment "${env_vars[@]}"

hash dbus-update-activation-environment \
  && dbus-update-activation-environment --systemd "${env_vars[@]}"

sleep 1

systemctl --user restart \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal \
  pipewire \
  pipewire-pulse \
  wireplumber

## original solution from the wiki

# sleep 4
# killall xdg-desktop-portal-wlr
# killall xdg-desktop-portal

# /usr/lib/xdg-desktop-portal-wlr &
# sleep 4
# /usr/lib/xdg-desktop-portal &
