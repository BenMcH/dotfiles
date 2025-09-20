{ config, pkgs, username, homeDirectory, ... }:

let
  linux = import ./linux.nix { inherit config pkgs; };
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
    btop
    deno
    dive
    duckdb
    entr
    fd
    ffmpeg
    github-cli
    htop
    httpie
    jq
    lsd
    ripgrep
    tree
    watch
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
  ] ++ linux.pkgs;

  home.file = {
    ".config/fish/themes/Dracula Official.theme".text = ''
      # Dracula Color Palette
      #
      # Foreground: f8f8f2
      # Selection: 44475a
      # Comment: 6272a4
      # Red: ff5555
      # Orange: ffb86c
      # Yellow: f1fa8c
      # Green: 50fa7b
      # Purple: bd93f9
      # Cyan: 8be9fd
      # Pink: ff79c6

      # Syntax Highlighting Colors
      fish_color_normal f8f8f2
      fish_color_command 8be9fd
      fish_color_keyword ff79c6
      fish_color_quote f1fa8c
      fish_color_redirection f8f8f2
      fish_color_end ffb86c
      fish_color_error ff5555
      fish_color_param bd93f9
      fish_color_comment 6272a4
      fish_color_selection --background=44475a
      fish_color_search_match --background=44475a
      fish_color_operator 50fa7b
      fish_color_escape ff79c6
      fish_color_autosuggestion 6272a4
      fish_color_cancel ff5555 --reverse
      fish_color_option ffb86c
      fish_color_history_current --bold
      fish_color_status ff5555
      fish_color_valid_path --underline

      # Default Prompt Colors
      fish_color_cwd 50fa7b
      fish_color_cwd_root red
      fish_color_host bd93f9
      fish_color_host_remote bd93f9
      fish_color_user 8be9fd

      # Completion Pager Colors
      fish_pager_color_progress 6272a4
      fish_pager_color_background
      fish_pager_color_prefix 8be9fd
      fish_pager_color_completion f8f8f2
      fish_pager_color_description 6272a4
      fish_pager_color_selected_background --background=44475a
      fish_pager_color_selected_prefix 8be9fd
      fish_pager_color_selected_completion f8f8f2
      fish_pager_color_selected_description 6272a4
      fish_pager_color_secondary_background
      fish_pager_color_secondary_prefix 8be9fd
      fish_pager_color_secondary_completion f8f8f2
      fish_pager_color_secondary_description 6272a4
    '';
  } // linux.file;

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
    PAGER = "bat -p";
    EDITOR = "nvim";
    # CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
    GOPAH = "${pkgs.go}/lib/go";
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

      "profile sai-dev" = {
        sso_account_id = "729161019481";
        sso_role_name = "AdministratorAccess";
        region = "us-east-1";
        sso_start_url = "https://allies.awsapps.com/start";
        sso_region = "us-east-1";
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

  programs.fish = {
    enable = true;

    shellAliases = {
      "docker-stop-all" = "docker stop $(docker ps -q)";
    };

    functions = {
      "add_to_path_if_exists" = {
        body = ''
          if test -d "$to_check"
            fish_add_path "$to_check"
          end
        '';
        argumentNames = [ "to_check" ];
      };

      "ssh" = ''
          if test -z "$SSH_AGENT_PID"
              eval $(ssh-agent -c)
              ssh-add ~/.ssh/id_rsa
              ssh-add ~/.ssh/id_ed25519
          end

          command ssh $argv
      '';

      "command_exists" = ''
          command -v $argv[1] >/dev/null
      '';

      "docker-clean" = ''
        docker-stop-all
        docker rm $(docker ps -aq)
      '';

      "mkcd" = ''
          mkdir -p "$argv[1]"
          cd "$argv[1]"
      '';

      "fnm" = ''
        if command_exists fnm
          if test -z "$FNM_DIR"
            command fnm env | source
            command fnm completions | source
            set -gx FNM_RESOLVE_ENGINES true
          end
        end
        command "fnm" $argv
      '';

      "node" = ''
        if command_exists "fnm" && test -z "$FNM_DIR"
            # Load fnm
            fnm --help > /dev/null
        end

        command node $argv
      '';
    
      "venv" = ''
        if test -n "$VIRTUAL_ENV"
            deactivate
            echo "Deactivated old venv"
        end

        if test -f ./.venv/bin/activate.fish
            . ./.venv/bin/activate.fish
        else if test -f ../.venv/bin/activate.fish
            . ../.venv/bin/activate.fish
        else
            echo "No .venv found in this folder or up a level"
            return
        end

        echo "Activated venv"
      '';
    };

    interactiveShellInit = ''
      set -g fish_greeting
      fish_config theme choose "Dracula Official"

      if test -n "$XDG_SESSION_TYPE" && test "$XDG_SESSION_TYPE" = "wayland"
          set -gx MOZ_ENABLE_WAYLAND 1
      end

      if test (uname) = 'Darwin'
        source /opt/homebrew/opt/asdf/libexec/asdf.fish
        set -gx DOCKER_HOST "unix:///Users/bmchone/.colima/default/docker.sock"
      end

      add_to_path_if_exists "$HOME/go/bin"
      add_to_path_if_exists "$HOME/.cargo/bin"
      add_to_path_if_exists "$HOME/.local/bin"

      starship init fish | source
      zoxide init fish | source
    '';

    shellAbbrs = {
      ls = "lsd";
      nvm = "fnm";
      "fish-reload" = "source ~/.config/fish/config.fish";
    };
  };
}
