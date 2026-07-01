{
  pkgs,
  config,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ## Minecraft
    prismlauncher

    ## runescape OSRS
    runelite
    bolt-launcher
  ];
}
