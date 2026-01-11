shader_type spatial;
render_mode unshaded, cull_disabled;
#include "funcs.gdshaderinc"

uniform int size: hint_range(0, 50, 1) = 10;
uniform vec3 led_color: source_color;
uniform vec3 banner_color: source_color;

void fragment() {
	// Called for every pixel the material is visible on.
	float s = float(size);
	vec2 igrid = floor(UV * s) / s; // 整数化分割
	vec2 fgrid = fract(UV * s);     // 分割 UV
	igrid.x += sin(TIME);
	float t_mask = 1.0 - polygon(igrid, 0.3, 3);   // 三角形
	float c_grid = 1.0 - circle(fgrid, 0.4, 0.02);    // 这里 1 - 是为了反转颜色
	vec3 output = mix(c_grid*banner_color, c_grid*led_color, t_mask);
	ALBEDO = output;
	EMISSION = t_mask * c_grid * led_color * 5.0;
	
}