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
            echo "No demo folder found for number $1"
            return 2
          fi

          folder_name=$(basename "$demo_folder")

          if [ -x "$demo_folder/$folder_name" ]; then
            if [[ $# -eq 2 && "$2" =~ ^[0-9]+$ ]]; then
              echo "Running $folder_name for $2 seconds"
              cd "$demo_folder" || return 1
              ./$folder_name $2 &
              pid=$!
              sleep $2
              kill $pid > /dev/null 2>&1
              wait $pid > /dev/null 2>&1
              # verify it closed, if it does not, use kill -9
              if ps -p $pid > /dev/null; then
                kill -9 $pid
              fi
              cd ..
            else
              echo "Running $folder_name"
              cd "$demo_folder" || return 1
              ./$folder_name
              cd .. || return 1
            fi
          else
            echo "Error: Binary $folder_name not found or not executable in $demo_folder"
            return 1
          fi
        }

        function brun() {
          build && run "$1" "$2"
        }

        function run_all_demos() {
          local demo_duration=''${1:-10}  # Default to 10 seconds if no argument is provided
          local demo_number=0
          local exit_code=0

          while [ $exit_code -ne 2 ]; do
              echo "Running demo $demo_number"

              # Start the demo
              run $demo_number $demo_duration

              exit_code=$?

              if [ $exit_code -eq 2 ]; then
                  echo "All demos have been run."
                  break
              elif [ $exit_code -ne 0 ]; then
                  echo "Error occurred while running demo $demo_number. Stopping."
                  break
              fi

              ((demo_number++))
          done
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
