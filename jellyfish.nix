{ lib
, stdenv
, buildPythonPackage
, fetchPypi
, isPy3k
, pytest
, unicodecsv
, rustPlatform
, libiconv
}:

buildPythonPackage rec {
  pname = "jellyfish";
  version = "1.0.3";

  disabled = !isPy3k;

  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-3bIrcVXyCOCINSKD7njLTvLSBnp24Uiou0PRd/MrN9I=";
  };

  nativeBuildInputs = with rustPlatform; [
    maturinBuildHook
    cargoSetupHook
  ];

  buildInputs = lib.optionals stdenv.isDarwin [
    libiconv
  ];

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}-rust-dependencies";
    hash = "sha256-XjVbMVM9k3bZfwPCRUI3ogWm5oLSHZuu8kCwNL2JyMo=";
  };

  nativeCheckInputs = [ pytest unicodecsv ];

  meta = {
    homepage = "https://github.com/sunlightlabs/jellyfish";
    description = "Approximate and phonetic matching of strings";
    maintainers = with lib.maintainers; [ koral ];
  };
}
