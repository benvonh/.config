{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, hyprland, ... }: {
    nixosConfigurations.fractal = nixpkgs.lib.nixosSystem {
      system = "x86_64-linxu";
      modules = [
        ./configuration.nix
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
      ];
    };
  };
}
