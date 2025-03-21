{
  stdenv,
  lib,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "forkstat";
  version = "0.03.02";

  src = fetchFromGitHub {
    owner = "ColinIanKing";
    repo = "forkstat";
    rev = "V${version}";
    hash = "sha256-lwJIs5knNzkwgIkSdMSVVtrzqnxGy6uOTKsBDkS3xy4=";
  };

  installFlags = [
    "BINDIR=${placeholder "out"}/bin"
    "MANDIR=${placeholder "out"}/share/man/man8"
    "BASHDIR=${placeholder "out"}/share/bash-completion/completions"
  ];

  meta = with lib; {
    description = "Process fork/exec/exit monitoring tool";
    mainProgram = "forkstat";
    homepage = "https://github.com/ColinIanKing/forkstat";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ womfoo ];
  };
}
