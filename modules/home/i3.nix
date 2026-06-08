{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "xrender";
    opacityRules = [
      "95:class_g = 'exiled-exchange-2'"
    ];
  };

  systemd.user.services.picom.unitConfig.ConditionalEnvironment = "XDG_SESSION_TYPE=x11";

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      gaps = {
        inner = 0;
        outer = 0;
      };

      startup = [
        {command = "${pkgs.dunst}/bin/dunst";}
        {command = "steam";}
        {command = "exec ~/.local/bin/vesktop-hw";}
        {command = "${pkgs.exiled-exchange-2}/bin/exiled-exchange-2";}
      ];

      assigns = {
        "0" = [{class = "^vesktop$";}];
        "1" = [{class = "^steam$";}];
        "2" = [{class = "^zen-beta$";}];
      };

      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
        zen-browser = inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default;
      in
        lib.mkOptionDefault {
          # "${modifier}+Return" = "exec i3-sensible-terminal";
          "${modifier}+Shift+q" = "exec i3-msg exit";
          "${modifier}+w" = "kill";
          "${modifier}+r" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "${modifier}+b" = "exec ${zen-browser}/bin/zen-beta";
          "${modifier}+d" = "[class=\"vesktop\"] focus";
          "F6" = "exec ${pkgs.volume}/bin/volume down 5";
          "F7" = "exec ${pkgs.volume}/bin/volume up 5";
          "${modifier}+q" = "exec ~/.local/bin/screenshot";
          "F9" = "exec ~/.local/bin/poe-macro.sh";
          "F12" = "exec ${pkgs.volume}/bin/volume sink";
        };
    };
  };
}
