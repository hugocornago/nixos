{ pkgs, host, config, ... }:
{
  networking = {
    hostName = "${host}";
		networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
    firewall = {
      enable = false;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
    };
  };
}
