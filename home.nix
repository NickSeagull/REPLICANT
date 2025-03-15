{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
          hello
        ];

        username = "nick";
        homeDirectory = "/home/nick/";

        stateVersion = "24.11";
      };
  }
