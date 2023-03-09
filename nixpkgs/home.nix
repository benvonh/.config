{ config, pkgs, ... }:

{
  #############################################################################
  # Nixpkgs
  nixpkgs.config.allowUnfree = true;

  #############################################################################
  # Home
  home.stateVersion = "22.11";
  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.packages = with pkgs; [
    # Command-line tools
    bat
    exa
    fd
    gh
    ookla-speedtest
    ripgrep
    taskwarrior
    tldr
    unzip

    # Build tools
    cargo
    cmake
    gcc
    gnumake
    go
    meson
    ninja
    nodejs
    pkg-config
    python3
    python3.pkgs.pip

    # Terminal applications
    btop
    htop
    neovim
    nvtop
    ranger

    # Rice :)
    cava
    neofetch
    pfetch
    pipes-rs
    tty-clock
  ];

  #############################################################################
  # Programs
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "benvonh";
    userEmail = "benjaminvonsnarski@gmail.com";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "nord";
      editor.scrolloff = 8;
    };
  };

  programs.zsh = {
    enable                      = true;
    enableCompletion            = false;
    defaultKeymap               = "emacs";
    dotDir                      = ".config/zsh";
    initExtraFirst              = "source ~/.config/zsh/extra.zsh";

    shellAliases = {
      du                        = "du -h --max-depth=1";
      home                      = "home-manager";
      l                         = "exa -s type --icons";
      la                        = "exa -s type --git --long --all";
      ls                        = "exa -s type --git --long";
      lt                        = "exa -s type --git --tree --level=2";
    };

    history = {
      share                     = false;
    };
  };

  #############################################################################
  # GTK Settings
  gtk = with pkgs; {
    enable                      = true;
    cursorTheme = {
      #package                   = nordzy-cursor-theme;
      #name                      = "Nordzy-cursors";
      package                   = numix-cursor-theme;
      name                      = "Numix-Cursor-Light";
      size                      = 24;
    };
    iconTheme = {
      #package                   = nordzy-icon-theme;
      #name                      = "Nordzy";
      package                   = numix-icon-theme-circle;
      name                      = "Numix-Circle";
    };
    theme = {
      package                   = nordic;
      name                      = "Nordic";
    };
    font = {
      #package                   = fira;
      name                      = "FiraCode Nerd Font";
      size                      = 10;
    };
  };
}
