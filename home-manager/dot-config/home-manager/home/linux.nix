{ config, pkgs, ... }:

{
  pkgs = if pkgs.stdenv.isLinux then with pkgs; [
    rofimoji # Emoji selector (integrated with fuzzel)
  ] else [ ];

  file = if pkgs.stdenv.isLinux then {
    ".config/rofimoji.rc".text = ''
      selector = fuzzel
    '';

    ".config/sway/config".source = ../../../../sway/config;
    ".config/sway/wallpaper.png".source = ../../../../sway/wallpaper.png;
    ".config/i3status.conf".source = ../../../../sway/i3status.conf;

    ".local/share/applications/slack.desktop".source = ./desktop-entries/slack.desktop;
    ".local/share/applications/discord.desktop".source = ./desktop-entries/discord.desktop;
    ".local/share/icons/hicolor/256x256/apps/discord.png".source = ./desktop-entries/discord.png;
    ".local/share/icons/hicolor/256x256/apps/slack.png".source = ./desktop-entries/slack.png;
  } else {};
}
