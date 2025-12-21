{pkgs,...}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    ratbagd.enable = true;
		earlyoom.enable = true;
		earlyoom.enableNotifications = true;
  };
  # services.logind.extraConfig = ''
  #   # don’t shutdown when power button is short-pressed
  #   HandlePowerKey=ignore
  # '';

  services.hardware.openrgb = {
		enable = true;
		package = pkgs.unstable.openrgb;
	};
}
