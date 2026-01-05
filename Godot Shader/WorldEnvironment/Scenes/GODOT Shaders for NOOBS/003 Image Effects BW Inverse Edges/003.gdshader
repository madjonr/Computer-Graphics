shader_type canvas_item;


void fragment() {
	//黑白图
	//COLOR = texture(TEXTURE, UV);
	//float bw = step(0.5, (COLOR.r + COLOR.b + COLOR.g)/3.0);   // 平均值小于0.5就是黑色，大于0.5就是白色
	//COLOR.rgb = vec3(bw);

	// 反色
	vec3 color = texture(TEXTURE, UV).rgb;
	color = vec3(1.0) - color;
	COLOR.rgb = color;
}