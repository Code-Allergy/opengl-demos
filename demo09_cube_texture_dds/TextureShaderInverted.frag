#version 330 core

in vec2 UV;
out vec3 color;

// Values that stay constant for the whole mesh.
uniform sampler2D myTextureSampler;

void main() {
	vec2 invertedUV = vec2(UV.x, 1.0 - UV.y);
    color = texture( myTextureSampler, invertedUV ).rgb;
}