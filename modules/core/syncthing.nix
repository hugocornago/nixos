{ ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "cornago";
    configDir = "/home/cornago/.config/syncthing";
    dataDir = "/home/cornago";
  };
}
