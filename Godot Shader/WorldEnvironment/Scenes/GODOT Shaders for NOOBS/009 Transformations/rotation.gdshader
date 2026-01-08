shader_type spatial;
render_mode cull_disabled, unshaded;

#include "funcs.gdshaderinc"


void fragment() {
	// Called for every pixel the material is visible on.
	vec2 rotation_uv = rotate(UV, vec2(0.5, 0.5), TIME);
	float poly = polygon(rotation_uv, 0.4, 5);
	ALBEDO = vec3(poly);
}
