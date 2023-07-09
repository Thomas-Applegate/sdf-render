import vector;

struct Ray
{
public:
	vec3 O;
	vec3 D;

	this(const vec3 o, const vec3 d) @nogc
	{
		O = o;
		D = d;
		D.makeUnitVector;
	}

	vec3 origin() const @nogc { return O; }
	vec3 direction() const @nogc { return D; }
	vec3 pointAtDistance(double t) const @nogc { return O + t * D; }
}
