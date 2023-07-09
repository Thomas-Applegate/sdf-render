import vector;

class Material {
private:
	vec3 color;
	
public:
	this(const vec3 color) {
		this.color = color;
	}
	
	vec3 getColor() const { return color; }
	void setColor(const vec3 color) { this.color = color; }
}
