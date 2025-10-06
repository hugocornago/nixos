{inputs, username, host, ...}: {
  imports = [
    ./bat.nix                         # better cat command
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./fastfetch.nix                   # fetch tool
    ./gaming.nix                      # packages related to gaming
    ./git.nix                         # version control
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal
    #./swayosd.nix                     # brightness / volume wiget
    ./swaync/swaync.nix               # notification deamon
    ./nixcord.nix                     # discord with nix!
    ./nemo.nix                        # file manager
    ./neovim/neovim.nix               # neovim editor
    #./p10k/p10k.nix
    ./packages.nix                    # other packages
    ./tmux.nix                        # tmux configuration
    ./rofi.nix                        # launcher
    ./scripts/scripts.nix             # personal scripts
    ./swaylock.nix                    # lock screen
    ./waybar                          # status bar
    ./waypaper.nix                    # GUI wallpaper picker
    ./xdg-mimes.nix                   # xdg config
    ./obs.nix
    ./zsh
		./symlinks.nix
  ];
}
