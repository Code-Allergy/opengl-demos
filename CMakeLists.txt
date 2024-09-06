# CMake entry point
cmake_minimum_required (VERSION 3.10)
project (Samples)

find_package(OpenGL REQUIRED)

if( CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR )
    message( FATAL_ERROR "Please select another Build Directory ! (and give it a clever name, like bin_Visual2012_64bits/)" )
endif()
if( CMAKE_SOURCE_DIR MATCHES " " )
	message( "Your Source Directory contains spaces. If you experience problems when compiling, this can be the cause." )
endif()
if( CMAKE_BINARY_DIR MATCHES " " )
	message( "Your Build Directory contains spaces. If you experience problems when compiling, this can be the cause." )
endif()


# Compile external dependencies 
add_subdirectory (external)

include_directories(
	external/AntTweakBar-1.16/include/
	external/glfw-3.1.2/include/
	external/glm-0.9.7.1/
	external/glew-1.13.0/include/
	external/assimp-3.0.1270/include/
	external/bullet-2.81-rev2613/src/
	.
)

set(ALL_LIBS
	${OPENGL_LIBRARY}
	glfw
	GLEW_1130
)

add_definitions(
	-DTW_STATIC
	-DTW_NO_LIB_PRAGMA
	-DTW_NO_DIRECT3D
	-DGLEW_STATIC
	-D_CRT_SECURE_NO_WARNINGS
)
#############################################
### 		  START OF DEMOS			  ###
#############################################

# Demo 0: Create a basic window. (Tutorial 01)
add_executable(demo00_first_window
    demo00_first_window/demo00.cpp
)
target_link_libraries(demo00_first_window
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo00_first_window POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo00_first_window${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo00_first_window/"
)

# Demo 1: Create a red triangle covering most of the screen. (Tutorial 02)
add_executable(demo01_triangle
    demo01_triangle/demo01.cpp
	common/shader.cpp
	common/shader.hpp
)
target_link_libraries(demo01_triangle
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo01_triangle POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo01_triangle${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo01_triangle/"
)

# Demo 2: Create a red triangle, and apply a matrix transformation to it (Tutorial 03)
add_executable(demo02_triangle_transformations
    demo02_triangle_transformations/demo02.cpp
	common/shader.cpp
	common/shader.hpp
)
target_link_libraries(demo02_triangle_transformations
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo02_triangle_transformations POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo02_triangle_transformations${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo02_triangle_transformations/"
)

# Demo 3: triangle_transformations_ortho
############################################################################
add_executable(demo03_triangle_transformations_ortho
    demo03_triangle_transformations_ortho/demo03.cpp
    common/shader.cpp
    common/shader.hpp
)
target_link_libraries(demo03_triangle_transformations_ortho
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo03_triangle_transformations_ortho POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo03_triangle_transformations_ortho${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo03_triangle_transformations_ortho/"
)

############################################################################
# Demo 4: cube
############################################################################
add_executable(demo04_cube
    demo04_cube/demo04.cpp
    common/shader.cpp
    common/shader.hpp
)
target_link_libraries(demo04_cube
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo04_cube POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo04_cube${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo04_cube/"
)
############################################################################
# Demo 5: A cube and a triangle rendered at the same time, with two different MVP matrices
############################################################################
add_executable(demo05_cube_triangle
demo05_cube_triangle/demo05.cpp
common/shader.cpp
common/shader.hpp
)
target_link_libraries(demo05_cube_triangle
${ALL_LIBS}
)
add_custom_command(
TARGET demo05_cube_triangle POST_BUILD
COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo05_cube_triangle${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo05_cube_triangle/"
)
############################################################################
# Demo 6: A cube with random colours, generated at runtime on each run.
############################################################################
add_executable(demo06_cube_random_colours
    demo06_cube_random_colours/demo06.cpp
    common/shader.cpp
    common/shader.hpp
)
target_link_libraries(demo06_cube_random_colours
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo06_cube_random_colours POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo06_cube_random_colours${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo06_cube_random_colours/"
)
############################################################################