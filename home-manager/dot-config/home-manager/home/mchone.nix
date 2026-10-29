{ lib, pkgs, username, homeDirectory, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./linux.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
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
    fzf
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
    yazi
    yt-dlp
    zellij
    zoxide # Frecency based directory navigation
  ];

  home.sessionVariables = {
    PAGER = "bat -p";
    EDITOR = "nvim";
    # CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
    GOPAH = "${pkgs.go}/lib/go";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.bun/bin"
    "$HOME/.opencode/bin"
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    "/opt/homebrew/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
}
