import image;
import ppm;
import vector;
import ray;

import std.stdio;

class SceneComponent {
	//dummy class to ensure that all objects inside a scene
	//decend from SceneComponent
}

class Scene {
private:
	SceneComponent[string] components;
	Ray camera;

public:
	this() {
		camera = Ray(vec3(0.0,0.0,0.0), vec3(0.0,0.0,1.0));
	}

	this(SceneComponent[string] components) {
		this();
		this.components = components;
	}
	
	this(SceneComponent[string] components, Ray camera) {
		this(components);
		this.camera = camera;
	}
	
	void setCamera(Ray camera) { this.camera = camera; }
	Ray getCamera() const { return camera; }
	
	void setComponent(string name, SceneComponent comp) {
		components[name] = comp;
	}
	
	bool removeComponent(string name) {
		return components.remove(name);
	}
	
	SceneComponent getComponent(string name) {
		return components[name];
	}
	
	void render(Image i) {
		
	}

}

void main(string[] args)
{
	//test the ppm save function
	//image should be one row of pure r,g,b
	//and one row of pure c,m,y
	PPM i = new PPM(3, 2);
	i.setPixel(0,0, vec3(1.0,0.0,0.0));
	i.setPixel(1,0, vec3(0.0,1.0,0.0));
	i.setPixel(2,0, vec3(0.0,0.0,1.0));
	i.setPixel(0,1, vec3(0.0,1.0,1.0));
	i.setPixel(1,1, vec3(1.0,0.0,1.0));
	i.setPixel(2,1, vec3(1.0,1.0,0.0));
	
	i.save("test.ppm");
}
