shader_type spatial;
render_mode unshaded, cull_disabled;


// 绘制多边形
float ploygon(vec2 uv, float width, int sides){
	uv = uv * 2.0 - 1.0;    // UV 中心移到中间
	float angle = atan(uv.x, uv.y);    // 算出像素点到中心点的角度
	float radius = TAU / float(sides);   // 算出半径
	float dist = cos(floor(0.5+angle/radius) * radius - angle) * length(uv);
	float poly = step(width, dist);
	
	return poly;
}

void fragment() {
	// Called for every pixel the material is visible on.
	float ploy = ploygon(UV, 0.5, 3);
	ALBEDO = vec3(ploy);
	
}

