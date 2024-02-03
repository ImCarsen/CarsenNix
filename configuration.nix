{ config, pkgs, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;
    # Networking
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;
    # Timezone
    time.timeZone = "America/Regina";
    # Internationalisation
    i18n.defaultLocale = "en_CA.UTF-8";

    # Users
    users.users.carsen = {
        isNormalUser = true;
        description = "carsen";
        extraGroups = [ "networkmanager", "wheel" ];
        packages = with pkgs; [];
    };

    # Home Manager
    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      users = {
        "carsen" = import ./home.nix;
      }; 
    };

    # Auto login
    services.getty.autologinUser = "carsen";

    # Unfree software
    nixpkgs.config.allowUnfree = true;

    # Packages
    { inputs, pkgs, ... }: {
        programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        };
    };

    environment.systemPackages = with pkgs; [
        git
    ];

    # Other
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    system.stateVersion = "23.11";
}
