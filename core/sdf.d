import vector;

interface SDF {
	double sdf(const vec3 point) const @nogc;
	vec3 sdfNormal(const vec3 point) const @nogc;
}
