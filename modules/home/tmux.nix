{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-kitty";
    historyLimit = 500000;
    extraConfig = ''
      # Change prefix to C-o
      unbind C-b
      set-option -g prefix C-o
      bind-key C-o send-prefix

      # Style points
      set -g status-style 'bg=#333333 fg=#5eacd3'

      set -g base-index 1

      setw -g mode-keys vi

      # vim-like pane switching (colemak)
      bind -r ^ last-window
      bind -r n select-pane -L
      bind -r o select-pane -R
      bind -r e select-pane -D
      bind -r i select-pane -U


      # TODO: tmux-sessionasizer
      # bind-key -r f run-shell "tmux nnew ~/.local/bin/tmux-sessionasizer"
  
      # Useful keybindings
      #bind-key -r l send-keys "tmux neww lazygit" C-m
      bind-key -r l new-window -n lazygit lazygit
    '';
  };
}
