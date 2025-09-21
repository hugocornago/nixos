{ pkgs, host, config, ... }:
{
  networking = {
    hostName = "${host}";
		wireless = {
			enable = true;
			secretsFile = config.sops.secrets."wireless.env".path;
			userControlled.enable = true;
			networks."CASA HUGO 5G" = {
				pskRaw = "ext:home_password";
				priority = 10;
			};
			networks."Cornago" = {
				pskRaw = "ext:phone_password";
				priority = 2;
			};
		  networks.eduroam = {
				priority = 1;
				auth = ''
					key_mgmt=WPA-EAP
					eap=PWD
					identity="873840@unizar.es"
					password="ext:eduroam_password"
				'';
			};
		};
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
