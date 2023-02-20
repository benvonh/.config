#!/bin/sh

cd ~

export EDITOR=nvim

export NIXPKGS_ALLOW_UNFREE=1

export XDG_DATA_DIRS=$XDG_DATA_DIRS:~/.nix-profile/share

export XCURSOR_SIZE=24
export XCURSOR_THEME=Nordzy-cursors
export GTK_THEME=Nordic

export HYPRLAND_LOG_WLR=1

# Nvidia fixes
if ls /dev | grep nvidia; then
    export LIBVA_DRIVER_NAME=nvidia
    export XDG_SESSION_TYPE=wayland
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
fi

exec Hyprland
