{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    historyLimit = 500000;
    extraConfig = ''
      set -g prefix C-o
			set -sg escape-time 10
      set -g base-index 1
			set -g renumber-windows on
			set -g mode-keys vi
			set -g status-position top
			set -g status-justify absolute-centre
			set -g status-style "bg=default"
			set -g window-status-current-style "fg=blue bg=default bold"
			set -g status-right ""
			#set -g status-left "#S"
			set -g status-left ""
			set -g focus-events on
			set -g default-terminal "tmux-256color"

			# Copy mode
			bind-key -T copy-mode-vi 'y' send -X copy-selection
			bind-key -T copy-mode-vi 'v' send -X begin-selection
			bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle


      # TODO: tmux-sessionasizer
      # bind-key -r f run-shell "tmux nnew ~/.local/bin/tmux-sessionasizer"
  
      # Useful keybindings
      bind-key -r l new-window -n lazygit lazygit
    '';
  };
}
