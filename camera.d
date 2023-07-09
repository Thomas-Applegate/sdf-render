import vector;
import ray;

struct Camera {
	vec3 pos;
	double hfov;
	double yaw;
	double pitch;
	double roll;
	
	this(vec3 pos, double hfov, double yaw, double pitch, double roll) {
		this.pos = pos;
		this.hfov = hfov;
		this.yaw = yaw;
		this.pitch = pitch;
		this.roll = roll;
	}
}
