{
  host,
  config,
  ...
}: {
  sops.secrets."wireless.env" = {};
	services.blueman.enable = true;

  networking = {
    hostName = "${host}";
    wireless = {
      enable = true;
      secretsFile = config.sops.secrets."wireless.env".path;
      userControlled.enable = true;
      networks."CASA HUGO" = {
        pskRaw = "ext:home_password";
        priority = 10;
        extraConfig = ''
          bssid_blacklist=80:af:ca:68:32:d0
        '';
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

			networks.deza = {
				priority = 0;
				psk = "miwifiputas";
			};

			networks."HotelSkylineLoft_5G" = {
				priority = 1;
				psk = "pedrezuela";
			};
    };
  };

  # eduroam
  security.pki.certificateFiles = [../../networking/eduroam.unizar.crt];

	# modifiable /etc/hosts
	environment.etc.hosts.mode = "0644";
}
