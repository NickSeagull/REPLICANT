{ config, pkgs, ... }:

{
  home.packages = [
    # Indexing / search dependencies
    pkgs.fd
    (pkgs.ripgrep.override {withPCRE2 = true;})

    # Font / icon config
    pkgs.emacs-all-the-icons-fonts

    pkgs.nixfmt-classic # :lang nix
  ];

  # Note that session variables and path can be a bit wonky to get going. To be
  # on the safe side, logging out and in again usually works.
  # Otherwise, to fast-track changes, run:
  # . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
  home.sessionVariables = {
    DOOMDIR = "${config.xdg.configHome}/doom";
    EMACSDIR = "${config.xdg.configHome}/emacs";
    DOOMLOCALDIR = "${config.xdg.dataHome}/doom";
    DOOMPROFILELOADFILE = "${config.xdg.stateHome}/doom-profiles-load.el";
  };
  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  programs.emacs.enable = true;


  # Note! This must match $EMACSDIR
  xdg.configFile."emacs".source = builtins.fetchGit {
    url = "https://github.com/doomemacs/doomemacs.git";
    rev = "466490c252d06f42a9c165f361de74a6e6abad8d";
  };
  xdg.configFile."doom".source = ./doom-emacs; # Note! This must match $DOOMDIR
}