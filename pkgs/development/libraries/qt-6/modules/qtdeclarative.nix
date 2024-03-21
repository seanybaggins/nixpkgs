{ qtModule
, qtbase
, qtlanguageserver
, qtshadertools
, openssl
, stdenv
, python3
, lib
, pkgsBuildBuild
}:

qtModule {
  pname = "qtdeclarative";
  strictDeps = true;
  propagatedBuildInputs = [ qtbase qtlanguageserver qtshadertools openssl ];
  nativeBuildInputs = [ python3 ];
  patches = [
    # prevent headaches from stale qmlcache data
    ../patches/qtdeclarative-default-disable-qmlcache.patch
    # add version specific QML import path
    ../patches/qtdeclarative-qml-paths.patch
  ];
  # Conditional is required to prevent infinate recursion during a cross build
  cmakeFlags = [
    "-DQt6ShaderToolsTools_DIR=${pkgsBuildBuild.qt6.qtshadertools}/lib/cmake/Qt6ShaderTools"
  ]
  # Conditional is required to preveDnt infinate recursion during a cross build
  ++ lib.optionals (!stdenv.buildPlatform.canExecute stdenv.hostPlatform) [
    "-DQt6QmlTools_DIR=${pkgsBuildBuild.qt6.qtdeclarative}/lib/cmake/Qt6QmlTools"
  ];
}
