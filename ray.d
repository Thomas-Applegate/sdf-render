import vector;

struct Ray
{
public:
	vec3 Or;
	vec3 Dir;

	this(const vec3 o, const vec3 d) @nogc
	{
		Or = o;
		Dir = d;
		Dir.makeUnitVector;
	}

	vec3 origin() const @nogc { return Or; }
	vec3 direction() const @nogc { return Dir; }
	vec3 pointAtDistance(double t) const @nogc { return Or + t * Dir; }
}
