import vector;

interface Image {
	uint getWidth() const @nogc;
	uint getHeight() const @nogc;
	final double getAspectRatio() const @nogc {
		return cast(double)getWidth() / cast(double)getHeight();
	}
	void save(string filename) const;
	vec3 getPixel(uint x, uint y) const;
	void setPixel(uint x, uint y, const vec3 p);
}
