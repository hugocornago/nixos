{pkgs}: let
  script-name = "steam-export.sh";
  script = (pkgs.writeScriptBin "${script-name}" (builtins.readFile ./steam-export.sh)).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
  share = pkgs.callPackage ../share/default.nix {};
in
  with pkgs;
    symlinkJoin
    rec {
      name = "steam-export.sh";
      description = "Utility to export videos from steam, and upload them to my homeserver.";
      buildInputs = [makeWrapper ffmpeg file gawk rsync share];
      paths = [script] ++ buildInputs;
      postBuild = "wrapProgram $out/bin/${script-name} --prefix PATH : $out/bin";
    }
