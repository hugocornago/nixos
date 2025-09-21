{ pkgs, ... }:
{
  security.rtkit.enable = true;
  security.sudo.enable = true;
  # security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };

	# sops
	sops = {
	  defaultSopsFile = ../../secrets/secrets.yaml;
	  defaultSopsFormat = "yaml";
		age.keyFile = "/home/cornago/.config/sops/age/keys.txt";
		secrets."wireless.env" = {};
	};


  # Change efi vars group
  environment.systemPackages = with pkgs; [
    efibootmgr
  ];

  users.groups.efiboot = {};
  users.groups.efiboot.members = [ "cornago" ];

  security.sudo.extraRules = [
    { groups = [ "efiboot" ]; commands = [ { command = "/run/current-system/sw/bin/efibootmgr"; options = [ "NOPASSWD" ]; } ]; }  
  ];
}
