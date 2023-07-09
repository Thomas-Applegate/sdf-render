import vector;

interface Image {
	uint getWidth() const;
	uint getHeight() const;
	final double getAspectRatio() const {
		return cast(double)getWidth() / cast(double)getHeight();
	}
	void save(string filename) const;
	vec3 getPixel(uint x, uint y) const;
	void setPixel(uint x, uint y, const vec3 p);
}
