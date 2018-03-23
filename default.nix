{ mkDerivation, base, ecstasy, gloss, linear, stdenv, transformers, darwin, containers, flamegraph, ghc-prof-flamegraph
}:
mkDerivation {
  pname = "arkmonoid";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildDepends = (if stdenv.isDarwin then [ darwin.apple_sdk.frameworks.OpenGL flamegraph ghc-prof-flamegraph ] else [flamegraph ghc-prof-flamegraph]);
  executableHaskellDepends = [
    base ecstasy gloss linear transformers containers
  ];
  license = stdenv.lib.licenses.bsd3;
}
