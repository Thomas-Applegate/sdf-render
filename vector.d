import std.stdio;
import std.math;

struct vec3
{
public:
	double[3] e;
	
	this (double e0, double e1, double e2) @nogc
	{
		e[0] = e0;
		e[1] = e1;
		e[2] = e2;
	}

	pragma(inline, true) float x() const @nogc { return e[0]; }
	pragma(inline, true) float y() const @nogc { return e[1]; }
	pragma(inline, true) float z() const @nogc { return e[2]; }
	pragma(inline, true) float r() const @nogc { return e[0]; }
	pragma(inline, true) float g() const @nogc { return e[1]; }
	pragma(inline, true) float b() const @nogc { return e[2]; }

	@nogc double* opUnary(string s)() if (s == "+") 
	{ 
		return &this; 
	}
	@nogc vec3 opUnary(string s)() if (s == "-") 
	{ 
		return vec3(-e[0], -e[1], -e[2]); 
	}

	@nogc double opIndex(size_t i) { return e[i]; }

	@nogc size_t dimension() const { return e.length; }

	@nogc vec3 opBinary(string op)(const vec3 rhs) const
	{ 
		mixin("return vec3(e[0] "~op~" rhs.e[0],"
							~"e[1] "~op~" rhs.e[1],"
							~"e[2] "~op~" rhs.e[2]);");
	}

	@nogc vec3 opBinary(string op)(const double scalar) const
	{
		mixin("return vec3(e[0] "~op~" scalar, "
							~"e[1] "~op~" scalar, "
							~"e[2] "~op~" scalar);");
	}
	
	@nogc vec3 opBinaryRight(string op)(const double scalar) const
	{
		mixin("return vec3(e[0] "~op~" scalar, "
							~"e[1] "~op~" scalar, "
							~"e[2] "~op~" scalar);");
	}

	@nogc void opOpAssign(string op)(const vec3 rhs)
	{
		mixin("e[0] "~op~"= rhs.e[0];"
			 ~"e[1] "~op~"= rhs.e[1];"
			 ~"e[2] "~op~"= rhs.e[2];");
	}

	@nogc void opOpAssign(string op)(const double scalar)
		if (op == "*" || op == "/")
	{
		mixin("e[0] "~op~"= scalar;"
			 ~"e[1] "~op~"= scalar;"
			 ~"e[2] "~op~"= scalar;");
	}
	
	@nogc double length() const {
		return sqrt(e[0] * e[0] + e[1] * e[1] + e[2] * e[2]);
	}

	@nogc double squaredLength() const
	{
		return e[0]*e[0] + e[1]*e[1] + e[2]*e[2];
	}

	@nogc void makeUnitVector()
	{
		double k = 1.0 / length();
		e[0] *= k; e[1] *= k; e[2] *= k;
	}
}

double dot(const vec3 v1, const vec3 v2) @nogc
{
	return v1.e[0] * v2.e[0] + v1.e[1] * v2.e[1] + v1.e[2] * v2.e[2];
}

vec3 cross(const vec3 v1, const vec3 v2) @nogc
{
	return vec3(v1.e[1] * v2.e[2] - v1.e[2] * v2.e[1],
				   v1.e[2] * v2.e[0] - v1.e[0] * v2.e[2],
				   v1.e[0] * v2.e[1] - v1.e[1] * v2.e[0]);
}

vec3 unitVector(vec3 v1) @nogc
{
	return vec3(v1[0] / v1.length, v1[1] / v1.length, v1[2] / v1.length);
}

vec3 reflect(const vec3 v, const vec3 n) @nogc
{
	return v - 2.0 * dot(v, n) * n;
}

//y is up, x is left right, z is forward back
//theta and phi are in degrees
//theta is measured from +x counterclockwise
//phi is measured from the x axis going plus or minus 90 degrees up or down
vec3 sphereCoord(double theta, double phi) @nogc {
	theta *= 180/PI;
	phi *= 180/PI;
	return vec3(cos(phi)*cos(theta), sin(phi), cos(phi)*sin(theta));
}
