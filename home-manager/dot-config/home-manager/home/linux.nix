{ config, pkgs, ... }:

{
  pkgs = if pkgs.stdenv.isLinux then with pkgs; [
    rofimoji # Emoji selector (integrated with fuzzel)
  ] else [ ];
}
