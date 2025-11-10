{...}: {
  nix.settings = {
    substituters = ["https://nix-community.cachix.org"];
    trusted-substituters = ["https://nix-community.cachix.org"];
    trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "cache.cornago.net:Zmntlu1k2L4u4wbdF4FLIfjsjs4/QkVYch2Tt7/ZGQ8="];
    trusted-users = [
      "@wheel"
    ];
  };

	nixpkgs.config.segger-jlink.acceptLicense = true;
}
