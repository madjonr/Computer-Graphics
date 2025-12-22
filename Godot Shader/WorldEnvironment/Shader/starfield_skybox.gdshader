shader_type sky;

float star(vec2 uv) {
	float star = 0.01 / length(uv);
	float rays = max(0.0, 1.0 - abs(uv.x * uv.y)* 1000.0) * star;
	//float rays = 1.0 - abs(uv.x * uv.y) * 1000.0;
	star  += rays;
	return pow(star, 3);

}

void sky() {
	vec2 uv = fract(EYEDIR.xz * 5.0);
	COLOR += star(uv);
	COLOR.rg = uv;
}
