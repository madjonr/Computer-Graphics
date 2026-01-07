shader_type spatial;

render_mode cull_disabled;
render_mode unshaded;

#include "funcs.gdshaderinc"

void fragment() {
	// Called for every pixel the material is visible on.
	float size = abs(sin(TIME));
	vec2 scale_uv = scale(UV, size, size);
	float poly = polygon(scale_uv, 0.2, 5);
	ALBEDO = vec3(poly);
}
