{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
  ];

  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;

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
  programs.dconf.enable = true;
  security.pam.services.swaylock = {};

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.ben = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      brave
      kitty
      pcmanfm
      virt-manager
      vscode
      waybar
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    libnotify
    mako
    pamixer
    pciutils
    swayidle
    swaylock-effects
    vim
    wget
    wlr-randr
  ];

  fonts.fonts = with pkgs; [
    meslo-lgs-nf
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.stateVersion = "22.11";
}
