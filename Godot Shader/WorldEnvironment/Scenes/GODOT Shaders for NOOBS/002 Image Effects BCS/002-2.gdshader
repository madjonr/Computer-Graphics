shader_type canvas_item;

uniform float brightness = 1.0;    // 亮度
uniform float contrast = 1.0;      // 对比度
uniform float saturation = 1.0;    // 饱和度


void fragment() {
	// Called for every pixel the material is visible on.
	vec3 out_color = texture(TEXTURE, UV, 1.0).rgb;
	out_color = mix(vec3(0.0), out_color.rgb, brightness);
	out_color = mix(vec3(0.5), out_color.rgb, contrast);
	float gray = 0.2126 * out_color.r + 0.7152 * out_color.g + 0.0722 * out_color.b ;
	out_color = mix(vec3(gray), out_color.rgb, saturation);
	COLOR.rgb = out_color;
}

