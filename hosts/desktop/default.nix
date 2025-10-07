{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
		./network.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
