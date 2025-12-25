shader_type sky;

uniform sampler2D sky_tex: source_color, filter_linear, hint_default_black;
uniform vec3 sun_pos = vec3(0.0);
uniform sampler2D planet_tex: source_color, filter_linear;
uniform float planet_radius = 300.0;
uniform sampler2D cloud_tex: source_color;
uniform vec4 cloud_color: source_color = vec4(1.0);
uniform float rotation_speed: hint_range(0.0, 1.0, 0.1) = 0.02;
uniform sampler2D moon_tex: source_color, filter_linear_mipmap_anisotropic;


struct RayHit {
	bool is_hit;
	vec3 normal;
	vec3 hit_point;
};

// 计算给定射线设中球体的信息，D: ray_dir    O: ray_origin
// ray_origin: 射线原点
// ray_dir: 射线方向
// sphere_center: 圆的中心
// sphere_radius: 圆的半径
RayHit hit_sphere(vec3 ray_origin, vec3 ray_dir, vec3 sphere_center, float sphere_radius){
	RayHit ray_hit;
	ray_hit.is_hit = false;
	vec3 oc = ray_origin - sphere_center;  // 射线原点减去圆心相当于以圆心为坐标原点指向射线原点的向量，目的是相当于把圆心移动到世界原点。这里得出来的是偏移后的O点
	float a = dot(ray_dir, ray_dir);       // a = D*D
	float b = 2.0 * dot(oc, ray_dir);     // b = 2.0*O*D
	float c = dot(oc, oc) - sphere_radius * sphere_radius;  // c = O*O - radious * radious
	float delta = b * b - 4.0 * a * c;
	if (delta < 0.0) {
		return ray_hit;
	}
	float root = sqrt(delta);
	float t1 = (-b - root) / (2.0 * a);  // 一元二次方程的其中一个解
	float t2 = (-b + root) / (2.0 * a);  // 一元二次方程的另一个解
	float t_near = min(t1, t2);          // 找出射线与球体相交的近点
	float t_far = max(t1, t2);           // 找出射线与球体相交的远点
	if (t_near < 0.0){                   // 如果近点小于 0 说明射线在球体内部
		if (t_far >= 0.0){               // 如果远点大于等于 0 （在球体外部），此时将近点记作 0，此时只有一个交点
			t_near = 0.0;
		}
		else{                            // 近点和远点都小于 0 ，说明射线与球体没有相交，返回空
			return ray_hit;
		}
	}
	ray_hit.hit_point = fma(ray_dir, vec3(t_near), ray_origin);     // 计算相交点
	ray_hit.normal = normalize(ray_hit.hit_point - sphere_center);  // 通过相交点和球心算出相交点的法线
	ray_hit.is_hit = true;                                          // 射中状态
	return ray_hit;
}

// 计算球体上点的UV坐标
// point_on_sphere: 球体上的点
// rotation: 旋转角度，为了实现球体自旋效果
vec2 get_spherical_uv(vec3 point_on_sphere, float rotation){
	vec3 n = normalize(point_on_sphere);
	float theta = atan(n.z, n.x);
	float phi = acos(n.y);
	theta += rotation;
	float u = (theta + PI) / TAU;
	float v = phi / PI;
	return vec2(u, v);
}

vec3 compute_lighting(vec3 normal, vec3 light_dir){
	return vec3(max(dot(normal, -light_dir), 0.0));
}


void vertex() {
    
}

