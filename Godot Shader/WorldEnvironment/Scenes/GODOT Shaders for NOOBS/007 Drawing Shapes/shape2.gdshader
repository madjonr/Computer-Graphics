shader_type spatial;
render_mode unshaded;
render_mode cull_disabled;

uniform float  square_radius: hint_range(0.0, 1.0, 0.1) = 0.3;
uniform float width: hint_range(0.0, 1.0, 0.1) = 0.3;
uniform float height: hint_range(0.0, 1.0, 0.1) = 0.3;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// 绘制彩色
	//vec2 new_uv = UV * 2.0 - 1.0;
	//ALBEDO = vec3(new_uv, 0.0);
	
	// 绘制镜像彩色
	//vec2 new_uv = UV * 2.0 - 1.0;
	//vec2 reflected_uv = abs(new_uv);
	//ALBEDO = vec3(reflected_uv, 0.0);
	
	// 绘制正方形
	//vec2 new_uv = UV * 2.0 - 1.0;   // 原始 UV 坐标是以右上角为原点
	//vec2 reflected_uv = abs(new_uv);
	//float df = max(reflected_uv.x, reflected_uv.y);  // 四芒星
	//float square = step(square_radius, df);    // 正方形
	//ALBEDO = vec3(square);
	
	
	// 绘制矩形
	vec2 new_uv = UV * 2.0 - 1.0;   // 原始 UV 坐标是以右上角为原点
	vec2 reflected_uv = abs(new_uv);
	float dfx = step(width, reflected_uv.x);    // 宽
	float dfy = step(height, reflected_uv.y);    // 高
	float df = max(dfx, dfy);  //
	ALBEDO = vec3(df);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
