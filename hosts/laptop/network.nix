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
					pairwise=CCMP
					group=CCMP TKIP
					eap=TTLS
					phase2="auth=PAP"
					anonymous_identity="anonymous@unizar.es"
					ca_cert="/etc/ssl/certs/ca-bundle.crt"
					identity="873840@unizar.es"
					password=ext:eduroam_password
				'';
			};
		};
  };

  # eduroam
	security.pki.certificateFiles = [ ../../networking/eduroam.unizar.crt ];
}
