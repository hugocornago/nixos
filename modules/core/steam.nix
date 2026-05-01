{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [pkgs.gamemode];
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
      capSysNice = false;
      args = [
        "-w 2560"
        "-h 1440"
        "-W 2560"
        "-H 1440"
        "-r 144"
        # "--force-grab-cursor"
        # "--force-windows-fullscreen"
      ];
    };
  };
}
