shader_type spatial;
render_mode unshaded, cull_disabled;

#include "funcs.gdshaderinc"

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float random_seed = random(UV);
	ALBEDO = vec3(random_seed);
}
