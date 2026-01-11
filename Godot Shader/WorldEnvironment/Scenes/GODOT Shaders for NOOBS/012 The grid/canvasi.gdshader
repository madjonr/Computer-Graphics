shader_type canvas_item;
//render_mode unshaded;

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uvresize = fract(UV * 5.0);
	COLOR = vec4(uvresize, 0.0, 1.0);
	COLOR = texture(TEXTURE , uvresize);
	
}
