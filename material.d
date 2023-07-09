import sdf;
import vector;

interface Material : SDF {
	vec3 getColor() const;
}
