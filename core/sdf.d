import vector;

interface SDF {
	double sdf(const vec3 point) const @nogc;
}

vec3 computeNormal(const SDF s, const vec3 point) @nogc {
	immutable double delta = 1e-6;
	double sP = s.sdf(point);
	double sDx = s.sdf(point + vec3(delta, 0, 0));
	double sDy = s.sdf(point + vec3(0, delta, 0));
	double sDz = s.sdf(point + vec3(0, 0, delta));
	
	double x = (sDx - sP)/delta;
	double y = (sDy - sP)/delta;
	double z = (sDz - sP)/delta;
	
	return vec3(x, y, z);
}
