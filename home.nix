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
  }
