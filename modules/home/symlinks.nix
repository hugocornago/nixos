{ pkgs, config, ... }:
{
	home.file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink ../../bin;
}
