shader_type canvas_item;

uniform float dist = 0.7;


void fragment() {
	// Called for every pixel the material is visible on.
	vec3 current_color = texture(TEXTURE, UV).rgb;
	vec3 right_color = texture(TEXTURE, UV + vec2(1, 0)).rgb;
	vec3 bottom_color = texture(TEXTURE, UV - vec2(0, 1)).rgb;
	float r_dist = length(current_color - right_color);
	float b_dist = length(current_color - bottom_color);
	COLOR.rgb = (r_dist > dist || b_dist > dist) ? vec3(1.0) : vec3(0.0);
	
	// 测试UV坐标
	//vec3 color = texture(TEXTURE, UV - vec2(0,1)).rgb;
	//COLOR.rgb = color;
}

