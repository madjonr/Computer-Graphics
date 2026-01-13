shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D albedo: source_color;   // 反射贴图
uniform float distortion: hint_range(0.0, 1.0, 0.01);  // 扭曲幅度
uniform vec2 time_scale = vec2(1.0, 1.0);  // 时间在 x、y 轴上的缩放


void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = UV * 5.0;     // UV 放大
	// 以左下到右上为中心的波,由(uv.x+uv.y)决定了波的方向，乘一个数值决定了波的频率，加一个数值决定了波的偏移量
	vec2 wavesoffset = vec2(
		cos(TIME + time_scale.x + (uv.x+uv.y)*0.5), 
		sin(TIME + time_scale.y + (uv.x+uv.y)*2.0)
		);
	
	ALBEDO = texture(albedo, UV + wavesoffset * distortion).rgb;
}
