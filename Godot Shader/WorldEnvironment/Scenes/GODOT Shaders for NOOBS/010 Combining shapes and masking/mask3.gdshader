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
	
	float df = distance(UV, vec2(0.5));    // 屏幕上的像素点到中心的距离
	float mask = step(abs(sin(TIME)), df);  // 根据正弦函数和时间生成遮罩参数
	vec3 interpolation = mix(logo1, logo2, mask);  // 混合 logo1 和 logo2
	ALBEDO = interpolation;
}