shader_type sky;

uniform int iterations = 17;
uniform float formuparam = 0.53;

uniform int volsteps = 20;
uniform float stepsize = 0.1;

uniform float zoom = 0.800;
uniform float tile = 0.850;
uniform float speed = 0.0010;

uniform float brightness = 0.0015;
uniform float darkmatter = 0.300;
uniform float distfading = 0.730;
uniform float saturation = 0.850;

void sky() {
	//get coords and directio
	vec2 uv = SCREEN_UV;
	vec3 dir = EYEDIR;
	float time = TIME * speed + 0.025;
	
	//volumetric rendering
	float s = 0.1;
	float fade = 1.0;
	vec3 v = vec3(0.0);
	for (int r=0; r<volsteps; r++) {
		vec3 from = vec3(1.0, 0.5, 0.5);
		from += vec3(time*2.0, time, -2.0);
		vec3 p = from + s * dir * 0.5;
		p = abs(vec3(tile) - mod(p, vec3(tile * 2.0))); // tiling fold
		float a = 0.0;
		float pa = 0.0 ;
		for (int i=0; i<iterations; i++) { 
			p = abs(p) / dot(p, p) - formuparam; // the magic formula
			a += abs(length(p) - pa); // absolute sum of average change
			pa = length(p);
		}
		float dm = max(0.0, darkmatter - a * a * 0.001); //dark matter
		a *= a * a; // add contrast
		if (r>6){
			fade *= 1.0 - dm; // dark matter, don't render near
		} 
		//v+=vec3(dm,dm*.5,0.);
		v += fade;
		v += vec3(s, s*s, s*s*s*s) * a * brightness * fade; // coloring based on distance
		fade *= distfading; // distance fading
		s += stepsize;
	}
	v = mix(vec3(length(v)), v, saturation); //color adjust
	COLOR = v * 0.002;
}


