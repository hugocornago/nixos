{ stdenv
, lib
, bash
, maim
, tesseract
, makeWrapper
, patsh
}: stdenv.mkDerivation rec {
  name = "poe-macro";

  phases = ["installPhase"];
  buildInputs = [ bash maim tesseract ];
  nativeBuildInputs = [ makeWrapper patsh ];
  script = builtins.readFile ./poe-macro.sh;

  installPhase = ''
    mkdir -p $out/bin
    patsh ${script} $out/bin/poe-macro.sh
    wrapProgram $out/bin/poe-macro.sh \
      --prefix PATH : ${lib.makeBinPath buildInputs}
  '';
}
