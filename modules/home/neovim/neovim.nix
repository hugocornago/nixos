{ inputs, pkgs, lib, ...}
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withRuby = false;
    extraConfig = lib.fileContents ./init.lua;
};
