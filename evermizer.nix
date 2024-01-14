{ lib
, stdenv
, fetchFromGitHub
, pkgs
}:

stdenv.mkDerivation rec {
  pname = "evermizer";
  version = "46";

  nativeBuildInputs = with pkgs; [
    python3
    which
    cppcheck
    closurecompiler
    emscripten
  ];

  buildFlags = [ "native" ];

  installPhase = ''
    mkdir -p $out/bin
    cp evermizer $out/bin
    cp ow-patch $out/bin
  '';


  src = fetchFromGitHub {
    owner = "black-sliver";
    repo = "evermizer";
    rev = "c8597da86c511f1d83621658fee7b877d5061bb8";
    hash = "sha256-NcSl6n2BCt4FEaj46eiiUYsnAkC7gKLUSB4pDW6v1v4=";
  };

  doCheck = false;

  meta = with lib; {
    description = "Source code of the Secret of Evermore randomizer \"Evermizer";
    homepage = "https://github.com/black-sliver/evermizer";
    changelog = "https://github.com/black-sliver/evermizer/blob/${src.rev}/changelog.txt";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "evermizer";
    platforms = platforms.all;
  };
}
