shader_type spatial;
render_mode unshaded, cull_disabled;
#include "funcs.gdshaderinc"

uniform int size: hint_range(0, 50, 1) = 10;


void fragment() {
	// Called for every pixel the material is visible on.
	float s = float(size);
	vec2 igrid = floor(UV * s) / s;
	float tri = polygon(igrid, 0.5, 3);
	
	ALBEDO = vec3(tri);
	
}

