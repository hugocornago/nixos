{ inputs, pkgs, ... }: 
let 
  _2048 = pkgs.callPackage ../../pkgs/2048/default.nix {}; 
in
{
  home.packages = (with pkgs; [
    _2048

    ## CLI utility
    ani-cli
    binsider
    bitwise                           # cli tool for bit / hex manipulation
    bottles                           # wine runner
    caligula                          # User-friendly, lightweight TUI for disk imaging
    dconf-editor
    docfd                             # TUI multiline fuzzy document finder
    eza                               # ls replacement
    entr                              # perform action when file change
    fd                                # find replacement
    ffmpeg
    file                              # Show file information 
    gtt                               # google translate TUI
    gifsicle                          # gif utility
    gtrash                            # rm replacement, put deleted files in system trash
    hexdump
    imv                               # image viewer
    jq                                # JSON processor
    keepassxc
    killall
    lazygit
    libnotify
    lutris
    man-pages					            	  # extra man pages
    mimeo
    mpv                               # video player
    ncdu                              # disk space
    nitch                             # systhem fetch util
    nixd                              # nix lsp
    nixfmt-rfc-style                  # nix formatter
    openrgb-with-all-plugins          # plugins for openrgb
    openssl
    onefetch                          # fetch utility for git repo
    p7zip                             # almighty decompressor
    pamixer                           # pulseaudio command line mixer
    pulsemixer                        # pulseaudio command line mixer with better frontend
    # copyq
    playerctl                         # controller for media players
    piper
    poweralertd
    programmer-calculator
    ripgrep                           # grep replacement
    shfmt                             # bash formatter
    swappy                            # snapshot editing tool
    tdf                               # cli pdf viewer
    #teamspeak3                        # teamspeak for albion
    treefmt                          # project formatter
    tldr
    todo                              # cli todo list
    toipe                             # typing test in the terminal
    ttyper                            # cli typing test
    unzip
    valgrind                          # c memory analyzer
    wl-clipboard                      # clipboard utils for wayland (wl-copy, wl-paste)
    wget
    yt-dlp-light
    xdg-utils
    xxd

    # Rust
    cargo
    rustc

    # CLI 
    cbonsai                           # terminal screensaver
    cmatrix
    pipes                             # terminal screensaver
    tty-clock                         # cli clock

    ## GUI Apps
    audacity
    bleachbit                         # cache cleaner
    gimp
    libreoffice
    nix-prefetch-github
    pavucontrol                       # pulseaudio volume controle (GUI)
    #pitivi                            # video editing
    qalculate-gtk                     # calculator
    qbittorrent
    resources                         # GUI resources monitor
    soundwireserver
    thunderbird
    vlc
    winetricks
    wineWowPackages.wayland
    zathura
    zenity

    xclip

    # C / C++
    # gcc
    # gdb
    # gnumake

    # Python
    python3

    inputs.alejandra.defaultPackage.${system}
  ]);
}
