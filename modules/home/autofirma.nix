{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.autofirma-nix.homeManagerModules.default];
  programs.autofirma = {
    enable = true;
    firefoxIntegration.profiles.default.enable = true;
    config.omitAskOnClose = true;
  };
  programs.configuradorfnmt = {
    enable = true;
    firefoxIntegration.profiles.default.enable = true;
  };

  # enable firefox to use with autofirma
  programs.firefox = {
    enable = true;

    # Set up security devices for DNIe access
    policies = {
      SecurityDevices = {
        # For physical smart card readers (like DNIe)
        "OpenSC PKCS11" = "${pkgs.opensc}/lib/opensc-pkcs11.so";

        # For smartphone NFC using DNIeRemote
        "DNIeRemote" = "${config.programs.dnieremote.finalPackage}/lib/libdnieremotepkcs11.so";
      };
    };

    # Define Firefox profiles
    profiles.default = {
      id = 0; # Makes this the default profile
    };
  };
}
