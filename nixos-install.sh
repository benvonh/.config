#!/bin/sh

sudo rm /etc/nixos/configuration.nix
sudo ln -s ~/.config/nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln -s ~/.config/nixos/flake.nix /etc/nixos/flake.nix
