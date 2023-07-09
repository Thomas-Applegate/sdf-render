import vector;

interface Image {
	uint getWidth() const;
	uint getHeight() const;
	void save(string filename) const;
	vec3 getPixel(uint x, uint y) const;
	void setPixel(uint x, uint y, const vec3 p);
}
