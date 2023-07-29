#!/usr/bin/env bash
set -ex

env_vars=(
  DISPLAY DBUS_SESSION_BUS_ADDRESS WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
)

systemctl --user import-environment "${env_vars[@]}"

hash dbus-update-activation-environment \
  && dbus-update-activation-environment --systemd "${env_vars[@]}"

# disabled tweaking the portals for now, see https://github.com/flatpak/xdg-desktop-portal/issues/986

# sleep 1
#
# systemctl --user restart \
#   xdg-desktop-portal-hyprland \
#   xdg-desktop-portal \
#   pipewire \
#   pipewire-pulse \
#   wireplumber

# sleep 1
# systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland
#
# sleep 1
# systemctl --user start xdg-desktop-portal xdg-desktop-portal-hyprland

## original solution from the wiki

# sleep 4
# killall xdg-desktop-portal-wlr
# killall xdg-desktop-portal

# /usr/lib/xdg-desktop-portal-wlr &
# sleep 4
# /usr/lib/xdg-desktop-portal &
