{ inputs, pkgs, ... }: 
let 
  _2048 = pkgs.callPackage ../../pkgs/2048/default.nix {}; 
in
{
  home.packages = (with pkgs; [
    _2048

    ## CLI utility
    binsider
    bitwise                           # cli tool for bit / hex manipulation
    bottles                           # wine runner
    caligula                          # User-friendly, lightweight TUI for disk imaging
    #dconf-editor
    eza                               # ls replacement
    entr                              # perform action when file change
    fd                                # find replacement
    ffmpeg
    file                              # Show file information 
    imv                               # image viewer
    jq                                # JSON processor
    skim                              # skim
    keepassxc
    killall
    lazygit
    libnotify
    man-pages					            	  # extra man pages
    mpv                               # video player
    ncdu                              # disk space
    nitch                             # systhem fetch util
    openrgb-with-all-plugins          # plugins for openrgb
    onefetch                          # fetch utility for git repo
    p7zip-rar                             # almighty decompressor
    pamixer                           # pulseaudio command line mixer
    pulsemixer                        # pulseaudio command line mixer with better frontend
    playerctl                         # controller for media players
    piper
    ripgrep                           # grep replacement
    swappy                            # snapshot editing tool
    tldr
    todo                              # cli todo list
    toipe                             # typing test in the terminal
    unzip
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    wget
    yt-dlp-light
    xdg-utils
    xxd

    # CLI 
    #cbonsai                           # terminal screensaver
    #cmatrix
    #pipes                             # terminal screensaver
    #tty-clock                         # cli clock

    ## GUI Apps
    #audacity
    #bleachbit                         # cache cleaner
    gimp
    libreoffice
    nix-prefetch-github
    #pavucontrol                       # pulseaudio volume controle (GUI)
    #pitivi                            # video editing
    #qalculate-gtk                     # calculator
    qbittorrent
    #soundwireserver
    thunderbird
    zathura
    zenity

    xclip

    # Python
    python3
  ]);
}
