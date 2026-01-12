shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D albedo: source_color;
uniform vec2 center = vec2(0.5);
uniform float force: hint_range(0.0, 1.0, 0.01);
uniform float mask_thickness: hint_range(0.0, 0.5);


float circle(vec2 uv, float diamater, float feather){
	float radius = diamater / 2.0;
	return smoothstep(radius, radius + feather, length(uv - vec2(0.5)));
}


float donut(vec2 uv, float size, float thickness, float feather){
	float c_in = circle(uv, size - thickness, feather);
	float c_out = circle(uv, size, feather);
	return (1.0 - c_out) - (1.0 - c_in);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 disp = normalize(UV - center) * force;
	vec2 distortion = UV - disp;
	float mask_size = mod(TIME, 2.0);
	float mask_donut = donut(UV, mask_size, mask_thickness, 0.1);
	distortion = mix(UV, distortion, mask_donut);
	ALBEDO = texture(albedo, distortion).rgb;
}

