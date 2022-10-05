#!/usr/bin/env bash

env_vars=(
  DISPLAY DBUS_SESSION_BUS_ADDRESS WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
)

systemctl --user import-environment "${env_vars[@]}"

hash dbus-update-activation-environment \
  && dbus-update-activation-environment --systemd "${env_vars[@]}"
