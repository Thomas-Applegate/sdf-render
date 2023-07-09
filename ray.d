import vector;

struct ray
{
public:
	vec3 O;
	vec3 D;

	this(const vec3 o, const vec3 d)
	{
		O = o;
		D = d;
	}

	vec3 origin() const { return O; }
	vec3 direction() const { return D; }
	vec3 pointAtParameter(double t) const { return O + t * D; }
}
