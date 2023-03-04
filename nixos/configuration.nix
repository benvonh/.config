{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zeph"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Australia/Brisbane";

  i18n.defaultLocale = "en_AU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.libinput.enable = true;

  programs.dconf.enable = true;
  nixpkgs.config.allowUnfree = false;
  
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.ben = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      brave
      kitty
      mako
      pcmanfm
      virt-manager
      waybar
      wofi
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # services.openssh.enable = true;
  system.stateVersion = "22.11";
}
