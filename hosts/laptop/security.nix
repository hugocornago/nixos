{ pkgs, ... }:
{
	# sops
	sops = {
	  defaultSopsFile = ../../secrets/secrets.yaml;
	  defaultSopsFormat = "yaml";
		age.keyFile = "/home/cornago/.config/sops/age/keys.txt";
		secrets."wireless.env" = {};
	};
}
