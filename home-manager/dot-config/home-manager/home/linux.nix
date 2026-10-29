{ lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [
    rofimoji # Emoji selector (integrated with fuzzel)
  ];

  home.file = {
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
  };

  programs.fuzzel = {
    enable = true;

    settings = {
      colors = {
        background = "282a36dd";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection-match = "8be9fdff";
        selection = "44475add";
        selection-text = "f8f8f2ff";
        border = "bd93f9ff";
      };
    };
  };
}
