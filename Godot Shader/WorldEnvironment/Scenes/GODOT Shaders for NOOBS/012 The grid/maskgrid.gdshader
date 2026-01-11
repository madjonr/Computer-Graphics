shader_type spatial;
render_mode cull_disabled, unshaded;

uniform int size: hint_range(0, 10, 1) = 5;


void fragment() {
	// Called for every pixel the material is visible on.
	float s = float(size);
	vec2 igrid = floor(UV * s) / s;
	ALBEDO = vec3(igrid.x * igrid.y);
}