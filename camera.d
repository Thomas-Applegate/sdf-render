import vector;
import ray;
import image;

struct Camera {
	vec3 pos;
	double hfov;
	double yaw;
	double pitch;
	
	//cached image info
	double vfov;
	double xlowbound;
	double xhighbound;
	double ylowbound;
	double yhighbound;
	
	this(vec3 pos, double hfov, double yaw, double pitch) {
		this.pos = pos;
		this.hfov = hfov;
		this.yaw = yaw;
		this.pitch = pitch;
	}
	
	//must be called before computing view rays because theese
	//divisions really only need to be done once
	void cacheImageInfo(const Image i) {
		vfov = hfov / i.getAspectRatio;
		xlowbound = yaw + hfov/2;
		xhighbound = yaw - hfov/2;
		ylowbound = pitch + vfov/2;
		yhighbound = pitch - vfov/2;
	}
	
	Ray computeRay(Image i, uint x, uint y){
		//compute theta
		double theta;
		double p = x/i.getWidth;
		theta = (1.0 - p) * xlowbound + xhighbound * p;
		
		//compute phi;
		double phi;
		p = y/i.getHeight;
		phi = (1.0 - p) * ylowbound + yhighbound * p;
		
		return Ray(pos, sphereCoord(theta, phi));
	}
}
