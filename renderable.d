import sdf;
import material;

interface Renderable : SDF {
	Material getMaterial();
	void setMaterial(Material mat);
}
