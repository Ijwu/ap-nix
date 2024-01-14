{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, anyio
}:

buildPythonPackage rec {
  pname = "factorio-rcon-py";
  version = "2.0.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-lt82CMtL/0dhEb7JcE1UgOWr9O9oVOo2hBHPW0Vgxq0=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  passthru.optional-dependencies = {
    async = [
      anyio
    ];
  };

  pythonImportsCheck = [ "factorio_rcon" ];

  meta = with lib; {
    description = "A simple Factorio RCON client";
    homepage = "https://pypi.org/project/factorio-rcon-py/";
    license = licenses.lgpl21Only;
    maintainers = with maintainers; [ ];
  };
}
