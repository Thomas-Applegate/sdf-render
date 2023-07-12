import vector;
import ray;
import image;
import std.math;

struct Camera {
private:
	vec3 lower_left_corner;
	vec3 horizontal;
	vec3 vertical;
public:
	vec3 origin;
	double vfov;

	this(vec3 origin, double vfov) @nogc {
		this.origin = origin;
		this.vfov = vfov;
	}
	
	//must be called before computing view rays because theese
	//divisions really only need to be done once
	void cacheImageInfo(const Image i) @nogc {
		double theta = vfov * PI/180;
		double h = tan(theta/2);
		double viewport_height = 2.0 * h;
		double viewport_width = i.getAspectRatio * viewport_height;

		double focal_length = 1.0;

		horizontal = vec3(viewport_width, 0.0, 0.0);
		vertical = vec3(0.0, viewport_height, 0.0);
		lower_left_corner = origin - (horizontal/2) - (vertical/2) - vec3(0, 0, -focal_length);
	}
	
	Ray computeRay(double u, double v) const @nogc {
		return Ray(origin, (lower_left_corner + u*horizontal + v*vertical) - origin);
	}
}
