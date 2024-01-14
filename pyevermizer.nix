{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
}:

buildPythonPackage rec {
  pname = "pyevermizer";
  version = "0.46.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-oZqg8K5FrOmFtTek6B2pJcHkselYsC27SrRmPiwlPr8=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "pyevermizer" ];

  meta = with lib; {
    description = "Python wrapper for Evermizer";
    homepage = "https://pypi.org/project/pyevermizer/";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
  };
}
