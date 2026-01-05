shader_type spatial;
render_mode unshaded;
render_mode cull_disabled;  // 双面贴图

float plot(vec2 st, float pct){
	st = 1.0 - st;
	return smoothstep(pct - 0.02, pct, st.y) - smoothstep(pct, pct + 0.02, st.y);
}

void fragment() {
	// Called for every pixel the material is visible on.
	//ALBEDO = vec3(UV.x, UV.y, 1.0);
	//ALBEDO = vec3(UV.x, UV.x, 1.0);
	//ALBEDO = vec3(UV.x);
	float x = UV.x;
	// 绘制线形函数
	//float y = x;
	//float y = sin(x);
	float y = pow(x, 2);
	vec3 color = vec3(y);
	
	// polt the line
	float pct = plot(UV, y);
	color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);
	ALBEDO = vec3(color);
}

