shader_type spatial;
render_mode unshaded;
render_mode cull_disabled;

uniform float round_radius: hint_range(0.0, 1.0, 0.1) = 0.2;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// 绘制圆形
	vec2 center = vec2(0.5, 0.5);
	float dis = distance(UV, center);
	dis = step(round_radius, dis);
	ALBEDO = vec3(dis);
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
