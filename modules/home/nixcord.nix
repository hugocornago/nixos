{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord.vencord.package = pkgs.vencord;
    vesktop.enable = true;
    discord.enable = false;
    config = {
      frameless = true;
      themeLinks = [
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/midnight.theme.css"
      ];
      plugins = {
        alwaysTrust.enable = true;
        betterUploadButton.enable = true;
        blurNSFW.enable = true;
        clearURLs.enable = true;
        crashHandler.enable = true;
        fakeNitro.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        imageZoom.enable = true;
        memberCount.enable = true;
        messageClickActions.enable = true;
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
