{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    cmake
    gnumake
    gcc
    xorg.libX11
    xorg.libXi
    libGL
    libGLU
    xorg.libXrandr
    xorg.libXext
    xorg.libXcursor
    xorg.libXinerama
  ];

  shellHook = ''
    if [ -f ./setup.sh ]; then
      source ./setup.sh
    else
      echo "setup.sh not found!"
    fi

    echo "Environment ready! Run 'brun XX' to run any demo."
  '';
}
