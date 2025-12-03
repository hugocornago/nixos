{pkgs,...}:
{
	services.cloudflare-warp = {
		enable = true;
	};

	environment.systemPackages = with pkgs; [
		cloudflare-warp
	];

	security.pki.certificates = [ (builtins.readFile ../../networking/cloudflare.crt) ];
}
