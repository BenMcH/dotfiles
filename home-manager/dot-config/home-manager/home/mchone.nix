{ config, lib, pkgs, username, homeDirectory, ... }:

{
  imports = [
    ./fish.nix
    ./ghostty.nix
    ./git.nix
    ./linux.nix
    ./ssh.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    asciinema
    bat
    btop
    cloc
    deno
    dive
    duckdb
    entr
    fd
    ffmpeg
    fnm
    github-cli
    htop
    httpie
    jq
    lazydocker
    lazygit
    lsd
    pre-commit
    ripgrep
    tree
    watch
    yt-dlp
  ];

  home.sessionVariables = {
    PAGER = "bat -p";
    EDITOR = "nvim";
    # CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    DOCKER_HOST = "unix://${config.home.homeDirectory}/.colima/default/docker.sock";
    # WeasyPrint loads pango/gobject from Homebrew. The fallback path is only
    # searched when a library isn't found normally, so Nix binaries are unaffected.
    DYLD_FALLBACK_LIBRARY_PATH = "/opt/homebrew/lib";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
    "$HOME/.opencode/bin"
    "$HOME/.lmstudio/bin"
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # `nh home switch` applies this config and shows what changed.
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/.dotfiles/home-manager/dot-config/home-manager";
  };

  programs.awscli = {
    enable = true;

    settings = {
      default = {
        region = "us-east-2";
        output = "json";
      };

      "profile sai-dev" = {
        sso_start_url = "https://allies.awsapps.com/start";
        sso_region = "us-east-1";
        sso_account_id = "729161019481";
        sso_role_name = "AdministratorAccess";
        region = "us-east-1";
        output = "json";
      };
    };
  };

  programs.uv.enable = true;

  programs.zoxide.enable = true; # Frecency based directory navigation
  programs.fzf.enable = true;

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  # Integrations would auto-launch zellij in every new shell.
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    enableZshIntegration = false;
    enableBashIntegration = false;
  };
}
