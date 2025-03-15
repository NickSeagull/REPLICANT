{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
          git
          bitwarden-cli
          nixpkgs-fmt
          home-manager
        ];

        programs = {
            home-manager = {
                enable = true;
              };
            fish = {
                enable = true;
              };
          };

        username = "nick";
        homeDirectory = "/home/nick/";
        stateVersion = "24.11";
      };
  }
