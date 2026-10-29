{ ... }:

{
  home.file.".config/fish/themes/Dracula Official.theme".text = ''
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

  programs.fish = {
    enable = true;

    shellAliases = {
      "docker-stop-all" = "docker stop $(docker ps -q)";
    };

    functions = {
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
      "y" = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };

    interactiveShellInit = ''
      set -g fish_greeting
      fish_config theme choose "Dracula Official"

      if test -n "$XDG_SESSION_TYPE" && test "$XDG_SESSION_TYPE" = "wayland"
          set -gx MOZ_ENABLE_WAYLAND 1
      end

      if test (uname) = 'Darwin'
        set -gx DYLD_LIBRARY_PATH /opt/homebrew/lib $DYLD_LIBRARY_PATH
      end

      zoxide init fish | source

      function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
        status --is-command-substitution; and return

        # Check if we are inside a git directory
        if git rev-parse --show-toplevel &>/dev/null
          set gitdir (realpath (git rev-parse --show-toplevel))
          set cwd (pwd -P)
          # While we are still inside the git directory, find the closest
          # virtualenv starting from the current directory.
          while string match "$gitdir*" "$cwd" &>/dev/null
            if test -e "$cwd/.venv/bin/activate.fish"
              source "$cwd/.venv/bin/activate.fish" &>/dev/null 
              return
            else
              set cwd (path dirname "$cwd")
            end
          end
        end
        # If virtualenv activated but we are not in a git directory, deactivate.
        if test -n "$VIRTUAL_ENV"
          deactivate
        end
      end

      set -gx CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR 1
    '';

    shellAbbrs = {
      ls = "lsd";
      nvm = "fnm";
      "fish-reload" = "source ~/.config/fish/config.fish";
      "ci" = "code-insiders";
      "cpy" = "copilot --yolo";
    };
  };
}
