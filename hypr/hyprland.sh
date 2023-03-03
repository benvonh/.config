#!/bin/sh

cd ~

export EDITOR=nvim
export XDG_DATA_DIRS=$XDG_DATA_DIRS:~/.nix-profile/share

export XCURSOR_SIZE=24
export XCURSOR_THEME=Nordzy-cursors
export GTK_THEME=Nordic

export HYPRLAND_LOG_WLR=1

exec Hyprland
