shader_type spatial;
render_mode unshaded, cull_disabled;
#include "funcs.gdshaderinc"

uniform int size: hint_range(0, 10, 1) = 5;


void fragment() {
	// Called for every pixel the material is visible on.
	float s = float(size);
	vec2 igrid = floor(UV * s) / s;
	float rand = random(igrid);
	
	ALBEDO = vec3(rand);
	
}

