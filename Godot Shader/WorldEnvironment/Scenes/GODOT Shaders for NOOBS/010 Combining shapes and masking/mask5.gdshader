shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_always;

#include "funcs.gdshaderinc"

uniform sampler2D logo1_tex: filter_linear, source_color;
uniform vec3 color: source_color = vec3(1.0, 0.5, 0.0);

void fragment() {
	// Called for every pixel the material is visible on.
	//vec2 polar_uv = polar_coordinates(UV, vec2(0.5));
	////float rays = sin(polar_uv.x * 100.0);
	//float rays = step(0.5, sin(polar_uv.y * 100.0));
	//float cirles = step(0.5, sin(polar_uv.x * 25.0));
	//ALBEDO = vec3(cirles);
	
	//vec2 polar_uv = polar_coordinates(UV, vec2(0.5));
	////float rays = sin(polar_uv.x * 100.0);
	//float rays = step(0.5, sin(polar_uv.y * 100.0));
	//float mask = rays * cirles;
	//ALBEDO = vec3(mask);
	
	vec2 polar_uv = polar_coordinates(UV, vec2(0.5));
	//float rays = sin(polar_uv.x * 100.0);
	polar_uv.y -= TIME * 0.2;
	float rays = step(0.5, sin(polar_uv.y * 100.0));
	float circles = step(0.5, sin(polar_uv.x * 25.0));
	float mask = rays * circles;
	ALBEDO = vec3(mask * color);
	ALPHA = mask;
	EMISSION = vec3(mask * color * 50.0);   // 自发光显示不了，没找到问题
}