shader_type canvas_item;

uniform vec3 replacement_color: source_color;

void fragment() {
	//过滤绿色通道
	//保留红色和蓝色通道
	vec3 color_without_green = COLOR.rgb * vec3(1, 0, 1);
	//调用长度函数，生成表示片段中红色和蓝色数量的数字。就是求模
	float amount_of_red_and_blue = length(color_without_green);
	//阶段化上一步的模长数据，只保留0和1。绿色部分是0,红蓝部分是1。这一步会将黑白图的渐变去掉，通道中只保留0和1两种。
	float red_and_blue_mask = step(0.26, amount_of_red_and_blue);
	//用原始图乘以上面的阶段化之后的图，得出来的是剔除了绿色分的原始图
	vec3 ratained_color = COLOR.rgb * red_and_blue_mask;
	//反转前面的黑白图，将剔除绿色通道后的黑色部分和保留红蓝的白色通道反转，绿色通道变成白色，红蓝通道变成黑色。
	//再乘上原始图的绿色通道，得出来的是有渐变效果的黑白图
	float green_mask = (1.0 - red_and_blue_mask) * COLOR.g;
	//将要替换上去的颜色和上一步的遮罩绿色的图，得出来有绿色渐变的图，红蓝部通道还是黑色
	vec3 masked_replacement_color = green_mask * replacement_color;
	//最后将遮罩绿色的图和替换绿色的图想加，补齐所有3个通道的颜色，得出来最终的图片
	vec3 final_color = ratained_color + masked_replacement_color;
	
	COLOR.rgb = final_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
