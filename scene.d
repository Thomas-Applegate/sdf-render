import ppm;
import vector;
import ray;

import std.stdio;

class SceneComponent {
	
}

class Scene {
	
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
	
	i.save("image-test.ppm");
}
