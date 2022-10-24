#!/usr/bin/env bash

export LIBVA_DRIVER_NAME=iHD
export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland

# export LIBVA_DRIVER_NAME=nvidia
# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export WLR_NO_HARDWARE_CURSORS=1
# export EGL_PLATFORM=wayland
# export MOZ_DISABLE_RDD_SANDBOX=1
