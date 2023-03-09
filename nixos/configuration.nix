{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zeph";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Brisbane";

  i18n.defaultLocale = "en_AU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.libinput.enable = true;
  # services.openssh.enable = true;
  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
        sha256 = "1wb2s1wg0zfmh02j8lf6qbxb8h2f9q8n3bczwxvfb6875v0w0bwc";
      }) {
      inherit pkgs;
    };
  };

  programs.dconf.enable = true;
  security.pam.services.swaylock = {};

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  users.users.ben = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      brave
      firefox
      google-chrome
      kitty
      pcmanfm
      virt-manager
      vscode
      waybar
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    # Official
    avizo
    brightnessctl
    libnotify
    mako
    pamixer
    pciutils
    sox
    swayidle
    swaylock-effects
    vim
    wget
    wlr-randr
    xdg-utils

    # NUR
    #nur.repos.berbiche.mpvpaper
  ];

  mpvpaper = import ./mpvpaper;

  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
        in
        prev.waybar.overrideAttrs
          (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            postPatch = (oldAttrs.postPatch or "") + ''
              sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
            '';
          });
      })
  ];

  system.stateVersion = "22.11";
}
