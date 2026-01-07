shader_type spatial;
render_mode cull_disabled;
render_mode unshaded; 

#include "funcs.gdshaderinc"



void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//vec2 tranform_uv = UV + vec2(0.1);
	vec2 tranform_uv = UV + sin(TIME)/2.0;
	float poly = polygon(tranform_uv, 0.3, 5);
	ALBEDO = vec3(poly);
}
