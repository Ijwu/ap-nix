{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, wheel
, nativeProtobuf
, pythonProtobuf
, pip
}:

buildPythonPackage rec {
  pname = "s2clientprotocol";
  version = "5.0.12.91115.0";

  src = fetchFromGitHub {
    owner = "Blizzard";
    repo = "s2client-proto";
    rev = "c04df4a";
    hash = "sha256-2v8qQNaoRidcA2Jsg6XKsHEYmVSQrX1z2+NDONZZUNQ=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
    nativeProtobuf
    pip
  ];

  propagatedBuildInputs = [
    pythonProtobuf
  ];

  # preBuild = ''
  #   export PROTOBUF_LOCATION=${protobuf}
  #   export PROTOC=$PROTOBUF_LOCATION/bin/protoc
  #   export PROTOC_INCLUDE=$PROTOBUF_LOCATION/include
  #   echo $PROTOC
  # '';

  pythonImportsCheck = [ "s2clientprotocol" ];

  meta = with lib; {
    description = "StarCraft II Client - protocol definitions used to communicate with StarCraft II";
    homepage = "https://github.com/Blizzard/s2client-proto";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
