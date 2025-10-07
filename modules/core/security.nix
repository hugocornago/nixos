{ pkgs, ... }:
{
  security.rtkit.enable = true;
  security.sudo.enable = true;
  # security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };

  # Change efi vars group
  environment.systemPackages = with pkgs; [
    efibootmgr
  ];

  users.groups.efiboot = {};
  users.groups.efiboot.members = [ "cornago" ];

  security.sudo.extraRules = [
    { groups = [ "efiboot" ]; commands = [ { command = "/run/current-system/sw/bin/efibootmgr"; options = [ "NOPASSWD" ]; } ]; }  
  ];
}
