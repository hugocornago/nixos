{
  pkgs
}:
let
  script-name = "share.sh";
  script = (pkgs.writeScriptBin "${script-name}" (builtins.readFile ./share.sh)).overrideAttrs(old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
in
with pkgs;
symlinkJoin
rec {
  name = "share.sh";
  description = "Utility to upload video clips to my homeserver.";
  buildInputs = [ makeWrapper ffmpeg file gawk rsync ];
  paths = [script] ++ buildInputs;
  postBuild = "wrapProgram $out/bin/${script-name} --prefix PATH : $out/bin";
}

