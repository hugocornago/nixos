{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    sideloadInitLua = true;

    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    defaultEditor = true;
    withRuby = false;
    #extraConfig = lib.fileContents ./init.lua;
  };
}
