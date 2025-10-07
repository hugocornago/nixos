{ pkgs, host, config, ... }:
{
  networking = {
    hostName = "${host}";
		networkmanager.enable = true;
  };
}
