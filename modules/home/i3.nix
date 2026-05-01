{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      gaps = {
        inner = 10;
        outer = 5;
      };

      startup = [
        {command = "steam";}
      ];

      assigns = {
        "0: discord" = [{class = "^vesktop$";}];
        "1: steam" = [{class = "^steam$";}];
        "2: web" = [{class = "^zen-browser$";}];
      };

      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
        zen-browser = inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default;
      in
        lib.mkOptionDefault {
          # "${modifier}+Return" = "exec i3-sensible-terminal";
          "${modifier}+w" = "kill";
          "${modifier}+r" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "${modifier}+b" = "exec ${zen-browser}/bin/zen-beta";
          "${modifier}+d" = "exec ~/.local/bin/vesktop-hw";
        };
    };
  };
}
