{ config, pkgs, ... }:

{
  #############################################################################
  # Nixpkgs
  nixpkgs.config.allowUnfree    = true;

  #############################################################################
  # Home
  home.stateVersion             = "22.11";

  home.username                 = "ben";
  home.homeDirectory            = "/home/ben";

  home.packages = with pkgs; [
    # Command-line tools
    exa
    fd
    gnumake
    ookla-speedtest
    ripgrep
    tldr
    unzip

    # Terminal applications
    bat
    btop
    htop
    nvtop
    ranger

    # Software
    cargo
    go
    nodejs
    python3
    python3.pkgs.pip
    zsh

    # Fonts
    meslo-lgs-nf

    # Rice :>
    neofetch
    pipes-rs
    tty-clock
  ];

  #############################################################################
  # Programs
  programs.home-manager.enable  = true;

  programs.zsh = {
    enable                      = true;
    enableCompletion            = false;
    defaultKeymap               = "emacs";
    dotDir                      = ".config/zsh";
    initExtraFirst              = "source ~/.config/zsh/zshextra";

    shellAliases = {
      du                        = "du -h --max-depth=1";
      grep                      = "grep --with-filename --line-number --color=always";
      hb                        = "home-manager build";
      he                        = "home-manager edit";
      hg                        = "home-manager generations";
      hs                        = "home-manager switch";
      l                         = "exa -s type --icons";
      la                        = "exa -s type --git --long --all";
      ls                        = "exa -s type --git --long";
      lt                        = "exa -s type --git --tree --level=2";
      nb                        = "nixos-rebuild build --max-jobs -p main";
      ne                        = "nvim ~/.config/nixos/configuration.nix";
      ns                        = "nixos-rebuild switch --max-jobs -p main";
    };

    history = {
      share                     = false;
    };
  };

  programs.git = {
    enable                      = true;
    userName                    = "benvonh";
    userEmail                   = "benjaminvonsnarski@gmail.com";
  };

  programs.gh.enable            = true;

  programs.neovim.enable        = true;

  #############################################################################
  # GTK Settings
  gtk = {
    enable                      = true;

    cursorTheme = {
      package                   = pkgs.nordzy-cursor-theme;
      name                      = "Nordzy-cursors";
      size                      = 24;
    };

    iconTheme = {
      package                   = pkgs.nordzy-icon-theme;
      name                      = "Nordzy";
    };

    theme = {
      package                   = pkgs.nordic;
      name                      = "Nordic";
    };

    font = {
      package                   = pkgs.fira;
      name                      = "fira";
      size                      = 10;
    };
  };
}
