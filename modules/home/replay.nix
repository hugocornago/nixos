{pkgs}: let
  replayScript = pkgs.writeShellScript "replay.sh" ''
    #!/usr/bin/env bash
    function handle {
    	if [[ "$\{1:0:10}" == "openwindow" ]] && [[ "$1" == *"Minecraft"* ]]; then
    		gpu-screen-recorder \
    			-r 900 \
    			-w portal \
    			-a app:java \
    			-f 144 \
    			-c mp4 -o "$HOME/Videos" \
    			-restore-portal-session yes \
    			-cursor no \
    			-df \
    			-restart-replay-on-save yes \
    			-replay-storage ram \
    			-encoder gpu
    	fi
    }

    socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
  '';
  saveReplayScript = pkgs.writeShellScript "saveReplay.sh" ''
    #!/usr/bin/env bash
    pkill -SIGUSR1 -f gpu-screen-recorder
    notify-send "Replay Saved\!"
  '';
in {
  home.packages = with pkgs; [
    gpu-screen-recorder
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = ["${replayScript}"];
    bind = [
      "$mainMod,`,exec, ${saveReplayScript}"
    ];
  };
}
