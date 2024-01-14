{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "maseya-z3pr";
  version = "1.0.0rc1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-wCj9syUrSuLIbwfsyZY2n+Oar+s7oxQBG/Y3Ilf4Z8U=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "maseya" ];

  meta = with lib; {
    description = "Randomize palette data for Legend of Zelda: A Link to the Past";
    homepage = "https://pypi.org/project/maseya-z3pr/";
    license = licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with maintainers; [ ];
  };
}
