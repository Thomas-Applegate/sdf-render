import vector;
import sdf;
import renderable;
import material;
import scene;

class Plane : SceneComponent, Renderable {
private:
	vec3 normal;
	double offset;
	Material mat;

public:
	this(vec3 normal, double offset, Material mat) {
		this.normal = normal;
		this.normal.makeUnitVector;
		this.offset = offset;
		this.mat = mat;
	}
	
	void setNormal(const vec3 normal){
		this.normal = normal; 
		this.normal.makeUnitVector;
	}
	vec3 getNormal() const { return normal; }
	
	void setOffset(double offset) { this.offset = offset; }
	double getOffset() const { return offset; }
	
	void setMaterial(Material mat) { this.mat = mat; }
	Material getMaterial() { return mat; }
	
	double sdf(const vec3 point) const @nogc {
		return dot(point, normal) + offset;
	}
}
