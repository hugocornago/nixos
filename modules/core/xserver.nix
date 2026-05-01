{
  pkgs,
  username,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "colemak";
      xkb.options = "caps:escape";
    };

    displayManager.autoLogin = {
      enable = false;
      user = "${username}";
    };
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
  # To prevent getting stuck at shutdown
  systemd.settings.Manager.RebootWatchdogSec = "10sec";
}
