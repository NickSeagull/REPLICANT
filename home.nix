{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
          git
          bitwarden-cli
          nixpkgs-fmt
        ];


        username = "nick";
        homeDirectory = "/home/nick/";
        stateVersion = "24.11";
      };
        programs = {
            home-manager = {
                enable = true;
              };
            fish = {
                enable = true;
              };
          };
  }
