{ lib
, python3
, fetchFromGitHub
, rustPlatform
, libiconv
, libcxx
, darwin
, fetchpatch
, pkg-config
, gst_all_1
, SDL2
, SDL2_image
, SDL2_ttf
, SDL2_mixer
, mtdev
, cacert
, gdb
, ncurses
, which
}:

with python3.pkgs;
let
  pyevermizer = import ./pyevermizer.nix { inherit lib buildPythonPackage fetchPypi setuptools wheel;};
  maseya-z3pr = import ./maseya.nix { inherit lib buildPythonPackage fetchPypi setuptools wheel; };
  zilliandomizer = import ./zilliandomizer.nix { inherit lib buildPythonPackage fetchFromGitHub setuptools setuptools-scm wheel; };
  xxtea = import ./xxtea.nix { inherit lib buildPythonPackage fetchPypi setuptools wheel; };
  websockets12 = import ./websockets.nix { inherit lib stdenv buildPythonPackage fetchFromGitHub unittestCheckHook pythonOlder; };
  jellyfish103 = import ./jellyfish.nix { inherit lib stdenv buildPythonPackage fetchPypi isPy3k pytest unicodecsv rustPlatform libiconv; };
  kivy221 = import ./kivy.nix { inherit lib stdenv buildPythonPackage fetchFromGitHub fetchpatch pkg-config
                                        cython docutils kivy-garden mesa mtdev SDL2 SDL2_image SDL2_ttf SDL2_mixer
                                        libcxx gst_all_1 pillow requests pygments packaging;
                                        Accelerate = darwin.apple_sdk.frameworks.Accelerate;
                                        ApplicationServices = darwin.apple_sdk.frameworks.ApplicationServices;
                                        AVFoundation = darwin.apple_sdk.frameworks.AVFoundation;
                              };
  platformdirs400 = import ./platformdirs.nix { inherit lib appdirs buildPythonPackage fetchFromGitHub hatch-vcs hatchling
                                                        pytest-mock pytestCheckHook pythonOlder; 
                                              };
  certifi20231117 = import ./certifi.nix { inherit lib buildPythonPackage cacert pythonOlder fetchFromGitHub pytestCheckHook; };
  cython308 = import ./cython.nix { inherit lib stdenv buildPythonPackage fetchPypi fetchpatch python pkg-config gdb numpy ncurses; };
  factorio-rcon-py = import ./factorio-rcon-py.nix { inherit lib buildPythonPackage fetchPypi setuptools wheel anyio; };
  sc2clientprotocol = import ./sc2clientprotocol.nix { inherit lib buildPythonPackage fetchFromGitHub setuptools wheel pip; nativeProtobuf = pkgs.protobuf; pythonProtobuf = protobuf; };
  pymem = import ./pymem.nix { inherit lib buildPythonPackage fetchPypi setuptools wheel recommonmark sphinx sphinx-rtd-theme regex codecov pytest pytest-cov twine; };
in
buildPythonApplication rec {
  pname = "Archipelago";
  version = "0.4.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ArchipelagoMW";
    repo = "Archipelago";
    rev = version;
    hash = "sha256-8PTssTxupdu7nRmk7kevpHcD14G2YsmwoiXpQWzUxds=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with python3.pkgs; [
    pip
    setuptools
    wheel
    pygobject3
    charset-normalizer
    cx-freeze
    cython308
    pkgs.git
    pkgs.ensureNewerSourcesForZipFilesHook
    protobuf3
  ];

  /*
    TODO: factorio-rcon-py
    TODO: fix s2clientprotocol
    TODO: websockets (package version in nix store is 11, but >=12 required)
    TODO: xxtea
  */

  propagatedBuildInputs = with python3.pkgs; [
    bsdiff4
    certifi20231117
    colorama
    cymem
    jellyfish103
    jinja2
    kivy221
    orjson
    platformdirs400
    pyyaml
    schema
    websockets12
    nest-asyncio
    pyevermizer
    maseya-z3pr
    zilliandomizer
    xxtea
    factorio-rcon-py
    sc2clientprotocol
    mpyq
    portpicker
    aiohttp
    loguru
    six
    pymem
  ];

  preBuild = ''
    sed -ie "s/, \"--upgrade\"//g" ModuleUpdate.py
    sed -ie "s/input(/print(/g" ModuleUpdate.py
    mkdir -p home/worlds
    export HOME=$PWD/home
  '';

  patches = [ ./Utils.py.patch ];

#   buildPhase = ''
#     # pygobject is an optional dependency for kivy that's not in requirements
#     # charset-normalizer was somehow incomplete in the github runner
#     python -m venv venv
#     source venv/bin/activate
#     python setup.py build_exe --yes bdist_appimage --yes
#     echo -e "setup.py build output:\n `ls build`"
#     echo -e "setup.py dist output:\n `ls dist`"
# #     cd dist && export APPIMAGE_NAME="`ls *.AppImage`" && cd ..
# #     export TAR_NAME="''${APPIMAGE_NAME%.AppImage}.tar.gz"
# #     (cd build && DIR_NAME="`ls | grep exe`" && mv "$DIR_NAME" Archipelago && tar -czvf ../dist/$TAR_NAME Archipelago && mv Archipelago "$DIR_NAME")
# #     echo "APPIMAGE_NAME=$APPIMAGE_NAME" >> $GITHUB_ENV
# #     echo "TAR_NAME=$TAR_NAME" >> $GITHUB_ENV
#   '';

  postBuild = ''
    mkdir -p $out/bin
    cp $src/build $out/bin
    deactivate
  '';
#
#   installPhase = ''
#   '';

#   pythonImportsCheck = [ "archipelago" ];


  meta = with lib; {
    description = "Archipelago Multi-Game Randomizer and Server";
    homepage = "https://github.com/ArchipelagoMW/Archipelago";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "ArchipelagoLauncher";
  };
}
