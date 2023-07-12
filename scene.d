import image;
import ppm;
import vector;
import ray;
import camera;
import sphere;
import material;
import renderable;
import sdf;
import hit_info;
import plane;

import std.stdio;
import std.math;
import std.algorithm.searching;

class SceneComponent {
	//dummy class to ensure that all objects inside a scene
	//decend from SceneComponent
}

class Scene {
private:
	SceneComponent[string] components;
	Camera cam;

	long marchRay(SDF[] sdfs, double[] distArr, const Ray r, double maxDist, out HitInfo h) @nogc
	in(sdfs.length == distArr.length)
	out(ret; ret >= 0)
	{
		double distAcc = 0.0;
		uint stepAcc = 0;
		long outIndex;
		vec3 currentPoint = r.origin;
		immutable double epsilon = 1e-9;
		
		while(distAcc <= maxDist && stepAcc <= 1000) {
			//march
			foreach(i, s ; sdfs) {
				distArr[i] = s.sdf(currentPoint);
			}
			outIndex = distArr.minIndex;
			
			//march current point along ray by min distance
			distAcc += distArr[outIndex];
			currentPoint = r.pointAtDistance(distAcc);
			
			stepAcc++;
			
			//check if abs(min distance) <= epsilon. if so we hit and break
			//otherwise keep marching
			if(abs(distArr[outIndex]) <= epsilon) {//hit
				h.hit = true;
				h.point = currentPoint;
				h.normal = computeNormal(sdfs[outIndex], currentPoint);
				break;
			}
		}
		
		return outIndex;
	}

public:
	this() {
		cam = Camera(vec3(0.0,0.0,0.0), 80, 90, 0);
	}

	this(SceneComponent[string] components) {
		this();
		this.components = components;
	}
	
	this(SceneComponent[string] components, Camera camera) {
		this(components);
		this.cam = camera;
	}
	
	void setCamera(Camera camera) { this.cam = camera; }
	Camera getCamera() const { return cam; }
	
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
		cam.cacheImageInfo(i);
		
		//build renderable array
		Renderable[] renderables;
		foreach(k, v ; components) {
			Renderable r = cast(Renderable)v;
			if(r !is null) {
				renderables ~= r;
			}
		}
		
		//make distance array to be reused for each pixel
		double[] distArr = new double[](renderables.length);
		
		//loop through all camera rays
		for(uint y = 0; y < i.getHeight; y++) {
			for(uint x = 0; x < i.getWidth; x++) {
				Ray r = cam.computeRay(i, x, y);
				
				HitInfo h;
				long index = marchRay(cast(SDF[])renderables, distArr, r, 150, h);
				
				if(h.hit) {
					vec3 color = renderables[index].getMaterial.getColor;
					i.setPixel(x, y, color);
				}else {
					i.setPixel(x, y, vec3(0.0, 0.0, 0.0));
				}
			}
		}
	}

}

void main(string[] args)
{	
	PPM i = new PPM(512, 1.9);
	Scene s = new Scene();
	
	Sphere cSphere = new Sphere(vec3(2, 1, 5), 1.0, new Material(vec3(0.0, 0.95, 0.95)));
	s.setComponent("c-sphere", cSphere);
	
	Sphere ySphere = new Sphere(vec3(-2, 1, 7), 1.0, new Material(vec3(0.95,0.95,0)));
	s.setComponent("y-sphere", ySphere);
	
	s.render(i);
	i.save("render.ppm");
}
