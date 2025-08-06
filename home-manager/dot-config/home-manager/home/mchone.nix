{ config, pkgs, username, homeDirectory, ... }:

let
  linuxPkgs = import ./linux.nix { inherit config pkgs; };
in
{
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
    # Utils
    bat
    duckdb
    entr
    fd
    github-cli
    htop
    lsd
    ripgrep
    yt-dlp
    zoxide # Frecency based directory navigation
    
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ] ++ linuxPkgs.pkgs;

  home.file = {
    ".config/rofimoji.rc".text = ''
      selector = fuzzel
    '';

    ".config/sway/config".source = ../../../../sway/config;
    ".config/sway/wallpaper.png".source = ../../../../sway/wallpaper.png;
    ".config/i3status.conf".source = ../../../../sway/i3status.conf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mchone/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.awscli = {
    enable = true;

    settings = {
      default = {
        region = "us-east-2";
        output = "json";
      };
    };
  };
  
  programs.git = {
    enable = true;

    userName = "Ben McHone";
    userEmail = "ben@mchone.dev";

    includes = [
      {
        condition = "gitdir:~/projects/";
        path = ".gitconfig-work";
      }
    ];

    extraConfig = {
      core = {
        excludesfile = "~/.gitignore";
        fsmonitor = true;
        untrackedCache = true;
      };

      init.defaultBranch = "main";

      alias = {
        co = "checkout";
        st = "status";
        p = "push";
        l = "pull";
        main = ''!f() { if git ls-remote --exit-code --heads origin master >/dev/null 2>&1; then git checkout master; else git checkout main; fi; }; f'';
        dad = "!curl -H 'Accept: text/plain' https://icanhazdadjoke.com";
      };

      "filter \"lfs\"" = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };

      branch.sort = "-committerdate";
      commit.verbose = true;
      tag.sort = "version:refname";
      column.ui = "auto";

      push = {
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      pull.rebase = true;

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      help.autocorrect = "prompt";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      "protocol \"file\"".allow = "always";

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      merge.conflictstyle = "zdiff3";
    };
  };

  programs.ssh = {
    enable = true;

    extraConfig = ''
      IgnoreUnknown UseKeychain
      AddKeysToAgent yes
      UseKeychain yes
      ForwardAgent yes

      Include /Users/bmchone/.colima/ssh_config
      Include config/*
    '';

    matchBlocks = {
      "pi" = {
        hostname = "192.168.86.43";
        user = "ubuntu";
      };

      "*" = {
        setEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
  
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      aws = {
        disabled = true;
      };

      shell = {
        fish_indicator = "󰈺 ";
        powershell_indicator = "_";
        unknown_indicator = "mystery shell";
        style = "cyan";
        disabled = false;
      };

      package = {
        disabled = true;
      };
    };
  };
  
  programs.fuzzel = {
    enable = pkgs.stdenv.isLinux;
    
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

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    prefix = "C-b";
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      setw -g mode-keys vi

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set -s copy-command 'wl-copy'
      if-shell "uname | grep -q Darwin" "set -s copy-command 'pbcopy'"

      set -g @dracula-show-powerline false
      set -g @dracula-show-flags true
      set -g @dracula-plugins "git time"
      set -g @dracula-show-left-icon session
      set -g status-position top
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = dracula;
        extraConfig = "";
      }
      {
        plugin = vim-tmux-navigator;
        extraConfig = "";
      }
    ];
  };

  programs.uv.enable = true;
}
