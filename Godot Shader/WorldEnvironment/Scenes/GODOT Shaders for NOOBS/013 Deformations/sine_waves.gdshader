shader_type spatial;
render_mode unshaded, cull_disabled;

group_uniforms deformation;  // 变量分组
uniform float defstrength: hint_range(0.0, 1.0, 0.01);   // 变形强度
uniform float deffreg: hint_range(0.0, 2.0, 0.01);    // 变形频率

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv = UV;   // 取 UV
	// sin(uv.x*TAU) 可以让一个波出现在x[0,1]之间，再乘以deffreg频率可以在0~1之间出现多次波形率
	// 最后乘以defstrength变形强度，增大波幅
	uv.y += sin(uv.x * TAU * deffreg) * defstrength;   
	float f = clamp(sin(uv.y * TAU * 5.0), 0.0, 1.0);

	ALBEDO = vec3(f);
}
