{ config, pkgs, ... }:

{
  pkgs = if pkgs.stdenv.isLinux then with pkgs; [
    btop
    rofimoji # Emoji selector (integrated with fuzzel)
  ] else [ ];
}