void sky() {
	if (AT_CUBEMAP_PASS){
		//COLOR = vec3(0.2, 0.6, 1.0);     // 在渲染为辐射立方贴图时，设置背景颜色
	}
	else{
		vec3 planet_center = vec3(0.0, -100.0, planet_radius * 2.0);  // 设置行星中心坐标
		RayHit planet_hit = hit_sphere(POSITION, EYEDIR, planet_center, planet_radius);   // 计算相机射线与行星的交点
		float moon_planet_dist = planet_radius * 8.0;     // 设置月球与行星的距离
		float moon_angle = TIME / 10.0;          // 设置月球的公转速度
		vec3 moon_center = planet_center + vec3(sin(moon_angle)*moon_planet_dist, 0.0, cos(moon_angle)*moon_planet_dist);  // 计算月球的中心坐标
		float moon_radius = planet_radius / 3.0;    // 设置月球的半径
		RayHit moon_hit = hit_sphere(POSITION, EYEDIR, moon_center, moon_radius);    // 计算相继射线与月球的交点
		if (planet_hit.is_hit){                      // 相机射线击中了行星（此时行星就在视野中）的部分射线
			vec2 planet_uv = get_spherical_uv(planet_hit.hit_point - planet_center, TIME * rotation_speed);  // 计算行星UV
			vec3 planet_color = texture(planet_tex, planet_uv).rgb;       // 设置行星纹理信息
			vec2 cloud_uv = get_spherical_uv(planet_hit.hit_point - planet_center, TIME * rotation_speed);  // 计算云层1的UV（云层1跟行星自转速度和方向一致）
			float cloud_noise = texture(cloud_tex, cloud_uv).r;    // 设置云层1纹理
			vec2 cloud_uv2 = get_spherical_uv(planet_hit.hit_point - planet_center, (TIME * rotation_speed * 200.0 + 40.0) * 0.035);  // 计算云层2的UV（云层2的自转速度稍快）
			float cloud_noise2 = texture(cloud_tex, cloud_uv2).r;   // 设置云层2的纹理
			cloud_noise = mix(cloud_noise, cloud_noise2, 0.5);  // 混合云层1和云层2
			COLOR = mix(planet_color, cloud_color.rgb, cloud_noise * cloud_color.a); // 混合行星纹理和云层纹理
			vec3 sunlight_dir = normalize(planet_hit.hit_point - sun_pos);   // 计算射向行星的太阳光方向
			RayHit light_hit = hit_sphere(planet_hit.hit_point, -sunlight_dir, moon_center, moon_radius);  // 计算行星射向太阳方向的射线是否击中月球，如果击中了，月球会在行星上留下影子
			vec3 lighting = compute_lighting(planet_hit.normal, sunlight_dir); // 计算光照强度
			COLOR *= lighting;   // 最终设置要显示的颜色
			if (light_hit.is_hit){
				COLOR *= 0.2;   // 如果月球遮挡了太阳射向行星的光线，降低阴影区域的颜色强度，呈现阴影效果
			}
		}
		else if (moon_hit.is_hit){    // 相机射线击中了月球（此时月球就在视野中）的部分射线
			vec2 moon_uv = get_spherical_uv(moon_hit.hit_point - moon_center, 0.0);//TIME * rotation_speed
			vec3 moon_color = texture(moon_tex, moon_uv).rgb;   // 设置月球纹理
			vec3 sunlight_dir = normalize(moon_hit.hit_point - sun_pos);    // 太阳光照向月球每个可看到的像素点的方向
			RayHit light_hit = hit_sphere(moon_hit.hit_point, -sunlight_dir, planet_center, planet_radius); // 月球射向太阳的射线，是否击中行星，如果击中说明行星挡在了太阳和月球之间，此时月球进入行星阴影区域
			if (light_hit.is_hit){
				moon_color *= 0.02;    // 月球进入行星阴影区域，降低月球颜色强度模拟阴影效果
			}
			else{
				vec3 lighting = compute_lighting(moon_hit.normal, sunlight_dir);   // 月球没有进入行星阴影区域正常绘制月球
				moon_color *= lighting;     // 叠加光线强度效果
			}
			COLOR = moon_color;
		}
		else{    // 相机射线击中了月球和行星以外的部分射线
			COLOR = texture(sky_tex, SKY_COORDS).rgb;   // 绘制宇宙背景
			float ds = max(dot(normalize(sun_pos - POSITION), EYEDIR), 0.0);
			//float ds = dot(normalize(sun_pos - POSITION), EYEDIR);
			COLOR += pow(vec3(pow(ds, 40.0), pow(ds, 60.0), pow(ds, 100.0)), vec3(2.0));   // 绘制太阳
		}
	}
}
