import std.stdio;
import std.file;

import image;
import vector;

class PPM : Image {
private:

	vec3[] pixels;
	uint width;
	uint height;

public:
	this(uint width, uint height) {
		this.width = width;
		this.height = height;
		pixels = new vec3[](width * height);
	}
	
	this(uint height, double aspectRatio) {
		this(cast(uint)(aspectRatio * cast(double)height + 0.5), height);
	}

	uint getWidth() const {
		return width;
	}
	
	uint getHeight() const {
		return height;
	}
	
	void save(string filename) const {
		File fout = File(filename, "w");
		scope(exit) fout.close();
		
		//write header
		fout.writeln("P3");
		fout.writeln(width, " ", height);
		fout.writeln("255");
		foreach(vec3 pixel ; pixels) {
			ubyte r = cast(ubyte) (255.999 * pixel.r);
			ubyte g = cast(ubyte) (255.999 * pixel.g);
			ubyte b = cast(ubyte) (255.999 * pixel.b);
			fout.writeln(r, " ", g, " ", b);
		}
	}
	
	@safe vec3 getPixel(uint x, uint y) const {
		return pixels[width * y + x];
	}
	
	@safe void setPixel(uint x, uint y, const vec3 p) {
		pixels[width * y + x] = p;
	}
	
	void clear(const vec3 p){
		foreach(ref vec3 pixel ; pixels) {
			pixel = p;
		}
	}
}
