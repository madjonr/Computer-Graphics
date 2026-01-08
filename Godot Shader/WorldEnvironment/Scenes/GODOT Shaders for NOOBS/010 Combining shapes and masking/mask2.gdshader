shader_type spatial;
render_mode unshaded, cull_disabled;

#include "funcs.gdshaderinc"

uniform sampler2D logo1_tex: filter_linear, source_color;
uniform vec3 color: source_color;

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 logo1 = texture(logo1_tex, UV).rgb;
	vec2 rotation_uv = rotate(UV, vec2(0.5), TAU/4.0);
	vec3 logo2 = texture(logo1_tex, rotation_uv).rgb;
	logo2 = (logo2.r + logo2.g + logo2.b)/3.0 * color;

	vec2 cartesian_uv = UV * 2.0 - 1.0;
	float df = abs(cartesian_uv.x);
	float mask = step(abs(sin(TIME)), df);
	vec3 interpolation = mix(logo1, logo2, mask);
	ALBEDO = interpolation;
}