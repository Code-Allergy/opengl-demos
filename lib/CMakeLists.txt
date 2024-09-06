cmake_minimum_required(VERSION 3.10)
# Define the library
add_library(demo STATIC
    libdemo.cpp
)

include_directories(
	../external/AntTweakBar-1.16/include/
	../external/glfw-3.1.2/include/
	../external/glm-0.9.7.1/
	../external/glew-1.13.0/include/
	../external/assimp-3.0.1270/include/
	../external/bullet-2.81-rev2613/src/
	.
)

find_package(OpenGL REQUIRED)
target_link_libraries(demo PRIVATE ${OPENGL_LIBRARIES})
