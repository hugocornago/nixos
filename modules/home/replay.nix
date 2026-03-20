{pkgs, ...}: let
  replayScript = pkgs.writeShellScript "replay.sh" ''
		exec 2>/tmp/minecraft-replay.err
		exec >/tmp/minecraft-replay.log

		function handle {
			case "$1" in
				openwindow*)
				if [[ "$1" == *"Minecraft"* ]]; then
					sleep 2
					gpu-screen-recorder \
						-r 900 \
						-w portal \
						-a app:java \
						-f 144 \
						-c mp4 -o "$HOME/Videos" \
						-restore-portal-session no \
						-cursor no \
						-df yes \
						-restart-replay-on-save yes \
						-encoder gpu &
				fi
				;;
				closewindow*)
					if [[ "$1" == *"Minecraft"* ]]; then
						pkill -SIGUSR1 -f gpu-screen-recorder # save recording
						pkill -SIGINT  -f gpu-screen-recorder # exit program
					fi
					;;
			esac
		}

		SOCKET_FILE="$XDG_RUNTIME_DIR/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock"
		while [ ! -S $SOCKET_FILE ]
		do
			SOCKET_FILE="$XDG_RUNTIME_DIR/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock"
			echo "$SOCKET_FILE"
			echo "not found"
			sleep 0.5
		done

		while true; do
			socat - UNIX-CONNECT:$SOCKET_FILE | while read line; do handle $line; done
		done
  '';
  saveReplayScript = pkgs.writeShellScript "saveReplay.sh" ''
    #!/usr/bin/env bash
    pkill -SIGUSR1 -f gpu-screen-recorder
    notify-send "Replay Saved."
  '';
in {
  home.packages = with pkgs; [
    gpu-screen-recorder
  ];

  wayland.windowManager.hyprland.settings = {
    exec = ["${replayScript} &"];
    bind = [
      "$mainMod,GRAVE,exec, ${saveReplayScript}"
    ];
  };
}
