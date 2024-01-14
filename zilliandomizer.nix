{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools
, setuptools-scm
, wheel
}:

buildPythonPackage rec {
  pname = "zilliandomizer";
  version = "0.6.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "beauxq";
    repo = "zilliandomizer";
    rev = "v${version}";
    hash = "sha256-ufXpTZY8l9+oVn21JER+CvqFBlWbM9q3CHSHKqK5LKs=";
    leaveDotGit = true;
    deepClone = true;
  };

  prePatch = ''
    export SETUPTOOLS_SCM_PRETEND_VERSION=${version}
  '';

  nativeBuildInputs = [
    setuptools
    setuptools-scm
    wheel
  ];

  pythonImportsCheck = [ "zilliandomizer" ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/beauxq/zilliandomizer";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ ];
  };
}
