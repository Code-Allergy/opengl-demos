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
        alias build="mkdir -p build && cd build && cmake .. && make all -j$(nproc) && cd .."


        function run() {
          if [ ! -d "build" ]; then
            echo "Please build project first"
            return -1
          fi

          if [[ ! "$1" =~ ^[0-9]+$ ]]; then
              echo "Error: Please provide a valid number."
              return 1
          fi

          padded_num=$(printf "%02d" "$1")

          demo_folder=$(find . -maxdepth 1 -type d -name "demo''${padded_num}_*" | head -n 1)

          if [ -z "$demo_folder" ]; then
            echo "Error: No demo folder found for number $1"
            return 1
          fi

          folder_name=$(basename "$demo_folder")

          if [ -x "$demo_folder/$folder_name" ]; then
            echo "Running $folder_name"
            cd "$demo_folder" && ./$folder_name && cd ..
          else
            echo "Error: Binary $folder_name not found or not executable in $demo_folder"
            return 1
          fi
        }

        function brun() {
          build && run "$1"
        }

        function gen-demo() {
          padded_num=$(printf "%02d" "$1")
          demo_name="demo''${padded_num}_$2"

          read -p "Create folder $demo_name? (y/n): " -n 1 -r
          echo
          if [[ $REPLY =~ ^[Yy]$ ]]
          then
              mkdir -p "$demo_name"
              echo "Folder $demo_name created."
          else
              echo "Folder creation skipped."
          fi

        cat << EOF
    -------------------COPY HERE------------------------
    # Demo $1: $2
    ############################################################################
    add_executable($demo_name
        $demo_name/demo''${padded_num}.cpp
        common/shader.cpp
        common/shader.hpp
    )
    target_link_libraries($demo_name
        \''${ALL_LIBS}
    )
    add_custom_command(
       TARGET $demo_name POST_BUILD
       COMMAND \''${CMAKE_COMMAND} -E copy "\''${CMAKE_CURRENT_BINARY_DIR}/\''${CMAKE_CFG_INTDIR}/''${demo_name}\''${CMAKE_EXECUTABLE_SUFFIX}" "\''${CMAKE_CURRENT_SOURCE_DIR}/''${demo_name}/"
    )
    ############################################################################
    -------------------COPY HERE------------------------
    EOF
        }
  '';
}
