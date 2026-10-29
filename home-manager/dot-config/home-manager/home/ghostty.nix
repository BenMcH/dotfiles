{ config, lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  programs.ghostty = {
    enable = true;
    # Installed as a macOS app, not from nixpkgs.
    package = null;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    installBatSyntax = false;

    settings = {
      command = "${config.home.profileDirectory}/bin/fish";
      window-padding-x = 10;
      background-opacity = 1.0;
    };
  };
}
