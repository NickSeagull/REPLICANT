{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
          bitwarden-cli
          nixpkgs-fmt
        ];


        username = "nick";
        homeDirectory = "/home/nick/";
        stateVersion = "24.11";
      };
        programs = {
            git = {
                enable = true;
                userEmail = "github@nickseagull.dev";
                userName = "Nikita Tchayka";
              };
            home-manager = {
                enable = true;
              };
            fish = {
                enable = true;
              };
          };
  }
