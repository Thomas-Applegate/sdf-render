import scene;
import vector;
import sdf;
import scene;

class Sphere : SceneComponent, Renderable {
public:
	vec3 position;
	double radius;
	vec3 color;
	
	this(vec3 pos, double radius, vec3 color) {
		this.position = pos;
		this.radius = radius;
		this.color = color;
	}
	
	void setColor(vec3 color) { this.color = color; }
	vec3 getColor() const { return color; }
	
	void setPosition(vec3 position){ this.position = position; }
	vec3 getPosition() const { return position; }
	
	void setRadius(double radius) { this.radius = radius; }
	double getRadius() const { return radius; }
	
	double sdf(const vec3 point) const {
		vec3 t = point + position;
		return t.length - radius;
	}
	
	Material getMaterial() const { return new Material; }
}
