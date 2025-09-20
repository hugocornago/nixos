{
  pkgs,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    ## Minecraft
    prismlauncher
  ];
}
