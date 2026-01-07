shader_type spatial;
render_mode cull_disabled;
render_mode unshaded;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// 花形
	//vec2 new_uv = UV * 2.0 - 1.0;
	//float angle = atan(new_uv.y, new_uv.x);
	//angle /= TAU;
	//angle += 0.5;
	//float strength = cos(angle * 10000.0);
	//ALBEDO = vec3(strength);
	
	// 角度动画
	vec2 new_uv = UV * 2.0 - 1.0;   // -1.0 ~ 1.0  相当于把UV的起点移到中间
	float angle = atan(new_uv.y, new_uv.x);    // -PI ~ PI  算出当前像素点相对于中点的角度
	angle /= TAU;  // -0.5 ~ 0.5 TAU = 2PI
	angle += 0.5;  // 0~1
	float strength = cos(angle*100.0 + TIME);   // 0~1 * 100  TIME 旋转
	strength = step(0.5, strength);
	ALBEDO = vec3(strength);
}

