{pkgs,...}:
let 
	time-fixdesync-bin = pkgs.writeShellScriptBin "time-fixdesync" ''
		#!/usr/bin/env bash

    current_year=$(date +%Y)
    if [ "$current_year" -lt "2026" ]; then
      date -s "01 Jan 2026"
    fi
	'';
in {

	systemd.services.time-fixdesync = {
		enable = true;
		description = "Fixes the time desync if bios fails";
		wantedBy = ["multi-user.target"];
		serviceConfig = {
			Type = "oneshot";
			ExecStart = "${pkgs.bash}/bin/bash ${time-fixdesync-bin}/bin/time-fixdesync";
		};
	};
}
