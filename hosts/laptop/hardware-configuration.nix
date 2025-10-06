{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c49090f8-6446-4f27-a1e9-42eb891d75e2";
      fsType = "ext4";
    };

  boot.initrd.luks.devices = {
		"luks-129351a4-55bc-4b2f-8e88-88f5d9e22927".device = "/dev/disk/by-uuid/129351a4-55bc-4b2f-8e88-88f5d9e22927";
  	"luks-d79993c6-fca7-4657-b50f-493ca7a94d0b".device = "/dev/disk/by-uuid/d79993c6-fca7-4657-b50f-493ca7a94d0b";
	};

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/623B-D0FA";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-d79993c6-fca7-4657-b50f-493ca7a94d0b"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

	hardware.enableAllFirmware = true;
	hardware.bluetooth.enable = false;
}
