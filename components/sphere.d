import scene;
import vector;
import renderable;
import sdf;
import material;

class Sphere : SceneComponent, Renderable {
private:
	vec3 position;
	double radius;
	Material mat;

public:
	this(vec3 pos, double radius, Material mat) {
		this.position = pos;
		this.radius = radius;
		this.mat = mat;
	}
	
	void setPosition(const vec3 position){ this.position = position; }
	vec3 getPosition() const { return position; }
	
	void setRadius(double radius) { this.radius = radius; }
	double getRadius() const { return radius; }
	
	void setMaterial(Material mat) { this.mat = mat; }
	Material getMaterial() { return mat; }
	
	double sdf(const vec3 point) const @nogc {
		vec3 t = point - position;
		return t.length - radius;
	}
}
