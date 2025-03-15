{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
          hello
        ];

        username = "nick";
        homeDirectory = "/home/linuxbrew/";

        stateVersion = "24.11";
      };
  }
