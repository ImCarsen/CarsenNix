{
    description = "Hyprland";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = {nixpkgs, ...} @ inputs: {
        nixosConfigurations.HOSTNAME = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; }; # this is the important part
            modules = [
                ./configuration.nix
            ];
        };
    }
}