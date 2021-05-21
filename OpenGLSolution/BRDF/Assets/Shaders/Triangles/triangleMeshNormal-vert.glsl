#version 450

layout(location = 0) in vec3 vPosition;
layout(location = 1) in vec3 vNormal;

subroutine vec3 brdfType(vec3 L, vec3 N, vec3 V, vec3 X, vec3 Y);
subroutine uniform brdfType brdfUniform;

// Matrices
uniform mat4 mModelView;
uniform mat4 mModelViewProj;

out vec3 normal;

INCLUDE BRDF

subroutine(brdfType)
vec3 noBRDF(vec3 L, vec3 N, vec3 V, vec3 X, vec3 Y)
{
	return vPosition;
}

void main()
{
	const vec3 L = normalize(vec3(.0f, 1.0f, .0f));
	const vec3 V = normalize(vec3(1.0f, 1.0f, .0f));
	const vec3 vertexPosition = brdfUniform(L, normalize(vPosition), V, vec3(.0f), vec3(.0f));

	gl_Position = mModelViewProj * vec4(vertexPosition, 1.0f);
	normal = vec3(mModelView * vec4(vNormal, 0.0f));
}