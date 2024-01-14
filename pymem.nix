{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, recommonmark
, sphinx
, sphinx-rtd-theme
, regex
, codecov
, pytest
, pytest-cov
, twine
}:

buildPythonPackage rec {
  pname = "pymem";
  version = "1.13.1";
  pyproject = true;

  src = fetchPypi {
    pname = "Pymem";
    inherit version;
    hash = "sha256-grUAQOLoUXnccC2T1IV7R14NLrRJvV8cUNP0DrBa4a0=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  passthru.optional-dependencies = {
    doc = [
      recommonmark
      sphinx
      sphinx-rtd-theme
    ];
    speed = [
      regex
    ];
    test = [
      codecov
      pytest
      pytest-cov
      twine
    ];
  };

  pythonImportsCheck = [ "pymem" ];

  meta = with lib; {
    description = "Pymem: python memory access made easy";
    homepage = "https://pypi.org/project/Pymem/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
