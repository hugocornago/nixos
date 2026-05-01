{
  description = "Rust generic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {flake-parts, fenix, ...}:
	let
		cargotoml = fromTOML (builtins.readFile ./Cargo.toml);
	in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {
        pkgs,
        system,
				self',
        ...
      }:
			let
				toolchain = fenix.packages.${system}.stable.toolchain;
			in
      {
				packages.default = self'.packages.volume;
				packages.volume = (pkgs.makeRustPlatform {
					cargo = toolchain;
					rustc = toolchain;
				}).buildRustPackage {
					pname = cargotoml.package.name;
					version = cargotoml.package.version;
					src = pkgs.lib.cleanSource ./.;
					cargoLock.lockFile = ./Cargo.lock;
				};

        devShells.default = pkgs.mkShell {
          buildInputs = [ toolchain ];
        };
      };
    };
}
