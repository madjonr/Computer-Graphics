// 绘制多边形
float polygon(vec2 uv, float width, int sides){
	uv = uv * 2.0 - 1.0;    // UV 中心移到中间
	float angle = atan(uv.x, uv.y);    // 算出像素点到中心点的角度
	float radius = TAU / float(sides);   // 算出半径
	float dist = cos(floor(0.5+angle/radius) * radius - angle) * length(uv);
	float poly = step(width, dist);
	
	return poly;
}

vec2 rotate(vec2 uv, vec2 center, float angle){
	mat2 rotation = mat2(vec2(cos(angle), -sin(angle)),
						vec2(sin(angle), cos(angle)));
	uv -= center;
	uv = uv * rotation;
	uv += center;
	return uv;
}

vec2 scale(vec2 uv, float x, float y){
	mat2 scale = mat2(vec2(x, 0.0),
						vec2(0.0, y));
	uv -= 0.5;
	uv = uv * scale;
	uv += 0.5;
	return uv;
}