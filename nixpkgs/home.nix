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
      l                         = "exa --icons";
      ls                        = "exa --git --long";
      la                        = "exa --git --long --all";
      lt                        = "exa --git --tree --level=2";
      du                        = "du -h --max-depth=1";
      grep                      = "grep --with-filename --line-number --color=always";
      he                        = "home-manager edit";
      hb                        = "home-manager build";
      hs                        = "home-manager switch";
      hg                        = "home-manager generations";
      ne                        = "sudo vim /etc/nixos/configuration.nix";
      ns                        = "sudo nixos-rebuild --impure switch";
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
