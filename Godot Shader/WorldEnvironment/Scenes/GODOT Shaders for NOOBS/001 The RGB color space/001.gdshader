shader_type canvas_item;

const vec3 colorA = vec3(0.1, 0.0, 1.0);
const vec3 colorB = vec3(1.0, 0.5, 0.3);

void vertex() {
	// Called for every vertex the material is visible on.

}

void fragment() {
	// Called for every pixel the material is visible on.
	// no:1
	//vec3 color = vec3(0.0);
	//float pct = abs(sin(TIME));
	//color = mix(colorA, colorB, pct);
	//COLOR = vec4(color, 1.0);
	
	// no:2
	vec3 colorC = texture(TEXTURE, UV).rgb;
	vec3 color = vec3(0.0);
	float pct = abs(sin(TIME));
	color = mix(colorC, colorB, pct);
	COLOR = vec4(color, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
