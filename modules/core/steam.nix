{
  pkgs,
  lib,
  ...
}: {
  programs = {
    steam = {
      enable = true;
			package = pkgs.steam.override {
				# skip waiting for network screen
				extraProfile = "export DBUS_SYSTEM_BUS_ADDRESS=";
			};

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;

      gamescopeSession.enable = true;

      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };
}
