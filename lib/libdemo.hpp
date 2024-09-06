#ifndef LIBDEMO_H
#define LIBDEMO_H

#include <GL/glew.h>

GLuint LoadShaders(const char * vertex_file_path,const char * fragment_file_path);

// from common/texture.cpp
GLuint loadBMP_custom(const char * imagepath);



#endif // LIBDEMO_H