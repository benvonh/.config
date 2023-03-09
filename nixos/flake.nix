{
  inputs = {
    nixpkgs.url  = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url      = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nur, hyprland, ... }: {
    nixosConfigurations.zeph = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix 
        nur.nixosModules.nur
        hyprland.nixosModules.default { programs.hyprland.enable = true; }
      ];
    };
  };
}
