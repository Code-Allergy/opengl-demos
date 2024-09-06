# CMake entry point
cmake_minimum_required (VERSION 3.10)
project (Samples)

find_package(OpenGL REQUIRED)
set (CMAKE_CXX_STANDARD 11)

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


# compile libdemo
add_subdirectory (lib)

include_directories(
	external/AntTweakBar-1.16/include/
	external/glfw-3.1.2/include/
	external/glm-0.9.7.1/
	external/glew-1.13.0/include/
	external/assimp-3.0.1270/include/
	external/bullet-2.81-rev2613/src/
    lib/
	.
)

set(ALL_LIBS
	${OPENGL_LIBRARY}
	glfw
	GLEW_1130
	demo
)

add_definitions(
	-DTW_STATIC
	-DTW_NO_LIB_PRAGMA
	-DTW_NO_DIRECT3D
	-DGLEW_STATIC
	-D_CRT_SECURE_NO_WARNINGS
)

## PLAYGROUND
# Create new variants in playground, then snapshot them into demos with the snapshot bash function.
add_executable(playground
    playground/main.cpp
)
target_link_libraries(playground
    ${ALL_LIBS}
)
add_custom_command(
   TARGET playground POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/playground${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/playground/"
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
)
target_link_libraries(demo06_cube_random_colours
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo06_cube_random_colours POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo06_cube_random_colours${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo06_cube_random_colours/"
)
############################################################################
# Demo 7: cube_random_colours_cycling
############################################################################
add_executable(demo07_cube_random_colours_cycling
    demo07_cube_random_colours_cycling/demo07.cpp
)
target_link_libraries(demo07_cube_random_colours_cycling
    ${ALL_LIBS}
)
add_custom_command(
   TARGET demo07_cube_random_colours_cycling POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo07_cube_random_colours_cycling${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo07_cube_random_colours_cycling/"
)
############################################################################
# Demo 8: cube_texture_bmp
############################################################################
add_executable(demo08_cube_texture_bmp
    demo08_cube_texture_bmp/demo08.cpp
)
target_link_libraries(demo08_cube_texture_bmp
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo08_cube_texture_bmp POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo08_cube_texture_bmp${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo08_cube_texture_bmp/"
)
############################################################################
# Demo 9: cube_texture_dds
############################################################################
add_executable(demo09_cube_texture_dds
    demo09_cube_texture_dds/demo09.cpp
)
target_link_libraries(demo09_cube_texture_dds
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo09_cube_texture_dds POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo09_cube_texture_dds${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo09_cube_texture_dds/"
)
############################################################################
# Demo 10: cube_keyboard_mouse
############################################################################
add_executable(demo10_cube_keyboard_mouse
    demo10_cube_keyboard_mouse/demo10.cpp
)
target_link_libraries(demo10_cube_keyboard_mouse
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo10_cube_keyboard_mouse POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo10_cube_keyboard_mouse${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo10_cube_keyboard_mouse/"
)
############################################################################
# Demo 11: cube_keyboard_mouse_capped_vangle
############################################################################
add_executable(demo11_cube_keyboard_mouse_capped_vangle
    demo11_cube_keyboard_mouse_capped_vangle/demo11.cpp
)
target_link_libraries(demo11_cube_keyboard_mouse_capped_vangle
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo11_cube_keyboard_mouse_capped_vangle POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo11_cube_keyboard_mouse_capped_vangle${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo11_cube_keyboard_mouse_capped_vangle/"
)
############################################################################
# Demo 12: cube_spinning
############################################################################
add_executable(demo12_cube_spinning
    demo12_cube_spinning/demo12.cpp
)
target_link_libraries(demo12_cube_spinning
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo12_cube_spinning POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo12_cube_spinning${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo12_cube_spinning/"
)
############################################################################
# Demo 13: cube_spinning_double
############################################################################
add_executable(demo13_cube_spinning_double
    demo13_cube_spinning_double/demo13.cpp
)
target_link_libraries(demo13_cube_spinning_double
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo13_cube_spinning_double POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo13_cube_spinning_double${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo13_cube_spinning_double/"
)
############################################################################
# Demo 14: cube_camera_rotation_fixed
############################################################################
add_executable(demo14_cube_camera_rotation_fixed
    demo14_cube_camera_rotation_fixed/demo14.cpp
)
target_link_libraries(demo14_cube_camera_rotation_fixed
    ${ALL_LIBS}
)
add_custom_command(
    TARGET demo14_cube_camera_rotation_fixed POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/demo14_cube_camera_rotation_fixed${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/demo14_cube_camera_rotation_fixed/"
)
############################################################################