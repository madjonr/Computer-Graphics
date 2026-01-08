shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D logo_tex;

// UV坐标转极坐标
vec2 polar_coordinates(vec2 uv, vec2 center){
	vec2 dir = uv - center;
	float radius = length(dir) * 2.0;
	float angle = atan(dir.y, dir.x)  / TAU;
	return fract(vec2(radius, angle));
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 polar_uv = polar_coordinates(UV, vec2(0.5));
	ALBEDO = texture(logo_tex, polar_uv).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
