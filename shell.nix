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
    alias playground="cd build && cmake .. && make all -j$(nproc) && cd ../playground && ./playground; cd .."
    echo "TIME FOR SOME CMPT485"
  '';
}
