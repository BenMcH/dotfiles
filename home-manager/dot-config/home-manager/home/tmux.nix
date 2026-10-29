{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-b";
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      set -g default-command ${pkgs.fish}/bin/fish

      # Truecolor (24-bit) support
      set -ga terminal-overrides ",*256col*:Tc"

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux.conf"

      setw -g mode-keys vi

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # Splits and new windows open in the current pane's directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Faster escape (helps vim responsiveness inside tmux)
      set -sg escape-time 10

      # Larger scrollback
      set -g history-limit 50000

      # 1-based indexing, renumber on close
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on

      # Clipboard: pbcopy on macOS; wl-copy on Wayland, else xclip
      ${if pkgs.stdenv.isDarwin
        then "set -s copy-command 'pbcopy'"
        else "if-shell 'command -v wl-copy' \"set -s copy-command 'wl-copy'\" \"set -s copy-command 'xclip -selection clipboard -in'\""}

      # Vim-style visual selection + yank in copy mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel

      set -g status-position top
      set -g mouse
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];
  };
}
