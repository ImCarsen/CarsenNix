{
    description = "Hyprland";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { self, nixpkgs, ... }:
    let 
        lib = nixpkgs.lib;
    in {
        nixosConfigurations = {
            carsen-nixhypr = nixpkgs.lib.nixosSytem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; }; # Hyprland stuff
                modules = [ ./configuration.nix ];
            };
        };
    };
}