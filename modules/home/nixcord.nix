{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;
    discord.enable = false;
    config = {
      frameless = true;
      themeLinks = [
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/midnight.theme.css"
      ];
      plugins = {
        alwaysTrust.enable = true;
        crashHandler.enable = true;
        imageZoom.enable = true;
        memberCount.enable = true;
        messageLogger = {
          enable = true;
          deleteStyle = "text";
          logDeletes = true;
          logEdits = true;
          ignoreSelf = true;
        };
        volumeBooster.enable = true;
      };
    };
  };
}
