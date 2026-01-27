{
  config,
  ...
}: {
  # home.file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink ../../bin;
	# home.activation.linkLocalBin = config.lib.dag.entryAfter ["writeBoundary"] ''
	# 	[ -L ~/.local/bin ] && unlink ~/.local/bin
	# 	ln -s ${builtins.toPath ../../bin} ~/.local/bin
	# '';
}
