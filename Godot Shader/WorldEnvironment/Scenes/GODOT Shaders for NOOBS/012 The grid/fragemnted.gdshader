shader_type spatial;
render_mode cull_disabled, unshaded;

uniform sampler2D tex: source_color, repeat_disable;


void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uvreside = floor(UV * 5.0) / 5.0;
	ALBEDO = vec3(uvreside, 0.0);
	//ALBEDO = texture(tex, uvreside).rgb;
}