{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "xxtea";
  version = "3.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-r1uY5w4trccrjLWpz+MSoVzYtQqLkqE9RGUKNjkc0k8=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "xxtea" ];

  meta = with lib; {
    description = "Xxtea is a simple block cipher";
    homepage = "https://pypi.org/project/xxtea/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ];
  };
}
